// To parse this JSON data, do
//
//     final labourListing = labourListingFromJson(jsonString);

import 'dart:convert';

LabourListing labourListingFromJson(String str) =>
    LabourListing.fromJson(json.decode(str));

String labourListingToJson(LabourListing data) => json.encode(data.toJson());

class LabourListing {
  Data data;
  String message;
  bool status;
  bool token;

  LabourListing({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory LabourListing.fromJson(Map<String, dynamic> json) => LabourListing(
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
  List<LabourDetail>? userDetails;
  List<TradeName>? tradeName;
  List<ContractorCompanyDetail>? contractorCompanyDetails;
  List<SkillLevel>? skillLevel;
  List<InductionTraining>? inductionTrainings;
  List<DocumentDetail>? documentDetails;
  List<EquipmentDetail>? equipmentDetails;
  List<InstructionDetail>? instructionDetails;
  List<ReasonOfVisit>? reasonOfVisit;

  Data({
    this.userDetails,
    this.tradeName,
    this.contractorCompanyDetails,
    this.skillLevel,
    this.inductionTrainings,
    this.documentDetails,
    this.equipmentDetails,
    this.instructionDetails,
    this.reasonOfVisit,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userDetails: json["user_details"] == null
            ? null
            : List<LabourDetail>.from(
                json["user_details"].map((x) => LabourDetail.fromJson(x))),
        tradeName: json["trade_name"] == null
            ? null
            : List<TradeName>.from(
                json["trade_name"].map((x) => TradeName.fromJson(x))),
        contractorCompanyDetails: json["contractor_company_details"] == null
            ? null
            : List<ContractorCompanyDetail>.from(
                json["contractor_company_details"]
                    .map((x) => ContractorCompanyDetail.fromJson(x))),
        skillLevel: json["skill_level"] == null
            ? null
            : List<SkillLevel>.from(
                json["skill_level"].map((x) => SkillLevel.fromJson(x))),
        inductionTrainings: json["induction_trainings"] == null
            ? null
            : List<InductionTraining>.from(json["induction_trainings"]
                .map((x) => InductionTraining.fromJson(x))),
        documentDetails: json["document_details"] == null
            ? null
            : List<DocumentDetail>.from(json["document_details"]
                .map((x) => DocumentDetail.fromJson(x))),
        equipmentDetails: json["equipment_details"] == null
            ? null
            : List<EquipmentDetail>.from(json["equipment_details"]
                .map((x) => EquipmentDetail.fromJson(x))),
        instructionDetails: json["instruction_details"] == null
            ? null
            : List<InstructionDetail>.from(json["instruction_details"]
                .map((x) => InstructionDetail.fromJson(x))),
        reasonOfVisit: json["reason_of_visit"] == null
            ? null
            : List<ReasonOfVisit>.from(
                json["reason_of_visit"].map((x) => ReasonOfVisit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        if (userDetails != null)
          "user_details":
              List<dynamic>.from(userDetails!.map((x) => x.toJson())),
        if (tradeName != null)
          "trade_name": List<dynamic>.from(tradeName!.map((x) => x.toJson())),
        if (contractorCompanyDetails != null)
          "contractor_company_details": List<dynamic>.from(
              contractorCompanyDetails!.map((x) => x.toJson())),
        if (skillLevel != null)
          "skill_level": List<dynamic>.from(skillLevel!.map((x) => x.toJson())),
        if (inductionTrainings != null)
          "induction_trainings":
              List<dynamic>.from(inductionTrainings!.map((x) => x.toJson())),
        if (documentDetails != null)
          "document_details":
              List<dynamic>.from(documentDetails!.map((x) => x.toJson())),
        if (equipmentDetails != null)
          "equipment_details":
              List<dynamic>.from(equipmentDetails!.map((x) => x.toJson())),
        if (instructionDetails != null)
          "instruction_details":
              List<dynamic>.from(instructionDetails!.map((x) => x.toJson())),
        if (reasonOfVisit != null)
          "reason_of_visit":
              List<dynamic>.from(reasonOfVisit!.map((x) => x.toJson())),
      };
}

class ContractorCompanyDetail {
  int id;
  String? contractorCompanyName;
  // int? createdBy;
  // dynamic? deletedAt;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  // String? gstnNumber;

  ContractorCompanyDetail({
    required this.id,
    this.contractorCompanyName,
    // required this.createdBy,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.gstnNumber,
  });

  factory ContractorCompanyDetail.fromJson(Map<String, dynamic> json) =>
      ContractorCompanyDetail(
        id: json["id"],
        contractorCompanyName: json["contractor_company_name"] ?? "",
        // createdBy: json["created_by"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // gstnNumber: json["gstn_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contractor_company_name": contractorCompanyName,
        // "created_by": createdBy,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "gstn_number": gstnNumber,
      };
}

class SkillLevel {
  String? skillLevel;

  SkillLevel({
    this.skillLevel,
  });

  factory SkillLevel.fromJson(Map<String, dynamic> json) => SkillLevel(
        skillLevel: json["skill_level"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "skill_level": skillLevel,
      };
}

class DocumentDetail {
  String? docmentType;
  String? idNumber;
  DateTime? validity;
  String? documentPath;

  DocumentDetail({
    required this.docmentType,
    required this.idNumber,
    required this.validity,
    required this.documentPath,
  });

  factory DocumentDetail.fromJson(Map<String, dynamic> json) => DocumentDetail(
        docmentType: json["docment_type"] ?? "",
        idNumber: json["id_number"] ?? "",
        validity:
            json["validity"] == null ? null : DateTime.parse(json["validity"]),
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
  String equipmentName;

  EquipmentDetail({
    required this.equipmentName,
  });

  factory EquipmentDetail.fromJson(Map<String, dynamic> json) =>
      EquipmentDetail(
        equipmentName: json["equipment_name"],
      );

  Map<String, dynamic> toJson() => {
        "equipment_name": equipmentName,
      };
}

class InductionTraining {
  int id;
  String inductionId;
  // int userId;
  // String userType;
  // String inducteeName;
  // int contractorCompanyId;
  // int tradeId;
  String? userPhoto;
  // int experienceInYears;
  // int signatureFlag;
  // int signatureBehalfOf;
  // String signaturePhoto;
  // int undertakingInstruction1;
  // int undertakingInstruction2;
  // int undertakingInstruction3;
  // int inductedById;
  // String inductedByName;
  // String location;
  DateTime? createdAt;
  // DateTime updatedAt;
  // int reasonOfVisit;
  // dynamic deletedAt;
  // int projectId;

  InductionTraining({
    required this.id,
    required this.inductionId,
    // required this.userId,
    // required this.userType,
    // required this.inducteeName,
    // required this.contractorCompanyId,
    // required this.tradeId,
    required this.userPhoto,
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
    required this.createdAt,
    // required this.updatedAt,
    // required this.reasonOfVisit,
    // required this.deletedAt,
    // required this.projectId,
  });

  factory InductionTraining.fromJson(Map<String, dynamic> json) =>
      InductionTraining(
        id: json["id"],
        inductionId: json["induction_id"],
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
        createdAt: json["created_at_ind"] != null
            ? DateTime.parse(json["created_at_ind"])
            : null,
        // updatedAt: DateTime.parse(json["updated_at"]),
        // reasonOfVisit: json["reason_of_visit"],
        // deletedAt: json["deleted_at"],
        // projectId: json["project_id"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "induction_id": inductionId,
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

class TradeName {
  String? inductionDetails;

  TradeName({
    this.inductionDetails,
  });

  factory TradeName.fromJson(Map<String, dynamic> json) => TradeName(
        inductionDetails: json["induction_details"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "induction_details": inductionDetails,
      };
}

class LabourDetail {
  int id;
  String inducteeId;
  String labourName;
  String? gender;
  String? literacy;
  String? maritalStatus;
  String? bloodGroup;
  String? birthDate;
  int? age;
  String? contactNumber;
  String? userPhoto;
  String? currentStreetName;
  String? currentCity;
  String? currentTaluka;
  int? currentDistrict;
  int? currentState;
  String? currentPincode;
  // String permanentStreetName;
  // String permanentCity;
  // String permanentTaluka;
  // int permanentDistrict;
  // int permanentState;
  // String permanentPincode;
  int? experienceInYears;
  // String uanNumber;
  // String bocwNumber;
  // String bankName;
  // String ifscNumber;
  // String accountNumber;
  // String branchAddress;
  // String groupInsuranceLimit;
  // String insuranceNumber;
  // String insuranceType;
  // String insuranceValidity;
  String? emergencyContactName;
  String? emergencyContactNumber;
  String? emergencyContactRelation;
  // String isActive;
  // dynamic deletedAt;
  DateTime? createdAt;
  // DateTime updatedAt;
  String? adhaarCardNo;
  // dynamic qrCode;
  // dynamic idCardExpiryDate;
  String? stateName;
  String? districtName;

  LabourDetail({
    required this.id,
    required this.inducteeId,
    required this.labourName,
    this.gender,
    this.literacy,
    this.maritalStatus,
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
    // required this.permanentStreetName,
    // required this.permanentCity,
    // required this.permanentTaluka,
    // required this.permanentDistrict,
    // required this.permanentState,
    // required this.permanentPincode,
    this.experienceInYears,
    // required this.uanNumber,
    // required this.bocwNumber,
    // required this.bankName,
    // required this.ifscNumber,
    // required this.accountNumber,
    // required this.branchAddress,
    // required this.groupInsuranceLimit,
    // required this.insuranceNumber,
    // required this.insuranceType,
    // required this.insuranceValidity,
    required this.emergencyContactName,
    required this.emergencyContactNumber,
    required this.emergencyContactRelation,
    // required this.isActive,
    // required this.deletedAt,
    this.createdAt,
    // required this.updatedAt,
    this.adhaarCardNo,
    // required this.qrCode,
    // required this.idCardExpiryDate,
    required this.stateName,
    required this.districtName,
  });

  factory LabourDetail.fromJson(Map<String, dynamic> json) => LabourDetail(
        id: json["id"],
        inducteeId: json["inductee_id"],
        labourName: json["labour_name"],
        gender: json["gender"] ?? "",
        literacy: json["literacy"] ?? "",
        maritalStatus: json["marital_status"] ?? "",
        bloodGroup: json["blood_group"] ?? "",
        birthDate: json["birth_date"] ?? "",
        age: json["age"] ?? "",
        contactNumber: json["contact_number"] ?? "",
        userPhoto: json["user_photo"] ?? "",
        currentStreetName: json["current_street_name"] ?? "",
        currentCity: json["current_city"] ?? "",
        currentTaluka: json["current_taluka"] ?? "",
        currentDistrict: json["current_district"] ?? "",
        currentState: json["current_state"] ?? "",
        currentPincode: json["current_pincode"] ?? "",
        // permanentStreetName: json["permanent_street_name"],
        // permanentCity: json["permanent_city"],
        // permanentTaluka: json["permanent_taluka"],
        // permanentDistrict: json["permanent_district"],
        // permanentState: json["permanent_state"],
        // permanentPincode: json["permanent_pincode"],
        experienceInYears: json["experience_in_years"] ?? "",
        // uanNumber: json["uan_number"],
        // bocwNumber: json["bocw_number"],
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
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        // updatedAt: DateTime.parse(json["updated_at"]),
        adhaarCardNo: json["adhaar_card_no"] ?? "",
        // qrCode: json["qr_code"],
        // idCardExpiryDate: json["id_card_expiry_date"],

        districtName: json["district_name"] ?? "",
        stateName: json["state_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inductee_id": inducteeId,
        "labour_name": labourName,
        "gender": gender,
        "literacy": literacy,
        "marital_status": maritalStatus,
        "blood_group": bloodGroup,

        "age": age,
        "contact_number": contactNumber,
        "user_photo": userPhoto,
        "current_street_name": currentStreetName,
        "current_city": currentCity,
        "current_taluka": currentTaluka,
        "current_district": currentDistrict,
        "current_state": currentState,
        "current_pincode": currentPincode,
        // "permanent_street_name": permanentStreetName,
        // "permanent_city": permanentCity,
        // "permanent_taluka": permanentTaluka,
        // "permanent_district": permanentDistrict,
        // "permanent_state": permanentState,
        // "permanent_pincode": permanentPincode,
        "experience_in_years": experienceInYears,
        // "uan_number": uanNumber,
        // "bocw_number": bocwNumber,
        // "bank_name": bankName,
        // "ifsc_number": ifscNumber,
        // "account_number": accountNumber,
        // "branch_address": branchAddress,
        // "group_insurance_limit": groupInsuranceLimit,
        // "insurance_number": insuranceNumber,
        // "insurance_type": insuranceType,
        // "insurance_validity": insuranceValidity,
        // "emergency_contact_name": emergencyContactName,
        // "emergency_contact_number": emergencyContactNumber,
        // "emergency_contact_relation": emergencyContactRelation,
        // "is_active": isActive,
        // "deleted_at": deletedAt,
        "created_at": createdAt!.toIso8601String(),
        //"updated_at": updatedAt.toIso8601String(),
        "adhaar_card_no": adhaarCardNo,
        // "qr_code": qrCode,
        // "id_card_expiry_date": idCardExpiryDate,
      };
}
