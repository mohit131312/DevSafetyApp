// To parse this JSON data, do
//
//     final inductionTrainingAdd = inductionTrainingAddFromJson(jsonString);

import 'dart:convert';

InductionTrainingAdd inductionTrainingAddFromJson(String str) =>
    InductionTrainingAdd.fromJson(json.decode(str));

String inductionTrainingAddToJson(InductionTrainingAdd data) =>
    json.encode(data.toJson());

class InductionTrainingAdd {
  Data data;
  String message;
  bool status;
  bool token;

  InductionTrainingAdd({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory InductionTrainingAdd.fromJson(Map<String, dynamic> json) =>
      InductionTrainingAdd(
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
  List<IdProofList> idProofList;
  List<IdProofList> reasonOfVisit;
  List<IdProofList> safetyEquipmentList;
  List<InstructionsListElement> tradeList;
  List<InstructionsListElement> instructionsList;
  List<ContractorList> contractorLists;
  List<StateList> stateList;
  List<DistrictList> districtList;
  List<BloodType> bloodTypes;
  List<ActivityList> activityList;
  List<SubActivityList> subactivityList;

  Data({
    required this.idProofList,
    required this.reasonOfVisit,
    required this.safetyEquipmentList,
    required this.tradeList,
    required this.instructionsList,
    required this.contractorLists,
    required this.stateList,
    required this.districtList,
    required this.bloodTypes,
    required this.activityList,
    required this.subactivityList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idProofList: List<IdProofList>.from(
            json["id_proof_list"].map((x) => IdProofList.fromJson(x))),
        reasonOfVisit: List<IdProofList>.from(
            json["reason_of_visit"].map((x) => IdProofList.fromJson(x))),
        safetyEquipmentList: List<IdProofList>.from(
            json["safety_equipment_list"].map((x) => IdProofList.fromJson(x))),
        tradeList: List<InstructionsListElement>.from(
            json["trade_list"].map((x) => InstructionsListElement.fromJson(x))),
        instructionsList: List<InstructionsListElement>.from(
            json["instructions_list"]
                .map((x) => InstructionsListElement.fromJson(x))),
        contractorLists: List<ContractorList>.from(
            json["contractor_lists"].map((x) => ContractorList.fromJson(x))),
        stateList: List<StateList>.from(
            json["state_list"].map((x) => StateList.fromJson(x))),
        districtList: List<DistrictList>.from(
            json["district_list"].map((x) => DistrictList.fromJson(x))),
        bloodTypes: List<BloodType>.from(
            json["bloodTypes"].map((x) => BloodType.fromJson(x))),
        activityList: List<ActivityList>.from(
            json["activity_list"].map((x) => ActivityList.fromJson(x))),
        subactivityList: List<SubActivityList>.from(
            json["sub_activity_list"].map((x) => SubActivityList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_proof_list": List<dynamic>.from(idProofList.map((x) => x.toJson())),
        "reason_of_visit":
            List<dynamic>.from(reasonOfVisit.map((x) => x.toJson())),
        "safety_equipment_list":
            List<dynamic>.from(safetyEquipmentList.map((x) => x.toJson())),
        "trade_list": List<dynamic>.from(tradeList.map((x) => x.toJson())),
        "instructions_list":
            List<dynamic>.from(instructionsList.map((x) => x.toJson())),
        "contractor_lists":
            List<dynamic>.from(contractorLists.map((x) => x.toJson())),
        "state_list": List<dynamic>.from(stateList.map((x) => x.toJson())),
        "district_list":
            List<dynamic>.from(districtList.map((x) => x.toJson())),
        "bloodTypes": List<dynamic>.from(bloodTypes.map((x) => x.toJson())),
        "activity_list":
            List<dynamic>.from(activityList.map((x) => x.toJson())),
        "sub_activity_list":
            List<dynamic>.from(activityList.map((x) => x.toJson())),
      };
}

class ActivityList {
  int id;
  String activityName;

  ActivityList({
    required this.id,
    required this.activityName,
  });

  factory ActivityList.fromJson(Map<String, dynamic> json) => ActivityList(
        id: json["id"],
        activityName: json["activity_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activity_name": activityName,
      };
}

class SubActivityList {
  int id;
  String subactivityName;

  SubActivityList({
    required this.id,
    required this.subactivityName,
  });

  factory SubActivityList.fromJson(Map<String, dynamic> json) =>
      SubActivityList(
        id: json["id"],
        subactivityName: json["sub_activity_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_activity_name": subactivityName,
      };
}

class BloodType {
  String type;
  String value;

  BloodType({
    required this.type,
    required this.value,
  });

  factory BloodType.fromJson(Map<String, dynamic> json) => BloodType(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}

class ContractorList {
  int id;
  String contractorCompanyName;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? gstnNumber;
  String? deletedAt;

  ContractorList({
    required this.id,
    required this.contractorCompanyName,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.gstnNumber,
    this.deletedAt,
  });

  // Convert JSON to Dart object
  factory ContractorList.fromJson(Map<String, dynamic> json) {
    return ContractorList(
      id: json['id'],
      contractorCompanyName: json['contractor_company_name'] ?? '',
      createdBy: json['created_by'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      gstnNumber: json['gstn_number'] ?? '',
      deletedAt: json['deleted_at'], // Nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contractor_company_name': contractorCompanyName,
      'created_by': createdBy,
      'created_at': createdAt ?? '',
      'updated_at': updatedAt ?? '',
      'gstn_number': gstnNumber ?? '',
      'deleted_at': deletedAt, // Nullable, don't assign default value
    };
  }
}

class DistrictList {
  int id;
  int stateId;
  String districtName;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  DistrictList({
    required this.id,
    required this.stateId,
    required this.districtName,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DistrictList.fromJson(Map<String, dynamic> json) => DistrictList(
        id: json["id"],
        stateId: json["state_id"],
        districtName: json["district_name"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_id": stateId,
        "district_name": districtName,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class IdProofList {
  int id;
  String listDetails;
  int setupType;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  IdProofList({
    required this.id,
    required this.listDetails,
    required this.setupType,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IdProofList.fromJson(Map<String, dynamic> json) => IdProofList(
        id: json["id"],
        listDetails: json["list_details"],
        setupType: json["setup_type"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "list_details": listDetails,
        "setup_type": setupType,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class InstructionsListElement {
  int id;
  int categoryId;
  String inductionDetails;
  int setupType;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  InstructionsListElement({
    required this.id,
    required this.categoryId,
    required this.inductionDetails,
    required this.setupType,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InstructionsListElement.fromJson(Map<String, dynamic> json) =>
      InstructionsListElement(
        id: json["id"],
        categoryId: json["category_id"],
        inductionDetails: json["induction_details"],
        setupType: json["setup_type"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "induction_details": inductionDetails,
        "setup_type": setupType,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class StateList {
  int id;
  String stateName;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  StateList({
    required this.id,
    required this.stateName,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        id: json["id"],
        stateName: json["state_name"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_name": stateName,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
