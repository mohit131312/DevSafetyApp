import 'dart:convert';

SelectProject selectProjectFromJson(String str) =>
    SelectProject.fromJson(json.decode(str));

String selectProjectToJson(SelectProject data) => json.encode(data.toJson());

class SelectProject {
  SelectProjectData data;
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
        data: SelectProjectData.fromJson(json["data"]),
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

class SelectProjectData {
  List<ProjectData> assignProjectInfo;

  SelectProjectData({
    required this.assignProjectInfo,
  });

  factory SelectProjectData.fromJson(Map<String, dynamic> json) =>
      SelectProjectData(
        assignProjectInfo: List<ProjectData>.from(
          json["assin_project_info"].map((x) => ProjectData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "assin_project_info":
            List<dynamic>.from(assignProjectInfo.map((x) => x.toJson())),
      };
}

class ProjectData {
  int projectId;
  String projectName;
  String projectLocation;

  ProjectData({
    required this.projectId,
    required this.projectName,
    required this.projectLocation,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
        projectId: json["project_id"],
        projectName: json["project_name"],
        projectLocation: json["project_location"],
      );

  Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "project_name": projectName,
        "project_location": projectLocation,
      };
}
