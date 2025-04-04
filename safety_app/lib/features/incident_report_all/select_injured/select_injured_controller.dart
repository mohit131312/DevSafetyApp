import 'package:flutter/material.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_model.dart';
import 'package:get/get.dart';

class SelectInjuredController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //------------------------------------------------------------------------------------------------------
  var selectedOption = 0.obs;
  final IncidentReportController incidentReportController = Get.find();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController searchStaffController = TextEditingController();
  final TextEditingController searchContractorController =
      TextEditingController();

  late TabController tabController;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      selectedOption.value = tabController.index;
      print("Selected Tab Index: ${selectedOption.value}");
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  var selectedIncidentLabourIds = <int>[].obs;
  var selectedIncidentLabourIdsFinal = <Map<String, dynamic>>[].obs;

  void toggleIncidentSelection(int id) {
    if (selectedIncidentLabourIds.contains(id)) {
      selectedIncidentLabourIds.remove(id);
    } else {
      selectedIncidentLabourIds.add(id);
    }
    print(
        "Selected IncidentLabourIds IDs: ${selectedIncidentLabourIds.toList()}");
  }

  var searchQuery = ''.obs;

  void updateIncidentSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<InvolvedList> get filteredIncidentLabours {
    final query = searchQuery.value.toLowerCase();
    return incidentReportController.involvedIncidentLaboursList
        .where((labour) =>
            labour.labourName.toLowerCase().contains(query) ||
            labour.id.toString().contains(query))
        .toList();
  }

  void addIncidentData() {
    selectedIncidentLabourIdsFinal.clear();
    selectedIncidentLabourIdsFinal.addAll(
        selectedIncidentLabourIds.map((id) => {"user_type": "1", "id": id}));

    print(
        "SelectedLabour Data for API: ${selectedIncidentLabourIdsFinal.toList()}");
  }

  void removeIncidentData(int index) {
    if (index >= 0 && index < selectedIncidentLabourIdsFinal.length) {
      Map<String, dynamic> itemToRemove = selectedIncidentLabourIdsFinal[index];
      int idToRemove = itemToRemove["id"];

      selectedIncidentLabourIdsFinal.removeAt(index);
      selectedIncidentLabourIds.remove(idToRemove);

      print("Removed Labour ID: $idToRemove");
      print(
          "Updated selectedIncidentLabourIdsFinal: ${selectedIncidentLabourIdsFinal.toList()}");
      print(
          "Updated selectedIncidentLabourIds: ${selectedIncidentLabourIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<InvolvedList> get addIncidentInvolvePerson {
    return incidentReportController.involvedIncidentLaboursList
        .where((labour) => selectedIncidentLabourIdsFinal
            .any((item) => item["id"] == labour.id))
        .toList();
  }

  ///------------------------------------------------------------------
  ///

  var selectedIncidentStaffIds = <int>[].obs;

  var selectedIncidentStaffIdsFinal = <Map<String, dynamic>>[].obs;

  void toggleIncidentStaffSelection(int id) {
    if (selectedIncidentStaffIds.contains(id)) {
      selectedIncidentStaffIds.remove(id);
    } else {
      selectedIncidentStaffIds.add(id);
    }
    print(
        "Selected selectedIncidentStaffIds IDs: ${selectedIncidentStaffIds.toList()}");
  }

  var searchStaffQuery = ''.obs;

  void updateSearchIncidentStaffQuery(String query) {
    searchStaffQuery.value = query;
  }

  List<InvolvedStaffList> get filteredIncidentStaff {
    final query = searchStaffQuery.value.toLowerCase();
    return incidentReportController.involvedIncidentStaffList
        .where((staff) =>
            staff.staffName!.toLowerCase().contains(query) ||
            staff.id.toString().contains(query))
        .toList();
  }

  void addIncidentStaffData() {
    selectedIncidentStaffIdsFinal.clear(); // Clear previous selections
    selectedIncidentStaffIdsFinal.addAll(
        selectedIncidentStaffIds.map((id) => {"user_type": "3", "id": id}));

    print(
        "Selected Staff Data for API: ${selectedIncidentStaffIdsFinal.toList()}");
  }

  void removeIncidentStaffData(int index) {
    if (index >= 0 && index < selectedIncidentStaffIdsFinal.length) {
      Map<String, dynamic> itemToRemove = selectedIncidentStaffIdsFinal[index];

      int idToRemove = itemToRemove["id"];

      selectedIncidentStaffIdsFinal.removeAt(index);
      selectedIncidentStaffIds.remove(idToRemove);

      print("Removed Staff ID: $idToRemove");
      print(
          "Updated selectedIncidentStaffIdsFinal: ${selectedIncidentStaffIdsFinal.toList()}");
      print(
          "Updated selectedIncidentStaffIds: ${selectedIncidentStaffIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<InvolvedStaffList> get addInvolveIncidentStaffPerson {
    return incidentReportController.involvedIncidentStaffList
        .where((staff) =>
            selectedIncidentStaffIdsFinal.any((item) => item["id"] == staff.id))
        .toList();
  }
  //-------------------------------------------------------------

  var selectedIncidentContractorIds = <int>[].obs;
  var selectedIncidentContractorIdsFinal = <Map<String, dynamic>>[].obs;

  void toggleIncidentContractorSelection(int id) {
    if (selectedIncidentContractorIds.contains(id)) {
      selectedIncidentContractorIds.remove(id);
    } else {
      selectedIncidentContractorIds.add(id);
    }
    print(
        "Selected selectedIncidentContractorIds IDs: ${selectedIncidentContractorIds.toList()}");
  }

  var searchContractorQuery = ''.obs;

  void updateSearchIncidentContractorQuery(String query) {
    searchContractorQuery.value = query;
  }

  List<InvolvedContractorUserList> get filteredIncidentContractor {
    final query = searchContractorQuery.value.toLowerCase();
    return incidentReportController.involvedIncidentContractorList
        .where((contractor) =>
            contractor.contractorName.toLowerCase().contains(query) ||
            contractor.id.toString().contains(query))
        .toList();
  }

  void addIncidentContractorData() {
    selectedIncidentContractorIdsFinal.clear();
    selectedIncidentContractorIdsFinal.addAll(selectedIncidentContractorIds
        .map((id) => {"user_type": "2", "id": id}));

    print(
        "Selected selectedIncidentContractorIdsFinal Data for API: ${selectedIncidentContractorIdsFinal.toList()}");
  }

  void removeIncidentContractorData(int index) {
    if (index >= 0 && index < selectedIncidentContractorIdsFinal.length) {
      Map<String, dynamic> itemToRemove =
          selectedIncidentContractorIdsFinal[index];
      int idToRemove = itemToRemove["id"];

      selectedIncidentContractorIdsFinal.removeAt(index);
      selectedIncidentContractorIds.remove(idToRemove);

      print("Removed Contractor ID: $idToRemove");
      print(
          "Updated Contractor: ${selectedIncidentContractorIdsFinal.toList()}");
      print(
          "Updated Contractor IDS: ${selectedIncidentContractorIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<InvolvedContractorUserList> get addInvolveIncidentContractorPerson {
    return incidentReportController.involvedIncidentContractorList
        .where((contractor) => selectedIncidentContractorIdsFinal
            .any((item) => item["id"] == contractor.id))
        .toList();
  }

  ///-----------------------------------------
  ///
  var combinedIncidentIdsFinal = <Map<String, String>>[].obs;
  void updateCombinedList() {
    combinedIncidentIdsFinal.clear(); // Clear existing data

    // Convert and add Labour IDs
    combinedIncidentIdsFinal.addAll(selectedIncidentLabourIdsFinal.map((e) => {
          "user_type": "1", // Assuming Labour user type is 1
          "user_id": e["id"].toString()
        }));

    // Convert and add Staff IDs
    combinedIncidentIdsFinal.addAll(selectedIncidentStaffIdsFinal.map((e) => {
          "user_type": "2", // Assuming Staff user type is 2
          "user_id": e["id"].toString()
        }));

    // Convert and add Contractor IDs
    combinedIncidentIdsFinal
        .addAll(selectedIncidentContractorIdsFinal.map((e) => {
              "user_type": "3", // Assuming Contractor user type is 3
              "user_id": e["id"].toString()
            }));

    print(" Updated Combined List: ${combinedIncidentIdsFinal.toList()}");
  }
}
