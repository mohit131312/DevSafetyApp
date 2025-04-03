// To parse this JSON data, do
//
//     final incidentReport = incidentReportFromJson(jsonString);

import 'dart:convert';

IncidentReport incidentReportFromJson(String str) =>
    IncidentReport.fromJson(json.decode(str));

String incidentReportToJson(IncidentReport data) => json.encode(data.toJson());

class IncidentReport {
  Data data;
  String message;
  bool status;
  bool token;

  IncidentReport({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory IncidentReport.fromJson(Map<String, dynamic> json) => IncidentReport(
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
  List<PreventionMeasure> severityLevel;
  List<PreventionMeasure> preventionMeasures;
  List<ContractorCompany> contractorCompany;
  List<InvolvedList> involvedLaboursList;
  List<InvolvedStaffList> involvedStaffList;
  List<InvolvedContractorUserList> involvedContractorUserList;
  List<InformedAsgineeUserList> informedAsgineeUserList;
  List<BuildingList> buildingList;

  Data({
    required this.severityLevel,
    required this.preventionMeasures,
    required this.contractorCompany,
    required this.involvedLaboursList,
    required this.involvedStaffList,
    required this.involvedContractorUserList,
    required this.informedAsgineeUserList,
    required this.buildingList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        severityLevel: List<PreventionMeasure>.from(
            json["severity_level:"].map((x) => PreventionMeasure.fromJson(x))),
        preventionMeasures: List<PreventionMeasure>.from(
            json["prevention_measures"]
                .map((x) => PreventionMeasure.fromJson(x))),
        contractorCompany: List<ContractorCompany>.from(
            json["contractor_company"]
                .map((x) => ContractorCompany.fromJson(x))),
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
        buildingList: List<BuildingList>.from(
            json["building_list"].map((x) => BuildingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "severity_level:":
            List<dynamic>.from(severityLevel.map((x) => x.toJson())),
        "prevention_measures":
            List<dynamic>.from(preventionMeasures.map((x) => x.toJson())),
        "contractor_company":
            List<dynamic>.from(contractorCompany.map((x) => x.toJson())),
        "involved_labours_list":
            List<dynamic>.from(involvedLaboursList.map((x) => x.toJson())),
        "involved_staff_list":
            List<dynamic>.from(involvedStaffList.map((x) => x.toJson())),
        "involved_contractor_user_list": List<dynamic>.from(
            involvedContractorUserList.map((x) => x.toJson())),
        "informed_asginee_user_list":
            List<dynamic>.from(informedAsgineeUserList.map((x) => x.toJson())),
        "building_list":
            List<dynamic>.from(buildingList.map((x) => x.toJson())),
      };
}

class BuildingList {
  int id;
  // int projectInfoId;
  int? buildingNo;
  String? buildingName;
  String? buildingAbv;
  // int basements;
  // int grounds;
  // int parkingAboveGrounds;
  // int floors;
  // int terrace;
  // int noOfFlatsPerFloor;
  // int noOfFootings;
  // int status;
  // int createdBy;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // int noOfColumns;
  // int completed;
  // int startZip;
  // dynamic lastQuarter;
  // dynamic zipDate;
  // dynamic mailQcZipDate;

  BuildingList({
    required this.id,
    // required this.projectInfoId,
    this.buildingNo,
    this.buildingName,
    this.buildingAbv,
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
        buildingNo: json["building_no"] ?? 0,
        buildingName: json["building_name"] ?? '',
        buildingAbv: json["building_abv"] ?? '',
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
        "building_no": buildingNo,
        "building_name": buildingName,
        "building_abv": buildingAbv,
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
  int id;
  String contractorCompanyName;
  // int createdBy;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  String? gstnNumber;

  ContractorCompany({
    required this.id,
    required this.contractorCompanyName,
    // required this.createdBy,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    this.gstnNumber,
  });

  factory ContractorCompany.fromJson(Map<String, dynamic> json) =>
      ContractorCompany(
        id: json["id"],
        contractorCompanyName: json["contractor_company_name"],
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

class InformedAsgineeUserList {
  int id;
  String firstName;
  String lastName;
  String email;
  // dynamic emailVerifiedAt;
  // String location;
  String mobileNumber;
  int role;
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

  InformedAsgineeUserList({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.emailVerifiedAt,
    // required this.location,
    required this.mobileNumber,
    required this.role,
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
        email: json["email"],
        // emailVerifiedAt: json["email_verified_at"],
        // location: json["location"],
        mobileNumber: json["mobile_number"],
        role: json["role"],
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
        "email": email,
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
  String contractorEmail;
  String contractorPhoneNo;
  int contractorCompanyId;
  // int createdBy;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  String contractorsCompanyName;
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
    required this.contractorEmail,
    required this.contractorPhoneNo,
    required this.contractorCompanyId,
    // required this.createdBy,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    required this.contractorsCompanyName,
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
        contractorEmail: json["contractor_email"],
        contractorPhoneNo: json["contractor_phone_no"],
        contractorCompanyId: json["contractor_company_id"],
        // createdBy: json["created_by"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        contractorsCompanyName: json["contractors_company_name"],
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
        "contractor_company_id": contractorCompanyId,
        // "created_by": createdBy,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "contractors_company_name": contractorsCompanyName,
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
  String inducteeId;
  String labourName;

  // DateTime birthDate;
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
  // String bankName;
  // String ifscNumber;
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
  // String qrCode;
  // DateTime idCardExpiryDate;
  // String staffId;
  // String staffName;
  // String adhaarNo;

  InvolvedList({
    required this.id,
    required this.inducteeId,
    required this.labourName,
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

  factory InvolvedList.fromJson(Map<String, dynamic> json) => InvolvedList(
        id: json["id"],
        inducteeId: json["inductee_id"],
        labourName: json["labour_name"],
        // birthDate: DateTime.parse(json["birth_date"]),
        // age: json["age"],
        contactNumber: json["contact_number"],
        userPhoto: json["user_photo"],
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
        // insuranceValidity: DateTime.parse(json["insurance_validity"]),
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
        //     "${idCardExpiryDate.year.toString().padLeft(4, '0')}-${idCardExpiryDate.month.toString().padLeft(2, '0')}-${idCardExpiryDate.day.toString().padLeft(2, '0')}",
        // "staff_id": staffId,
        // "staff_name": staffName,
        // "adhaar_no": adhaarNo,
      };
}

class InvolvedStaffList {
  int id;
  String staffId;
  String? staffName;

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
  // dynamic uanNumber;
  // dynamic bocwNumber;
  // String bankName;
  // String ifscNumber;
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
  // String qrCode;
  // DateTime idCardExpiryDate;
  // String staffId;
  // String staffName;
  // String adhaarNo;

  InvolvedStaffList({
    required this.id,
    required this.staffId,
    this.staffName,
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

  factory InvolvedStaffList.fromJson(Map<String, dynamic> json) =>
      InvolvedStaffList(
        id: json["id"],
        staffId: json["staff_id"],
        staffName: json["staff_name"] ?? '',
        // birthDate: DateTime.parse(json["birth_date"]),
        // age: json["age"],
        contactNumber: json["contact_number"] ?? '',
        userPhoto: json["user_photo"] ?? '',
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
        // insuranceValidity: DateTime.parse(json["insurance_validity"]),
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
        "staff_id": staffId,
        "staff_name": staffName,
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

class PreventionMeasure {
  int id;
  int categoryId;
  String incidentDetails;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String severityColor;

  PreventionMeasure({
    required this.id,
    required this.categoryId,
    required this.incidentDetails,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.severityColor,
  });

  factory PreventionMeasure.fromJson(Map<String, dynamic> json) =>
      PreventionMeasure(
        id: json["id"],
        categoryId: json["category_id"],
        incidentDetails: json["incident_details"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // severityColor: json["severity_color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "incident_details": incidentDetails,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "severity_color": severityColor,
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
