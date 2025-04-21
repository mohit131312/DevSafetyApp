// To parse this JSON data, do
//
//     final workPermitall = workPermitallFromJson(jsonString);

import 'dart:convert';

WorkPermitall workPermitallFromJson(String str) =>
    WorkPermitall.fromJson(json.decode(str));

String workPermitallToJson(WorkPermitall data) => json.encode(data.toJson());

class WorkPermitall {
  List<WorkPermitListingAll> data;
  String message;
  bool status;
  bool token;

  WorkPermitall({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory WorkPermitall.fromJson(Map<String, dynamic> json) => WorkPermitall(
        data: List<WorkPermitListingAll>.from(
            json["data"].map((x) => WorkPermitListingAll.fromJson(x))),
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

class WorkPermitListingAll {
  int id;
  String nameOfWorkpermit;
  // int subActivityId;
  String? description;
  int? toolboxTrainingId;
  int? projectId;
  // DateTime fromDateTime;
  // DateTime toDateTime;
  // String makerSignaturePhoto;
  int? makerId;
  // dynamic makerSignaturePhotoAfter;
  // dynamic makerComment;
  String? status;
  DateTime? createdAt;
  // DateTime updatedAt;
  // dynamic deletedAt;
  // int undertaking1;
  // int undertaking2;
  // int undertaking3;
  // String location;

  WorkPermitListingAll({
    required this.id,
    required this.nameOfWorkpermit,
    // required this.subActivityId,
    this.description,
    this.toolboxTrainingId,
    this.projectId,
    // required this.fromDateTime,
    // required this.toDateTime,
    // required this.makerSignaturePhoto,
    this.makerId,
    // required this.makerSignaturePhotoAfter,
    // required this.makerComment,
    this.status,
    this.createdAt,
    // required this.updatedAt,
    // required this.deletedAt,
    // required this.undertaking1,
    // required this.undertaking2,
    // required this.undertaking3,
    // required this.location,
  });

  factory WorkPermitListingAll.fromJson(Map<String, dynamic> json) =>
      WorkPermitListingAll(
        id: json["id"],
        nameOfWorkpermit: json["name_of_workpermit"],
        // subActivityId: json["sub_activity_id"],
        description: json["description"] ?? "",
        toolboxTrainingId: json["toolbox_training_id"] ?? 0,
        projectId: json["project_id"] ?? 0,
        // fromDateTime: DateTime.parse(json["from_date_time"]),
        // toDateTime: DateTime.parse(json["to_date_time"]),
        // makerSignaturePhoto: json["maker_signature_photo"],
        makerId: json["maker_id"] ?? 0,
        // makerSignaturePhotoAfter: json["maker_signature_photo_after"],
        // makerComment: json["maker_comment"],
        status: json["status"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
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
        // "sub_activity_id": subActivityId,
        "description": description,
        "toolbox_training_id": toolboxTrainingId,
        "project_id": projectId,
        // "from_date_time": fromDateTime.toIso8601String(),
        // "to_date_time": toDateTime.toIso8601String(),
        // "maker_signature_photo": makerSignaturePhoto,
        "maker_id": makerId,
        // "maker_signature_photo_after": makerSignaturePhotoAfter,
        // "maker_comment": makerComment,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "deleted_at": deletedAt,
        // "undertaking_1": undertaking1,
        // "undertaking_2": undertaking2,
        // "undertaking_3": undertaking3,
        // "location": location,
      };
}



