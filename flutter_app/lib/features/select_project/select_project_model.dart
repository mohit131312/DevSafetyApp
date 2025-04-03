// To parse this JSON data, do
//
//     final selectRole = selectRoleFromJson(jsonString);

import 'dart:convert';

SelectProject selectRoleFromJson(String str) =>
    SelectProject.fromJson(json.decode(str));

String selectRoleToJson(SelectProject data) => json.encode(data.toJson());

class SelectProject {
  List<ProjectData> data;
  String message;
  bool status;
  bool token;

  SelectProject({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory SelectProject.fromJson(Map<String, dynamic> json) => SelectProject(
        data: List<ProjectData>.from(
            json["data"].map((x) => ProjectData.fromJson(x))),
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

class ProjectData {
  int projectId;
  String projectName;

  ProjectData({
    required this.projectId,
    required this.projectName,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
        projectId: json["project_id"],
        projectName: json["project_name"],
      );

  Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "project_name": projectName,
      };
}
