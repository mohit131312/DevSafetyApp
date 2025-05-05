// To parse this JSON data, do
//
//     final incidentReportListing = incidentReportListingFromJson(jsonString);

import 'dart:convert';

IncidentReportListing incidentReportListingFromJson(String str) =>
    IncidentReportListing.fromJson(json.decode(str));

String incidentReportListingToJson(IncidentReportListing data) =>
    json.encode(data.toJson());

class IncidentReportListing {
  final List<IncidentReportList> data;
  final String message;
  final bool status;
  final bool token;

  IncidentReportListing({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory IncidentReportListing.fromJson(Map<String, dynamic> json) =>
      IncidentReportListing(
        data: List<IncidentReportList>.from(
            json["data"].map((x) => IncidentReportList.fromJson(x))),
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

class IncidentReportList {
  final int id;
  final int projectId;
  final int? buildingId;
  final int? floorId;
  final int? contractorCompanyId;
  final String? incidentDetails;
  final int? severityLevelId;
  final int? assigneeId;
  final int? assignerId;
  final String? location;
  // final String? signaturePhoto;
  // final dynamic deletedAt;
  final DateTime? createdAt;
  // final DateTime updatedAt;
  // final int createdBy;
  // final String rootCause;
  // final dynamic signaturePhotoAfter;
  // final dynamic assignerComment;
  final int? status;
  final String? severityColor;
  final String? colorName;

  IncidentReportList(
      {required this.id,
      required this.projectId,
      required this.buildingId,
      required this.floorId,
      required this.contractorCompanyId,
      required this.incidentDetails,
      required this.severityLevelId,
      required this.assigneeId,
      required this.assignerId,
      required this.location,
      // required this.signaturePhoto,
      // required this.deletedAt,
      required this.createdAt,
      // required this.updatedAt,
      // required this.createdBy,
      // required this.rootCause,
      // required this.signaturePhotoAfter,
      // required this.assignerComment,
      this.status,
      this.severityColor,
      this.colorName});

  factory IncidentReportList.fromJson(Map<String, dynamic> json) =>
      IncidentReportList(
        id: json["id"],
        projectId: json["project_id"],
        buildingId: json["building_id"] ?? 0,
        floorId: json["floor_id"] ?? 0,
        contractorCompanyId: json["contractor_company_id"] ?? 0,
        incidentDetails: json["incident_details"] ?? "",
        severityLevelId: json["severity_level_id"] ?? 0,
        assigneeId: json["assignee_id"] ?? 0,
        assignerId: json["assigner_id"] ?? 0,
        location: json["location"]! ?? "",
        // signaturePhoto: json["signature_photo"],
        // deletedAt: json["deleted_at"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        // updatedAt: DateTime.parse(json["updated_at"]),
        // createdBy: json["created_by"],
        // rootCause: json["root_cause"],
        // signaturePhotoAfter: json["signature_photo_after"],
        // assignerComment: json["assigner_comment"],
        status: json["status"] ?? 0,
        severityColor: json["severity_color"] ?? "",
        colorName: json["Color_name"] ?? "",
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
        "location": locationValues.reverse[location],
        // "signature_photo": signaturePhoto,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "created_by": createdBy,
        // "root_cause": rootCause,
        // "signature_photo_after": signaturePhotoAfter,
        // "assigner_comment": assignerComment,
        // "status": status,
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
