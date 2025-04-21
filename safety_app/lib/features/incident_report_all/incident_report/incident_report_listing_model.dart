// To parse this JSON data, do
//
//     final incidentReportListing = incidentReportListingFromJson(jsonString);

import 'dart:convert';

IncidentReportListing incidentReportListingFromJson(String str) =>
    IncidentReportListing.fromJson(json.decode(str));

String incidentReportListingToJson(IncidentReportListing data) =>
    json.encode(data.toJson());

class IncidentReportListing {
  List<Datum> data;
  String message;
  bool status;
  bool token;

  IncidentReportListing({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory IncidentReportListing.fromJson(Map<String, dynamic> json) =>
      IncidentReportListing(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  int id;
  int projectId;
  int buildingId;
  int floorId;
  int contractorCompanyId;
  String incidentDetails;
  int severityLevelId;
  int assigneeId;
  int assignerId;
  String location;
  String signaturePhoto;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int createdBy;
  String rootCause;
  dynamic signaturePhotoAfter;
  dynamic assignerComment;
  dynamic status;

  Datum({
    required this.id,
    required this.projectId,
    required this.buildingId,
    required this.floorId,
    required this.contractorCompanyId,
    required this.incidentDetails,
    required this.severityLevelId,
    required this.assigneeId,
    required this.assignerId,
    required this.location,
    required this.signaturePhoto,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.rootCause,
    required this.signaturePhotoAfter,
    required this.assignerComment,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        projectId: json["project_id"],
        buildingId: json["building_id"],
        floorId: json["floor_id"],
        contractorCompanyId: json["contractor_company_id"],
        incidentDetails: json["incident_details"],
        severityLevelId: json["severity_level_id"],
        assigneeId: json["assignee_id"],
        assignerId: json["assigner_id"],
        location: json["location"],
        signaturePhoto: json["signature_photo"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        rootCause: json["root_cause"],
        signaturePhotoAfter: json["signature_photo_after"],
        assignerComment: json["assigner_comment"],
        status: json["status"],
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
        "signature_photo": signaturePhoto,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "root_cause": rootCause,
        "signature_photo_after": signaturePhotoAfter,
        "assigner_comment": assignerComment,
        "status": status,
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
