// To parse this JSON data, do
//
//     final workPremitData = workPremitDataFromJson(jsonString);

import 'dart:convert';

WorkPremitData workPremitDataFromJson(String str) =>
    WorkPremitData.fromJson(json.decode(str));

String workPremitDataToJson(WorkPremitData data) => json.encode(data.toJson());

class WorkPremitData {
  Data data;
  String message;
  bool status;
  bool token;

  WorkPremitData({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory WorkPremitData.fromJson(Map<String, dynamic> json) => WorkPremitData(
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
  List<CategoryList> categoryList;
  List<SubActivityList> subActivityLists;
  List<BuildingList> buildingList;
  List<CheckerUserList> checkerUserList;
  List<ProjectWiseFloor> projectwiseFloorList;

  Data({
    required this.categoryList,
    required this.subActivityLists,
    required this.buildingList,
    required this.checkerUserList,
    required this.projectwiseFloorList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryList: List<CategoryList>.from(
            json["category_list"].map((x) => CategoryList.fromJson(x))),
        subActivityLists: List<SubActivityList>.from(
            json["sub_activity_lists"].map((x) => SubActivityList.fromJson(x))),
        buildingList: List<BuildingList>.from(
            json["building_list"].map((x) => BuildingList.fromJson(x))),
        checkerUserList: List<CheckerUserList>.from(
            json["checker_user_list"].map((x) => CheckerUserList.fromJson(x))),
        projectwiseFloorList: List<ProjectWiseFloor>.from(
            json["project_wise_floor_list"]
                .map((x) => ProjectWiseFloor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_list":
            List<dynamic>.from(categoryList.map((x) => x.toJson())),
        "sub_activity_lists":
            List<dynamic>.from(subActivityLists.map((x) => x.toJson())),
        "building_list":
            List<dynamic>.from(buildingList.map((x) => x.toJson())),
        "checker_user_list":
            List<dynamic>.from(checkerUserList.map((x) => x.toJson())),
        "project_wise_floor_list":
            List<dynamic>.from(projectwiseFloorList.map((x) => x.toJson())),
      };
}

class BuildingList {
  int id;
  int projectInfoId;
  int buildingNo;
  String buildingName;
  // String buildingAbv;
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
    required this.projectInfoId,
    required this.buildingNo,
    required this.buildingName,
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
        projectInfoId: json["project_info_id"],
        buildingNo: json["building_no"],
        buildingName: json["building_name"],
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
        "project_info_id": projectInfoId,
        "building_no": buildingNo,
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

class CategoryList {
  int id;
  String categoryName;

  CategoryList({
    required this.id,
    required this.categoryName,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
      };
}

class CheckerUserList {
  int id;
  String firstName;
  String lastName;
  // String email;
  // dynamic emailVerifiedAt;
  // String location;
  // String mobileNumber;
  // int role;
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

  CheckerUserList({
    required this.id,
    required this.firstName,
    required this.lastName,
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

  factory CheckerUserList.fromJson(Map<String, dynamic> json) =>
      CheckerUserList(
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

class SubActivityList {
  int id;
  String subActivityName;

  SubActivityList({
    required this.id,
    required this.subActivityName,
  });

  factory SubActivityList.fromJson(Map<String, dynamic> json) =>
      SubActivityList(
        id: json["id"],
        subActivityName: json["sub_activity_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_activity_name": subActivityName,
      };
}

class ProjectWiseFloor {
  final int id;
  final String floorName;
  final int? floorCategory;

  ProjectWiseFloor({
    required this.id,
    required this.floorName,
    this.floorCategory,
  });

  // Factory constructor to create an object from JSON
  factory ProjectWiseFloor.fromJson(Map<String, dynamic> json) {
    return ProjectWiseFloor(
      id: json['id'],
      floorName: json['floor_name'],
      floorCategory: json['floor_category'] ?? "",
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'floor_name': floorName,
      'floor_category': floorCategory,
    };
  }
}
