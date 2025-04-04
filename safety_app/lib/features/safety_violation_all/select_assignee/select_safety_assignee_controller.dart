import 'package:flutter/material.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectSafetyAssigneeController extends GetxController {
  var selectedAssignee = <String, bool>{}.obs;
  var addedAssignee = <String, bool>{}.obs; // Store confirmed selections
  var searchInformedAssignee = ''.obs;

  final Map<String, List<Map<String, String>>> selectlistAssignee = {
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
  void toggleAssigneeSelection(String contactName) {
    selectedAssignee[contactName] = !(selectedAssignee[contactName] ?? false);
  }

  /// Confirm selections by adding them to `addedContacts`
  void confirmSelectionAssignee() {
    addedAssignee.clear();
    addedAssignee.addAll(selectedAssignee);
  }

  /// Remove a contact from added list
  void removeAddedAssignee(String contactName) {
    addedAssignee.remove(contactName);
    selectedAssignee[contactName] = false;
  }

  /// Filter contacts based on search query
  List<Map<String, String>> getFilteredAssignee() {
    if (searchInformedAssignee.value.isEmpty) {
      return selectlistAssignee.values.expand((list) => list).toList();
    }
    return selectlistAssignee.values.expand((list) => list).where((contact) {
      return contact['name']!
          .toLowerCase()
          .contains(searchInformedAssignee.value.toLowerCase());
    }).toList();
  }

  /// Group contacts by their first letter
  Map<String, List<Map<String, String>>> getGroupedAssignee() {
    Map<String, List<Map<String, String>>> groupedContacts = {};

    for (var entry in selectlistAssignee.entries) {
      String letter = entry.key;
      List<Map<String, String>> contactList = entry.value;

      List<Map<String, String>> filteredContacts = contactList.where((contact) {
        return contact['name']!
            .toLowerCase()
            .contains(searchInformedAssignee.value.toLowerCase());
      }).toList();

      if (filteredContacts.isNotEmpty) {
        groupedContacts[letter] = filteredContacts;
      }
    }

    return groupedContacts;
  }

  //-----------------------------------------------------------------------
  final SafetyViolationDetailsController safetyViolationDetailsController =
      Get.find();

  final TextEditingController assigneeDataController = TextEditingController();
  var selectedassigneeDataIds = <int>[].obs;
  var selectedassigneeDataIdsFinal = <int>[].obs;

  var searchassigneeDataQuery = ''.obs;

  void updateSearchassigneeDataQuery(String query) {
    searchassigneeDataQuery.value = query;
  }

  List<InformedAsgineeUserList> get filteredassigneeData {
    final query = searchassigneeDataQuery.value.toLowerCase();
    return safetyViolationDetailsController.assigneeList
        .where((assignee) =>
            assignee.firstName.toLowerCase().contains(query) ||
            assignee.id.toString().contains(query))
        .toList();
  }

  void removeassigneeData(int index) {
    if (index >= 0 && index < selectedassigneeDataIdsFinal.length) {
      int idToRemove = selectedassigneeDataIdsFinal[index];

      selectedassigneeDataIdsFinal.removeAt(index);
      selectedassigneeDataIds.remove(idToRemove);

      print("Removed assigneeData ID: $idToRemove");
      print("Updated assigneeData: ${selectedassigneeDataIdsFinal.toList()}");
      print("Updated assigneeData IDS: ${selectedassigneeDataIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<InformedAsgineeUserList> get addInvolveassigneeDataPerson {
    return safetyViolationDetailsController.assigneeList
        .where((assignee) => selectedassigneeDataIdsFinal.contains(assignee.id))
        .toList();
  }

  void toggleSingleAssigneeSelection(int id) {
    selectedassigneeDataIds.clear();
    selectedassigneeDataIds.add(id);
    print(
        "Selected selectedassigneeDataIds ID: ${selectedassigneeDataIds.toList()}");
  }

  void addassigneeData() {
    selectedassigneeDataIdsFinal.clear();
    selectedassigneeDataIdsFinal.addAll(selectedassigneeDataIds);
    print(
        "Selected selectedassigneeDataIdsFinal IDs: ${selectedassigneeDataIdsFinal.toList()}");
  }

  ///------------------------------
  ///
  Future<void> makeCall(String phoneNumber) async {
    // Ensure the phone number is valid for the 'tel' scheme
    final Uri callUri = Uri.parse('tel:$phoneNumber');
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(callUri.toString())) {
        // ignore: deprecated_member_use
        await launch(callUri.toString());
      } else {
        Get.snackbar(
          'Error',
          'Unable to launch dialer. Please check your number or phone settings.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while trying to make a call.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
