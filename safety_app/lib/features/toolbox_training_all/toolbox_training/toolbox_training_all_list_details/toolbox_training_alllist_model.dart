// To parse this JSON data, do
//
//     final toolboxAllModel = toolboxAllModelFromJson(jsonString);

import 'dart:convert';

ToolboxAllModel toolboxAllModelFromJson(String str) =>
    ToolboxAllModel.fromJson(json.decode(str));

String toolboxAllModelToJson(ToolboxAllModel data) =>
    json.encode(data.toJson());

class ToolboxAllModel {
  Data data;
  String message;
  bool status;
  bool token;

  ToolboxAllModel({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory ToolboxAllModel.fromJson(Map<String, dynamic> json) =>
      ToolboxAllModel(
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
  List<SafetyToolboxTraining> safetyToolboxTraining;
  List<ToolboxCategoryList> toolboxCategoryList;
  List<ToolboxInstructionsList> toolboxInstructionsList;
  List<TraineeLaboursList> traineeLaboursList;
  List<ErUser> makerUser;
  List<ErUser> reviewerUser;
  List<TbtAddedPhoto> tbtAddedPhotos;

  Data({
    required this.safetyToolboxTraining,
    required this.toolboxCategoryList,
    required this.toolboxInstructionsList,
    required this.traineeLaboursList,
    required this.makerUser,
    required this.reviewerUser,
    required this.tbtAddedPhotos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        safetyToolboxTraining: List<SafetyToolboxTraining>.from(
            json["safety_toolbox_training"]
                .map((x) => SafetyToolboxTraining.fromJson(x))),
        toolboxCategoryList: List<ToolboxCategoryList>.from(
            json["toolbox_category_list"]
                .map((x) => ToolboxCategoryList.fromJson(x))),
        toolboxInstructionsList: List<ToolboxInstructionsList>.from(
            json["toolbox_instructions_list"]
                .map((x) => ToolboxInstructionsList.fromJson(x))),
        traineeLaboursList: List<TraineeLaboursList>.from(
            json["trainee_labours_list"]
                .map((x) => TraineeLaboursList.fromJson(x))),
        makerUser: List<ErUser>.from(
            json["maker_user"].map((x) => ErUser.fromJson(x))),
        reviewerUser: List<ErUser>.from(
            json["reviewer_user"].map((x) => ErUser.fromJson(x))),
        tbtAddedPhotos: List<TbtAddedPhoto>.from(
            json["tbt_added_photos"].map((x) => TbtAddedPhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "safety_toolbox_training":
            List<dynamic>.from(safetyToolboxTraining.map((x) => x.toJson())),
        "toolbox_category_list":
            List<dynamic>.from(toolboxCategoryList.map((x) => x.toJson())),
        "toolbox_instructions_list":
            List<dynamic>.from(toolboxInstructionsList.map((x) => x.toJson())),
        "trainee_labours_list":
            List<dynamic>.from(traineeLaboursList.map((x) => x.toJson())),
        "maker_user": List<dynamic>.from(makerUser.map((x) => x.toJson())),
        "reviewer_user":
            List<dynamic>.from(reviewerUser.map((x) => x.toJson())),
        "tbt_added_photos":
            List<dynamic>.from(tbtAddedPhotos.map((x) => x.toJson())),
      };
}

class ErUser {
  int id;
  String firstName;
  String lastName;
  // String email;
  // dynamic emailVerifiedAt;
  // String location;
  // String mobileNumber;
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
  String? documentPath;
  String? profilePhoto;
  // int isActive;
  // dynamic adhaarCardNo;

  ErUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    // required this.email,
    // required this.emailVerifiedAt,
    // required this.location,
    // required this.mobileNumber,
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
    this.documentPath,
    this.profilePhoto,
    // required this.isActive,
    // required this.adhaarCardNo,
  });

  factory ErUser.fromJson(Map<String, dynamic> json) => ErUser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        // email: json["email"],
        // emailVerifiedAt: json["email_verified_at"],
        // location: json["location"],
        // mobileNumber: json["mobile_number"],
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
        documentPath: json["document_path"] ?? "",
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
        // "mobile_number": mobileNumber,
        "role": role,
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
        "document_path": documentPath,
        "profile_photo": profilePhoto,
        // "is_active": isActive,
        // "adhaar_card_no": adhaarCardNo,
      };
}

class SafetyToolboxTraining {
  int id;
  int projectId;
  String? details;
  String? nameOfTbTraining;
  int? toolboxCategoryId;
  int? makerId;
  int? reviwerId;
  String? makerComment;
  String? reviwerComment;
  String? location;
  String? makerSignaturePhoto;
  String? makerPhotoSignatureAfter;
  String? reviwerPhotoSignatureAfter;
  int? status;
  // dynamic reviewerUpdatedAt;
  String? toolboxUniqueId;
  DateTime? createdAt;
  // DateTime updatedAt;
  // dynamic deletedAt;
  // dynamic workPermitId;

  SafetyToolboxTraining({
    required this.id,
    required this.projectId,
    required this.details,
    required this.nameOfTbTraining,
    required this.toolboxCategoryId,
    required this.makerId,
    required this.reviwerId,
    required this.makerComment,
    required this.reviwerComment,
    required this.location,
    required this.makerSignaturePhoto,
    required this.makerPhotoSignatureAfter,
    required this.reviwerPhotoSignatureAfter,
    required this.status,
    // required this.reviewerUpdatedAt,
    this.toolboxUniqueId,
    this.createdAt,
    // required this.updatedAt,
    // required this.deletedAt,
    // required this.workPermitId,
  });

  factory SafetyToolboxTraining.fromJson(Map<String, dynamic> json) =>
      SafetyToolboxTraining(
        id: json["id"],
        projectId: json["project_id"],
        details: json["details"] ?? "",
        nameOfTbTraining: json["name_of_tb_training"] ?? "",
        toolboxCategoryId: json["toolbox_category_id"] ?? 0,
        makerId: json["maker_id"] ?? 0,
        reviwerId: json["reviwer_id"] ?? 0,
        makerComment: json["maker_comment"] ?? "",
        reviwerComment: json["reviwer_comment"] ?? "",
        location: json["location"] ?? "",
        makerSignaturePhoto: json["maker_signature_photo"] ?? "",
        makerPhotoSignatureAfter: json["maker_photo_signature_after"] ?? "",
        reviwerPhotoSignatureAfter: json["reviwer_photo_signature_after"] ?? "",
        status: json["status"] ?? "",
        // reviewerUpdatedAt: json["reviewer_updated_at"],
        toolboxUniqueId: json["toolbox_unique_id"] ?? "",
        createdAt: json["created_at_ind"] != null
            ? DateTime.parse(json["created_at_ind"])
            : DateTime(1970, 1, 1),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // deletedAt: json["deleted_at"],
        // workPermitId: json["work_permit_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "details": details,
        "name_of_tb_training": nameOfTbTraining,
        "toolbox_category_id": toolboxCategoryId,
        "maker_id": makerId,
        "reviwer_id": reviwerId,
        "maker_comment": makerComment,
        "reviwer_comment": reviwerComment,
        "location": location,
        "maker_signature_photo": makerSignaturePhoto,
        "maker_photo_signature_after": makerPhotoSignatureAfter,
        "reviwer_photo_signature_after": reviwerPhotoSignatureAfter,
        "status": status,
        // "reviewer_updated_at": reviewerUpdatedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "deleted_at": deletedAt,
        // "work_permit_id": workPermitId,
      };
}

class TbtAddedPhoto {
  int id;
  // int safetyToolboxTrainingId;
  // int makerId;
  String? photoPath;
  // DateTime createdAt;
  // DateTime updatedAt;
  // dynamic deletedAt;

  TbtAddedPhoto({
    required this.id,
    // required this.safetyToolboxTrainingId,
    // required this.makerId,
    this.photoPath,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.deletedAt,
  });

  factory TbtAddedPhoto.fromJson(Map<String, dynamic> json) => TbtAddedPhoto(
        id: json["id"],
        // safetyToolboxTrainingId: json["safety_toolbox_training_id"],
        // makerId: json["maker_id"],
        photoPath: json["photo_path"] ?? "",
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "safety_toolbox_training_id": safetyToolboxTrainingId,
        // "maker_id": makerId,
        "photo_path": photoPath,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "deleted_at": deletedAt,
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

class ToolboxInstructionsList {
  int id;
  String toolboxInstructions;

  ToolboxInstructionsList({
    required this.id,
    required this.toolboxInstructions,
  });

  factory ToolboxInstructionsList.fromJson(Map<String, dynamic> json) =>
      ToolboxInstructionsList(
        id: json["id"],
        toolboxInstructions: json["toolbox_instructions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "toolbox_instructions": toolboxInstructions,
      };
}


class Contractor {
  final int id;
  final String contractorName;
  final String companyName;

  Contractor({
    required this.id,
    required this.contractorName,
    required this.companyName,
  });

  // Factory constructor to create object from JSON
  factory Contractor.fromJson(Map<String, dynamic> json) {
    return Contractor(
      id: json['id'] ?? 0,
      contractorName: json['contractor_name'] ?? '',
      companyName: json['company_name'] ?? '',
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contractor_name': contractorName,
      'company_name': companyName,
    };
  }
}


class TraineeLaboursList {
  int id;
  String? inducteeId;
  String? labourName;
  // String gender;
  // String literacy;
  // String maritalStatus;
  // String bloodGroup;
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
  // dynamic qrCode;
  // dynamic idCardExpiryDate;

  TraineeLaboursList({
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
  });

  factory TraineeLaboursList.fromJson(Map<String, dynamic> json) =>
      TraineeLaboursList(
        id: json["id"],
        inducteeId: json["inductee_id"] ?? "",
        labourName: json["labour_name"] ?? "",
        // gender: json["gender"],
        // literacy: json["literacy"],
        // maritalStatus: json["marital_status"],
        // bloodGroup: json["blood_group"],
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
        // idCardExpiryDate: json["id_card_expiry_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inductee_id": inducteeId,
        "labour_name": labourName,
        // "gender": gender,
        // "literacy": literacy,
        // "marital_status": maritalStatus,
        // "blood_group": bloodGroup,
        // "birth_date":
        //     "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        // "age": age,
        // "contact_number": contactNumber,
        // "user_photo": userPhoto,
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
        // "id_card_expiry_date": idCardExpiryDate,
      };
}
