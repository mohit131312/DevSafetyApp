// To parse this JSON data, do
//
//     final workPermitMakerModel = workPermitMakerModelFromJson(jsonString);

import 'dart:convert';

WorkPermitMakerModel workPermitMakerModelFromJson(String str) =>
    WorkPermitMakerModel.fromJson(json.decode(str));

String workPermitMakerModelToJson(WorkPermitMakerModel data) =>
    json.encode(data.toJson());

class WorkPermitMakerModel {
  Data data;
  String message;
  bool status;
  bool token;

  WorkPermitMakerModel({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory WorkPermitMakerModel.fromJson(Map<String, dynamic> json) =>
      WorkPermitMakerModel(
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
  List<WorkPermit> workPermits;
  List<SelectedSubActivity> selectedSubActivity;
  List<SelectedToolboxTraining> selectedToolboxTraining;

  BuildingList buildingList;
  CategoryList categoryList;
  List<CheckerInformation> checkerInformation;
  List<MakerInformation> makerInformation;

  Data({
    required this.workPermits,
    required this.selectedSubActivity,
    required this.selectedToolboxTraining,
    required this.buildingList,
    required this.categoryList,
    required this.checkerInformation,
    required this.makerInformation,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        workPermits: List<WorkPermit>.from(
            json["work_permits"].map((x) => WorkPermit.fromJson(x))),
        selectedSubActivity: List<SelectedSubActivity>.from(
            json["selected_sub_activity"]
                .map((x) => SelectedSubActivity.fromJson(x))),
        selectedToolboxTraining: List<SelectedToolboxTraining>.from(
            json["selected_toolbox_training"]
                .map((x) => SelectedToolboxTraining.fromJson(x))),
        buildingList: BuildingList.fromJson(json["building_list"]),
        categoryList: CategoryList.fromJson(json["category_list"]),
        checkerInformation: List<CheckerInformation>.from(
            json["checker_information"]
                .map((x) => CheckerInformation.fromJson(x))),
        makerInformation: List<MakerInformation>.from(
            json["maker_information"].map((x) => MakerInformation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "work_permits": List<dynamic>.from(workPermits.map((x) => x.toJson())),
        "selected_sub_activity":
            List<dynamic>.from(selectedSubActivity.map((x) => x.toJson())),
        "selected_toolbox_training":
            List<dynamic>.from(selectedToolboxTraining.map((x) => x.toJson())),
        "building_list": buildingList.toJson(),
        "category_list": categoryList.toJson(),
        "checker_information":
            List<dynamic>.from(checkerInformation.map((x) => x.toJson())),
      };
}

class SelectedToolboxTraining {
  int? id;
  String? nameOfTbTraining;

  SelectedToolboxTraining({
    this.id,
    this.nameOfTbTraining,
  });

  factory SelectedToolboxTraining.fromJson(Map<String, dynamic> json) =>
      SelectedToolboxTraining(
        id: json["id"] ?? 0,
        nameOfTbTraining: json["name_of_tb_training"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_of_tb_training": nameOfTbTraining,
      };
}

class BuildingList {
  List<K5> k5;

  BuildingList({
    required this.k5,
  });

  factory BuildingList.fromJson(Map<String, dynamic> json) => BuildingList(
        k5: List<K5>.from(json["K5"].map((x) => K5.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "K5": List<dynamic>.from(k5.map((x) => x.toJson())),
      };
}

class K5 {
  String buildingName;
  String floorName;

  K5({
    required this.buildingName,
    required this.floorName,
  });

  factory K5.fromJson(Map<String, dynamic> json) => K5(
        buildingName: json["building_name"],
        floorName: json["floor_name"],
      );

  Map<String, dynamic> toJson() => {
        "building_name": buildingName,
        "floor_name": floorName,
      };
}

class CategoryList {
  List<Hazard> hazards;

  CategoryList({
    required this.hazards,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        hazards:
            List<Hazard>.from(json["Hazards"].map((x) => Hazard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Hazards": List<dynamic>.from(hazards.map((x) => x.toJson())),
      };
}

class Hazard {
  int categoryId;
  String categoryName;
  int workPermitDetailsId;
  String permitDetails;

  Hazard({
    required this.categoryId,
    required this.categoryName,
    required this.workPermitDetailsId,
    required this.permitDetails,
  });

  factory Hazard.fromJson(Map<String, dynamic> json) => Hazard(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        workPermitDetailsId: json["work_permit_details_id"],
        permitDetails: json["permit_details"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "work_permit_details_id": workPermitDetailsId,
        "permit_details": permitDetails,
      };
}

class CheckerInformation {
  int userId;
  String? designation;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? photo;
  dynamic checkerComment;
  dynamic checkerSignaturePhoto;
  String? checkerStatus;

  CheckerInformation({
    required this.userId,
    this.designation,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.photo,
    this.checkerComment,
    this.checkerSignaturePhoto,
    this.checkerStatus,
  });

  factory CheckerInformation.fromJson(Map<String, dynamic> json) =>
      CheckerInformation(
        userId: json["user_id"],
        designation: json["designation"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        email: json["email"] ?? "",
        photo: json["photo"] ?? "",
        checkerComment: json["checker_comment"] ?? "",
        checkerSignaturePhoto: json["checker_signature_photo"] ?? "",
        checkerStatus: json["checker_status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "designation": designation,
        "first_name": firstName,
        "last_name": lastName,
        "mobile_number": mobileNumber,
        "email": email,
        "photo": photo,
        "checker_comment": checkerComment,
        "checker_signature_photo": checkerSignaturePhoto,
        "checker_status": checkerStatus,
      };
}

class SelectedSubActivity {
  int id;
  String subActivityName;

  SelectedSubActivity({
    required this.id,
    required this.subActivityName,
  });

  factory SelectedSubActivity.fromJson(Map<String, dynamic> json) =>
      SelectedSubActivity(
        id: json["id"],
        subActivityName: json["sub_activity_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_activity_name": subActivityName,
      };
}

class MakerInformation {
  int userId;
  String? designation;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? photo;
  String? makerComment;
  String? makerSignaturePhoto;
  String status;

  MakerInformation({
    required this.userId,
    this.designation,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.photo,
    this.makerComment,
    this.makerSignaturePhoto,
    required this.status,
  });

  factory MakerInformation.fromJson(Map<String, dynamic> json) =>
      MakerInformation(
        userId: json["user_id"],
        designation: json["designation"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        email: json["email"] ?? "",
        photo: json["photo"] ?? "",
        makerComment: json["maker_comment"] ?? "",
        makerSignaturePhoto: json["maker_signature_photo"] ?? "",
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "designation": designation,
        "first_name": firstName,
        "last_name": lastName,
        "mobile_number": mobileNumber,
        "email": email,
        "photo": photo,
        "maker_comment": makerComment,
        "maker_signature_photo": makerSignaturePhoto,
        "status": status,
      };
}

class WorkPermit {
  int id;
  String nameOfWorkpermit;
  int? subActivityId;
  String? description;
  dynamic toolboxTrainingId;
  int? projectId;
  DateTime? fromDateTime;
  DateTime? toDateTime;
  String? makerSignaturePhoto;
  int? makerId;
  dynamic makerSignaturePhotoAfter;
  dynamic makerComment;
  String? status;
  DateTime createdAt;
  // DateTime updatedAt;
  // dynamic deletedAt;
  // int undertaking1;
  // int undertaking2;
  // int undertaking3;
  // String location;

  WorkPermit({
    required this.id,
    required this.nameOfWorkpermit,
    this.subActivityId,
    this.description,
    this.toolboxTrainingId,
    this.projectId,
    this.fromDateTime,
    this.toDateTime,
    this.makerSignaturePhoto,
    this.makerId,
    this.makerSignaturePhotoAfter,
    this.makerComment,
    this.status,
    required this.createdAt,
    // required this.updatedAt,
    // required this.deletedAt,
    // required this.undertaking1,
    // required this.undertaking2,
    // required this.undertaking3,
    // required this.location,
  });

  factory WorkPermit.fromJson(Map<String, dynamic> json) => WorkPermit(
        id: json["id"],
        nameOfWorkpermit: json["name_of_workpermit"] ?? "",
        subActivityId: json["sub_activity_id"] ?? 0,
        description: json["description"] ?? "",
        toolboxTrainingId: json["toolbox_training_id"] ?? "",
        projectId: json["project_id"] ?? 0,
        fromDateTime: json["from_date_time"] != null
            ? DateTime.parse(json["from_date_time"])
            : DateTime.now(),
        toDateTime: json["to_date_time"] != null
            ? DateTime.parse(json["to_date_time"])
            : DateTime.now(),
        makerSignaturePhoto: json["maker_signature_photo"] ?? "",
        makerId: json["maker_id"] ?? 0,
        makerSignaturePhotoAfter: json["maker_signature_photo_after"],
        makerComment: json["maker_comment"],
        status: json["status"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
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
        "sub_activity_id": subActivityId,
        "description": description,
        "toolbox_training_id": toolboxTrainingId,
        "project_id": projectId,
        "from_date_time": fromDateTime!.toIso8601String(),
        "to_date_time": toDateTime!.toIso8601String(),
        "maker_signature_photo": makerSignaturePhoto,
        "maker_id": makerId,
        "maker_signature_photo_after": makerSignaturePhotoAfter,
        "maker_comment": makerComment,
        "status": status,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // "deleted_at": deletedAt,
        // "undertaking_1": undertaking1,
        // "undertaking_2": undertaking2,
        // "undertaking_3": undertaking3,
        // "location": location,
      };
}
