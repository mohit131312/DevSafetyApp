import 'package:flutter/material.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_model.dart';
import 'package:get/get.dart';

class AssignCheckerController extends GetxController {
  //-----------------------------------------------------------------------
  final WorkPermitController workPermitController = Get.find();
  final TextEditingController assigneeDataController = TextEditingController();
  var selectedassigneeDataIds = <int>[].obs;
  var selectedassigneeDataIdsFinal = <int>[].obs;

  var searchassigneeDataQuery = ''.obs;

  void updateSearchassigneeDataQuery(String query) {
    searchassigneeDataQuery.value = query;
  }

  List<CheckerUserList> get filteredassigneeData {
    final query = searchassigneeDataQuery.value.toLowerCase();
    return workPermitController.checkuserList
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

  List<CheckerUserList> get addInvolveassigneeDataPerson {
    return workPermitController.checkuserList
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
    selectedassigneeDataIdsFinal.refresh(); // 🔄 Ensure UI updates
    print("in add method: ${selectedassigneeDataIdsFinal.toList()}");
    print(
        "Selected selectedassigneeDataIdsFinal IDs: ${selectedassigneeDataIdsFinal.toList()}");
  }

  var assigneeError = ''.obs;
  bool validateAssignee() {
    if (addInvolveassigneeDataPerson.isEmpty) {
      assigneeError.value = "Please add an assignee";
      return false; // Validation failed
    } else {
      assigneeError.value = "";
      return true; // Validation passed
    }
  }

  void clearAssigneeData() {
    selectedassigneeDataIds.clear();
    selectedassigneeDataIdsFinal.clear();
    assigneeError.value = ''; // Optionally, clear the error message

    print("Assignee data cleared");
  }

  ///------------------------------
}
