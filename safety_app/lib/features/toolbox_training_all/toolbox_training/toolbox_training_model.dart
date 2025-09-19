// To parse this JSON data, do
//
//     final toolboxTrainingModel = toolboxTrainingModelFromJson(jsonString);

import 'dart:convert';

ToolboxTrainingModel toolboxTrainingModelFromJson(String str) =>
    ToolboxTrainingModel.fromJson(json.decode(str));

String toolboxTrainingModelToJson(ToolboxTrainingModel data) =>
    json.encode(data.toJson());

class ToolboxTrainingModel {
  Data data;
  String message;
  bool status;
  bool token;

  ToolboxTrainingModel({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory ToolboxTrainingModel.fromJson(Map<String, dynamic> json) =>
      ToolboxTrainingModel(
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
  List<ToolboxCategoryList> toolboxCategoryList;
  List<dynamic> topicsInstructionsList;
  List<TraineesList> traineesLaboursList;
  List<TraineesListStaff> traineesStaffList;
  List<TraineesContractorUserList> traineesContractorUserList;
  List<ReviwerUserList> reviwerUserList;
  List<WorkPermit> workPermits;

  Data({
    required this.toolboxCategoryList,
    required this.topicsInstructionsList,
    required this.traineesLaboursList,
    required this.traineesStaffList,
    required this.traineesContractorUserList,
    required this.reviwerUserList,
    required this.workPermits,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        toolboxCategoryList: List<ToolboxCategoryList>.from(
            json["toolbox_category_list"]
                .map((x) => ToolboxCategoryList.fromJson(x))),
        topicsInstructionsList:
            List<dynamic>.from(json["topics_instructions_list"].map((x) => x)),
        traineesLaboursList: List<TraineesList>.from(
            json["trainees_labours_list"].map((x) => TraineesList.fromJson(x))),
        traineesStaffList: List<TraineesListStaff>.from(
            json["trainees_staff_list"]
                .map((x) => TraineesListStaff.fromJson(x))),
        traineesContractorUserList: List<TraineesContractorUserList>.from(
            json["trainees_contractor_user_list"]
                .map((x) => TraineesContractorUserList.fromJson(x))),
        reviwerUserList: List<ReviwerUserList>.from(
            json["reviwer_user_list"].map((x) => ReviwerUserList.fromJson(x))),
        workPermits: List<WorkPermit>.from(
            json["work_permits"].map((x) => WorkPermit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "toolbox_category_list":
            List<dynamic>.from(toolboxCategoryList.map((x) => x.toJson())),
        "topics_instructions_list":
            List<dynamic>.from(topicsInstructionsList.map((x) => x)),
        "trainees_labours_list":
            List<dynamic>.from(traineesLaboursList.map((x) => x.toJson())),
        "trainees_staff_list":
            List<dynamic>.from(traineesStaffList.map((x) => x.toJson())),
        "trainees_contractor_user_list": List<dynamic>.from(
            traineesContractorUserList.map((x) => x.toJson())),
        "reviwer_user_list":
            List<dynamic>.from(reviwerUserList.map((x) => x.toJson())),
        "work_permits": List<dynamic>.from(workPermits.map((x) => x.toJson())),
      };
}

class ReviwerUserList {
  int id;
  String? firstName;
  String? lastName;
  // String email;
  // dynamic emailVerifiedAt;
  // String location;
  String? mobileNumber;
  int? role;
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
  // String documentPath;
  String? profilePhoto;
  // int isActive;
  // dynamic adhaarCardNo;

  ReviwerUserList({
    required this.id,
    this.firstName,
    this.lastName,
    // required this.email,
    // required this.emailVerifiedAt,
    // required this.location,
    this.mobileNumber,
    this.role,
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

  factory ReviwerUserList.fromJson(Map<String, dynamic> json) =>
      ReviwerUserList(
        id: json["id"],
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        // email: json["email"],
        // emailVerifiedAt: json["email_verified_at"],
        // location: json["location"],
        mobileNumber: json["mobile_number"] ?? "",
        role: json["role"] ?? 0,
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // encryptPassword: json["encrypt_password"],
        // deletedAt: json["deleted_at"],
        // apiToken: json["api_token"],
        // fcmToken: json["FCM_token"],
        designation: json["designation"] ?? "",
        // userParty: json["user_party"],
        // emergencyContactName: json["emergency_contact_name"],
        // emergencyContactRelation: json["emergency_contact_relation"],
        // emergencyContactNumber: json["emergency_contact_number"],
        // idProof: json["id_proof"],
        // idProofNumber: json["id_proof_number"],
        // documentPath: json["document_path"],
        profilePhoto: json["profile_photo"] ?? "",
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
        "role": role,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "encrypt_password": encryptPassword,
        // "deleted_at": deletedAt,
        // "api_token": apiToken,
        // "FCM_token": fcmToken,
        // "designation": designation,
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

class ToolboxCategoryList {
  int id;
  String categoryName;

  ToolboxCategoryList({
    required this.id,
    required this.categoryName,
  });

  factory ToolboxCategoryList.fromJson(Map<String, dynamic> json) =>
      ToolboxCategoryList(
        id: json["id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
      };
}



class ContractorUserList {
  final int contractor_id;
  final String? contractorName;
  final String? contractorEmail;
  final String? contractorPhoneNo;
  final int? contractorCompanyId;
  final int? createdBy;
  final String? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contractorsCompanyName;
  final int? idProofType;
  final String? idProofNumber;
  final String? documentPath;
  final String? secondaryContactPersonName;
  final String? secondaryContactPersonNumber;
  final String? qrCode;
  final String? idCardExpiryDate;
  final int? labourId;
  final int? projectId;
  final int? tradeId;
  final String? isActive;
  final String? skillType;
  final int? contractorId;

  ContractorUserList({
    required this.contractor_id,
    this.contractorName,
    this.contractorEmail,
    this.contractorPhoneNo,
    this.contractorCompanyId,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.contractorsCompanyName,
    this.idProofType,
    this.idProofNumber,
    this.documentPath,
    this.secondaryContactPersonName,
    this.secondaryContactPersonNumber,
    this.qrCode,
    this.idCardExpiryDate,
    this.labourId,
    this.projectId,
    this.tradeId,
    this.isActive,
    this.skillType,
    this.contractorId,
  });

  factory ContractorUserList.fromJson(Map<String, dynamic> json) =>
      ContractorUserList(
        contractor_id: json["contractor_id"] ?? 0,
        contractorName: json["contractor_name"] ?? "",
        contractorEmail: json["contractor_email"] ?? "",
        contractorPhoneNo: json["contractor_phone_no"] ?? "",
        contractorCompanyId: json["contractor_company_id"],
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        contractorsCompanyName: json["contractors_company_name"] ?? "",
        idProofType: json["id_proof_type"],
        idProofNumber: json["id_proof_number"],
        documentPath: json["document_path"],
        secondaryContactPersonName: json["secondary_contact_person_name"],
        secondaryContactPersonNumber: json["secondary_contact_person_number"],
        qrCode: json["qr_code"],
        idCardExpiryDate: json["id_card_expiry_date"],
        labourId: json["labour_id"],
        projectId: json["project_id"],
        tradeId: json["trade_id"],
        isActive: json["is_active"],
        skillType: json["skill_type"],
        contractorId: json["contractor_id"],
      );

  Map<String, dynamic> toJson() => {
    "id": contractor_id,
    "contractor_name": contractorName,
    "contractor_email": contractorEmail,
    "contractor_phone_no": contractorPhoneNo,
    "contractor_company_id": contractorCompanyId,
    "created_by": createdBy,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "contractors_company_name": contractorsCompanyName,
    "id_proof_type": idProofType,
    "id_proof_number": idProofNumber,
    "document_path": documentPath,
    "secondary_contact_person_name": secondaryContactPersonName,
    "secondary_contact_person_number": secondaryContactPersonNumber,
    "qr_code": qrCode,
    "id_card_expiry_date": idCardExpiryDate,
    "labour_id": labourId,
    "project_id": projectId,
    "trade_id": tradeId,
    "is_active": isActive,
    "skill_type": skillType,
    "contractor_id": contractorId,
  };
}

class TraineesContractorUserList {
  int id;
  String? contractorName;
  String? contractorEmail;
  String? contractorPhoneNo;
  int? contractorCompanyId;
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

  TraineesContractorUserList({
    required this.id,
    this.contractorName,
    this.contractorEmail,
    this.contractorPhoneNo,
    this.contractorCompanyId,
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

  factory TraineesContractorUserList.fromJson(Map<String, dynamic> json) =>
      TraineesContractorUserList(
        id: json["id"],
        contractorName: json["contractor_name"] ?? "",
        contractorEmail: json["contractor_email"] ?? "",
        contractorPhoneNo: json["contractor_phone_no"] ?? "",
        contractorCompanyId: json["contractor_company_id"] ?? "",
        // createdBy: json["created_by"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // contractorsCompanyName: json["contractors_company_name"],
        // idProofType: json["id_proof_type"],
        // idProofNumber: json["id_proof_number"],
        documentPath: json["document_path"] ?? "",
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
        "contractor_company_id": contractorCompanyId,
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

class TraineesList {
  int id;
  String? inducteeId;
  String? labourName;
  // Gender gender;
  // Literacy literacy;
  // MaritalStatus maritalStatus;
  // BloodGroup bloodGroup;
  // DateTime birthDate;
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
  // String emergencyContactName;
  // String emergencyContactNumber;
  // String emergencyContactRelation;
  // String isActive;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String adhaarCardNo;
  // String qrCode;
  // DateTime idCardExpiryDate;
  // String staffId;
  // String staffName;
  // String adhaarNo;

  TraineesList({
    required this.id,
    this.inducteeId,
    this.labourName,
    // required this.gender,
    // required this.literacy,
    // required this.maritalStatus,
    // required this.bloodGroup,
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

  factory TraineesList.fromJson(Map<String, dynamic> json) => TraineesList(
        id: json["id"],
        inducteeId: json["inductee_id"] ?? "",
        labourName: json["labour_name"] ?? "",
        // gender: genderValues.map[json["gender"]] ?? Gender.MALE,
        // literacy: literacyValues.map[json["literacy"]] ?? Literacy.ILLITERATE,
        // maritalStatus: maritalStatusValues.map[json["marital_status"]] ??
        //     MaritalStatus.UNMARRIED,
        // bloodGroup: bloodGroupValues.map[json["blood_group"]] ?? BloodGroup.O,
        // birthDate: DateTime.parse(json["birth_date"]),
        // age: json["age"],
        contactNumber: json["contact_number"] ?? "",
        userPhoto: json["user_photo"] ?? "",
        // currentStreetName: json["current_street_name"],
        // currentCity: json["current_city"],
        // currentTaluka: json["current_taluka"],
        // currentDistrict: json["current_district"],
        // currentState: json["current_state"],
        // currentPincode: json["current_pincode"],
        // permanentStreetName: json["permanent_street_name"],
        // permanentCity: json["permanent_city"],
        // permanentTaluka: json["permanent_taluka"],
        // permanentDistrict: json["permanent_district"],
        // permanentState: json["permanent_state"],
        // permanentPincode: json["permanent_pincode"],
        // experienceInYears: json["experience_in_years"],
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
        // idCardExpiryDate: DateTime.parse(json["id_card_expiry_date"]),
        // staffId: json["staff_id"],
        // staffName: json["staff_name"],
        // adhaarNo: json["adhaar_no"],
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
        //     "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
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
        // "id_card_expiry_date":
        //     "${idCardExpiryDate.year.toString().padLeft(4, '0')}-${idCardExpiryDate.month.toString().padLeft(2, '0')}-${idCardExpiryDate.day.toString().padLeft(2, '0')}",
        // "staff_id": staffId,
        // "staff_name": staffName,
        // "adhaar_no": adhaarNo,
      };
}

class TraineesListStaff {
  int staffid;
  String? staffinducteeId;
  String? staffName;
  // Gender gender;
  // Literacy literacy;
  // MaritalStatus maritalStatus;
  // BloodGroup bloodGroup;
  // DateTime birthDate;
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
  // String emergencyContactName;
  // String emergencyContactNumber;
  // String emergencyContactRelation;
  // String isActive;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String adhaarCardNo;
  // String qrCode;
  // DateTime idCardExpiryDate;
  // String staffId;
  // String staffName;
  // String adhaarNo;

  TraineesListStaff({
    required this.staffid,
    this.staffinducteeId,
    this.staffName,
    // required this.gender,
    // required this.literacy,
    // required this.maritalStatus,
    // required this.bloodGroup,
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

  factory TraineesListStaff.fromJson(Map<String, dynamic> json) =>
      TraineesListStaff(
        staffid: json["id"],
        staffinducteeId: json["inductee_id"] ?? "",
        staffName: json["staff_name"] ?? "",
        // gender: genderValues.map[json["gender"]] ?? Gender.MALE,
        // literacy: literacyValues.map[json["literacy"]] ?? Literacy.ILLITERATE,
        // maritalStatus: maritalStatusValues.map[json["marital_status"]] ??
        //     MaritalStatus.UNMARRIED,
        // bloodGroup: bloodGroupValues.map[json["blood_group"]] ?? BloodGroup.O,
        // birthDate: DateTime.parse(json["birth_date"]),
        // age: json["age"],
        contactNumber: json["contact_number"] ?? '',
        userPhoto: json["user_photo"] ?? "",
        // currentStreetName: json["current_street_name"],
        // currentCity: json["current_city"],
        // currentTaluka: json["current_taluka"],
        // currentDistrict: json["current_district"],
        // currentState: json["current_state"],
        // currentPincode: json["current_pincode"],
        // permanentStreetName: json["permanent_street_name"],
        // permanentCity: json["permanent_city"],
        // permanentTaluka: json["permanent_taluka"],
        // permanentDistrict: json["permanent_district"],
        // permanentState: json["permanent_state"],
        // permanentPincode: json["permanent_pincode"],
        // experienceInYears: json["experience_in_years"],
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
        // idCardExpiryDate: DateTime.parse(json["id_card_expiry_date"]),
        // staffId: json["staff_id"],
        // staffName: json["staff_name"],
        // adhaarNo: json["adhaar_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": staffid,
        "inductee_id": staffinducteeId,
        "labour_name": staffid,
        // "gender": genderValues.reverse[gender],
        // "literacy": literacyValues.reverse[literacy],
        // "marital_status": maritalStatusValues.reverse[maritalStatus],
        // "blood_group": bloodGroupValues.reverse[bloodGroup],
        // "birth_date":
        //     "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
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
        // "id_card_expiry_date":
        //     "${idCardExpiryDate.year.toString().padLeft(4, '0')}-${idCardExpiryDate.month.toString().padLeft(2, '0')}-${idCardExpiryDate.day.toString().padLeft(2, '0')}",
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
  "A+": BloodGroup.A,
  "AB+": BloodGroup.AB,
  "B-": BloodGroup.B,
  "A-": BloodGroup.BLOOD_GROUP_A,
  "AB-": BloodGroup.BLOOD_GROUP_AB,
  "B+": BloodGroup.BLOOD_GROUP_B,
  "O+": BloodGroup.O,
  "A": BloodGroup.PURPLE_A
});

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({"Female": Gender.FEMALE, "Male": Gender.MALE});

enum Literacy { ILLITERATE, LITERATE }

final literacyValues = EnumValues(
    {"Illiterate": Literacy.ILLITERATE, "Literate": Literacy.LITERATE});

enum MaritalStatus { MARRIED, UNMARRIED }

final maritalStatusValues = EnumValues(
    {"Married": MaritalStatus.MARRIED, "Unmarried": MaritalStatus.UNMARRIED});

class WorkPermit {
  int? id;
  String? nameOfWorkpermit;
  int? subActivityId;
  String? description;
  // int? toolboxTrainingId;
  int? projectId;
  // DateTime fromDateTime;
  // DateTime toDateTime;
  // String makerSignaturePhoto;
  // int makerId;
  // dynamic makerSignaturePhotoAfter;
  // dynamic makerComment;
  // dynamic status;
  // DateTime createdAt;
  // DateTime updatedAt;
  // dynamic deletedAt;
  // int undertaking1;
  // int undertaking2;
  // int undertaking3;
  // String location;

  WorkPermit({
    this.id,
    this.nameOfWorkpermit,
    this.subActivityId,
    this.description,
    // this.toolboxTrainingId,
    this.projectId,
    // required this.fromDateTime,
    // required this.toDateTime,
    // required this.makerSignaturePhoto,
    // required this.makerId,
    // required this.makerSignaturePhotoAfter,
    // required this.makerComment,
    // required this.status,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.deletedAt,
    // required this.undertaking1,
    // required this.undertaking2,
    // required this.undertaking3,
    // required this.location,
  });

  factory WorkPermit.fromJson(Map<String, dynamic> json) => WorkPermit(
        id: json["id"] ?? "",
        nameOfWorkpermit: json["name_of_workpermit"] ?? "",
        subActivityId: json["sub_activity_id"] ?? "",
        description: json["description"] ?? "",
        // toolboxTrainingId: json["toolbox_training_id"] ?? "",
        projectId: json["project_id"] ?? "",
        // fromDateTime: DateTime.parse(json["from_date_time"]),
        // toDateTime: DateTime.parse(json["to_date_time"]),
        // makerSignaturePhoto: json["maker_signature_photo"],
        // makerId: json["maker_id"],
        // makerSignaturePhotoAfter: json["maker_signature_photo_after"],
        // makerComment: json["maker_comment"],
        // status: json["status"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // deletedAt: json["deleted_at"],
        // undertaking1: json["undertaking_1"],
        // undertaking2: json["undertaking_2"],
        // undertaking3: json["undertaking_3"],
        // location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_of_workpermit": nameOfWorkpermit,
        "sub_activity_id": subActivityId,
        "description": description,
        // "toolbox_training_id": toolboxTrainingId,
        "project_id": projectId,
        // "from_date_time": fromDateTime.toIso8601String(),
        // "to_date_time": toDateTime.toIso8601String(),
        // "maker_signature_photo": makerSignaturePhoto,
        // "maker_id": makerId,
        // "maker_signature_photo_after": makerSignaturePhotoAfter,
        // "maker_comment": makerComment,
        // "status": status,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "deleted_at": deletedAt,
        // "undertaking_1": undertaking1,
        // "undertaking_2": undertaking2,
        // "undertaking_3": undertaking3,
        // "location": location,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

InstructionData instructionDataFromJson(String str) =>
    InstructionData.fromJson(json.decode(str));

String instructionDataToJson(InstructionData data) =>
    json.encode(data.toJson());

class InstructionData {
  List<Instruction> data;
  String message;
  bool status;
  bool token;

  InstructionData({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory InstructionData.fromJson(Map<String, dynamic> json) =>
      InstructionData(
        data: List<Instruction>.from(
            json["data"].map((x) => Instruction.fromJson(x))),
        message: json["message"],
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "token": token,
      };
}

class Instruction {
  int id;
  String toolboxDetails;

  Instruction({
    required this.id,
    required this.toolboxDetails,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
        id: json["id"],
        toolboxDetails: json["toolbox_details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "toolbox_details": toolboxDetails,
      };
}
