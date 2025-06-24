// To parse this JSON data, do
//
//     final safetyViolationDetailsModel = safetyViolationDetailsModelFromJson(jsonString);

import 'dart:convert';

SafetyViolationDetailsModel safetyViolationDetailsModelFromJson(String str) =>
    SafetyViolationDetailsModel.fromJson(json.decode(str));

String safetyViolationDetailsModelToJson(SafetyViolationDetailsModel data) =>
    json.encode(data.toJson());

class SafetyViolationDetailsModel {
  final Data data;
  final String message;
  final bool status;
  final bool token;

  SafetyViolationDetailsModel({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory SafetyViolationDetailsModel.fromJson(Map<String, dynamic> json) =>
      SafetyViolationDetailsModel(
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
  final List<ViolationDebitNote> violationDebitNote;
  final List<Category> violationType;
  final List<Category> category;
  final List<Category> riskLevel;
  final List<Category> sourceOfObservation;
  final List<InvolvedLaboursList> involvedLaboursList;
  final List<InvolvedStaffList> involvedStaffList;
  final List<InvolvedContractorUserList>? involvedContractorUserList;
  final List<InformedPersonsList> informedPersonsList;
  final List<Photo> photos;
  final List<AsgineUserList> asgineeUserList;
  final List<AsgineUserList> asginerUserList;
  final List<AsgineeAddPhoto> asgineeAddPhotos;

  Data({
    required this.violationDebitNote,
    required this.violationType,
    required this.category,
    required this.riskLevel,
    required this.sourceOfObservation,
    required this.involvedLaboursList,
    required this.involvedStaffList,
    required this.involvedContractorUserList,
    required this.informedPersonsList,
    required this.photos,
    required this.asgineeUserList,
    required this.asginerUserList,
    required this.asgineeAddPhotos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        violationDebitNote: List<ViolationDebitNote>.from(
            json["violation_debit_note"]
                .map((x) => ViolationDebitNote.fromJson(x))),
        violationType: List<Category>.from(
            json["violation_type"].map((x) => Category.fromJson(x))),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        riskLevel: List<Category>.from(
            json["risk_level"].map((x) => Category.fromJson(x))),
        sourceOfObservation: List<Category>.from(
            json["source_of_observation"].map((x) => Category.fromJson(x))),
        involvedLaboursList: List<InvolvedLaboursList>.from(
            json["involved_labours_list"]
                .map((x) => InvolvedLaboursList.fromJson(x))),
        involvedStaffList: json["involved_staff_list"] == null
            ? []
            : List<InvolvedStaffList>.from(json["involved_staff_list"]!
                .map((x) => InvolvedStaffList.fromJson(x))),
        involvedContractorUserList:
            json["involved_contractor_user_list"] == null
                ? []
                : List<InvolvedContractorUserList>.from(
                    json["involved_contractor_user_list"]!
                        .map((x) => InvolvedContractorUserList.fromJson(x))),
        informedPersonsList: List<InformedPersonsList>.from(
            json["informedPersonsList"]
                .map((x) => InformedPersonsList.fromJson(x))),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        asgineeUserList: List<AsgineUserList>.from(
            json["asginee_user_list"].map((x) => AsgineUserList.fromJson(x))),
        asginerUserList: List<AsgineUserList>.from(
            json["asginer_user_list"].map((x) => AsgineUserList.fromJson(x))),
        asgineeAddPhotos: List<AsgineeAddPhoto>.from(
            json["asginee_add_photos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "violation_debit_note":
            List<dynamic>.from(violationDebitNote.map((x) => x.toJson())),
        "violation_type":
            List<dynamic>.from(violationType.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "risk_level": List<dynamic>.from(riskLevel.map((x) => x.toJson())),
        "source_of_observation":
            List<dynamic>.from(sourceOfObservation.map((x) => x.toJson())),
        "involved_labours_list":
            List<dynamic>.from(involvedLaboursList.map((x) => x.toJson())),
        // "involved_staff_list": involvedStaffList.map(
        //   (k, v) => MapEntry(
        //       k, v.toJson()), // Correct serialization of involvedStaffList
        // ),
        // "involved_contractor_user_list": involvedContractorUserList.map(
        //   (k, v) => MapEntry(k,
        //       v.toJson()), // Correct serialization of involvedContractorUserList
        // ),
        "informedPersonsList":
            List<dynamic>.from(informedPersonsList.map((x) => x.toJson())),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "asginee_user_list":
            List<dynamic>.from(asgineeUserList.map((x) => x.toJson())),
        "asginer_user_list":
            List<dynamic>.from(asginerUserList.map((x) => x.toJson())),
        "asginee_add_photos":
            List<dynamic>.from(asgineeAddPhotos.map((x) => x)),
      };
}

class AsgineUserList {
  final int? id;
  final String? firstName;
  final String? lastName;
  // final String email;
  // final dynamic emailVerifiedAt;
  // final String location;
  final String? mobileNumber;
  // final int role;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final String encryptPassword;
  // final dynamic deletedAt;
  // final String apiToken;
  // final dynamic fcmToken;
  final String? designation;
  // final int userParty;
  // final String emergencyContactName;
  // final String emergencyContactRelation;
  // final String emergencyContactNumber;
  // final int idProof;
  // final String idProofNumber;
  // final String documentPath;
  final String? profilePhoto;
  // final int isActive;
  // final dynamic adhaarCardNo;

  AsgineUserList({
    this.id,
    this.firstName,
    this.lastName,
    // required this.email,
    // required this.emailVerifiedAt,
    // required this.location,
    this.mobileNumber,
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

  factory AsgineUserList.fromJson(Map<String, dynamic> json) => AsgineUserList(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        // email: json["email"],
        // emailVerifiedAt: json["email_verified_at"],
        // location: json["location"],
        mobileNumber: json["mobile_number"] ?? '',
        // role: json["role"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // encryptPassword: json["encrypt_password"],
        // deletedAt: json["deleted_at"],
        // apiToken: json["api_token"],
        // fcmToken: json["FCM_token"],
        designation: json["designation"] ?? '',
        // userParty: json["user_party"],
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

class Category {
  final int id;
  final String? safetyDetails;

  Category({
    required this.id,
    this.safetyDetails,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        safetyDetails: json["safety_details"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "safety_details": safetyDetails,
      };
}

class InformedPersonsList {
  final int userId;
  final String? designation;
  final String? firstName;
  final String? lastName;
  final String? mobileNumber;
  final String? email;
  final String? photo;

  InformedPersonsList({
    required this.userId,
    this.designation,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.photo,
  });

  factory InformedPersonsList.fromJson(Map<String, dynamic> json) =>
      InformedPersonsList(
        userId: json["user_id"],
        designation: json["designation"] ?? '',
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        email: json["email"] ?? "",
        photo: json["photo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "designation": designation,
        "first_name": firstName,
        "last_name": lastName,
        "mobile_number": mobileNumber,
        "email": email,
        "photo": photo,
      };
}

class InvolvedLaboursList {
  final int id;
  final String? inducteeId;
  final String? labourName;
  // final String gender;
  // final String literacy;
  // final String maritalStatus;
  // final String bloodGroup;
  // final DateTime birthDate;
  // final int age;
  final String? contactNumber;
  final String? userPhoto;
  // final String currentStreetName;
  // final String currentCity;
  // final String currentTaluka;
  // final int currentDistrict;
  // final int currentState;
  // final String currentPincode;
  // final String permanentStreetName;
  // final String permanentCity;
  // final String permanentTaluka;
  // final int permanentDistrict;
  // final int permanentState;
  // final String permanentPincode;
  // final int experienceInYears;
  // final dynamic uanNumber;
  // final dynamic bocwNumber;
  // final dynamic bankName;
  // final dynamic ifscNumber;
  // final dynamic accountNumber;
  // final dynamic branchAddress;
  // final dynamic groupInsuranceLimit;
  // final dynamic insuranceNumber;
  // final dynamic insuranceType;
  // final dynamic insuranceValidity;
  // final String emergencyContactName;
  // final String emergencyContactNumber;
  // final String emergencyContactRelation;
  // final String isActive;
  // final dynamic deletedAt;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final String adhaarCardNo;
  // final dynamic qrCode;
  // final dynamic idCardExpiryDate;

  InvolvedLaboursList({
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

  factory InvolvedLaboursList.fromJson(Map<String, dynamic> json) =>
      InvolvedLaboursList(
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
        // "id_card_expiry_date": idCardExpiryDate,
      };
}

class InvolvedStaffList {
  final int? id;
  final String? staffId;
  final String? staffName;
  // final String? gender;
  // final String? bloodGroup;
  // final String? birthDate;
  // final int? age;
  final String? contactNumber;
  final String? userPhoto;

  // final String? currentStreetName;
  // final String? currentCity;
  // final String? currentTaluka;
  // final int? currentDistrict;
  // final int? currentState;
  // final String? currentPincode;

  // final String? permanentStreetName;
  // final String? permanentCity;
  // final String? permanentTaluka;
  // final int? permanentDistrict;
  // final int? permanentState;
  // final String? permanentPincode;

  // final String? adhaarNo;
  // final String? bankName;
  // final String? ifscNumber;
  // final String? accountNumber;
  // final String? branchAddress;
  // final String? groupInsuranceLimit;
  // final String? insuranceNumber;
  // final String? insuranceType;
  // final String? insuranceValidity;

  // final String? emergencyContactName;
  // final String? emergencyContactNumber;
  // final String? emergencyContactRelation;

  // final String? isActive;
  // final String? deletedAt;
  // final String? createdAt;
  // final String? updatedAt;
  // final String? qrCode;
  // final String? idCardExpiryDate;

  InvolvedStaffList({
    this.id,
    this.staffId,
    this.staffName,
    // this.gender,
    // this.bloodGroup,
    // this.birthDate,
    // this.age,
    this.contactNumber,
    this.userPhoto,
    // this.currentStreetName,
    // this.currentCity,
    // this.currentTaluka,
    // this.currentDistrict,
    // this.currentState,
    // this.currentPincode,
    // this.permanentStreetName,
    // this.permanentCity,
    // this.permanentTaluka,
    // this.permanentDistrict,
    // this.permanentState,
    // this.permanentPincode,
    // this.adhaarNo,
    // this.bankName,
    // this.ifscNumber,
    // this.accountNumber,
    // this.branchAddress,
    // this.groupInsuranceLimit,
    // this.insuranceNumber,
    // this.insuranceType,
    // this.insuranceValidity,
    // this.emergencyContactName,
    // this.emergencyContactNumber,
    // this.emergencyContactRelation,
    // this.isActive,
    // this.deletedAt,
    // this.createdAt,
    // this.updatedAt,
    // this.qrCode,
    // this.idCardExpiryDate,
  });

  factory InvolvedStaffList.fromJson(Map<String, dynamic> json) {
    return InvolvedStaffList(
      id: json["id"] ?? 0,
      staffId: json["staff_id"] ?? "",
      staffName: json["staff_name"] ?? "",
      // gender: json["gender"],
      // bloodGroup: json["blood_group"],
      // birthDate: json["birth_date"],
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
      // adhaarNo: json["adhaar_no"],
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
      // createdAt: json["created_at"],
      // updatedAt: json["updated_at"],
      // qrCode: json["qr_code"],
      // idCardExpiryDate: json["id_card_expiry_date"],
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "staff_id": staffId,
  //       "staff_name": staffName,
  //       "gender": gender,
  //       "blood_group": bloodGroup,
  //       "birth_date": birthDate,
  //       "age": age,
  //       "contact_number": contactNumber,
  //       "user_photo": userPhoto,
  //       "current_street_name": currentStreetName,
  //       "current_city": currentCity,
  //       "current_taluka": currentTaluka,
  //       "current_district": currentDistrict,
  //       "current_state": currentState,
  //       "current_pincode": currentPincode,
  //       "permanent_street_name": permanentStreetName,
  //       "permanent_city": permanentCity,
  //       "permanent_taluka": permanentTaluka,
  //       "permanent_district": permanentDistrict,
  //       "permanent_state": permanentState,
  //       "permanent_pincode": permanentPincode,
  //       "adhaar_no": adhaarNo,
  //       "bank_name": bankName,
  //       "ifsc_number": ifscNumber,
  //       "account_number": accountNumber,
  //       "branch_address": branchAddress,
  //       "group_insurance_limit": groupInsuranceLimit,
  //       "insurance_number": insuranceNumber,
  //       "insurance_type": insuranceType,
  //       "insurance_validity": insuranceValidity,
  //       "emergency_contact_name": emergencyContactName,
  //       "emergency_contact_number": emergencyContactNumber,
  //       "emergency_contact_relation": emergencyContactRelation,
  //       "is_active": isActive,
  //       "deleted_at": deletedAt,
  //       "created_at": createdAt,
  //       "updated_at": updatedAt,
  //       "qr_code": qrCode,
  //       "id_card_expiry_date": idCardExpiryDate,
  //     };
}

class AsgineeAddPhoto {
  final int? id;
  final int? safetyViolationDebitNoteId;
  final int? assigneeId;
  final String? photoPath;
  final String? assigneeComment;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final String? assigneePhotoSignatureAfter;
  // final dynamic deletedAt;

  AsgineeAddPhoto({
    this.id,
    this.safetyViolationDebitNoteId,
    this.assigneeId,
    this.photoPath,
    this.assigneeComment,
    // required this.createdAt,
    // required this.updatedAt,
    this.assigneePhotoSignatureAfter,
    // required this.deletedAt,
  });

  factory AsgineeAddPhoto.fromJson(Map<String, dynamic> json) =>
      AsgineeAddPhoto(
        id: json["id"] ?? 0,
        safetyViolationDebitNoteId: json["safety_violation_debit_note_id"] ?? 0,
        assigneeId: json["assignee_id"] ?? 0,
        photoPath: json["photo_path"] ?? "",
        assigneeComment: json["assignee_comment"] ?? "",
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        assigneePhotoSignatureAfter:
            json["assignee_photo_signature_after"] ?? "",
        //  deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "safety_violation_debit_note_id": safetyViolationDebitNoteId,
        "assignee_id": assigneeId,
        "photo_path": photoPath,
        "assignee_comment": assigneeComment,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "assignee_photo_signature_after": assigneePhotoSignatureAfter,
        // "deleted_at": deletedAt,
      };
}

class InvolvedContractorUserList {
  int? id;
  String? contractorName;
  String? contractorEmail;
  String? contractorPhoneNo;
  // int? contractorCompanyId;
  // int? createdBy;
  // DateTime? deletedAt;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  String? contractorsCompanyName;
  // int? idProofType;
  // String? idProofNumber;
  String? documentPath;
  // String? secondaryContactPersonName;
  // String? secondaryContactPersonNumber;
  // dynamic qrCode;
  // dynamic idCardExpiryDate;
  // String? contractorCompanyName;
  //ContractorCompany? contractorCompany;

  InvolvedContractorUserList({
    this.id,
    this.contractorName,
    this.contractorEmail,
    this.contractorPhoneNo,
    // this.contractorCompanyId,
    // this.createdBy,
    // this.deletedAt,
    // this.createdAt,
    // this.updatedAt,
    this.contractorsCompanyName,
    // this.idProofType,
    // this.idProofNumber,
    this.documentPath,
    // this.secondaryContactPersonName,
    // this.secondaryContactPersonNumber,
    // this.qrCode,
    // this.idCardExpiryDate,
    // this.contractorCompanyName,
    // this.contractorCompany,
  });

  factory InvolvedContractorUserList.fromJson(Map<String, dynamic> json) =>
      InvolvedContractorUserList(
        id: json["id"],
        contractorName: json["contractor_name"],
        contractorEmail: json["contractor_email"],
        contractorPhoneNo: json["contractor_phone_no"],
        // contractorCompanyId: json["contractor_company_id"],
        // createdBy: json["created_by"],
        // deletedAt: json["deleted_at"] == null
        //     ? null
        //     : DateTime.parse(json["deleted_at"]),
        // createdAt: json["created_at"] == null
        //     ? null
        //     : DateTime.parse(json["created_at"]),
        // updatedAt: json["updated_at"] == null
        //     ? null
        //     : DateTime.parse(json["updated_at"]),
        contractorsCompanyName: json["contractors_company_name"],
        // idProofType: json["id_proof_type"],
        // idProofNumber: json["id_proof_number"],
        documentPath: json["document_path"] ?? "",
        // secondaryContactPersonName: json["secondary_contact_person_name"],
        // secondaryContactPersonNumber: json["secondary_contact_person_number"],
        // qrCode: json["qr_code"],
        // idCardExpiryDate: json["id_card_expiry_date"],
        // contractorCompanyName: json["contractor_company_name"],
        // contractorCompany: json["contractor_company"] == null
        //     ? null
        //     : ContractorCompany.fromJson(json["contractor_company"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "contractor_name": contractorName,
  //       "contractor_email": contractorEmail,
  //       "contractor_phone_no": contractorPhoneNo,
  //       "contractor_company_id": contractorCompanyId,
  //       "created_by": createdBy,
  //       "deleted_at": deletedAt?.toIso8601String(),
  //       "created_at": createdAt?.toIso8601String(),
  //       "updated_at": updatedAt?.toIso8601String(),
  //       "contractors_company_name": contractorsCompanyName,
  //       "id_proof_type": idProofType,
  //       "id_proof_number": idProofNumber,
  //       "document_path": documentPath,
  //       "secondary_contact_person_name": secondaryContactPersonName,
  //       "secondary_contact_person_number": secondaryContactPersonNumber,
  //       "qr_code": qrCode,
  //       "id_card_expiry_date": idCardExpiryDate,
  //       "contractor_company_name": contractorCompanyName,
  //       "contractor_company": contractorCompany?.toJson(),
  //     };
}

class Photo {
  final String? photoPath;

  Photo({
    this.photoPath,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        photoPath: json["photo_path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "photo_path": photoPath,
      };
}

class ViolationDebitNote {
  final int id;
  final int? violationTypeId;
  final int? categoryId;
  final String? details;
  final String? locationOfBreach;
  final int? riskLevelId;
  final int? sourceOfObservationId;
  final int? assigneeId;
  final int? assignerId;
  final String? location;
  final String? signaturePhoto;
  final int? createdBy;
  // final dynamic deletedAt;
  final DateTime? createdAt;
  // final DateTime updatedAt;
  final String? assignerComment;
  final int? status;
  final String? assignerPhotoSignatureAfter;
  final int? projectId;
  final DateTime? turnAroundTime;
  final String? violationUniqueId;

  ViolationDebitNote({
    required this.id,
    this.violationTypeId,
    this.categoryId,
    this.details,
    this.locationOfBreach,
    this.riskLevelId,
    this.sourceOfObservationId,
    this.assigneeId,
    this.assignerId,
    this.location,
    this.signaturePhoto,
    this.createdBy,
    // required this.deletedAt,
    this.createdAt,
    // required this.updatedAt,
    this.assignerComment,
    this.status,
    this.assignerPhotoSignatureAfter,
    this.projectId,
    this.turnAroundTime,
    this.violationUniqueId,
  });

  factory ViolationDebitNote.fromJson(Map<String, dynamic> json) =>
      ViolationDebitNote(
        id: json["id"],
        violationTypeId: json["violation_type_id"] ?? 0,
        categoryId: json["category_id"] ?? 0,
        details: json["details"] ?? '',
        locationOfBreach: json["location_of_breach"] ?? "",
        riskLevelId: json["risk_level_id"] ?? 0,
        sourceOfObservationId: json["source_of_observation_id"] ?? 0,
        assigneeId: json["assignee_id"] ?? 0,
        assignerId: json["assigner_id"] ?? 0,
        location: json["location"] ?? "",
        signaturePhoto: json["signature_photo"] ?? "",
        createdBy: json["created_by"] ?? 0,
        // deletedAt: json["deleted_at"],
        createdAt: json["created_at_ind"] != null
            ? DateTime.parse(json["created_at_ind"])
            : null,
        // updatedAt: DateTime.parse(json["updated_at"]),
        assignerComment: json["assigner_comment"] ?? "",
        status: json["status"] ?? 0,
        assignerPhotoSignatureAfter:
            json["assigner_photo_signature_after"] ?? "",
        projectId: json["project_id"] ?? 0,
        turnAroundTime: json["turn_around_time"] != null
            ? DateTime.parse(json["turn_around_time"])
            : null,
        violationUniqueId: json["violation_unique_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "violation_type_id": violationTypeId,
        "category_id": categoryId,
        "details": details,
        "location_of_breach": locationOfBreach,
        "risk_level_id": riskLevelId,
        "source_of_observation_id": sourceOfObservationId,
        "assignee_id": assigneeId,
        "assigner_id": assignerId,
        "location": location,
        "signature_photo": signaturePhoto,
        "created_by": createdBy,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "assigner_comment": assignerComment,
        "status": status,
        "assigner_photo_signature_after": assignerPhotoSignatureAfter,
        "project_id": projectId,
        "turn_around_time": turnAroundTime!.toIso8601String(),
        "violation_unique_id": violationUniqueId,
      };
}
