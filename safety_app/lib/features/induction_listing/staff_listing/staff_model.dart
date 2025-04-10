// To parse this JSON data, do
//
//     final staffListing = staffListingFromJson(jsonString);

import 'dart:convert';

StaffListing staffListingFromJson(String str) =>
    StaffListing.fromJson(json.decode(str));

String staffListingToJson(StaffListing data) => json.encode(data.toJson());

class StaffListing {
  Data data;
  String message;
  bool status;
  bool token;

  StaffListing({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory StaffListing.fromJson(Map<String, dynamic> json) => StaffListing(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
        "token": token,
      };
}

class Data {
  List<UserDetail> userDetails;
  List<InductionTraining> inductionTrainings;
  List<DocumentDetail> documentDetails;
  List<EquipmentDetail> equipmentDetails;
  List<InstructionDetail> instructionDetails;
  List<ReasonOfVisit> reasonOfVisit;

  Data({
    required this.userDetails,
    required this.inductionTrainings,
    required this.documentDetails,
    required this.equipmentDetails,
    required this.instructionDetails,
    required this.reasonOfVisit,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userDetails: List<UserDetail>.from(
            json["user_details"].map((x) => UserDetail.fromJson(x))),
        inductionTrainings: List<InductionTraining>.from(
            json["induction_trainings"]
                .map((x) => InductionTraining.fromJson(x))),
        documentDetails: List<DocumentDetail>.from(
            json["document_details"].map((x) => DocumentDetail.fromJson(x))),
        equipmentDetails: List<EquipmentDetail>.from(
            json["equipment_details"].map((x) => EquipmentDetail.fromJson(x))),
        instructionDetails: List<InstructionDetail>.from(
            json["instruction_details"]
                .map((x) => InstructionDetail.fromJson(x))),
        reasonOfVisit: List<ReasonOfVisit>.from(
            json["reason_of_visit"].map((x) => ReasonOfVisit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_details": List<dynamic>.from(userDetails.map((x) => x.toJson())),
        "induction_trainings":
            List<dynamic>.from(inductionTrainings.map((x) => x.toJson())),
        "document_details":
            List<dynamic>.from(documentDetails.map((x) => x.toJson())),
        "equipment_details":
            List<dynamic>.from(equipmentDetails.map((x) => x.toJson())),
        "instruction_details":
            List<dynamic>.from(instructionDetails.map((x) => x.toJson())),
        "reason_of_visit":
            List<dynamic>.from(reasonOfVisit.map((x) => x.toJson())),
      };
}

class DocumentDetail {
  String? docmentType;
  String? idNumber;
  DateTime? validity;
  String? documentPath;

  DocumentDetail({
    this.docmentType,
    this.idNumber,
    this.validity,
    this.documentPath,
  });

  factory DocumentDetail.fromJson(Map<String, dynamic> json) => DocumentDetail(
        docmentType: json["docment_type"] ?? "",
        idNumber: json["id_number"] ?? "",
        validity:
            json["validity"] != null ? DateTime.parse(json["validity"]) : null,
        documentPath: json["document_path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "docment_type": docmentType,
        "id_number": idNumber,
        "validity":
            "${validity!.year.toString().padLeft(4, '0')}-${validity!.month.toString().padLeft(2, '0')}-${validity!.day.toString().padLeft(2, '0')}",
        "document_path": documentPath,
      };
}

class EquipmentDetail {
  String? equipmentName;

  EquipmentDetail({
    this.equipmentName,
  });

  factory EquipmentDetail.fromJson(Map<String, dynamic> json) =>
      EquipmentDetail(
        equipmentName: json["equipment_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "equipment_name": equipmentName,
      };
}

class InductionTraining {
  int id;
  String? inductionId;
  // int userId;
  // String userType;
  // String inducteeName;
  // dynamic contractorCompanyId;
  // dynamic tradeId;
  String? userPhoto;
  // dynamic experienceInYears;
  // int signatureFlag;
  // int signatureBehalfOf;
  // String signaturePhoto;
  // int undertakingInstruction1;
  // int undertakingInstruction2;
  // int undertakingInstruction3;
  // int inductedById;
  // String inductedByName;
  // String location;
  // DateTime createdAt;
  // DateTime updatedAt;
  // int reasonOfVisit;
  // dynamic deletedAt;
  // int projectId;

  InductionTraining({
    required this.id,
    this.inductionId,
    // required this.userId,
    // required this.userType,
    // required this.inducteeName,
    // required this.contractorCompanyId,
    // required this.tradeId,
    this.userPhoto,
    // required this.experienceInYears,
    // required this.signatureFlag,
    // required this.signatureBehalfOf,
    // required this.signaturePhoto,
    // required this.undertakingInstruction1,
    // required this.undertakingInstruction2,
    // required this.undertakingInstruction3,
    // required this.inductedById,
    // required this.inductedByName,
    // required this.location,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.reasonOfVisit,
    // required this.deletedAt,
    // required this.projectId,
  });

  factory InductionTraining.fromJson(Map<String, dynamic> json) =>
      InductionTraining(
        id: json["id"],
        inductionId: json["induction_id"] ?? "",
        // userId: json["user_id"],
        // userType: json["user_type"],
        // inducteeName: json["inductee_name"],
        // contractorCompanyId: json["contractor_company_id"],
        // tradeId: json["trade_id"],
        userPhoto: json["user_photo"] ?? "",
        // experienceInYears: json["experience_in_years"],
        // signatureFlag: json["signature_flag"],
        // signatureBehalfOf: json["signature_behalf_of"],
        // signaturePhoto: json["signature_photo"],
        // undertakingInstruction1: json["undertaking_instruction_1"],
        // undertakingInstruction2: json["undertaking_instruction_2"],
        // undertakingInstruction3: json["undertaking_instruction_3"],
        // inductedById: json["inducted_by_id"],
        // inductedByName: json["inducted_by_name"],
        // location: json["location"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // reasonOfVisit: json["reason_of_visit"],
        // deletedAt: json["deleted_at"],
        // projectId: json["project_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "induction_id": inductionId,
        // "user_id": userId,
        // "user_type": userType,
        // "inductee_name": inducteeName,
        // "contractor_company_id": contractorCompanyId,
        // "trade_id": tradeId,
        // "user_photo": userPhoto,
        // "experience_in_years": experienceInYears,
        // "signature_flag": signatureFlag,
        // "signature_behalf_of": signatureBehalfOf,
        // "signature_photo": signaturePhoto,
        // "undertaking_instruction_1": undertakingInstruction1,
        // "undertaking_instruction_2": undertakingInstruction2,
        // "undertaking_instruction_3": undertakingInstruction3,
        // "inducted_by_id": inductedById,
        // "inducted_by_name": inductedByName,
        // "location": location,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "reason_of_visit": reasonOfVisit,
        // "deleted_at": deletedAt,
        // "project_id": projectId,
      };
}

class InstructionDetail {
  String? instructionName;

  InstructionDetail({
    this.instructionName,
  });

  factory InstructionDetail.fromJson(Map<String, dynamic> json) =>
      InstructionDetail(
        instructionName: json["instruction_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "instruction_name": instructionName,
      };
}

class ReasonOfVisit {
  String? reasonOfVisit;

  ReasonOfVisit({
    this.reasonOfVisit,
  });

  factory ReasonOfVisit.fromJson(Map<String, dynamic> json) => ReasonOfVisit(
        reasonOfVisit: json["reason_of_visit"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "reason_of_visit": reasonOfVisit,
      };
}

class UserDetail {
  int id;
  String staffId;
  String staffName;
  String? gender;
  String? bloodGroup;
  DateTime? birthDate;
  int? age;
  String? contactNumber;
  String? userPhoto;
  String? currentStreetName;
  String? currentCity;
  String? currentTaluka;
  int? currentDistrict;
  int? currentState;
  String? currentPincode;
  String? permanentStreetName;
  String? permanentCity;
  String? permanentTaluka;
  int? permanentDistrict;
  int? permanentState;
  String? permanentPincode;
  String? adhaarNo;
  // dynamic bankName;
  // dynamic ifscNumber;
  // dynamic accountNumber;
  // dynamic branchAddress;
  // dynamic groupInsuranceLimit;
  // dynamic insuranceNumber;
  // dynamic insuranceType;
  // dynamic insuranceValidity;
  String? emergencyContactName;
  String? emergencyContactNumber;
  String? emergencyContactRelation;
  // String isActive;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // dynamic qrCode;
  // dynamic idCardExpiryDate;
  String? stateName;
  String? districtName;

  UserDetail({
    required this.id,
    required this.staffId,
    required this.staffName,
    this.gender,
    this.bloodGroup,
    this.birthDate,
    this.age,
    this.contactNumber,
    this.userPhoto,
    this.currentStreetName,
    this.currentCity,
    this.currentTaluka,
    this.currentDistrict,
    this.currentState,
    this.currentPincode,
    this.permanentStreetName,
    this.permanentCity,
    this.permanentTaluka,
    this.permanentDistrict,
    this.permanentState,
    this.permanentPincode,
    this.adhaarNo,
    // required this.bankName,
    // required this.ifscNumber,
    // required this.accountNumber,
    // required this.branchAddress,
    // required this.groupInsuranceLimit,
    // required this.insuranceNumber,
    // required this.insuranceType,
    // required this.insuranceValidity,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.emergencyContactRelation,
    // required this.isActive,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.qrCode,
    // required this.idCardExpiryDate,
    this.stateName,
    this.districtName,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        staffId: json["staff_id"],
        staffName: json["staff_name"],
        gender: json["gender"] ?? "",
        bloodGroup: json["blood_group"] ?? "",
        birthDate: json["birth_date"] != null
            ? DateTime.parse(json["birth_date"])
            : null,
        age: json["age"],
        contactNumber: json["contact_number"] ?? "",
        userPhoto: json["user_photo"] ?? "",
        currentStreetName: json["current_street_name"] ?? "",
        currentCity: json["current_city"] ?? "",
        currentTaluka: json["current_taluka"] ?? "",
        currentDistrict: json["current_district"] ?? "",
        currentState: json["current_state"] ?? "",
        currentPincode: json["current_pincode"] ?? "",
        permanentStreetName: json["permanent_street_name"] ?? "",
        permanentCity: json["permanent_city"] ?? "",
        permanentTaluka: json["permanent_taluka"] ?? "",
        permanentDistrict: json["permanent_district"] ?? "",
        permanentState: json["permanent_state"] ?? "",
        permanentPincode: json["permanent_pincode"] ?? "",
        adhaarNo: json["adhaar_no"] ?? "",
        // bankName: json["bank_name"],
        // ifscNumber: json["ifsc_number"],
        // accountNumber: json["account_number"],
        // branchAddress: json["branch_address"],
        // groupInsuranceLimit: json["group_insurance_limit"],
        // insuranceNumber: json["insurance_number"],
        // insuranceType: json["insurance_type"],
        // insuranceValidity: json["insurance_validity"],
        emergencyContactName: json["emergency_contact_name"] ?? "",
        emergencyContactNumber: json["emergency_contact_number"] ?? "",
        emergencyContactRelation: json["emergency_contact_relation"] ?? "",
        // isActive: json["is_active"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // qrCode: json["qr_code"],
        // idCardExpiryDate: json["id_card_expiry_date"],
        stateName: json["state_name"] ?? "",
        districtName: json["district_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "staff_id": staffId,
        "staff_name": staffName,
        "gender": gender,
        "blood_group": bloodGroup,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "age": age,
        "contact_number": contactNumber,
        "user_photo": userPhoto,
        "current_street_name": currentStreetName,
        "current_city": currentCity,
        "current_taluka": currentTaluka,
        "current_district": currentDistrict,
        "current_state": currentState,
        "current_pincode": currentPincode,
        "permanent_street_name": permanentStreetName,
        "permanent_city": permanentCity,
        "permanent_taluka": permanentTaluka,
        "permanent_district": permanentDistrict,
        "permanent_state": permanentState,
        "permanent_pincode": permanentPincode,
        "adhaar_no": adhaarNo,
        // "bank_name": bankName,
        // "ifsc_number": ifscNumber,
        // "account_number": accountNumber,
        // "branch_address": branchAddress,
        // "group_insurance_limit": groupInsuranceLimit,
        // "insurance_number": insuranceNumber,
        // "insurance_type": insuranceType,
        // "insurance_validity": insuranceValidity,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_number": emergencyContactNumber,
        "emergency_contact_relation": emergencyContactRelation,
        // "is_active": isActive,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "qr_code": qrCode,
        // "id_card_expiry_date": idCardExpiryDate,
        "state_name": stateName,
        "district_name": districtName,
      };
}
