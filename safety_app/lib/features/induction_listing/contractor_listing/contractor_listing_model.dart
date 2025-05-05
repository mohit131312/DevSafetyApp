// To parse this JSON data, do
//
//     final contractorListing = contractorListingFromJson(jsonString);

import 'dart:convert';

ContractorListing contractorListingFromJson(String str) =>
    ContractorListing.fromJson(json.decode(str));

String contractorListingToJson(ContractorListing data) =>
    json.encode(data.toJson());

class ContractorListing {
  Data data;
  String message;
  bool status;
  bool token;

  ContractorListing({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory ContractorListing.fromJson(Map<String, dynamic> json) =>
      ContractorListing(
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
  List<ContractorCompanyDetail> contractorCompanyDetails;
  List<InductionTraining> inductionTrainings;
  List<ContractorServicesDetail> contractorServicesDetails;

  List<dynamic> documentDetails;
  List<dynamic> equipmentDetails;
  List<dynamic> instructionDetails;
  List<ReasonOfVisit> reasonOfVisit;

  Data({
    required this.userDetails,
    required this.contractorCompanyDetails,
    required this.contractorServicesDetails,
    required this.inductionTrainings,
    required this.documentDetails,
    required this.equipmentDetails,
    required this.instructionDetails,
    required this.reasonOfVisit,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userDetails: List<UserDetail>.from(
            json["user_details"].map((x) => UserDetail.fromJson(x))),
        contractorCompanyDetails: List<ContractorCompanyDetail>.from(
            json["contractor_company_details"]
                .map((x) => ContractorCompanyDetail.fromJson(x))),
        contractorServicesDetails: List<ContractorServicesDetail>.from(
            json["contractor_services_details"].map((x) => x)),
        inductionTrainings: List<InductionTraining>.from(
            json["induction_trainings"]
                .map((x) => InductionTraining.fromJson(x))),
        documentDetails:
            List<dynamic>.from(json["document_details"].map((x) => x)),
        equipmentDetails:
            List<dynamic>.from(json["equipment_details"].map((x) => x)),
        instructionDetails:
            List<dynamic>.from(json["instruction_details"].map((x) => x)),
        reasonOfVisit: List<ReasonOfVisit>.from(
            json["reason_of_visit"].map((x) => ReasonOfVisit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_details": List<dynamic>.from(userDetails.map((x) => x.toJson())),
        "contractor_company_details":
            List<dynamic>.from(contractorCompanyDetails.map((x) => x.toJson())),
        "contractor_services_details":
            List<dynamic>.from(contractorServicesDetails.map((x) => x)),
        "induction_trainings":
            List<dynamic>.from(inductionTrainings.map((x) => x.toJson())),
        "document_details": List<dynamic>.from(documentDetails.map((x) => x)),
        "equipment_details": List<dynamic>.from(equipmentDetails.map((x) => x)),
        "instruction_details":
            List<dynamic>.from(instructionDetails.map((x) => x)),
        "reason_of_visit":
            List<dynamic>.from(reasonOfVisit.map((x) => x.toJson())),
      };
}

class ContractorServicesDetail {
  int id;
  int contractorId;
  // int activityId;
  // int subActivityId;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;
  // String sequenceNo;
  String activityName;
  // int createdBy;
  String subActivityName;
  // int reportingUnitId;
  // String subActSequence;

  ContractorServicesDetail({
    required this.id,
    required this.contractorId,
    // required this.activityId,
    // required this.subActivityId,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.sequenceNo,
    required this.activityName,
    //  required this.createdBy,
    required this.subActivityName,
    // required this.reportingUnitId,
    // required this.subActSequence,
  });

  factory ContractorServicesDetail.fromJson(Map<String, dynamic> json) =>
      ContractorServicesDetail(
        id: json["id"],
        contractorId: json["contractor_id"],
        // activityId: json["activity_id"],
        // subActivityId: json["sub_activity_id"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // sequenceNo: json["sequence_no"],
        activityName: json["activity_name"],
        // createdBy: json["created_by"],
        subActivityName: json["sub_activity_name"],
        // reportingUnitId: json["reporting_unit_id"],
        // subActSequence: json["sub_act_sequence"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contractor_id": contractorId,
        // "activity_id": activityId,
        // "sub_activity_id": subActivityId,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "sequence_no": sequenceNo,
        "activity_name": activityName,
        // "created_by": createdBy,
        "sub_activity_name": subActivityName,
        // "reporting_unit_id": reportingUnitId,
        // "sub_act_sequence": subActSequence,
      };
}

class ContractorCompanyDetail {
  int id;
  String contractorCompanyName;
  //int? createdBy;
  // dynamic? deletedAt;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  String? gstnNumber;

  ContractorCompanyDetail({
    required this.id,
    required this.contractorCompanyName,
    // this.createdBy,
    //  this.deletedAt,
    //  this.createdAt,
    //  this.updatedAt,
    this.gstnNumber,
  });

  factory ContractorCompanyDetail.fromJson(Map<String, dynamic> json) =>
      ContractorCompanyDetail(
        id: json["id"],
        contractorCompanyName: json["contractor_company_name"],
        // createdBy: json["created_by"] ?? 0,
        // deletedAt: json["deleted_at"]??"",
        // createdAt: DateTime.parse(json["created_at"]??""),
        // updatedAt: DateTime.parse(json["updated_at"])??"",
        gstnNumber: json["gstn_number"] ?? "",
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

class InductionTraining {
  int id;
  String inductionId;
  // int userId;
  // String userType;
  // String inducteeName;
  // dynamic contractorCompanyId;
  // dynamic tradeId;
  dynamic userPhoto;
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
    // required this.createdAt,
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
        userPhoto: json["user_photo"],
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
        "user_photo": userPhoto,
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
  String contractorName;
  String? contractorEmail;
  String? contractorPhoneNo;
  int? contractorCompanyId;
  // int createdBy;
  // dynamic deletedAt;
  DateTime? createdAt;
  // DateTime updatedAt;
  String? contractorsCompanyName;
  int? idProofType;
  String? idProofNumber;
  String? documentPath;
  String? secondaryContactPersonName;
  String? secondaryContactPersonNumber;
  // dynamic qrCode;
  // dynamic idCardExpiryDate;

  UserDetail({
    required this.id,
    required this.contractorName,
    this.contractorEmail,
    this.contractorPhoneNo,
    this.contractorCompanyId,
    // required this.createdBy,
    // required this.deletedAt,
    this.createdAt,
    // required this.updatedAt,
    this.contractorsCompanyName,
    this.idProofType,
    this.idProofNumber,
    this.documentPath,
    this.secondaryContactPersonName,
    this.secondaryContactPersonNumber,
    // required this.qrCode,
    // required this.idCardExpiryDate,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        contractorName: json["contractor_name"],
        contractorEmail: json["contractor_email"] ?? "",
        contractorPhoneNo: json["contractor_phone_no"] ?? "",
        contractorCompanyId: json["contractor_company_id"] ?? 0,
        // createdBy: json["created_by"],
        // deletedAt: json["deleted_at"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        // updatedAt: DateTime.parse(json["updated_at"]),
        contractorsCompanyName: json["contractors_company_name"] ?? '',
        idProofType: json["id_proof_type"] ?? 0,
        idProofNumber: json["id_proof_number"] ?? "",
        documentPath: json["document_path"] ?? "",
        secondaryContactPersonName: json["secondary_contact_person_name"] ?? "",
        secondaryContactPersonNumber:
            json["secondary_contact_person_number"] ?? "",
        // qrCode: json["qr_code"],
        // idCardExpiryDate: json["id_card_expiry_date"],
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
        "id_proof_type": idProofType,
        "id_proof_number": idProofNumber,
        "document_path": documentPath,
        "secondary_contact_person_name": secondaryContactPersonName,
        "secondary_contact_person_number": secondaryContactPersonNumber,
        // "qr_code": qrCode,
        // "id_card_expiry_date": idCardExpiryDate,
      };
}
