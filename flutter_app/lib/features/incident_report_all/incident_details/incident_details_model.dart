// To parse this JSON data, do
//
//     final incidentFloor = incidentFloorFromJson(jsonString);

import 'dart:convert';

IncidentFloor incidentFloorFromJson(String str) =>
    IncidentFloor.fromJson(json.decode(str));

String incidentFloorToJson(IncidentFloor data) => json.encode(data.toJson());

class IncidentFloor {
  List<FloorModel> data;
  String message;
  bool status;
  bool token;

  IncidentFloor({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory IncidentFloor.fromJson(Map<String, dynamic> json) => IncidentFloor(
        data: List<FloorModel>.from(
            json["data"].map((x) => FloorModel.fromJson(x))),
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

class FloorModel {
  int id;
  String floorName;
  int floorCategory;

  FloorModel({
    required this.id,
    required this.floorName,
    required this.floorCategory,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) => FloorModel(
        id: json["id"],
        floorName: json["floor_name"],
        floorCategory: json["floor_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "floor_name": floorName,
        "floor_category": floorCategory,
      };
}
