import 'package:flutter/material.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectAssigneController extends GetxController {
  //-----------------------------------------------------------------------
  final IncidentReportController incidentReportController = Get.find();

  final TextEditingController assigneeDataController = TextEditingController();
  var selectedassigneeDataIds = <int>[].obs;
  var selectedassigneeDataIdsFinal = <int>[].obs;

  var searchassigneeDataQuery = ''.obs;

  void updateSearchassigneeDataQuery(String query) {
    searchassigneeDataQuery.value = query;
  }

  List<InformedAsgineeUserList> get filteredassigneeData {
    final query = searchassigneeDataQuery.value.toLowerCase();
    return incidentReportController.assigneeIncidentList
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
    return incidentReportController.assigneeIncidentList
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
