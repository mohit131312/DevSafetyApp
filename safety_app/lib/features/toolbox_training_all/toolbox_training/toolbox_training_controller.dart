import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_listing_model.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class ToolboxTrainingController extends GetxController {
  List<ToolboxCategoryList> toolboxCategoryList = [];
  List<TraineesList> traineesLaboursList = [];
  List<TraineesListStaff> traineesstaffList = [];
  List<TraineesContractorUserList> traineesContractorList = [];
  List<ReviwerUserList> reviewerList = [];
  List<WorkPermit> workPermitList = [];

  Future getToolBoxData(projcetId, userId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_toolbox_form_primary_data', map);
      var data = await responseData['data'];
      //  log("Request body: $data");

      // //-------------------------------------------------

      toolboxCategoryList = (data['toolbox_category_list'] as List<dynamic>)
          .map((e) => ToolboxCategoryList.fromJson(e as Map<String, dynamic>))
          .toList();
      traineesLaboursList = (data['trainees_labours_list'] as List<dynamic>)
          .map((e) => TraineesList.fromJson(e as Map<String, dynamic>))
          .toList();
      traineesstaffList = (data['trainees_staff_list'] as List<dynamic>)
          .map((e) => TraineesListStaff.fromJson(e as Map<String, dynamic>))
          .toList();
      traineesContractorList = (data['trainees_contractor_user_list']
              as List<dynamic>)
          .map((e) =>
              TraineesContractorUserList.fromJson(e as Map<String, dynamic>))
          .toList();
      reviewerList = (data['reviwer_user_list'] as List<dynamic>)
          .map((e) => ReviwerUserList.fromJson(e as Map<String, dynamic>))
          .toList();
      workPermitList = (data['work_permits'] as List<dynamic>)
          .map((e) => WorkPermit.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------ToolboxCategoryList${toolboxCategoryList.length}');
      log('----------traineesLaboursList${traineesLaboursList.length}');
      log('----------traineesstaffList${traineesstaffList.length}');
      log('----------traineesContractorList${traineesContractorList.length}');
      log('----------reviewerList${reviewerList.length}');
      log('----------workPermitList${workPermitList.length}');

      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  void clearToolboxData() {
    toolboxCategoryList.clear();
    traineesLaboursList.clear();
    traineesstaffList.clear();
    traineesContractorList.clear();
    reviewerList.clear();
    workPermitList.clear();

    // Optionally, log the data after clearing
    log('Toolbox data cleared');
  }

  //-----------------------------------------------------

  RxList<ToolboxDetails> toolboxListingAll = <ToolboxDetails>[].obs;

  Future getToolBoxListingAll(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_toolbox_training_all_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      // toolboxListingAll.value = (await responseData['data'] as List<dynamic>)
      //     .map((e) => ToolboxDetails.fromJson(e as Map<String, dynamic>))
      //     .toList();

      final data = responseData['data'];

      if (data is List) {
        toolboxListingAll.value = data
            .map((e) => ToolboxDetails.fromJson(e as Map<String, dynamic>))
            .toList();

        log('----------=toolboxListingAll: ${toolboxListingAll.length}');
      } else {
        log("No toolbox data found.");
      }
      log('----------=toolboxListingAll: ${(toolboxListingAll.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerylistingall = ''.obs;
  TextEditingController searchtoolAllController = TextEditingController();
  TextEditingController searchtoolMakerController = TextEditingController();
  TextEditingController searchtoolReviwerController = TextEditingController();
  FocusNode searchAllListFocusNode = FocusNode();
  FocusNode searchMakerFocusNode = FocusNode();
  FocusNode searchReviewerFocusNode = FocusNode();

  List<ToolboxDetails> get filteredtoolboxAllList {
    final query = searchQuerylistingall.value.toLowerCase();
    return toolboxListingAll
        .where((ind) =>
            ind.nameOfTbTraining.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  //------------------------------------------------------------------

  RxList<ToolboxDetails> toolboxListingMaker = <ToolboxDetails>[].obs;

  Future getToolBoxListingMaker(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_toolbox_training_all_list', map);

      // toolboxListingMaker.value = (await responseData['data'] as List<dynamic>)
      //     .map((e) => ToolboxDetails.fromJson(e as Map<String, dynamic>))
      //     .where((item) => item.status != 0) // integer comparison
      //     .toList();

      final data = responseData['data'];

      if (data is List) {
        toolboxListingMaker.value = data
            .map((e) => ToolboxDetails.fromJson(e as Map<String, dynamic>))
            .where((item) => item.status != 0) // integer status check
            .toList();

        log('----------=toolboxListingMaker: ${toolboxListingMaker.length}');
      } else {
        log("No toolbox data found.");
      }

      log('----------=toolboxListingMaker: ${(toolboxListingMaker.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerylistingMaker = ''.obs;

  List<ToolboxDetails> get filteredtoolboxListMaker {
    final query = searchQuerylistingMaker.value.toLowerCase();
    return toolboxListingMaker
        .where((ind) =>
            ind.nameOfTbTraining.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  //------------------------------------------------------------------
  RxList<ToolboxDetails> toolboxListingReviewer = <ToolboxDetails>[].obs;

  Future getToolBoxListingReviewer(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_toolbox_training_all_list', map);

      // //-------------------------------------------------
      // toolboxListingReviewer.value =
      //     (await responseData['data'] as List<dynamic>)
      //         .map((e) => ToolboxDetails.fromJson(e as Map<String, dynamic>))
      //         .toList();
      final data = responseData['data'];

      if (data is List) {
        toolboxListingReviewer.value = data
            .map((e) => ToolboxDetails.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        log("No valid list data received for toolboxListingReviewer.");
      }
      log('----------=toolboxListingReviewer: ${(toolboxListingReviewer.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerylistingReviewer = ''.obs;
  List<ToolboxDetails> get filteredtoolboxListReviewer {
    final query = searchQuerylistingReviewer.value.toLowerCase();
    return toolboxListingReviewer
        .where((ind) =>
            ind.nameOfTbTraining.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  void handleSearchAll(String query) {
    searchQuerylistingall.value = query;
  }

  void handleSearchDoer(String query) {
    searchQuerylistingMaker.value = query;
  }

  void handleSearchChecker(String query) {
    searchQuerylistingReviewer.value = query;
  }

  void clearSearchData() {
    searchtoolAllController.clear();
    searchtoolMakerController.clear();
    searchtoolReviwerController.clear();
    searchQuerylistingall.value = '';
    searchQuerylistingMaker.value = '';
    searchQuerylistingReviewer.value = '';
    log('Search data cleared');
  }
}
