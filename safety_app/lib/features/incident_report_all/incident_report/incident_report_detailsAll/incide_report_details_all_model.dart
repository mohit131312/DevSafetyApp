// To parse this JSON data, do
//
//     final incidentReportListingDetails = incidentReportListingDetailsFromJson(jsonString);

import 'dart:convert';

IncidentReportListingDetails incidentReportListingDetailsFromJson(String str) =>
    IncidentReportListingDetails.fromJson(json.decode(str));

// String incidentReportListingDetailsToJson(IncidentReportListingDetails data) =>
//     json.encode(data.toJson());

class IncidentReportListingDetails {
  final Data data;
  final String message;
  final bool status;
  final bool token;

  IncidentReportListingDetails({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory IncidentReportListingDetails.fromJson(Map<String, dynamic> json) =>
      IncidentReportListingDetails(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
        token: json["token"],
      );

  // Map<String, dynamic> toJson() => {
  //       "data": data.toJson(),
  //       "message": message,
  //       "status": status,
  //       "token": token,
  //     };
}

class Data {
  final List<SafetyIncidentReport> safetyIncidentReport;
  final List<SeverityLevel> severityLevel;
  final List<FloorAreaOfWork> floorAreaOfWork;
  final List<ContractorCompany> contractorCompany;
  final List<BuildingList> buildingList;
  final List<InvolvedList> involvedLaboursList;
  List<Staff>? involvedStaffList;
  List<InvolvedContractorUserList>? involvedContractorUserList;
  final List<InformedPersonsList> informedPersonsList;
  final List<PreventionMeasure> preventionMeasures;
  final List<Photo> photos;
  final List<AsgineUserList> asgineeUserList;
  final List<AsgineUserList> asginerUserList;
  final List<AsgineeAddPhoto> asgineeAddPhotos;

  Data({
    required this.safetyIncidentReport,
    required this.severityLevel,
    required this.floorAreaOfWork,
    required this.contractorCompany,
    required this.buildingList,
    required this.involvedLaboursList,
    required this.involvedStaffList,
    required this.involvedContractorUserList,
    required this.informedPersonsList,
    required this.preventionMeasures,
    required this.photos,
    required this.asgineeUserList,
    required this.asginerUserList,
    required this.asgineeAddPhotos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        safetyIncidentReport: List<SafetyIncidentReport>.from(
            json["safety_incident_report"]
                .map((x) => SafetyIncidentReport.fromJson(x))),
        severityLevel: List<SeverityLevel>.from(
            json["severity_level"].map((x) => SeverityLevel.fromJson(x))),
        floorAreaOfWork: List<FloorAreaOfWork>.from(
            json["floor_area_of_work"].map((x) => FloorAreaOfWork.fromJson(x))),
        contractorCompany: List<ContractorCompany>.from(
            json["contractor_company"]
                .map((x) => ContractorCompany.fromJson(x))),
        buildingList: List<BuildingList>.from(
            json["building_list"].map((x) => BuildingList.fromJson(x))),
        involvedLaboursList: List<InvolvedList>.from(
            json["involved_labours_list"].map((x) => InvolvedList.fromJson(x))),
        involvedStaffList: json["involved_staff_list"] == null
            ? []
            : List<Staff>.from(
                json["involved_staff_list"]!.map((x) => Staff.fromJson(x))),
        involvedContractorUserList:
            json["involved_contractor_user_list"] == null
                ? []
                : List<InvolvedContractorUserList>.from(
                    json["involved_contractor_user_list"]!
                        .map((x) => InvolvedContractorUserList.fromJson(x))),
        informedPersonsList: List<InformedPersonsList>.from(
            json["informedPersonsList"]
                .map((x) => InformedPersonsList.fromJson(x))),
        preventionMeasures: List<PreventionMeasure>.from(
            json["prevention_measures"]
                .map((x) => PreventionMeasure.fromJson(x))),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        asgineeUserList: List<AsgineUserList>.from(
            json["asginee_user_list"].map((x) => AsgineUserList.fromJson(x))),
        asginerUserList: List<AsgineUserList>.from(
            json["asginer_user_list"].map((x) => AsgineUserList.fromJson(x))),
        asgineeAddPhotos: List<AsgineeAddPhoto>.from(
            json["asginee_add_photos"].map((x) => AsgineeAddPhoto.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "safety_incident_report":
  //           List<dynamic>.from(safetyIncidentReport.map((x) => x.toJson())),
  //       "severity_level":
  //           List<dynamic>.from(severityLevel.map((x) => x.toJson())),
  //       "floor_area_of_work":
  //           List<dynamic>.from(floorAreaOfWork.map((x) => x.toJson())),
  //       "contractor_company":
  //           List<dynamic>.from(contractorCompany.map((x) => x.toJson())),
  //       "building_list":
  //           List<dynamic>.from(buildingList.map((x) => x.toJson())),
  //       "involved_labours_list":
  //           List<dynamic>.from(involvedLaboursList.map((x) => x.toJson())),
  //       "involved_staff_list": Map.from(involvedStaffList)
  //           .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  //       "involved_contractor_user_list": Map.from(involvedContractorUserList)
  //           .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  //       "informedPersonsList":
  //           List<dynamic>.from(informedPersonsList.map((x) => x.toJson())),
  //       "prevention_measures":
  //           List<dynamic>.from(preventionMeasures.map((x) => x.toJson())),
  //       "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
  //       "asginee_user_list":
  //           List<dynamic>.from(asgineeUserList.map((x) => x.toJson())),
  //       "asginer_user_list":
  //           List<dynamic>.from(asginerUserList.map((x) => x.toJson())),
  //       "asginee_add_photos":
  //           List<dynamic>.from(asgineeAddPhotos.map((x) => x.toJson())),
  //     };
}

class InvolvedContractorUserList {
  final int id;
  final String? contractorName;
  final String? contractorEmail;
  final String? contractorPhoneNo;
  // final int contractorCompanyId;
  // final int createdBy;
  // final dynamic deletedAt;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final String contractorsCompanyName;
  // final int idProofType;
  // final dynamic idProofNumber;
  final String? documentPath;
  // final String secondaryContactPersonName;
  // final String secondaryContactPersonNumber;
  // final dynamic qrCode;
  // final dynamic idCardExpiryDate;

  InvolvedContractorUserList({
    required this.id,
    this.contractorName,
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
        contractorName: json["contractor_name"] ?? "",
        contractorEmail: json["contractor_email"] ?? '',
        contractorPhoneNo: json["contractor_phone_no"] ?? "",
        // contractorCompanyId: json["contractor_company_id"],
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
        // idCardExpiryDate: json["id_card_expiry_date"],
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
        // "id_card_expiry_date": idCardExpiryDate,
      };
}

class InvolvedList {
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
  // final String staffId;
  // final String staffName;
  // final String adhaarNo;

  InvolvedList({
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
  factory InvolvedList.fromJson(Map<String, dynamic> json) => InvolvedList(
        id: json["id"] ?? 0,
        inducteeId: json["inductee_id"] ?? "",
        labourName: json["labour_name"] ?? "",
        contactNumber: json["contact_number"] ?? "",
        userPhoto: json["user_photo"] ?? "",
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
        // "staff_id": staffId,
        // "staff_name": staffName,
        // "adhaar_no": adhaarNo,
      };
}

class Staff {
  int id;
  String staffId;
  String staffName;
  String? contactNumber;
  String? userPhoto;

  // Constructor
  Staff({
    required this.id,
    required this.staffId,
    required this.staffName,
    this.contactNumber,
    this.userPhoto,
  });

  // Method to convert JSON into Staff object
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      staffId: json['staff_id'],
      staffName: json['staff_name'],
      contactNumber: json['contact_number'],
      userPhoto: json['user_photo'],
    );
  }

  // Method to convert Staff object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'staff_id': staffId,
      'staff_name': staffName,
      'contact_number': contactNumber,
      'user_photo': userPhoto,
    };
  }
}

class AsgineeAddPhoto {
  final int id;
  final int? safetyIncidentReportId;
  final int? assigneeId;
  final String? photoPath;
  final String? assigneeComment;
  final String? assigneePhotoSignatureAfter;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final dynamic deletedAt;

  AsgineeAddPhoto({
    required this.id,
    this.safetyIncidentReportId,
    this.assigneeId,
    this.photoPath,
    this.assigneeComment,
    this.assigneePhotoSignatureAfter,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.deletedAt,
  });

  factory AsgineeAddPhoto.fromJson(Map<String, dynamic> json) =>
      AsgineeAddPhoto(
        id: json["id"],
        safetyIncidentReportId: json["safety_incident_report_id"] ?? "",
        assigneeId: json["assignee_id"] ?? '',
        photoPath: json["photo_path"] ?? '',
        assigneeComment: json["assignee_comment"] ?? "",
        assigneePhotoSignatureAfter:
            json["assignee_photo_signature_after"] ?? "",
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "safety_incident_report_id": safetyIncidentReportId,
        "assignee_id": assigneeId,
        "photo_path": photoPath,
        "assignee_comment": assigneeComment,
        "assignee_photo_signature_after": assigneePhotoSignatureAfter,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "deleted_at": deletedAt,
      };
}

class AsgineUserList {
  final int id;
  final String? firstName;
  final String? lastName;
  // final String email;
  // final dynamic emailVerifiedAt;
  // final String location;
  // final String mobileNumber;
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
    required this.id,
    this.firstName,
    this.lastName,
    // required this.email,
    // required this.emailVerifiedAt,
    // required this.location,
    // required this.mobileNumber,
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
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        // email: json["email"],
        // emailVerifiedAt: json["email_verified_at"],
        // location: json["location"],
        // mobileNumber: json["mobile_number"],
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

class BuildingList {
  final int id;
  // final int projectInfoId;
  // final int buildingNo;
  final String? buildingName;
  // final String buildingAbv;
  // final int basements;
  // final int grounds;
  // final int parkingAboveGrounds;
  // final int floors;
  // final int terrace;
  // final int noOfFlatsPerFloor;
  // final int noOfFootings;
  // final int status;
  // final int createdBy;
  // final dynamic deletedAt;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final int noOfColumns;
  // final int completed;
  // final int startZip;
  // final dynamic lastQuarter;
  // final dynamic zipDate;
  // final dynamic mailQcZipDate;

  BuildingList({
    required this.id,
    // required this.projectInfoId,
    // required this.buildingNo,
    this.buildingName,
    // required this.buildingAbv,
    // required this.basements,
    // required this.grounds,
    // required this.parkingAboveGrounds,
    // required this.floors,
    // required this.terrace,
    // required this.noOfFlatsPerFloor,
    // required this.noOfFootings,
    // required this.status,
    // required this.createdBy,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.noOfColumns,
    // required this.completed,
    // required this.startZip,
    // required this.lastQuarter,
    // required this.zipDate,
    // required this.mailQcZipDate,
  });

  factory BuildingList.fromJson(Map<String, dynamic> json) => BuildingList(
        id: json["id"],
        // projectInfoId: json["project_info_id"],
        // buildingNo: json["building_no"],
        buildingName: json["building_name"] ?? "",
        // buildingAbv: json["building_abv"],
        // basements: json["basements"],
        // grounds: json["grounds"],
        // parkingAboveGrounds: json["parking_above_grounds"],
        // floors: json["floors"],
        // terrace: json["terrace"],
        // noOfFlatsPerFloor: json["no_of_flats_per_floor"],
        // noOfFootings: json["no_of_footings"],
        // status: json["status"],
        // createdBy: json["created_by"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // noOfColumns: json["no_of_columns"],
        // completed: json["completed"],
        // startZip: json["start_zip"],
        // lastQuarter: json["last_quarter"],
        // zipDate: json["zip_date"],
        // mailQcZipDate: json["mail_qc_zip_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "project_info_id": projectInfoId,
        // "building_no": buildingNo,
        "building_name": buildingName,
        // "building_abv": buildingAbv,
        // "basements": basements,
        // "grounds": grounds,
        // "parking_above_grounds": parkingAboveGrounds,
        // "floors": floors,
        // "terrace": terrace,
        // "no_of_flats_per_floor": noOfFlatsPerFloor,
        // "no_of_footings": noOfFootings,
        // "status": status,
        // "created_by": createdBy,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "no_of_columns": noOfColumns,
        // "completed": completed,
        // "start_zip": startZip,
        // "last_quarter": lastQuarter,
        // "zip_date": zipDate,
        // "mail_qc_zip_date": mailQcZipDate,
      };
}

class ContractorCompany {
  final int id;
  final String? contractorCompanyName;
  // final int? createdBy;
  // final dynamic deletedAt;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final String? gstnNumber;

  ContractorCompany({
    required this.id,
    this.contractorCompanyName,
    // required this.createdBy,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    this.gstnNumber,
  });

  factory ContractorCompany.fromJson(Map<String, dynamic> json) =>
      ContractorCompany(
        id: json["id"],
        contractorCompanyName: json["contractor_company_name"] ?? "",
        // createdBy: json["created_by"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        gstnNumber: json["gstn_number"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contractor_company_name": contractorCompanyName,
        // "created_by": createdBy,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "gstn_number": gstnNumber,
      };
}

class FloorAreaOfWork {
  final String floorName;

  FloorAreaOfWork({
    required this.floorName,
  });

  factory FloorAreaOfWork.fromJson(Map<String, dynamic> json) =>
      FloorAreaOfWork(
        floorName: json["floor_name"],
      );

  Map<String, dynamic> toJson() => {
        "floor_name": floorName,
      };
}

class InformedPersonsList {
  final int? userId;
  final String? designation;
  final String? firstName;
  final String? lastName;
  final String? mobileNumber;
  // final String email;
  final String? photo;

  InformedPersonsList({
    required this.userId,
    this.designation,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    // required this.email,
    this.photo,
  });

  factory InformedPersonsList.fromJson(Map<String, dynamic> json) =>
      InformedPersonsList(
        userId: json["user_id"] ?? 0,
        designation: json["designation"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        // email: json["email"],
        photo: json["photo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "designation": designation,
        "first_name": firstName,
        "last_name": lastName,
        "mobile_number": mobileNumber,
        // "email": email,
        "photo": photo,
      };
}

class InvolvedLaboursList {
  final The1 the1;

  InvolvedLaboursList({
    required this.the1,
  });

  factory InvolvedLaboursList.fromJson(Map<String, dynamic> json) =>
      InvolvedLaboursList(
        the1: The1.fromJson(json["1"]),
      );

  Map<String, dynamic> toJson() => {
        "1": the1.toJson(),
      };
}

class The1 {
  final int id;
  final String inducteeId;
  final String labourName;
  final String gender;
  final String literacy;
  final String maritalStatus;
  final String bloodGroup;
  final DateTime birthDate;
  final int age;
  final String contactNumber;
  final String userPhoto;
  final String currentStreetName;
  final String currentCity;
  final String currentTaluka;
  final int currentDistrict;
  final int currentState;
  final String currentPincode;
  final String permanentStreetName;
  final String permanentCity;
  final String permanentTaluka;
  final int permanentDistrict;
  final int permanentState;
  final String permanentPincode;
  final int experienceInYears;
  final dynamic uanNumber;
  final dynamic bocwNumber;
  final String bankName;
  final String ifscNumber;
  final String accountNumber;
  final String branchAddress;
  final String groupInsuranceLimit;
  final String insuranceNumber;
  final String insuranceType;
  final DateTime insuranceValidity;
  final String emergencyContactName;
  final String emergencyContactNumber;
  final String emergencyContactRelation;
  final String isActive;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String adhaarCardNo;
  final String qrCode;
  final DateTime idCardExpiryDate;
  final String staffId;
  final String staffName;
  final String adhaarNo;

  The1({
    required this.id,
    required this.inducteeId,
    required this.labourName,
    required this.gender,
    required this.literacy,
    required this.maritalStatus,
    required this.bloodGroup,
    required this.birthDate,
    required this.age,
    required this.contactNumber,
    required this.userPhoto,
    required this.currentStreetName,
    required this.currentCity,
    required this.currentTaluka,
    required this.currentDistrict,
    required this.currentState,
    required this.currentPincode,
    required this.permanentStreetName,
    required this.permanentCity,
    required this.permanentTaluka,
    required this.permanentDistrict,
    required this.permanentState,
    required this.permanentPincode,
    required this.experienceInYears,
    required this.uanNumber,
    required this.bocwNumber,
    required this.bankName,
    required this.ifscNumber,
    required this.accountNumber,
    required this.branchAddress,
    required this.groupInsuranceLimit,
    required this.insuranceNumber,
    required this.insuranceType,
    required this.insuranceValidity,
    required this.emergencyContactName,
    required this.emergencyContactNumber,
    required this.emergencyContactRelation,
    required this.isActive,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.adhaarCardNo,
    required this.qrCode,
    required this.idCardExpiryDate,
    required this.staffId,
    required this.staffName,
    required this.adhaarNo,
  });

  factory The1.fromJson(Map<String, dynamic> json) => The1(
        id: json["id"],
        inducteeId: json["inductee_id"],
        labourName: json["labour_name"],
        gender: json["gender"],
        literacy: json["literacy"],
        maritalStatus: json["marital_status"],
        bloodGroup: json["blood_group"],
        birthDate: DateTime.parse(json["birth_date"]),
        age: json["age"],
        contactNumber: json["contact_number"],
        userPhoto: json["user_photo"],
        currentStreetName: json["current_street_name"],
        currentCity: json["current_city"],
        currentTaluka: json["current_taluka"],
        currentDistrict: json["current_district"],
        currentState: json["current_state"],
        currentPincode: json["current_pincode"],
        permanentStreetName: json["permanent_street_name"],
        permanentCity: json["permanent_city"],
        permanentTaluka: json["permanent_taluka"],
        permanentDistrict: json["permanent_district"],
        permanentState: json["permanent_state"],
        permanentPincode: json["permanent_pincode"],
        experienceInYears: json["experience_in_years"],
        uanNumber: json["uan_number"],
        bocwNumber: json["bocw_number"],
        bankName: json["bank_name"],
        ifscNumber: json["ifsc_number"],
        accountNumber: json["account_number"],
        branchAddress: json["branch_address"],
        groupInsuranceLimit: json["group_insurance_limit"],
        insuranceNumber: json["insurance_number"],
        insuranceType: json["insurance_type"],
        insuranceValidity: DateTime.parse(json["insurance_validity"]),
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactNumber: json["emergency_contact_number"],
        emergencyContactRelation: json["emergency_contact_relation"],
        isActive: json["is_active"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        adhaarCardNo: json["adhaar_card_no"],
        qrCode: json["qr_code"],
        idCardExpiryDate: DateTime.parse(json["id_card_expiry_date"]),
        staffId: json["staff_id"],
        staffName: json["staff_name"],
        adhaarNo: json["adhaar_no"],
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
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
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
        "uan_number": uanNumber,
        "bocw_number": bocwNumber,
        "bank_name": bankName,
        "ifsc_number": ifscNumber,
        "account_number": accountNumber,
        "branch_address": branchAddress,
        "group_insurance_limit": groupInsuranceLimit,
        "insurance_number": insuranceNumber,
        "insurance_type": insuranceType,
        "insurance_validity":
            "${insuranceValidity.year.toString().padLeft(4, '0')}-${insuranceValidity.month.toString().padLeft(2, '0')}-${insuranceValidity.day.toString().padLeft(2, '0')}",
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_number": emergencyContactNumber,
        "emergency_contact_relation": emergencyContactRelation,
        "is_active": isActive,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "adhaar_card_no": adhaarCardNo,
        "qr_code": qrCode,
        "id_card_expiry_date":
            "${idCardExpiryDate.year.toString().padLeft(4, '0')}-${idCardExpiryDate.month.toString().padLeft(2, '0')}-${idCardExpiryDate.day.toString().padLeft(2, '0')}",
        "staff_id": staffId,
        "staff_name": staffName,
        "adhaar_no": adhaarNo,
      };
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

class PreventionMeasure {
  final int preventionMeasuresId;
  final String incidentDetails;

  PreventionMeasure({
    required this.preventionMeasuresId,
    required this.incidentDetails,
  });

  factory PreventionMeasure.fromJson(Map<String, dynamic> json) =>
      PreventionMeasure(
        preventionMeasuresId: json["prevention_measures_id"],
        incidentDetails: json["incident_details"],
      );

  Map<String, dynamic> toJson() => {
        "prevention_measures_id": preventionMeasuresId,
        "incident_details": incidentDetails,
      };
}

class SafetyIncidentReport {
  final int id;
  final int? projectId;
  final int? buildingId;
  final int? floorId;
  final int? contractorCompanyId;
  final String? incidentDetails;
  final int? severityLevelId;
  final int? assigneeId;
  final int? assignerId;
  final String? location;
  final String? signaturePhoto;
  // final dynamic deletedAt;
  final DateTime? createdAt;
  // final DateTime updatedAt;
  // final int createdBy;
  final String? rootCause;
  final String? signaturePhotoAfter;
  final String? assignerComment;
  final int? status;

  SafetyIncidentReport({
    required this.id,
    this.projectId,
    this.buildingId,
    this.floorId,
    this.contractorCompanyId,
    this.incidentDetails,
    this.severityLevelId,
    this.assigneeId,
    this.assignerId,
    this.location,
    this.signaturePhoto,
    // required this.deletedAt,
    this.createdAt,
    // required this.updatedAt,
    // required this.createdBy,
    this.rootCause,
    this.signaturePhotoAfter,
    this.assignerComment,
    this.status,
  });

  factory SafetyIncidentReport.fromJson(Map<String, dynamic> json) =>
      SafetyIncidentReport(
        id: json["id"],
        projectId: json["project_id"] ?? 0,
        buildingId: json["building_id"] ?? 0,
        floorId: json["floor_id"] ?? 0,
        contractorCompanyId: json["contractor_company_id"] ?? 0,
        incidentDetails: json["incident_details"] ?? "",
        severityLevelId: json["severity_level_id"] ?? 0,
        assigneeId: json["assignee_id"] ?? 0,
        assignerId: json["assigner_id"] ?? 0,
        location: json["location"] ?? "",
        signaturePhoto: json["signature_photo"] ?? "",
        // deletedAt: json["deleted_at"],
        createdAt: json["created_at_ind"] != null
            ? DateTime.parse(json["created_at_ind"])
            : null,
        // updatedAt: DateTime.parse(json["updated_at"]),
        // createdBy: json["created_by"],
        rootCause: json["root_cause"] ?? "",
        signaturePhotoAfter: json["signature_photo_after"] ?? "",
        assignerComment: json["assigner_comment"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "building_id": buildingId,
        "floor_id": floorId,
        "contractor_company_id": contractorCompanyId,
        "incident_details": incidentDetails,
        "severity_level_id": severityLevelId,
        "assignee_id": assigneeId,
        "assigner_id": assignerId,
        "location": location,
        "signature_photo": signaturePhoto,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "created_by": createdBy,
        "root_cause": rootCause,
        "signature_photo_after": signaturePhotoAfter,
        "assigner_comment": assignerComment,
        "status": status,
      };
}

class SeverityLevel {
  final int id;
  final int? categoryId;
  final String? incidentDetails;
  // final dynamic deletedAt;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final String? severityColor;

  SeverityLevel({
    required this.id,
    this.categoryId,
    this.incidentDetails,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    this.severityColor,
  });

  factory SeverityLevel.fromJson(Map<String, dynamic> json) => SeverityLevel(
        id: json["id"],
        categoryId: json["category_id"] ?? 0,
        incidentDetails: json["incident_details"] ?? 0,
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        severityColor: json["severity_color"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "incident_details": incidentDetails,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "severity_color": severityColor,
      };
}
