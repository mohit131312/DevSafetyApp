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

class WorkPermitDetail {
  final int id;
  final String permitDetails;
  final int categoriesId;
  final String categoryName;

  WorkPermitDetail({
    required this.id,
    required this.permitDetails,
    required this.categoriesId,
    required this.categoryName,
  });

  /// Factory method to create an instance from a JSON object
  factory WorkPermitDetail.fromJson(Map<String, dynamic> json) {
    return WorkPermitDetail(
      id: json['id'],
      permitDetails: json['permit_details'],
      categoriesId: json['categories_id'],
      categoryName: json['category_name'],
    );
  }

  /// Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'permit_details': permitDetails,
      'categories_id': categoriesId,
      'category_name': categoryName,
    };
  }
}
