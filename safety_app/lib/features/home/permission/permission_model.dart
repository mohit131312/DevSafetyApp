import 'dart:convert';

Permission permissionFromJson(String str) =>
    Permission.fromJson(json.decode(str));

String permissionToJson(Permission data) => json.encode(data.toJson());

class Permission {
  Data? data;
  String? message;
  bool? status;
  bool? token;

  Permission({
    this.data,
    this.message,
    this.status,
    this.token,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "status": status,
        "token": token,
      };
}

class Data {
  RolesArry? rolesArry;
  List<int>? moduleId;
  List<int>? entitlementId;
  List<int>? projects;
  String? rolemessage;
  int? rolestatus;
  int? safetyAdmin;
  int? safetyAdminSetup;

  Data({
    this.rolesArry,
    this.moduleId,
    this.entitlementId,
    this.projects,
    this.rolemessage,
    this.rolestatus,
    this.safetyAdmin,
    this.safetyAdminSetup,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rolesArry: (json["roles_arry"] is Map<String, dynamic>)
            ? RolesArry.fromJson(json["roles_arry"])
            : null,
        moduleId: (json["module_id"] is List)
            ? List<int>.from(json["module_id"].map((x) => x))
            : [],
        entitlementId: (json["entitlement_id"] is List)
            ? List<int>.from(json["entitlement_id"].map((x) => x))
            : [],
        projects: (json["projects"] is List)
            ? List<int>.from(json["projects"].map((x) => x))
            : [],
        rolemessage: json["rolemessage"],
        rolestatus: json["rolestatus"],
        safetyAdmin: json["safety_admin"],
        safetyAdminSetup: json["safety_admin_setup"],
      );

  Map<String, dynamic> toJson() => {
        "roles_arry": rolesArry?.toJson(),
        "module_id":
            moduleId == null ? [] : List<dynamic>.from(moduleId!.map((x) => x)),
        "entitlement_id": entitlementId == null
            ? []
            : List<dynamic>.from(entitlementId!.map((x) => x)),
        "projects":
            projects == null ? [] : List<dynamic>.from(projects!.map((x) => x)),
        "rolemessage": rolemessage,
        "rolestatus": rolestatus,
        "safety_admin": safetyAdmin,
        "safety_admin_setup": safetyAdminSetup,
      };
}

class RolesArry {
  Map<String, The23>? entitlementMap;
  List<int>? moduleId;
  List<int>? entitlementId;
  String? moduleName;
  int? assignedRoleId;
  List<int>? userType;

  RolesArry({
    this.entitlementMap,
    this.moduleId,
    this.entitlementId,
    this.moduleName,
    this.assignedRoleId,
    this.userType,
  });

  factory RolesArry.fromJson(Map<String, dynamic> json) {
    Map<String, The23> entMap = {};
    json.forEach((key, value) {
      if (RegExp(r'^\d+$').hasMatch(key)) {
        entMap[key] = The23.fromJson(value);
      }
    });

    return RolesArry(
      entitlementMap: entMap,
      moduleId: (json["module_id"] is List)
          ? List<int>.from(json["module_id"].map((x) => x))
          : [],
      entitlementId: (json["entitlement_id"] is List)
          ? List<int>.from(json["entitlement_id"].map((x) => x))
          : [],
      moduleName: json["module_name"],
      assignedRoleId: json["assigned_role_id"],
      userType: (json["user_type"] is List)
          ? List<int>.from(json["user_type"].map((x) => x))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (entitlementMap != null) {
      entitlementMap!.forEach((key, value) {
        map[key] = value.toJson();
      });
    }

    map["module_id"] =
        moduleId == null ? [] : List<dynamic>.from(moduleId!.map((x) => x));
    map["entitlement_id"] = entitlementId == null
        ? []
        : List<dynamic>.from(entitlementId!.map((x) => x));
    map["module_name"] = moduleName;
    map["assigned_role_id"] = assignedRoleId;
    map["user_type"] =
        userType == null ? [] : List<dynamic>.from(userType!.map((x) => x));

    return map;
  }
}

class The23 {
  bool? moduleView;
  bool? moduleCreate;
  bool? moduleEdit;
  bool? moduleDelete;
  bool? moduleDownload;
  int? assignedRoleId;
  List<int>? projects;
  int? userId;
  int? entitlementId;
  int? moduleId;
  String? moduleName;
  String? moduleEntitle;
  int? userType;

  The23({
    this.moduleView,
    this.moduleCreate,
    this.moduleEdit,
    this.moduleDelete,
    this.moduleDownload,
    this.assignedRoleId,
    this.projects,
    this.userId,
    this.entitlementId,
    this.moduleId,
    this.moduleName,
    this.moduleEntitle,
    this.userType,
  });

  factory The23.fromJson(Map<String, dynamic> json) => The23(
        moduleView: json["module_view"],
        moduleCreate: json["module_create"],
        moduleEdit: json["module_edit"],
        moduleDelete: json["module_delete"],
        moduleDownload: json["module_download"],
        assignedRoleId: json["assigned_role_id"],
        projects: (json["projects"] is List)
            ? List<int>.from(json["projects"].map((x) => x))
            : [],
        userId: json["user_id"],
        entitlementId: json["entitlement_id"],
        moduleId: json["module_id"],
        moduleName: json["module_name"],
        moduleEntitle: json["module_entitle"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "module_view": moduleView,
        "module_create": moduleCreate,
        "module_edit": moduleEdit,
        "module_delete": moduleDelete,
        "module_download": moduleDownload,
        "assigned_role_id": assignedRoleId,
        "projects":
            projects == null ? [] : List<dynamic>.from(projects!.map((x) => x)),
        "user_id": userId,
        "entitlement_id": entitlementId,
        "module_id": moduleId,
        "module_name": moduleName,
        "module_entitle": moduleEntitle,
        "user_type": userType,
      };
}
