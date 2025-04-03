import 'package:flutter/material.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectReviewerController extends GetxController {
  //-----------------------------------------------------------------------
  ToolboxTrainingController toolboxTrainingController =
      Get.put(ToolboxTrainingController());
  final TextEditingController assigneeDataController = TextEditingController();
  var selectedassigneeDataIds = <int>[].obs;
  var selectedassigneeDataIdsFinal = <int>[].obs;

  var searchassigneeDataQuery = ''.obs;

  void updateSearchassigneeDataQuery(String query) {
    searchassigneeDataQuery.value = query;
  }

  List<ReviwerUserList> get filteredassigneeData {
    final query = searchassigneeDataQuery.value.toLowerCase();
    return toolboxTrainingController.reviewerList
        .where((assignee) =>
            assignee.firstName!.toLowerCase().contains(query) ||
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

  List<ReviwerUserList> get addInvolveassigneeDataPerson {
    return toolboxTrainingController.reviewerList
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
      assigneeError.value = "Please add an Reviewer";
      return false; // Validation failed
    } else {
      assigneeError.value = "";
      return true; // Validation passed
    }
  }

  ///------------------------------
  ///
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
