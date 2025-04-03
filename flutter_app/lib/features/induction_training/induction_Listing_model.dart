// To parse this JSON data, do
//
//     final inductionListing = inductionListingFromJson(jsonString);

import 'dart:convert';

InductionListing inductionListingFromJson(String str) =>
    InductionListing.fromJson(json.decode(str));

String inductionListingToJson(InductionListing data) =>
    json.encode(data.toJson());

class InductionListing {
  List<InductionListing> data;
  String message;
  bool status;
  bool token;

  InductionListing({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory InductionListing.fromJson(Map<String, dynamic> json) =>
      InductionListing(
        data: List<InductionListing>.from(
            json["data"].map((x) => InductionListing.fromJson(x))),
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

class InductionListingData {
  int id;
  String inductionId;
  int userId;
  String? userType;
  String? inducteeName;
  int? contractorCompanyId;
  int? tradeId;
  String? userPhoto;
  // int experienceInYears;
  // int signatureFlag;
  // int signatureBehalfOf;
  // String signaturePhoto;
  // int undertakingInstruction1;
  // int undertakingInstruction2;
  // int undertakingInstruction3;
  int? inductedById;
  // InductedByName inductedByName;
  // Location location;
  DateTime? createdAt;
  // DateTime updatedAt;
  int? reasonOfVisit;
  // dynamic deletedAt;
  int? projectId;
  // String name;

  InductionListingData({
    required this.id,
    required this.inductionId,
    required this.userId,
    this.userType,
    this.inducteeName,
    this.contractorCompanyId,
    this.tradeId,
    this.userPhoto,
    // required this.experienceInYears,
    // required this.signatureFlag,
    // required this.signatureBehalfOf,
    // required this.signaturePhoto,
    // required this.undertakingInstruction1,
    // required this.undertakingInstruction2,
    // required this.undertakingInstruction3,
    this.inductedById,
    // required this.inductedByName,
    // required this.location,
    this.createdAt,
    // required this.updatedAt,
    this.reasonOfVisit,
    // required this.deletedAt,
    this.projectId,
    // required this.name,
  });

  factory InductionListingData.fromJson(Map<String, dynamic> json) =>
      InductionListingData(
        id: json["id"],
        inductionId: json["induction_id"],
        userId: json["user_id"] ?? 0,
        userType: json["user_type"] ?? 1,
        inducteeName: json["inductee_name"] ?? "",
        contractorCompanyId: json["contractor_company_id"] ?? 0,
        tradeId: json["trade_id"] ?? 0,
        userPhoto: json["user_photo"] ?? "",
        // experienceInYears: json["experience_in_years"],
        // signatureFlag: json["signature_flag"],
        // signatureBehalfOf: json["signature_behalf_of"],
        // signaturePhoto: json["signature_photo"],
        // undertakingInstruction1: json["undertaking_instruction_1"],
        // undertakingInstruction2: json["undertaking_instruction_2"],
        // undertakingInstruction3: json["undertaking_instruction_3"],
        inductedById: json["inducted_by_id"] ?? 0,
        // inductedByName: inductedByNameValues.map[json["inducted_by_name"]],
        // location: locationValues.map[json["location"]],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        // updatedAt: DateTime.parse(json["updated_at"]),
        reasonOfVisit: json["reason_of_visit"] ?? "",
        // deletedAt: json["deleted_at"],
        projectId: json["project_id"] ?? 0,
        // name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "induction_id": inductionId,
        "user_id": userId,
        "user_type": userType,
        "inductee_name": inducteeName,
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
        // "inducted_by_name": inductedByNameValues.reverse[inductedByName],
        // "location": locationValues.reverse[location],
        "created_at": createdAt!.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "reason_of_visit": reasonOfVisit,
        // "deleted_at": deletedAt,
        // "project_id": projectId,
        // "name": name,
      };
}

enum InductedByName { NULL, SANIKA_RAJE }

final inductedByNameValues = EnumValues(
    {"null": InductedByName.NULL, "sanika raje": InductedByName.SANIKA_RAJE});

enum Location { PUNE }

final locationValues = EnumValues({"pune": Location.PUNE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
