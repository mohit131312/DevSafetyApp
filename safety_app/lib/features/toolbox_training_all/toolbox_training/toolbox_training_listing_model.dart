// To parse this JSON data, do
//
//     final toolBoxListing = toolBoxListingFromJson(jsonString);

import 'dart:convert';

ToolBoxListing toolBoxListingFromJson(String str) =>
    ToolBoxListing.fromJson(json.decode(str));

String toolBoxListingToJson(ToolBoxListing data) => json.encode(data.toJson());

class ToolBoxListing {
  final List<ToolboxDetails> data;
  final String message;
  final bool status;
  final bool token;

  ToolBoxListing({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory ToolBoxListing.fromJson(Map<String, dynamic> json) => ToolBoxListing(
        data: List<ToolboxDetails>.from(
            json["data"].map((x) => ToolboxDetails.fromJson(x))),
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

class ToolboxDetails {
  final int id;
  final int projectId;
  final String details;
  final String nameOfTbTraining;
  final int? toolboxCategoryId;
  // final int? makerId;
  // final int? reviwerId;
  // final String? makerComment;
  // final String? reviwerComment;
  // final String? location;
  // final String? makerSignaturePhoto;
  // final String makerPhotoSignatureAfter;
  // final String reviwerPhotoSignatureAfter;
  final int? status;
  // final String reviewerUpdatedAt;
  final DateTime? createdAt;
  final String? tooluniqueId;
  // final DateTime updatedAt;
  // final dynamic deletedAt;
  // final int workPermitId;

  ToolboxDetails(
      {required this.id,
      required this.projectId,
      required this.details,
      required this.nameOfTbTraining,
      this.toolboxCategoryId,
      // required this.makerId,
      // required this.reviwerId,
      // required this.makerComment,
      // required this.reviwerComment,
      // required this.location,
      // required this.makerSignaturePhoto,
      // required this.makerPhotoSignatureAfter,
      // required this.reviwerPhotoSignatureAfter,
      this.status,
      // required this.reviewerUpdatedAt,
      this.createdAt,
      this.tooluniqueId
      // required this.updatedAt,
      // required this.deletedAt,
      // required this.workPermitId,
      });

  factory ToolboxDetails.fromJson(Map<String, dynamic> json) => ToolboxDetails(
      id: json["id"],
      projectId: json["project_id"],
      details: json["details"],
      nameOfTbTraining: json["name_of_tb_training"],
      toolboxCategoryId: json["toolbox_category_id"] ?? 0,
      // makerId: json["maker_id"],
      // reviwerId: json["reviwer_id"],
      // makerComment: json["maker_comment"],
      // reviwerComment: json["reviwer_comment"],
      // location: json["location"],
      // makerSignaturePhoto: json["maker_signature_photo"],
      // makerPhotoSignatureAfter: json["maker_photo_signature_after"],
      // reviwerPhotoSignatureAfter: json["reviwer_photo_signature_after"],
      status: json["status"] ?? 4,
      // reviewerUpdatedAt: json["reviewer_updated_at"],
      createdAt: DateTime.parse(json["created_at"]),
      tooluniqueId: json['toolbox_unique_id'] ?? ""
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
        // "maker_id": makerId,
        // "reviwer_id": reviwerId,
        // "maker_comment": makerComment,
        // "reviwer_comment": reviwerComment,
        // "location": location,
        // "maker_signature_photo": makerSignaturePhoto,
        // "maker_photo_signature_after": makerPhotoSignatureAfter,
        // "reviwer_photo_signature_after": reviwerPhotoSignatureAfter,
        // "status": status,
        // "reviewer_updated_at": reviewerUpdatedAt,
        "created_at": createdAt!.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "deleted_at": deletedAt,
        // "work_permit_id": workPermitId,
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
