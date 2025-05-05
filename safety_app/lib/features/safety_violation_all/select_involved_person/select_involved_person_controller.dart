import 'package:flutter/material.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_model.dart';
import 'package:get/get.dart';

class SelectInvolvedPersonController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedPersons = <String, bool>{}.obs;
  var addedPersons = <String, bool>{}.obs; // Store confirmed selections
  var searchPersonsQuery = ''.obs;

  final Map<String, List<Map<String, String>>> selectInvoledPersons = {
    'A': [
      {
        'name': 'John Doe',
        'designation': 'Manager',
        'img': 'assets/icons/phone_orange.png'
      },
      {
        'name': 'Alice Brown',
        'designation': 'Designer',
        'img': 'assets/icons/phone_orange.png'
      },
    ],
    'B': [
      {
        'name': 'Brian Adams',
        'designation': 'HR',
        'img': 'assets/icons/phone_orange.png'
      },
      {
        'name': 'Bob Marley',
        'designation': 'Musician',
        'img': 'assets/icons/phone_orange.png'
      },
    ],
  };

  /// Toggle contact selection
  void togglePersonsSelection(String contactName) {
    selectedPersons[contactName] = !(selectedPersons[contactName] ?? false);
  }

  /// Confirm selections by adding them to `addedContacts`
  void confirmSelectionPersons() {
    addedPersons.clear();
    addedPersons.addAll(selectedPersons);
  }

  /// Remove a contact from added list
  void removeAddedPersons(String contactName) {
    addedPersons.remove(contactName);
    selectedPersons[contactName] = false;
  }

  /// Filter contacts based on search query
  List<Map<String, String>> getFilteredPersons() {
    if (searchPersonsQuery.value.isEmpty) {
      return selectInvoledPersons.values.expand((list) => list).toList();
    }
    return selectInvoledPersons.values.expand((list) => list).where((contact) {
      return contact['name']!
          .toLowerCase()
          .contains(searchPersonsQuery.value.toLowerCase());
    }).toList();
  }

  /// Group contacts by their first letter
  Map<String, List<Map<String, String>>> getGroupedPersons() {
    Map<String, List<Map<String, String>>> groupedContacts = {};

    for (var entry in selectInvoledPersons.entries) {
      String letter = entry.key;
      List<Map<String, String>> contactList = entry.value;

      List<Map<String, String>> filteredContacts = contactList.where((contact) {
        return contact['name']!
            .toLowerCase()
            .contains(searchPersonsQuery.value.toLowerCase());
      }).toList();

      if (filteredContacts.isNotEmpty) {
        groupedContacts[letter] = filteredContacts;
      }
    }

    return groupedContacts;
  }

  //------------------------------------------------------------------------------------------------------
  var selectedOption = 0.obs;
  final SafetyViolationDetailsController safetyViolationDetailsController =
      Get.find();
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

  var selectedLabourIds = <int>[].obs;
  var selectedLabourIdsFinal = <Map<String, dynamic>>[].obs;

  void toggleSelection(int id) {
    if (selectedLabourIds.contains(id)) {
      selectedLabourIds.remove(id);
    } else {
      selectedLabourIds.add(id);
    }
    print("Selected Labour IDs: ${selectedLabourIds.toList()}");
  }

  var searchQuery = ''.obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<InvolvedList> get filteredLabours {
    final query = searchQuery.value.toLowerCase();
    return safetyViolationDetailsController.involvedSafetyLaboursList
        .where((labour) =>
            labour.labourName!.toLowerCase().contains(query) ||
            labour.id.toString().contains(query))
        .toList();
  }

  void addData() {
    selectedLabourIdsFinal.clear();
    selectedLabourIdsFinal
        .addAll(selectedLabourIds.map((id) => {"user_type": "1", "id": id}));

    print("SelectedLabour Data for API: ${selectedLabourIdsFinal.toList()}");
  }

  void removeData(int index) {
    if (index >= 0 && index < selectedLabourIdsFinal.length) {
      Map<String, dynamic> itemToRemove = selectedLabourIdsFinal[index];
      int idToRemove = itemToRemove["id"];

      selectedLabourIdsFinal.removeAt(index);
      selectedLabourIds.remove(idToRemove);

      print("Removed Labour ID: $idToRemove");
      print(
          "Updated selectedLabourIdsFinal: ${selectedLabourIdsFinal.toList()}");
      print("Updated selectedLabourIds: ${selectedLabourIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<InvolvedList> get addInvolvePerson {
    return safetyViolationDetailsController.involvedSafetyLaboursList
        .where((labour) =>
            selectedLabourIdsFinal.any((item) => item["id"] == labour.id))
        .toList();
  }

  ///------------------------------------------------------------------
  ///

  var selectedStaffIds = <int>[].obs;

  var selectedStaffIdsFinal = <Map<String, dynamic>>[].obs;

  void toggleStaffSelection(int id) {
    if (selectedStaffIds.contains(id)) {
      selectedStaffIds.remove(id);
    } else {
      selectedStaffIds.add(id);
    }
    print("Selected selectedStaffIds IDs: ${selectedStaffIds.toList()}");
  }

  var searchStaffQuery = ''.obs;

  void updateSearchStaffQuery(String query) {
    searchStaffQuery.value = query;
  }

  List<InvolvedStaffList> get filteredStaff {
    final query = searchStaffQuery.value.toLowerCase();
    return safetyViolationDetailsController.involvedSafetyStaffList
        .where((staff) =>
            staff.staffName.toLowerCase().contains(query) ||
            staff.id.toString().contains(query))
        .toList();
  }

  void addStaffData() {
    selectedStaffIdsFinal.clear(); // Clear previous selections
    selectedStaffIdsFinal
        .addAll(selectedStaffIds.map((id) => {"user_type": "3", "id": id}));

    print("Selected Staff Data for API: ${selectedStaffIdsFinal.toList()}");
  }

  void removeStaffData(int index) {
    if (index >= 0 && index < selectedStaffIdsFinal.length) {
      Map<String, dynamic> itemToRemove = selectedStaffIdsFinal[index];

      int idToRemove = itemToRemove["id"];

      selectedStaffIdsFinal.removeAt(index);
      selectedStaffIds.remove(idToRemove);

      print("Removed Staff ID: $idToRemove");
      print("Updated selectedStaffIdsFinal: ${selectedStaffIdsFinal.toList()}");
      print("Updated selectedStaffIds: ${selectedStaffIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<InvolvedStaffList> get addInvolveStaffPerson {
    return safetyViolationDetailsController.involvedSafetyStaffList
        .where((staff) =>
            selectedStaffIdsFinal.any((item) => item["id"] == staff.id))
        .toList();
  }
  //-------------------------------------------------------------

  var selectedContractorIds = <int>[].obs;
  var selectedContractorIdsFinal = <Map<String, dynamic>>[].obs;

  void toggleContractorSelection(int id) {
    if (selectedContractorIds.contains(id)) {
      selectedContractorIds.remove(id);
    } else {
      selectedContractorIds.add(id);
    }
    print(
        "Selected selectedContractorIds IDs: ${selectedContractorIds.toList()}");
  }

  var searchContractorQuery = ''.obs;

  void updateSearchContractorQuery(String query) {
    searchContractorQuery.value = query;
  }

  List<InvolvedContractorUserList> get filteredContractor {
    final query = searchContractorQuery.value.toLowerCase();
    return safetyViolationDetailsController.involvedSafetycontactor
        .where((contractor) =>
            contractor.contractorName.toLowerCase().contains(query) ||
            contractor.id.toString().contains(query))
        .toList();
  }

  void addContractorData() {
    selectedContractorIdsFinal.clear();
    selectedContractorIdsFinal.addAll(
        selectedContractorIds.map((id) => {"user_type": "2", "id": id}));

    print(
        "Selected selectedContractorIdsFinal Data for API: ${selectedContractorIdsFinal.toList()}");
  }

  void removeContractorData(int index) {
    if (index >= 0 && index < selectedContractorIdsFinal.length) {
      Map<String, dynamic> itemToRemove = selectedContractorIdsFinal[index];
      int idToRemove = itemToRemove["id"];

      selectedContractorIdsFinal.removeAt(index);
      selectedContractorIds.remove(idToRemove);

      print("Removed Contractor ID: $idToRemove");
      print("Updated Contractor: ${selectedContractorIdsFinal.toList()}");
      print("Updated Contractor IDS: ${selectedContractorIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<InvolvedContractorUserList> get addInvolveContractorPerson {
    return safetyViolationDetailsController.involvedSafetycontactor
        .where((contractor) => selectedContractorIdsFinal
            .any((item) => item["id"] == contractor.id))
        .toList();
  }

  ///-----------------------------------------
  ///
  var combinedSelectedIdsFinal = <Map<String, String>>[].obs;
  void updateCombinedList() {
    combinedSelectedIdsFinal.clear(); // Clear existing data

    // Convert and add Labour IDs
    combinedSelectedIdsFinal.addAll(selectedLabourIdsFinal.map((e) => {
          "user_type": "1", // Assuming Labour user type is 1
          "user_id": e["id"].toString()
        }));

    // Convert and add Staff IDs
    combinedSelectedIdsFinal.addAll(selectedStaffIdsFinal.map((e) => {
          "user_type": "3", // Assuming Staff user type is 2
          "user_id": e["id"].toString()
        }));

    // Convert and add Contractor IDs
    combinedSelectedIdsFinal.addAll(selectedContractorIdsFinal.map((e) => {
          "user_type": "2", // Assuming Contractor user type is 3
          "user_id": e["id"].toString()
        }));

    print("✅ Updated Combined List: ${combinedSelectedIdsFinal.toList()}");
  }
}
