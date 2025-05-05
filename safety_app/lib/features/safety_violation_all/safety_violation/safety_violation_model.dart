// To parse this JSON data, do
//
//     final safetyViolationListingDetails = safetyViolationListingDetailsFromJson(jsonString);

import 'dart:convert';

SafetyViolationListingDetails safetyViolationListingDetailsFromJson(
        String str) =>
    SafetyViolationListingDetails.fromJson(json.decode(str));

String safetyViolationListingDetailsToJson(
        SafetyViolationListingDetails data) =>
    json.encode(data.toJson());

class SafetyViolationListingDetails {
  final List<SafetyViolationModel> data;
  final String message;
  final bool status;
  final bool token;

  SafetyViolationListingDetails({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory SafetyViolationListingDetails.fromJson(Map<String, dynamic> json) =>
      SafetyViolationListingDetails(
        data: List<SafetyViolationModel>.from(
            json["data"].map((x) => SafetyViolationModel.fromJson(x))),
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

class SafetyViolationModel {
  final int id;
  final int violationTypeId;
  // final int categoryId;
  final String details;
  // final String locationOfBreach;
  // final int riskLevelId;
  // final int sourceOfObservationId;
  // final int assigneeId;
  // final int assignerId;
  // final Location location;
  // final String signaturePhoto;
  // final int createdBy;
  // final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  // final dynamic assignerComment;
  final int? status;
  // final dynamic assignerPhotoSignatureAfter;
  // final int projectId;
  // final DateTime turnAroundTime;
  // final String violationUniqueId;

  SafetyViolationModel({
    required this.id,
    required this.violationTypeId,
    // required this.categoryId,
    required this.details,
    // required this.locationOfBreach,
    // required this.riskLevelId,
    // required this.sourceOfObservationId,
    // required this.assigneeId,
    // required this.assignerId,
    // required this.location,
    // required this.signaturePhoto,
    // required this.createdBy,
    // required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    // required this.assignerComment,
    this.status,
    // required this.assignerPhotoSignatureAfter,
    // required this.projectId,
    // required this.turnAroundTime,
    // required this.violationUniqueId,
  });

  factory SafetyViolationModel.fromJson(Map<String, dynamic> json) =>
      SafetyViolationModel(
        id: json["id"],
        violationTypeId: json["violation_type_id"],
        // categoryId: json["category_id"],
        details: json["details"],
        // locationOfBreach: json["location_of_breach"],
        // riskLevelId: json["risk_level_id"],
        // sourceOfObservationId: json["source_of_observation_id"],
        // assigneeId: json["assignee_id"],
        // assignerId: json["assigner_id"],
        // location: locationValues.map[json["location"]]!,
        // signaturePhoto: json["signature_photo"],
        // createdBy: json["created_by"],
        // deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // assignerComment: json["assigner_comment"],
        status: json["status"] ?? 0,
        // assignerPhotoSignatureAfter: json["assigner_photo_signature_after"],
        // projectId: json["project_id"],
        // turnAroundTime: DateTime.parse(json["turn_around_time"]),
        // violationUniqueId: json["violation_unique_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "violation_type_id": violationTypeId,
        // "category_id": categoryId,
        "details": details,
        // "location_of_breach": locationOfBreach,
        // "risk_level_id": riskLevelId,
        // "source_of_observation_id": sourceOfObservationId,
        // "assignee_id": assigneeId,
        // "assigner_id": assignerId,
        // "location": locationValues.reverse[location],
        // "signature_photo": signaturePhoto,
        // "created_by": createdBy,
        // "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        // "assigner_comment": assignerComment,
        // "status": status,
        // "assigner_photo_signature_after": assignerPhotoSignatureAfter,
        // "project_id": projectId,
        // "turn_around_time": turnAroundTime.toIso8601String(),
        // "violation_unique_id": violationUniqueId,
      };
}

enum Location { LOCATION_PUNE, PUNE }

final locationValues =
    EnumValues({"\"Pune\"": Location.LOCATION_PUNE, "pune": Location.PUNE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
