// To parse this JSON data, do
//
//     final projectDetails = projectDetailsFromJson(jsonString);

import 'dart:convert';

ProjectDetails projectDetailsFromJson(String str) =>
    ProjectDetails.fromJson(json.decode(str));

String projectDetailsToJson(ProjectDetails data) => json.encode(data.toJson());

class ProjectDetails {
  Data data;
  String message;
  bool status;
  bool token;

  ProjectDetails({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
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
  List<LaboursDetail> laboursDetails;
  List<LaboursProjectDetail> laboursProjectDetails;
  List<DocumentDetail> documentDetails;

  Data({
    required this.laboursDetails,
    required this.laboursProjectDetails,
    required this.documentDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        laboursDetails: List<LaboursDetail>.from(
            json["labours_details"].map((x) => LaboursDetail.fromJson(x))),
        laboursProjectDetails: List<LaboursProjectDetail>.from(
            json["labours_project_details"]
                .map((x) => LaboursProjectDetail.fromJson(x))),
        documentDetails: List<DocumentDetail>.from(
            json["document_details"].map((x) => DocumentDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "labours_details":
            List<dynamic>.from(laboursDetails.map((x) => x.toJson())),
        "labours_project_details":
            List<dynamic>.from(laboursProjectDetails.map((x) => x.toJson())),
        "document_details":
            List<dynamic>.from(documentDetails.map((x) => x.toJson())),
      };
}

class DocumentDetail {
  String docmentType;
  String idNumber;
  DateTime validity;
  String photos;

  DocumentDetail({
    required this.docmentType,
    required this.idNumber,
    required this.validity,
    required this.photos,
  });

  factory DocumentDetail.fromJson(Map<String, dynamic> json) => DocumentDetail(
        docmentType: json["docment_type"],
        idNumber: json["id_number"],
        validity: DateTime.parse(json["validity"]),
        photos: json["photos"],
      );

  Map<String, dynamic> toJson() => {
        "docment_type": docmentType,
        "id_number": idNumber,
        "validity":
            "${validity.year.toString().padLeft(4, '0')}-${validity.month.toString().padLeft(2, '0')}-${validity.day.toString().padLeft(2, '0')}",
        "photos": photos,
      };
}

class LaboursDetail {
  int id;
  String inducteeId;
  String? labourName;
  String? gender;
  String? literacy;
  String? maritalStatus;
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
  int? experienceInYears;
  // dynamic uanNumber;
  // dynamic bocwNumber;
  // dynamic bankName;
  // dynamic ifscNumber;
  // dynamic accountNumber;
  // dynamic branchAddress;
  // dynamic groupInsuranceLimit;
  // dynamic insuranceNumber;
  // dynamic insuranceType;
  // dynamic insuranceValidity;
  // String emergencyContactName;
  // String emergencyContactNumber;
  // String emergencyContactRelation;
  // String isActive;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String adhaarCardNo;
  // dynamic qrCode;
  // dynamic idCardExpiryDate;

  LaboursDetail({
    required this.id,
    required this.inducteeId,
    this.labourName,
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
    this.permanentStreetName,
    this.permanentCity,
    this.permanentTaluka,
    this.permanentDistrict,
    this.permanentState,
    this.permanentPincode,
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
    // required this.emergencyContactName,
    // required this.emergencyContactNumber,
    // required this.emergencyContactRelation,
    // required this.isActive,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.adhaarCardNo,
    // required this.qrCode,
    // required this.idCardExpiryDate,
  });

  factory LaboursDetail.fromJson(Map<String, dynamic> json) => LaboursDetail(
        id: json["id"],
        inducteeId: json["inductee_id"],
        labourName: json["labour_name"] ?? "",
        gender: json["gender"] ?? "",
        literacy: json["literacy"] ?? "",
        maritalStatus: json["marital_status"] ?? "",
        bloodGroup: json["blood_group"] ?? "",
        birthDate: json["birth_date"] != null
            ? DateTime.tryParse(json["birth_date"]) ?? DateTime(1900, 1, 1)
            : null, // Defaulting to null or a fallback date        age: json["age"] ?? "",
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
        // emergencyContactName: json["emergency_contact_name"],
        // emergencyContactNumber: json["emergency_contact_number"],
        // emergencyContactRelation: json["emergency_contact_relation"],
        // isActive: json["is_active"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // adhaarCardNo: json["adhaar_card_no"],
        // qrCode: json["qr_code"],
        // idCardExpiryDate: json["id_card_expiry_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inductee_id": inducteeId,
        "labour_name": labourName,
        "gender": gender,
        "literacy": literacy,
        "marital_status": maritalStatus,
        "blood_group": bloodGroup,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
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
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "adhaar_card_no": adhaarCardNo,
        // "qr_code": qrCode,
        // "id_card_expiry_date": idCardExpiryDate,
      };
}

class LaboursProjectDetail {
  int id;
  int labourId;
  int projectId;
  int tradeId;
  String isActive;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String skillType;
  int contractorId;
  String tradeName;
  String contractorContactPersonName;
  String contractorPhoneNo;

  LaboursProjectDetail({
    required this.id,
    required this.labourId,
    required this.projectId,
    required this.tradeId,
    required this.isActive,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.skillType,
    required this.contractorId,
    required this.tradeName,
    required this.contractorContactPersonName,
    required this.contractorPhoneNo,
  });

  factory LaboursProjectDetail.fromJson(Map<String, dynamic> json) =>
      LaboursProjectDetail(
        id: json["id"],
        labourId: json["labour_id"],
        projectId: json["project_id"],
        tradeId: json["trade_id"],
        isActive: json["is_active"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        skillType: json["skill_type"],
        contractorId: json["contractor_id"],
        tradeName: json["trade_name"],
        contractorContactPersonName: json["contractor_contact_person_name"],
        contractorPhoneNo: json["contractor_phone_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "labour_id": labourId,
        "project_id": projectId,
        "trade_id": tradeId,
        "is_active": isActive,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "skill_type": skillType,
        "contractor_id": contractorId,
        "trade_name": tradeName,
        "contractor_contact_person_name": contractorContactPersonName,
        "contractor_phone_no": contractorPhoneNo,
      };
}
