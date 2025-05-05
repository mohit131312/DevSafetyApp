// To parse this JSON data, do
//
//     final safetyViolation = safetyViolationFromJson(jsonString);

import 'dart:convert';

SafetyViolation safetyViolationFromJson(String str) =>
    SafetyViolation.fromJson(json.decode(str));

String safetyViolationToJson(SafetyViolation data) =>
    json.encode(data.toJson());

class SafetyViolation {
  Data data;
  String message;
  bool status;
  bool token;

  SafetyViolation({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory SafetyViolation.fromJson(Map<String, dynamic> json) =>
      SafetyViolation(
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
  List<Category> violationType;
  List<Category> category;
  List<Category> riskLevel;
  List<Category> sourceOfObservation;
  List<InvolvedList> involvedLaboursList;
  List<InvolvedStaffList> involvedStaffList;
  List<InvolvedContractorUserList> involvedContractorUserList;
  List<InformedAsgineeUserList> informedAsgineeUserList;

  Data({
    required this.violationType,
    required this.category,
    required this.riskLevel,
    required this.sourceOfObservation,
    required this.involvedLaboursList,
    required this.involvedStaffList,
    required this.involvedContractorUserList,
    required this.informedAsgineeUserList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        violationType: List<Category>.from(
            json["violation_type"].map((x) => Category.fromJson(x))),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        riskLevel: List<Category>.from(
            json["risk_level"].map((x) => Category.fromJson(x))),
        sourceOfObservation: List<Category>.from(
            json["source_of_observation"].map((x) => Category.fromJson(x))),
        involvedLaboursList: List<InvolvedList>.from(
            json["involved_labours_list"].map((x) => InvolvedList.fromJson(x))),
        involvedStaffList: List<InvolvedStaffList>.from(
            json["involved_staff_list"]
                .map((x) => InvolvedStaffList.fromJson(x))),
        involvedContractorUserList: List<InvolvedContractorUserList>.from(
            json["involved_contractor_user_list"]
                .map((x) => InvolvedContractorUserList.fromJson(x))),
        informedAsgineeUserList: List<InformedAsgineeUserList>.from(
            json["informed_asginee_user_list"]
                .map((x) => InformedAsgineeUserList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "violation_type":
            List<dynamic>.from(violationType.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "risk_level": List<dynamic>.from(riskLevel.map((x) => x.toJson())),
        "source_of_observation":
            List<dynamic>.from(sourceOfObservation.map((x) => x.toJson())),
        "involved_labours_list":
            List<dynamic>.from(involvedLaboursList.map((x) => x.toJson())),
        "involved_staff_list":
            List<dynamic>.from(involvedStaffList.map((x) => x.toJson())),
        "involved_contractor_user_list": List<dynamic>.from(
            involvedContractorUserList.map((x) => x.toJson())),
        "informed_asginee_user_list":
            List<dynamic>.from(informedAsgineeUserList.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String safetyDetails;

  Category({
    required this.id,
    required this.safetyDetails,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        safetyDetails: json["safety_details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "safety_details": safetyDetails,
      };
}

class InformedAsgineeUserList {
  int id;
  String firstName;
  String lastName;
  // String email;
  // dynamic emailVerifiedAt;
  // String location;
  String mobileNumber;
  // int role;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String encryptPassword;
  // dynamic deletedAt;
  // String apiToken;
  // dynamic fcmToken;
  String? designation;
  // int userParty;
  // String emergencyContactName;
  // String emergencyContactRelation;
  // String emergencyContactNumber;
  // int idProof;
  // String idProofNumber;
  //String documentPath;
  String? profilePhoto;
  // int isActive;
  // dynamic adhaarCardNo;

  InformedAsgineeUserList({
    required this.id,
    required this.firstName,
    required this.lastName,
    // required this.email,
    // required this.emailVerifiedAt,
    // required this.location,
    required this.mobileNumber,
    // required this.role,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.encryptPassword,
    // required this.deletedAt,
    // required this.apiToken,
    // required this.fcmToken,
    this.designation,
    // required this.userParty,
    // required this.emergencyContactName,
    // required this.emergencyContactRelation,
    // required this.emergencyContactNumber,
    // required this.idProof,
    // required this.idProofNumber,
    // required this.documentPath,
    this.profilePhoto,
    // required this.isActive,
    // required this.adhaarCardNo,
  });

  factory InformedAsgineeUserList.fromJson(Map<String, dynamic> json) =>
      InformedAsgineeUserList(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        // email: json["email"],
        // emailVerifiedAt: json["email_verified_at"],
        // location: json["location"],
        mobileNumber: json["mobile_number"],
        // role: json["role"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // encryptPassword: json["encrypt_password"],
        // deletedAt: json["deleted_at"],
        // apiToken: json["api_token"],
        // fcmToken: json["FCM_token"],
        designation: json["designation"] ?? '', // Handle null designation
        // emergencyContactName: json["emergency_contact_name"],
        // emergencyContactRelation: json["emergency_contact_relation"],
        // emergencyContactNumber: json["emergency_contact_number"],
        // idProof: json["id_proof"],
        // idProofNumber: json["id_proof_number"],
        // documentPath: json["document_path"],
        profilePhoto: json["profile_photo"] ?? '',
        // isActive: json["is_active"],
        // adhaarCardNo: json["adhaar_card_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        // "email": email,
        // "email_verified_at": emailVerifiedAt,
        // "location": location,
        "mobile_number": mobileNumber,
        // "role": role,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "encrypt_password": encryptPassword,
        // "deleted_at": deletedAt,
        // "api_token": apiToken,
        // "FCM_token": fcmToken,
        "designation": designation,
        // "user_party": userParty,
        // "emergency_contact_name": emergencyContactName,
        // "emergency_contact_relation": emergencyContactRelation,
        // "emergency_contact_number": emergencyContactNumber,
        // "id_proof": idProof,
        // "id_proof_number": idProofNumber,
        // "document_path": documentPath,
        "profile_photo": profilePhoto,
        // "is_active": isActive,
        // "adhaar_card_no": adhaarCardNo,
      };
}

class InvolvedContractorUserList {
  int id;
  String contractorName;
  String? contractorEmail;
  String? contractorPhoneNo;
  // int contractorCompanyId;
  // int createdBy;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String contractorsCompanyName;
  // int idProofType;
  // String idProofNumber;
  String? documentPath;
  // String secondaryContactPersonName;
  // String secondaryContactPersonNumber;
  // String qrCode;
  // DateTime idCardExpiryDate;

  InvolvedContractorUserList({
    required this.id,
    required this.contractorName,
    this.contractorEmail,
    this.contractorPhoneNo,
    // required this.contractorCompanyId,
    // required this.createdBy,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.contractorsCompanyName,
    // required this.idProofType,
    // required this.idProofNumber,
    this.documentPath,
    // required this.secondaryContactPersonName,
    // required this.secondaryContactPersonNumber,
    // required this.qrCode,
    // required this.idCardExpiryDate,
  });

  factory InvolvedContractorUserList.fromJson(Map<String, dynamic> json) =>
      InvolvedContractorUserList(
        id: json["id"],
        contractorName: json["contractor_name"],
        contractorEmail: json["contractor_email"] ?? '',
        contractorPhoneNo: json["contractor_phone_no"] ?? '',
        // contractorCompanyId: json["contractor_company_id"],
        // createdBy: json["created_by"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // contractorsCompanyName: json["contractors_company_name"],
        // idProofType: json["id_proof_type"],
        // idProofNumber: json["id_proof_number"],

        documentPath: json["document_path"] ?? '',
        // secondaryContactPersonName: json["secondary_contact_person_name"],
        // secondaryContactPersonNumber: json["secondary_contact_person_number"],
        // qrCode: json["qr_code"],
        // idCardExpiryDate: DateTime.parse(json["id_card_expiry_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contractor_name": contractorName,
        "contractor_email": contractorEmail,
        "contractor_phone_no": contractorPhoneNo,
        // "contractor_company_id": contractorCompanyId,
        // "created_by": createdBy,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "contractors_company_name": contractorsCompanyName,
        // "id_proof_type": idProofType,
        // "id_proof_number": idProofNumber,
        "document_path": documentPath,
        // "secondary_contact_person_name": secondaryContactPersonName,
        // "secondary_contact_person_number": secondaryContactPersonNumber,
        // "qr_code": qrCode,
        // "id_card_expiry_date":
        //     "${idCardExpiryDate.year.toString().padLeft(4, '0')}-${idCardExpiryDate.month.toString().padLeft(2, '0')}-${idCardExpiryDate.day.toString().padLeft(2, '0')}",
      };
}

class InvolvedList {
  int id;
  String? inducteeId;
  String? labourName;
  // Gender? gender;
  // Literacy? literacy;
  // MaritalStatus? maritalStatus;
  // BloodGroup? bloodGroup;
  // DateTime? birthDate;
  // int age;
  String? contactNumber;
  String? userPhoto;
  // String currentStreetName;
  // String currentCity;
  // String currentTaluka;
  // int currentDistrict;
  // int currentState;
  // String currentPincode;
  // String permanentStreetName;
  // String permanentCity;
  // String permanentTaluka;
  // int permanentDistrict;
  // int permanentState;
  // String permanentPincode;
  // int experienceInYears;
  // dynamic uanNumber;
  // dynamic bocwNumber;
  // String? bankName;
  // String? ifscNumber;
  // String accountNumber;
  // String branchAddress;
  // String groupInsuranceLimit;
  // String insuranceNumber;
  // String insuranceType;
  // DateTime insuranceValidity;
  // String emergencyContactName;
  // String emergencyContactNumber;
  // String emergencyContactRelation;
  // String isActive;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String adhaarCardNo;
  // String? qrCode;
  // DateTime? idCardExpiryDate;
  // String staffId;
  // String staffName;
  // String adhaarNo;

  InvolvedList({
    required this.id,
    this.inducteeId,
    this.labourName,
    // this.gender,
    // this.literacy,
    // this.maritalStatus,
    // this.bloodGroup,
    // required this.birthDate,
    // required this.age,
    this.contactNumber,
    this.userPhoto,
    // required this.currentStreetName,
    // required this.currentCity,
    // required this.currentTaluka,
    // required this.currentDistrict,
    // required this.currentState,
    // required this.currentPincode,
    // required this.permanentStreetName,
    // required this.permanentCity,
    // required this.permanentTaluka,
    // required this.permanentDistrict,
    // required this.permanentState,
    // required this.permanentPincode,
    // required this.experienceInYears,
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
    // required this.staffId,
    // required this.staffName,
    // required this.adhaarNo,
  });
  factory InvolvedList.fromJson(Map<String, dynamic> json) => InvolvedList(
        id: json["id"],
        inducteeId: json["inductee_id"] ?? "",
        labourName: json["labour_name"] ?? "",
        // gender: genderValues.map[json["gender"]],
        // literacy: literacyValues.map[json["literacy"]],
        // maritalStatus: maritalStatusValues.map[json["marital_status"]],
        // bloodGroup: bloodGroupValues.map[json["blood_group"]],
        // birthDate: json["birth_date"] != null
        //     ? DateTime.parse(json["birth_date"])
        //     : null,
        // age: json["age"] ?? 0,
        contactNumber: json["contact_number"] ?? "",
        userPhoto: json["user_photo"] ?? "",
        // currentStreetName: json["current_street_name"] ?? "",
        // currentCity: json["current_city"] ?? "",
        // currentTaluka: json["current_taluka"] ?? "",
        // currentDistrict: json["current_district"] ?? 0,
        // currentState: json["current_state"] ?? 0,
        // currentPincode: json["current_pincode"] ?? "",
        // permanentStreetName: json["permanent_street_name"] ?? "",
        // permanentCity: json["permanent_city"] ?? "",
        // permanentTaluka: json["permanent_taluka"] ?? "",
        // permanentDistrict: json["permanent_district"] ?? 0,
        // permanentState: json["permanent_state"] ?? 0,
        // permanentPincode: json["permanent_pincode"] ?? "",
        // experienceInYears: json["experience_in_years"] ?? 0,
        // uanNumber: json["uan_number"] ?? "", // Handle null
        // bocwNumber: json["bocw_number"] ?? "", // Handle null
        // bankName: json["bank_name"] ?? "", // Handle null
        // ifscNumber: json["ifsc_number"] ?? "", // Handle null
        // accountNumber: json["account_number"] ?? "", // Handle null
        // branchAddress: json["branch_address"] ?? "", // Handle null
        // groupInsuranceLimit: json["group_insurance_limit"] ?? "", // Handle null
        // insuranceNumber: json["insurance_number"] ?? "", // Handle null
        // insuranceType: json["insurance_type"] ?? "", // Handle null
        // insuranceValidity: json["insurance_validity"] != null
        //     ? DateTime.parse(json["insurance_validity"])
        //     : DateTime.now(),
        // emergencyContactName: json["emergency_contact_name"] ?? "",
        // emergencyContactNumber: json["emergency_contact_number"] ?? "",
        // emergencyContactRelation: json["emergency_contact_relation"] ?? "",
        // isActive: json["is_active"] ?? "0",
        // deletedAt: json["deleted_at"],
        // createdAt: json["created_at"] != null
        //     ? DateTime.parse(json["created_at"])
        //     : DateTime.now(),
        // updatedAt: json["updated_at"] != null
        //     ? DateTime.parse(json["updated_at"])
        //     : DateTime.now(),
        // adhaarCardNo: json["adhaar_card_no"] ?? "",
        // qrCode: json["qr_code"] ?? "", // Handle null
        // idCardExpiryDate: json["id_card_expiry_date"] != null
        //     ? DateTime.parse(json["id_card_expiry_date"])
        //     : DateTime.now(),
        // staffId: json["staff_id"] ?? "",
        // staffName: json["staff_name"] ?? "",
        // adhaarNo: json["adhaar_no"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inductee_id": inducteeId,
        "labour_name": labourName,
        // "gender": genderValues.reverse[gender],
        // "literacy": literacyValues.reverse[literacy],
        // "marital_status": maritalStatusValues.reverse[maritalStatus],
        // "blood_group": bloodGroupValues.reverse[bloodGroup],
        // "birth_date":
        //     "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        // "age": age,
        "contact_number": contactNumber,
        "user_photo": userPhoto,
        // "current_street_name": currentStreetName,
        // "current_city": currentCity,
        // "current_taluka": currentTaluka,
        // "current_district": currentDistrict,
        // "current_state": currentState,
        // "current_pincode": currentPincode,
        // "permanent_street_name": permanentStreetName,
        // "permanent_city": permanentCity,
        // "permanent_taluka": permanentTaluka,
        // "permanent_district": permanentDistrict,
        // "permanent_state": permanentState,
        // "permanent_pincode": permanentPincode,
        // "experience_in_years": experienceInYears,
        // "uan_number": uanNumber,
        // "bocw_number": bocwNumber,
        // "bank_name": bankName,
        // "ifsc_number": ifscNumber,
        // "account_number": accountNumber,
        // "branch_address": branchAddress,
        // "group_insurance_limit": groupInsuranceLimit,
        // "insurance_number": insuranceNumber,
        // "insurance_type": insuranceType,
        // "insurance_validity":
        //     "${insuranceValidity.year.toString().padLeft(4, '0')}-${insuranceValidity.month.toString().padLeft(2, '0')}-${insuranceValidity.day.toString().padLeft(2, '0')}",
        // "emergency_contact_name": emergencyContactName,
        // "emergency_contact_number": emergencyContactNumber,
        // "emergency_contact_relation": emergencyContactRelation,
        // "is_active": isActive,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "adhaar_card_no": adhaarCardNo,
        // "qr_code": qrCode,
        // "id_card_expiry_date":
        //     "${idCardExpiryDate!.year.toString().padLeft(4, '0')}-${idCardExpiryDate!.month.toString().padLeft(2, '0')}-${idCardExpiryDate!.day.toString().padLeft(2, '0')}",
        // "staff_id": staffId,
        // "staff_name": staffName,
        // "adhaar_no": adhaarNo,
      };
}

//---------------------------------------

class InvolvedStaffList {
  int id;
  String staffId;
  String staffName;
  // Gender? gender;
  // Literacy? literacy;
  // MaritalStatus? maritalStatus;
  // BloodGroup? bloodGroup;
  // DateTime? birthDate;
  // int age;
  String contactNumber;
  String userPhoto;
  // String currentStreetName;
  // String currentCity;
  // String currentTaluka;
  // int currentDistrict;
  // int currentState;
  // String currentPincode;
  // String permanentStreetName;
  // String permanentCity;
  // String permanentTaluka;
  // int permanentDistrict;
  // int permanentState;
  // String permanentPincode;
  // int experienceInYears;
  // dynamic uanNumber;
  // dynamic bocwNumber;
  // String? bankName;
  // String? ifscNumber;
  // String accountNumber;
  // String branchAddress;
  // String groupInsuranceLimit;
  // String insuranceNumber;
  // String insuranceType;
  // DateTime insuranceValidity;
  // String emergencyContactName;
  // String emergencyContactNumber;
  // String emergencyContactRelation;
  // String isActive;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String adhaarCardNo;
  // String? qrCode;
  // DateTime? idCardExpiryDate;
  // String staffId;
  // String staffName;
  // String adhaarNo;

  InvolvedStaffList({
    required this.id,
    required this.staffId,
    required this.staffName,
    // this.gender,
    // this.literacy,
    // this.maritalStatus,
    // this.bloodGroup,
    // required this.birthDate,
    // required this.age,
    required this.contactNumber,
    required this.userPhoto,
    // required this.currentStreetName,
    // required this.currentCity,
    // required this.currentTaluka,
    // required this.currentDistrict,
    // required this.currentState,
    // required this.currentPincode,
    // required this.permanentStreetName,
    // required this.permanentCity,
    // required this.permanentTaluka,
    // required this.permanentDistrict,
    // required this.permanentState,
    // required this.permanentPincode,
    // required this.experienceInYears,
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
    // required this.staffId,
    // required this.staffName,
    // required this.adhaarNo,
  });
  factory InvolvedStaffList.fromJson(Map<String, dynamic> json) =>
      InvolvedStaffList(
        id: json["id"],
        staffId: json["inductee_id"] ?? "",
        staffName: json["staff_name"] ?? "",
        // gender: genderValues.map[json["gender"]],
        // literacy: literacyValues.map[json["literacy"]],
        // maritalStatus: maritalStatusValues.map[json["marital_status"]],
        // bloodGroup: bloodGroupValues.map[json["blood_group"]],
        // birthDate: json["birth_date"] != null
        //     ? DateTime.parse(json["birth_date"])
        //     : null,
        // age: json["age"] ?? 0,
        contactNumber: json["contact_number"] ?? "",
        userPhoto: json["user_photo"] ?? "",
        // currentStreetName: json["current_street_name"] ?? "",
        // currentCity: json["current_city"] ?? "",
        // currentTaluka: json["current_taluka"] ?? "",
        // currentDistrict: json["current_district"] ?? 0,
        // currentState: json["current_state"] ?? 0,
        // currentPincode: json["current_pincode"] ?? "",
        // permanentStreetName: json["permanent_street_name"] ?? "",
        // permanentCity: json["permanent_city"] ?? "",
        // permanentTaluka: json["permanent_taluka"] ?? "",
        // permanentDistrict: json["permanent_district"] ?? 0,
        // permanentState: json["permanent_state"] ?? 0,
        // permanentPincode: json["permanent_pincode"] ?? "",
        // experienceInYears: json["experience_in_years"] ?? 0,
        // uanNumber: json["uan_number"] ?? "", // Handle null
        // bocwNumber: json["bocw_number"] ?? "", // Handle null
        // bankName: json["bank_name"] ?? "", // Handle null
        // ifscNumber: json["ifsc_number"] ?? "", // Handle null
        // accountNumber: json["account_number"] ?? "", // Handle null
        // branchAddress: json["branch_address"] ?? "", // Handle null
        // groupInsuranceLimit: json["group_insurance_limit"] ?? "", // Handle null
        // insuranceNumber: json["insurance_number"] ?? "", // Handle null
        // insuranceType: json["insurance_type"] ?? "", // Handle null
        // insuranceValidity: json["insurance_validity"] != null
        //     ? DateTime.parse(json["insurance_validity"])
        //     : DateTime.now(),
        // emergencyContactName: json["emergency_contact_name"] ?? "",
        // emergencyContactNumber: json["emergency_contact_number"] ?? "",
        // emergencyContactRelation: json["emergency_contact_relation"] ?? "",
        // isActive: json["is_active"] ?? "0",
        // deletedAt: json["deleted_at"],
        // createdAt: json["created_at"] != null
        //     ? DateTime.parse(json["created_at"])
        //     : DateTime.now(),
        // updatedAt: json["updated_at"] != null
        //     ? DateTime.parse(json["updated_at"])
        //     : DateTime.now(),
        // adhaarCardNo: json["adhaar_card_no"] ?? "",
        // qrCode: json["qr_code"] ?? "", // Handle null
        // idCardExpiryDate: json["id_card_expiry_date"] != null
        //     ? DateTime.parse(json["id_card_expiry_date"])
        //     : DateTime.now(),
        // staffId: json["staff_id"] ?? "",
        // staffName: json["staff_name"] ?? "",
        // adhaarNo: json["adhaar_no"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inductee_id": staffId,
        "staff_name": staffName,
        // "gender": genderValues.reverse[gender],
        // "literacy": literacyValues.reverse[literacy],
        // "marital_status": maritalStatusValues.reverse[maritalStatus],
        // "blood_group": bloodGroupValues.reverse[bloodGroup],
        // "birth_date":
        //     "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        // "age": age,
        "contact_number": contactNumber,
        "user_photo": userPhoto,
        // "current_street_name": currentStreetName,
        // "current_city": currentCity,
        // "current_taluka": currentTaluka,
        // "current_district": currentDistrict,
        // "current_state": currentState,
        // "current_pincode": currentPincode,
        // "permanent_street_name": permanentStreetName,
        // "permanent_city": permanentCity,
        // "permanent_taluka": permanentTaluka,
        // "permanent_district": permanentDistrict,
        // "permanent_state": permanentState,
        // "permanent_pincode": permanentPincode,
        // "experience_in_years": experienceInYears,
        // "uan_number": uanNumber,
        // "bocw_number": bocwNumber,
        // "bank_name": bankName,
        // "ifsc_number": ifscNumber,
        // "account_number": accountNumber,
        // "branch_address": branchAddress,
        // "group_insurance_limit": groupInsuranceLimit,
        // "insurance_number": insuranceNumber,
        // "insurance_type": insuranceType,
        // "insurance_validity":
        //     "${insuranceValidity.year.toString().padLeft(4, '0')}-${insuranceValidity.month.toString().padLeft(2, '0')}-${insuranceValidity.day.toString().padLeft(2, '0')}",
        // "emergency_contact_name": emergencyContactName,
        // "emergency_contact_number": emergencyContactNumber,
        // "emergency_contact_relation": emergencyContactRelation,
        // "is_active": isActive,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "adhaar_card_no": adhaarCardNo,
        // "qr_code": qrCode,
        // "id_card_expiry_date":
        //     "${idCardExpiryDate!.year.toString().padLeft(4, '0')}-${idCardExpiryDate!.month.toString().padLeft(2, '0')}-${idCardExpiryDate!.day.toString().padLeft(2, '0')}",
        // "staff_id": staffId,
        // "staff_name": staffName,
        // "adhaar_no": adhaarNo,
      };
}

enum BloodGroup {
  A,
  AB,
  B,
  BLOOD_GROUP_A,
  BLOOD_GROUP_AB,
  BLOOD_GROUP_B,
  O,
  PURPLE_A
}

final bloodGroupValues = EnumValues({
  "A-": BloodGroup.A,
  "AB+": BloodGroup.AB,
  "B-": BloodGroup.B,
  "A": BloodGroup.BLOOD_GROUP_A,
  "AB-": BloodGroup.BLOOD_GROUP_AB,
  "B+": BloodGroup.BLOOD_GROUP_B,
  "O+": BloodGroup.O,
  "A+": BloodGroup.PURPLE_A
});

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({"Female": Gender.FEMALE, "Male": Gender.MALE});

enum Literacy { ILLITERATE, LITERATE }

final literacyValues = EnumValues(
    {"Illiterate": Literacy.ILLITERATE, "Literate": Literacy.LITERATE});

enum MaritalStatus { MARRIED, UNMARRIED }

final maritalStatusValues = EnumValues(
    {"Married": MaritalStatus.MARRIED, "Unmarried": MaritalStatus.UNMARRIED});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
