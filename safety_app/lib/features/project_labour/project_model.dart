// To parse this JSON data, do
//
//     final project = projectFromJson(jsonString);

import 'dart:convert';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Data data;
  String message;
  bool status;
  bool token;

  Project({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
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
  List<InvolvedLaboursList> involvedLaboursList;

  Data({
    required this.involvedLaboursList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        involvedLaboursList: List<InvolvedLaboursList>.from(
            json["involved_labours_list"]
                .map((x) => InvolvedLaboursList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "involved_labours_list":
            List<dynamic>.from(involvedLaboursList.map((x) => x.toJson())),
      };
}

class InvolvedLaboursList {
  int labourId;
  String labourName;
  String contactNumber;
  String? labourImageUrl;

  InvolvedLaboursList({
    required this.labourId,
    required this.labourName,
    required this.contactNumber,
    this.labourImageUrl,
  });

  factory InvolvedLaboursList.fromJson(Map<String, dynamic> json) =>
      InvolvedLaboursList(
        labourId: json["labour_id"],
        labourName: json["labour_name"],
        contactNumber: json["contact_number"],
        labourImageUrl: json["user_photo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "labour_id": labourId,
        "labour_name": labourName,
        "contact_number": contactNumber,
      };
}
