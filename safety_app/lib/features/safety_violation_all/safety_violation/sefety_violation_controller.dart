import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class SefetyViolationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var searchQueryIncident = ''.obs;
  var incidentDetails = <Map<String, dynamic>>[].obs;
  var incidentfilteredDetails = <Map<String, dynamic>>[].obs;

  var selectedOption = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    incidentDetails.value = incidentDetailData;
    incidentfilteredDetails.value = incidentDetailData;
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

  final List<Map<String, dynamic>> incidentDetailData = [
    {
      'text2': "Critical",
      'title': "Safety Violation ID",
      "subtitle": "Safety detail",
      "text": "Open",
      'date': 'Creation Date',
    },
    {
      'text2': "Critical",
      'title': "Safety Violation ID",
      "subtitle": "Safety detail",
      "text": "Open",
      'date': 'Creation Date',
    },
    {
      'text2': "Critical",
      'title': "Safety Violation ID",
      "subtitle": "Safety detail",
      "text": "Open",
      'date': 'Creation Date',
    },
    {
      'text2': "Critical",
      'title': "Safety Violation ID",
      "subtitle": "Safety detail",
      "text": "Open",
      'date': 'Creation Date',
    },
    {
      'text2': "Critical",
      'title': "Safety Violation ID",
      "subtitle": "Safety detail",
      "text": "Open",
      'date': 'Creation Date',
    },
  ];

  void changeSelection(int index) {
    selectedOption.value = index;
    print("Selected option changed to: $index"); // ✅ Debugging
    applyFilters();
  }

  void searchLabor(String query) {
    searchQueryIncident.value = query;
    applyFilters();
  }

  /// **Apply both search and selection filters**
  void applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(incidentDetails);

    // **Search Filter**
    if (searchQueryIncident.value.isNotEmpty) {
      filtered = filtered
          .where((item) => item['title']!
              .toLowerCase()
              .contains(searchQueryIncident.value.toLowerCase()))
          .toList();
    }

    // **Status Filter**
    if (selectedOption.value == 1) {
      filtered = filtered.where((item) => item['text'] == "Open").toList();
    } else if (selectedOption.value == 2) {
      filtered = filtered.where((item) => item['text'] == "Closed").toList();
    } else if (selectedOption.value == 3) {
      filtered = filtered.where((item) => item['text'] == "Accepted").toList();
    }

    // **Update filtered list**
    incidentfilteredDetails.value = filtered;
  }

  //-----------------------------------------------------------------

  RxList<SafetyViolationModel> safetyViolationListingAll =
      <SafetyViolationModel>[].obs;

  Future getSafetyViolationAllListing(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_violation_debit_note_all_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      safetyViolationListingAll.value = (await responseData['data']
              as List<dynamic>)
          .map((e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------=SafetyViolationModel: ${(safetyViolationListingAll.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerySafetyAll = ''.obs;
  TextEditingController searchSafetyAllController = TextEditingController();
  TextEditingController searchSafetyAssignorController =
      TextEditingController();
  TextEditingController searchSafetyAssigneeController =
      TextEditingController();

  void updateSearchSafetyAllQuery(String query) {
    searchQuerySafetyAll.value = query;
  }

  List<SafetyViolationModel> get filteredSafetyAllList {
    final query = searchQuerySafetyAll.value.toLowerCase();
    return safetyViolationListingAll
        .where((ind) =>
            ind.details.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  // //----------------------------------------------------------------------------

  RxList<SafetyViolationModel> safetyViolationAssignor =
      <SafetyViolationModel>[].obs;

  Future getSafetyViolationAssignorListing(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_violation_debit_note_all_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      // safetyViolationAssignor.value = (await responseData['data']
      //         as List<dynamic>)
      //     .map((e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
      //     .toList();
      safetyViolationAssignor.value = (await responseData['data']
              as List<dynamic>)
          .map((e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
          .where((item) => item.status != 0) // integer comparison
          .toList();
      log('----------=safetyViolationAssignor: ${(safetyViolationAssignor.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerySafetyAssignor = ''.obs;

  void updateSearchSafetyAssignorQuery(String query) {
    searchQuerySafetyAssignor.value = query;
  }

  List<SafetyViolationModel> get filteredIncidentAssignorList {
    final query = searchQuerySafetyAssignor.value.toLowerCase();
    return safetyViolationAssignor
        .where((ind) =>
            ind.details.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  // //-----------------------------------------------------
  RxList<SafetyViolationModel> safetyViolationAssignee =
      <SafetyViolationModel>[].obs;

  Future getSafetyViolationAssigneeListing(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_violation_debit_note_all_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      safetyViolationAssignee.value = (await responseData['data']
              as List<dynamic>)
          .map((e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------=safetyViolationAssignee: ${(safetyViolationAssignee.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerySafetyAssignee = ''.obs;

  void updateSearchSafetyAssigneeQuery(String query) {
    searchQuerySafetyAssignee.value = query;
  }

  List<SafetyViolationModel> get filteredSafetyAssigneeList {
    final query = searchQuerySafetyAssignee.value.toLowerCase();
    return safetyViolationAssignee
        .where((ind) =>
            ind.details.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  void handleSearchByTab(int index, String query) {
    if (index == 0) {
      searchQuerySafetyAll.value = query;
    } else if (index == 1) {
      searchQuerySafetyAssignor.value = query;
    } else if (index == 2) {
      searchQuerySafetyAssignee.value = query;
    }
  }

  // void resetIncidentData() {
  //   // Clear all listings
  //   incidentReportListingAll.clear();
  //   incidentReportListingAssignor.clear();
  //   incidentReportListingAssignee.clear();

  //   // Reset search queries
  //   searchQueryIncidentAll.value = '';
  //   searchQueryIncidentAssignor.value = '';
  //   searchQueryIncidentAssignee.value = '';

  //   // Clear text fields
  //   searchIncidentAllController.clear();
  //   searchIncidentAssignorController.clear();
  //   searchIncidentAssigneeController.clear();

  //   log("Incident data reset completed.");
  // }
}
