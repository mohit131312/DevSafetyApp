import 'package:flutter/material.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_model.dart';
import 'package:get/get.dart';

class IncidentMoreDetailsController extends GetxController {
  IncidentReportController incidentReportController = Get.find();

  TextEditingController rootcauseController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  FocusNode rootcauseFocusNode = FocusNode();
  GlobalKey preventivekey = GlobalKey();
  var selectedMoreIncidentIds = <int>[].obs;
  var isCheckedMeasures = false.obs;

  void toggleIncidentSelection(int id) {
    if (selectedMoreIncidentIds.contains(id)) {
      selectedMoreIncidentIds.remove(id);
    } else {
      selectedMoreIncidentIds.add(id);
    }
    if (selectedMoreIncidentIds.isNotEmpty) {
      preventionError.value = "";
    }
    print(
        "Selected selectedMoreIncidentIds IDs: ${selectedMoreIncidentIds.toList()}");
    updateSelectAllState();
  }

  void toggleSelectAllMeasures() {
    final filteredList = filteredIncidentMeasures.map((e) => e.id).toList();

    if (isCheckedMeasures.value) {
      selectedMoreIncidentIds.removeWhere((id) => filteredList.contains(id));
    } else {
      selectedMoreIncidentIds.addAll(filteredList);
    }
    if (selectedMoreIncidentIds.isNotEmpty) {
      preventionError.value = "";
    }
    print(
        "Selected selectedMoreIncidentIds IDs: ${selectedMoreIncidentIds.toList()}");
    updateSelectAllState();
  }

  void updateSelectAllState() {
    final filteredList = filteredIncidentMeasures.map((e) => e.id).toList();
    isCheckedMeasures.value =
        filteredList.every((id) => selectedMoreIncidentIds.contains(id));
    print(
        "Selected selectedMoreIncidentIds IDs: ${selectedMoreIncidentIds.toList()}");
  }

  var searchQuery = ''.obs;

  void updatePreventiveSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<PreventionMeasure> get filteredIncidentMeasures {
    final query = searchQuery.value.toLowerCase();
    return incidentReportController.preventionMeasuresList
        .where((measure) =>
            measure.incidentDetails.contains(query) ||
            measure.id.toString().contains(query))
        .toList();
  }

  var selectedIncidentMeasuresList = <Map<String, dynamic>>[].obs;
  void updateSelectedIncidentMeasuresList(int userId) {
    selectedIncidentMeasuresList.value = selectedMoreIncidentIds
        .map((id) =>
            {"prevention_measures_id": id.toString(), "user_id": userId})
        .toList();
    print("Selected Incident Measures List: $selectedIncidentMeasuresList");
  }

  var preventionError = ''.obs;

  //---------------------------------------------------

  void resetData() {
    rootcauseController.clear();
    searchController.clear();
    rootcauseFocusNode.unfocus();

    selectedMoreIncidentIds.clear();
    isCheckedMeasures.value = false;
    searchQuery.value = '';
    selectedIncidentMeasuresList.clear();
    preventionError.value = '';

    print('IncidentMoreDetailsController data has been reset.');
  }
}
