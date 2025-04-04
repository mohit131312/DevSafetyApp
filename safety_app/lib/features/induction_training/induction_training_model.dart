// To parse this JSON data, do
//
//     final addData = addDataFromJson(jsonString);

import 'dart:convert';

AddData addDataFromJson(String str) => AddData.fromJson(json.decode(str));

String addDataToJson(AddData data) => json.encode(data.toJson());

class AddData {
  List<CategoryData> data;
  String message;
  bool status;
  bool token;

  AddData({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory AddData.fromJson(Map<String, dynamic> json) => AddData(
        data: List<CategoryData>.from(
            json["data"].map((x) => CategoryData.fromJson(x))),
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

class CategoryData {
  int id;
  String categoryName;
  String iconPath;

  CategoryData({
    required this.id,
    required this.categoryName,
    required this.iconPath,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"],
        categoryName: json["category_name"],
        iconPath: json["icon_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "icon_path": iconPath,
      };
}
