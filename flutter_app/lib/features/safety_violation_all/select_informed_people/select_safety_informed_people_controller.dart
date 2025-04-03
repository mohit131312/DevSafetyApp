import 'package:flutter/material.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_model.dart';
import 'package:get/get.dart';

class SelectSafetyInformedPeopleController extends GetxController {
  var selectedInformedPeople = <String, bool>{}.obs;
  var addedInformedPeople = <String, bool>{}.obs; // Store confirmed selections
  var searchInformedPeopleQuery = ''.obs;

  final Map<String, List<Map<String, String>>> selectinformedPeople = {
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
  void toggleInformedPeopleSelection(String contactName) {
    selectedInformedPeople[contactName] =
        !(selectedInformedPeople[contactName] ?? false);
  }

  /// Confirm selections by adding them to `addedContacts`
  void confirmSelectionInformedPeople() {
    addedInformedPeople.clear();
    addedInformedPeople.addAll(selectedInformedPeople);
  }

  /// Remove a contact from added list
  void removeAddedInformedPeople(String contactName) {
    addedInformedPeople.remove(contactName);
    selectedInformedPeople[contactName] = false;
  }

  /// Filter contacts based on search query
  List<Map<String, String>> getFilteredInformedPeople() {
    if (searchInformedPeopleQuery.value.isEmpty) {
      return selectinformedPeople.values.expand((list) => list).toList();
    }
    return selectinformedPeople.values.expand((list) => list).where((contact) {
      return contact['name']!
          .toLowerCase()
          .contains(searchInformedPeopleQuery.value.toLowerCase());
    }).toList();
  }

  /// Group contacts by their first letter
  Map<String, List<Map<String, String>>> getGroupedInformedPeople() {
    Map<String, List<Map<String, String>>> groupedContacts = {};

    for (var entry in selectinformedPeople.entries) {
      String letter = entry.key;
      List<Map<String, String>> contactList = entry.value;

      List<Map<String, String>> filteredContacts = contactList.where((contact) {
        return contact['name']!
            .toLowerCase()
            .contains(searchInformedPeopleQuery.value.toLowerCase());
      }).toList();

      if (filteredContacts.isNotEmpty) {
        groupedContacts[letter] = filteredContacts;
      }
    }

    return groupedContacts;
  }

  //-----------------------------------------------------------
  final SafetyViolationDetailsController safetyViolationDetailsController =
      Get.find();

  final TextEditingController informedController = TextEditingController();
  var selectedAssigneeIds = <int>[].obs;
  var selectedAssigneeIdsFinal = <int>[].obs;

  void toggleAssigneeSelection(int id) {
    if (selectedAssigneeIds.contains(id)) {
      selectedAssigneeIds.remove(id);
    } else {
      selectedAssigneeIds.add(id);
    }
    print("Selected selectedAssigneeIds IDs: ${selectedAssigneeIds.toList()}");
  }

  var searchAssigneeQuery = ''.obs;

  void updateSearchAssigneeQuery(String query) {
    searchAssigneeQuery.value = query;
  }

  List<InformedAsgineeUserList> get filteredAssignee {
    final query = searchAssigneeQuery.value.toLowerCase();
    return safetyViolationDetailsController.assigneeList
        .where((assignee) =>
            assignee.firstName.toLowerCase().contains(query) ||
            assignee.id.toString().contains(query))
        .toList();
  }

  void addAsgineeData() {
    selectedAssigneeIdsFinal.clear();
    selectedAssigneeIdsFinal.addAll(selectedAssigneeIds);
    print(
        "Selected selectedAssigneeIdsFinal IDs: ${selectedAssigneeIdsFinal.toList()}");
  }

  void removeAssigneeInformedData(int index) {
    if (index >= 0 && index < selectedAssigneeIdsFinal.length) {
      int idToRemove = selectedAssigneeIdsFinal[index];

      selectedAssigneeIdsFinal.removeAt(index);
      selectedAssigneeIds.remove(idToRemove);

      print("Removed Assignee ID: $idToRemove");
      print("Updated Assignee: ${selectedAssigneeIdsFinal.toList()}");
      print("Updated Assignee IDS: ${selectedAssigneeIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<InformedAsgineeUserList> get addInvolveAssigneePerson {
    return safetyViolationDetailsController.assigneeList
        .where((assignee) => selectedAssigneeIdsFinal.contains(assignee.id))
        .toList();
  }

  var selectedAssigneeIdsFinalMap = <Map<String, String>>[].obs;

  void convertAssigneeIdsToMap() {
    selectedAssigneeIdsFinalMap.clear();
    selectedAssigneeIdsFinalMap.addAll(
      selectedAssigneeIdsFinal.map((id) => {"user_id": id.toString()}),
    );

    print("✅ Converted List of Maps: ${selectedAssigneeIdsFinalMap.toList()}");
  }
}
