import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class SefetyViolationController extends GetxController {
  TextEditingController activeController = TextEditingController();
  var searchQueryIncident = ''.obs;
  var incidentDetails = <Map<String, dynamic>>[].obs;
  var incidentfilteredDetails = <Map<String, dynamic>>[].obs;

  // **Status Filter**

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
      // safetyViolationListingAll.value = (await responseData['data']
      //         as List<dynamic>)
      //     .map((e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
      //     .toList();
      final data = responseData['data'];

      if (data is List) {
        safetyViolationListingAll.value = data
            .map(
                (e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
            .toList();

        log('----------=safetyViolationListingAll: ${safetyViolationListingAll.length}');
      } else {
        log("No valid list data received for safetyViolationListingAll.");
      }
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
      // safetyViolationAssignor.value = (await responseData['data']
      //         as List<dynamic>)
      //     .map((e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
      //     .where((item) => item.status != 0) // integer comparison
      //     .toList();

      final data = responseData['data'];

      if (data is List) {
        safetyViolationAssignor.value = data
            .map(
                (e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
            .where((item) => item.status != 0) // integer comparison
            .toList();

        log('----------=safetyViolationAssignor: ${safetyViolationAssignor.length}');
      } else {
        log("No valid list data received for safetyViolationAssignor.");
      }

      log('----------=safetyViolationAssignor: ${(safetyViolationAssignor.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerySafetyAssignor = ''.obs;

  List<SafetyViolationModel> get filteredSafetyAssignorList {
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
      // safetyViolationAssignee.value = (await responseData['data']
      //         as List<dynamic>)
      //     .map((e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
      //     .toList();
      final data = responseData['data'];

      if (data is List) {
        safetyViolationAssignee.value = data
            .map(
                (e) => SafetyViolationModel.fromJson(e as Map<String, dynamic>))
            .toList();

        log('----------=safetyViolationAssignee: ${safetyViolationAssignee.length}');
      } else {
        log("No valid list data received for safetyViolationAssignee.");
      }
      log('----------=safetyViolationAssignee: ${(safetyViolationAssignee.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerySafetyAssignee = ''.obs;

  List<SafetyViolationModel> get filteredSafetyAssigneeList {
    final query = searchQuerySafetyAssignee.value.toLowerCase();
    return safetyViolationAssignee
        .where((ind) =>
            ind.details.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  FocusNode searchAllFocusNode = FocusNode();
  FocusNode searchmakerFocusNode = FocusNode();
  FocusNode searchcheckerFocusNode = FocusNode();

  void handleSfsfearchByTab(int index, String query) {
    if (index == 0) {
      searchQuerySafetyAll.value = query;
    } else if (index == 1) {
      searchQuerySafetyAssignor.value = query;
    } else if (index == 2) {
      searchQuerySafetyAssignee.value = query;
    }
  }

  void handlesearchAll(String query) {
    searchQuerySafetyAll.value = query;
  }

  void handlesearchAssignor(String query) {
    searchQuerySafetyAssignor.value = query;
  }

  void handlesearchAssignee(String query) {
    searchQuerySafetyAssignee.value = query;
  }

  void resetData() {
    searchSafetyAllController.clear();
    searchSafetyAssigneeController.clear();
    searchSafetyAssignorController.clear();
    searchQuerySafetyAll.value = "";
    searchQuerySafetyAssignor.value = "";
    searchQuerySafetyAssignee.value = "";
  }
}
