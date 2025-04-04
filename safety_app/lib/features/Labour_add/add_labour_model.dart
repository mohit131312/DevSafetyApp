// To parse this JSON data, do
//
//     final searchLabourInfo = searchLabourInfoFromJson(jsonString);

import 'dart:convert';

SearchLabourInfo searchLabourInfoFromJson(String str) =>
    SearchLabourInfo.fromJson(json.decode(str));

String searchLabourInfoToJson(SearchLabourInfo data) =>
    json.encode(data.toJson());

class SearchLabourInfo {
  Data data;
  String message;
  bool status;
  bool token;

  SearchLabourInfo({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory SearchLabourInfo.fromJson(Map<String, dynamic> json) =>
      SearchLabourInfo(
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
  List<Labour> labour;
  List<IdProofList> idProofList;
  List<IdProofList> reasonOfVisit;
  List<IdProofList> safetyEquipmentList;
  List<InstructionsListElement> tradeList;
  List<InstructionsListElement> instructionsList;
  List<ContractorList> contractorLists;
  List<StateList> stateList;
  List<DistrictList> districtList;
  List<BloodType> bloodTypes;

  Data({
    required this.labour,
    required this.idProofList,
    required this.reasonOfVisit,
    required this.safetyEquipmentList,
    required this.tradeList,
    required this.instructionsList,
    required this.contractorLists,
    required this.stateList,
    required this.districtList,
    required this.bloodTypes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        labour:
            List<Labour>.from(json["labour"].map((x) => Labour.fromJson(x))),
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
      );

  Map<String, dynamic> toJson() => {
        "labour": List<dynamic>.from(labour.map((x) => x.toJson())),
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
  int createdBy;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String gstnNumber;

  ContractorList({
    required this.id,
    required this.contractorCompanyName,
    required this.createdBy,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.gstnNumber,
  });

  factory ContractorList.fromJson(Map<String, dynamic> json) => ContractorList(
        id: json["id"],
        contractorCompanyName: json["contractor_company_name"],
        createdBy: json["created_by"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        gstnNumber: json["gstn_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contractor_company_name": contractorCompanyName,
        "created_by": createdBy,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "gstn_number": gstnNumber,
      };
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
    required this.deletedAt,
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
    required this.deletedAt,
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
    required this.deletedAt,
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

class Labour {
  int id;
  String inducteeId;
  String labourName;
  String gender;
  String literacy;
  String maritalStatus;
  String bloodGroup;
  DateTime birthDate;
  int age;
  String contactNumber;
  String userPhoto;
  String currentStreetName;
  String currentCity;
  String currentTaluka;
  int currentDistrict;
  int currentState;
  String currentPincode;
  String permanentStreetName;
  String permanentCity;
  String permanentTaluka;
  int permanentDistrict;
  int permanentState;
  String permanentPincode;
  int experienceInYears;
  dynamic uanNumber;
  dynamic bocwNumber;
  String bankName;
  String ifscNumber;
  String accountNumber;
  String branchAddress;
  String groupInsuranceLimit;
  String insuranceNumber;
  String insuranceType;
  DateTime insuranceValidity;
  String emergencyContactName;
  String emergencyContactNumber;
  String emergencyContactRelation;
  String isActive;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String adhaarCardNo;
  dynamic qrCode;
  dynamic idCardExpiryDate;
  List<AssignLabourProject> assignLabourProjects;

  Labour({
    required this.id,
    required this.inducteeId,
    required this.labourName,
    required this.gender,
    required this.literacy,
    required this.maritalStatus,
    required this.bloodGroup,
    required this.birthDate,
    required this.age,
    required this.contactNumber,
    required this.userPhoto,
    required this.currentStreetName,
    required this.currentCity,
    required this.currentTaluka,
    required this.currentDistrict,
    required this.currentState,
    required this.currentPincode,
    required this.permanentStreetName,
    required this.permanentCity,
    required this.permanentTaluka,
    required this.permanentDistrict,
    required this.permanentState,
    required this.permanentPincode,
    required this.experienceInYears,
    required this.uanNumber,
    required this.bocwNumber,
    required this.bankName,
    required this.ifscNumber,
    required this.accountNumber,
    required this.branchAddress,
    required this.groupInsuranceLimit,
    required this.insuranceNumber,
    required this.insuranceType,
    required this.insuranceValidity,
    required this.emergencyContactName,
    required this.emergencyContactNumber,
    required this.emergencyContactRelation,
    required this.isActive,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.adhaarCardNo,
    required this.qrCode,
    required this.idCardExpiryDate,
    required this.assignLabourProjects,
  });

  factory Labour.fromJson(Map<String, dynamic> json) => Labour(
        id: json["id"],
        inducteeId: json["inductee_id"],
        labourName: json["labour_name"],
        gender: json["gender"],
        literacy: json["literacy"],
        maritalStatus: json["marital_status"],
        bloodGroup: json["blood_group"],
        birthDate: DateTime.parse(json["birth_date"]),
        age: json["age"],
        contactNumber: json["contact_number"],
        userPhoto: json["user_photo"],
        currentStreetName: json["current_street_name"],
        currentCity: json["current_city"],
        currentTaluka: json["current_taluka"],
        currentDistrict: json["current_district"],
        currentState: json["current_state"],
        currentPincode: json["current_pincode"],
        permanentStreetName: json["permanent_street_name"],
        permanentCity: json["permanent_city"],
        permanentTaluka: json["permanent_taluka"],
        permanentDistrict: json["permanent_district"],
        permanentState: json["permanent_state"],
        permanentPincode: json["permanent_pincode"],
        experienceInYears: json["experience_in_years"],
        uanNumber: json["uan_number"],
        bocwNumber: json["bocw_number"],
        bankName: json["bank_name"],
        ifscNumber: json["ifsc_number"],
        accountNumber: json["account_number"],
        branchAddress: json["branch_address"],
        groupInsuranceLimit: json["group_insurance_limit"],
        insuranceNumber: json["insurance_number"],
        insuranceType: json["insurance_type"],
        insuranceValidity: DateTime.parse(json["insurance_validity"]),
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactNumber: json["emergency_contact_number"],
        emergencyContactRelation: json["emergency_contact_relation"],
        isActive: json["is_active"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        adhaarCardNo: json["adhaar_card_no"],
        qrCode: json["qr_code"],
        idCardExpiryDate: json["id_card_expiry_date"],
        assignLabourProjects: List<AssignLabourProject>.from(
            json["assign_labour_projects"].map((x) =>
                AssignLabourProject.fromJson(
                    x, x["trade_name"], x["contractor_name"]))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inductee_id": inducteeId,
        "labour_name": labourName,
        "gender": gender,
        "literacy": literacy,
        "marital_status": maritalStatus,
        "blood_group": bloodGroup,
        "birth_date":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "age": age,
        "contact_number": contactNumber,
        "user_photo": userPhoto,
        "current_street_name": currentStreetName,
        "current_city": currentCity,
        "current_taluka": currentTaluka,
        "current_district": currentDistrict,
        "current_state": currentState,
        "current_pincode": currentPincode,
        "permanent_street_name": permanentStreetName,
        "permanent_city": permanentCity,
        "permanent_taluka": permanentTaluka,
        "permanent_district": permanentDistrict,
        "permanent_state": permanentState,
        "permanent_pincode": permanentPincode,
        "experience_in_years": experienceInYears,
        "uan_number": uanNumber,
        "bocw_number": bocwNumber,
        "bank_name": bankName,
        "ifsc_number": ifscNumber,
        "account_number": accountNumber,
        "branch_address": branchAddress,
        "group_insurance_limit": groupInsuranceLimit,
        "insurance_number": insuranceNumber,
        "insurance_type": insuranceType,
        "insurance_validity":
            "${insuranceValidity.year.toString().padLeft(4, '0')}-${insuranceValidity.month.toString().padLeft(2, '0')}-${insuranceValidity.day.toString().padLeft(2, '0')}",
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_number": emergencyContactNumber,
        "emergency_contact_relation": emergencyContactRelation,
        "is_active": isActive,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "adhaar_card_no": adhaarCardNo,
        "qr_code": qrCode,
        "id_card_expiry_date": idCardExpiryDate,
        "assign_labour_projects":
            List<dynamic>.from(assignLabourProjects.map((x) => x.toJson())),
      };
}

class AssignLabourProject {
  int id;
  int labourId;
  int projectId;
  int tradeId;
  String tradeName; // New field to store trade name
  String contractorName; // Store contractor name

  String isActive;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String skillType;
  int contractorId;

  AssignLabourProject({
    required this.id,
    required this.labourId,
    required this.projectId,
    required this.tradeId,
    required this.tradeName, // Include tradeName
    required this.contractorName,
    required this.isActive,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.skillType,
    required this.contractorId,
  });

  factory AssignLabourProject.fromJson(
          Map<String, dynamic> json, String tradeName, String contractorName) =>
      AssignLabourProject(
        id: json["id"],
        labourId: json["labour_id"],
        projectId: json["project_id"],
        tradeId: json["trade_id"],
        tradeName: tradeName, // Set trade name
        contractorName: contractorName,
        isActive: json["is_active"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        skillType: json["skill_type"],
        contractorId: json["contractor_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "labour_id": labourId,
        "project_id": projectId,
        "trade_id": tradeId,
        "trade_name": tradeName, // Include in JSON
        'contractor_name': contractorName,
        "is_active": isActive,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "skill_type": skillType,
        "contractor_id": contractorId,
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
    required this.deletedAt,
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
