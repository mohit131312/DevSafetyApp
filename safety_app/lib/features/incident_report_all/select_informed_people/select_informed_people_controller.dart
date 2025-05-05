import 'package:flutter/material.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_model.dart';
import 'package:get/get.dart';

class SelectInformedIncidentController extends GetxController {
  //-----------------------------------------------------------
  final IncidentReportController incidentReportController = Get.find();

  final TextEditingController informedController = TextEditingController();
  var selectedAssIncidentIds = <int>[].obs;
  var selectedAssIncidentIdsFinal = <int>[].obs;

  void toggleIncidentSelection(int id) {
    if (selectedAssIncidentIds.contains(id)) {
      selectedAssIncidentIds.remove(id);
    } else {
      selectedAssIncidentIds.add(id);
    }
    print(
        "Selected selectedAssIncidentIds IDs: ${selectedAssIncidentIds.toList()}");
  }

  var searchAssigneeQuery = ''.obs;

  void updateIncidentSearchAssigneeQuery(String query) {
    searchAssigneeQuery.value = query;
  }

  List<InformedAsgineeUserList> get filteredIncidentAssignee {
    final query = searchAssigneeQuery.value.toLowerCase();
    return incidentReportController.assigneeIncidentList
        .where((assignee) =>
            assignee.firstName!.toLowerCase().contains(query) ||
            assignee.id.toString().contains(query))
        .toList();
  }

  void addIncidentData() {
    selectedAssIncidentIdsFinal.clear();
    selectedAssIncidentIdsFinal.addAll(selectedAssIncidentIds);
    print(
        "Selected selectedAssIncidentIdsFinal IDs: ${selectedAssIncidentIdsFinal.toList()}");
  }

  void removeIncidentAssigneeData(int index) {
    if (index >= 0 && index < selectedAssIncidentIdsFinal.length) {
      int idToRemove = selectedAssIncidentIdsFinal[index];

      selectedAssIncidentIdsFinal.removeAt(index);
      selectedAssIncidentIds.remove(idToRemove);

      print("Removed Assignee ID: $idToRemove");
      print("Updated Assignee: ${selectedAssIncidentIdsFinal.toList()}");
      print("Updated Assignee IDS: ${selectedAssIncidentIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<InformedAsgineeUserList> get addInvolveIncidentPerson {
    return incidentReportController.assigneeIncidentList
        .where((assignee) => selectedAssIncidentIdsFinal.contains(assignee.id))
        .toList();
  }

  var selectedAssIncidentIdsFinalMap = <Map<String, String>>[].obs;

  void convertIncidentInvolveIdsToMap() {
    selectedAssIncidentIdsFinalMap.clear();
    selectedAssIncidentIdsFinalMap.addAll(
      selectedAssIncidentIdsFinal.map((id) => {"user_id": id.toString()}),
    );

    print(
        "✅ Converted List of Maps: ${selectedAssIncidentIdsFinalMap.toList()}");
  }
}
