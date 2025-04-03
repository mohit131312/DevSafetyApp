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
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<PermissionList> permissionList;

  RolesArray({
    required this.id,
    required this.roleName,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.permissionList,
  });

  factory RolesArray.fromJson(Map<String, dynamic> json) => RolesArray(
        id: json["id"],
        roleName: json["role_name"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        permissionList: List<PermissionList>.from(
            json["permission_list"].map((x) => PermissionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_name": roleName,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "permission_list":
            List<dynamic>.from(permissionList.map((x) => x.toJson())),
      };
}

class PermissionList {
  int id;
  int entitlementModuleId;
  int safetyRoleId;
  String moduleView;
  String moduleCreate;
  String moduleEdit;
  String moduleDelete;
  String moduleDownload;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  ModuleName moduleName;

  PermissionList({
    required this.id,
    required this.entitlementModuleId,
    required this.safetyRoleId,
    required this.moduleView,
    required this.moduleCreate,
    required this.moduleEdit,
    required this.moduleDelete,
    required this.moduleDownload,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.moduleName,
  });

  factory PermissionList.fromJson(Map<String, dynamic> json) => PermissionList(
        id: json["id"],
        entitlementModuleId: json["entitlement_module_id"],
        safetyRoleId: json["safety_role_id"],
        moduleView: json["module_view"],
        moduleCreate: json["module_create"],
        moduleEdit: json["module_edit"],
        moduleDelete: json["module_delete"],
        moduleDownload: json["module_download"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        moduleName: ModuleName.fromJson(json["module_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entitlement_module_id": entitlementModuleId,
        "safety_role_id": safetyRoleId,
        "module_view": moduleView,
        "module_create": moduleCreate,
        "module_edit": moduleEdit,
        "module_delete": moduleDelete,
        "module_download": moduleDownload,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "module_name": moduleName.toJson(),
      };
}

class ModuleName {
  int id;
  int moduleId;
  String moduleName;
  String moduleEntitle;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  ModuleName({
    required this.id,
    required this.moduleId,
    required this.moduleName,
    required this.moduleEntitle,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ModuleName.fromJson(Map<String, dynamic> json) => ModuleName(
        id: json["id"],
        moduleId: json["module_id"],
        moduleName: json["module_name"],
        moduleEntitle: json["module_entitle"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "module_id": moduleId,
        "module_name": moduleName,
        "module_entitle": moduleEntitle,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
