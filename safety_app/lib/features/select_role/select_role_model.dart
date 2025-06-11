import 'dart:convert';

SelectRoleData selectRoleFromJson(String str) =>
    SelectRoleData.fromJson(json.decode(str));

String selectRoleToJson(SelectRoleData data) => json.encode(data.toJson());

class SelectRoleData {
  Data data;
  String message;
  bool status;

  SelectRoleData({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SelectRoleData.fromJson(Map<String, dynamic> json) => SelectRoleData(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  int userId;
  String userName;
  String email;
  String userRole;
  String accessToken;
  List<RolesArray> rolesArray;

  Data({
    required this.userId,
    required this.userName,
    required this.email,
    required this.userRole,
    required this.accessToken,
    required this.rolesArray,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        userName: json["user_name"],
        email: json["email"],
        userRole: json["user_role"],
        accessToken: json["access_token"],
        rolesArray: List<RolesArray>.from(
            json["roles_array"].map((x) => RolesArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "email": email,
        "user_role": userRole,
        "access_token": accessToken,
        "roles_array": List<dynamic>.from(rolesArray.map((x) => x.toJson())),
      };
}

class RolesArray {
  int id;
  String roleName;
  // dynamic deletedAt;
  // DateTime createdAt;
  // DateTime updatedAt;

  RolesArray({
    required this.id,
    required this.roleName,
    // required this.deletedAt,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory RolesArray.fromJson(Map<String, dynamic> json) => RolesArray(
        id: json["id"],
        roleName: json["role_name"],
        // deletedAt: json["deleted_at"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_name": roleName,
        // "deleted_at": deletedAt,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        // List<dynamic>.from(permissionList.map((x) => x.toJson())),
      };
}
