import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_all_model.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class WorkPermitController extends GetxController {
  var searchQuery = ''.obs;
  var personalDetails = <Map<String, dynamic>>[].obs;
  var filteredDetails = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // tabController = TabController(length: 3, vsync: this);
    // tabController.addListener(() {
    //   selectedOption.value = tabController.index;
    //   print("Selected Tab Index: ${selectedOption.value}");
    // });
  }

  List<CategoryList> categoryWorkList = [];
  List<BuildingList> buildingList = [];
  List<SubActivityList> subActivityWorkList = [];
  List<CheckerUserList> checkuserList = [];
  List<ProjectWiseFloor> projectfloorList = [];
  List<SafetyToolboxTraining> safetyToolboxTraining = [];

  Future getWorkPermitData(projcetId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_work_permit_primary_data', map);
      var data = await responseData['data'];
      //  log("Request body: $data");

      // //-------------------------------------------------
      categoryWorkList = (await data['category_list'] as List<dynamic>)
          .map((e) => CategoryList.fromJson(e as Map<String, dynamic>))
          .toList();
      subActivityWorkList = (await data['sub_activity_lists'] as List<dynamic>)
          .map((e) => SubActivityList.fromJson(e as Map<String, dynamic>))
          .toList();
      buildingList = (await data['building_list'] as List<dynamic>)
          .map((e) => BuildingList.fromJson(e as Map<String, dynamic>))
          .toList();
      checkuserList = (await data['checker_user_list'] as List<dynamic>)
          .map((e) => CheckerUserList.fromJson(e as Map<String, dynamic>))
          .toList();
      projectfloorList =
          (await data['project_wise_floor_list'] as List<dynamic>)
              .map((e) => ProjectWiseFloor.fromJson(e as Map<String, dynamic>))
              .toList();
      safetyToolboxTraining = (await data['safety_toolbox_training']
              as List<dynamic>)
          .map((e) => SafetyToolboxTraining.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------=categoryWorkList: ${(categoryWorkList.length)}');
      log('----------=buildingList: ${(buildingList.length)}');
      log('----------=sub_activity_lists: ${(subActivityWorkList.length)}');
      log('----------=CheckerUserList: ${(checkuserList.length)}');
      log('----------=projectfloorList: ${(projectfloorList.length)}');
      log('----------=safetyToolboxTraining: ${(safetyToolboxTraining.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  void clearWorkPermitData() {
    categoryWorkList.clear();
    buildingList.clear();
    subActivityWorkList.clear();
    checkuserList.clear();
    projectfloorList.clear();
    safetyToolboxTraining.clear();

    // Optionally, log the data after clearing
    log('Data cleared');
  }

  RxList<WorkPermitListingAll> workPermitListingAll =
      <WorkPermitListingAll>[].obs;

  Future getWorkPermitAllListing(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData = await globApiCall('get_work_permit_all_list', map);
      //  log("Request body: $data");
      final data = responseData['data'];

      // //-------------------------------------------------
      // workPermitListingAll.value = (await responseData['data'] as List<dynamic>)
      //     .map((e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
      //     .toList();
      if (data is List) {
        workPermitListingAll.value = data
            .map(
                (e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        // Handle empty or invalid list response
        workPermitListingAll.clear(); // or leave it unchanged if needed
        log("No work permit data found.");
      }
      log('----------=workPermitListingAll: ${(workPermitListingAll.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQueryworkpermit = ''.obs;
  TextEditingController searchWorkAllController = TextEditingController();
  FocusNode searchAllFocusNode = FocusNode();
  FocusNode searchmakerFocusNode = FocusNode();
  FocusNode searchcheckerFocusNode = FocusNode();
  TextEditingController searchWorkMakerController = TextEditingController();
  TextEditingController searchWorkCheckerController = TextEditingController();

  List<WorkPermitListingAll> get filteredworkAllList {
    final query = searchQueryworkpermit.value.toLowerCase();
    return workPermitListingAll
        .where((ind) =>
            ind.nameOfWorkpermit.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  //--------------------------------------------
  RxList<WorkPermitListingAll> workPermitMakerList =
      <WorkPermitListingAll>[].obs;

  Future getWorkPermitMakerListing(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData = await globApiCall('get_work_permit_all_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      // workPermitMakerList.value = (await responseData['data'] as List<dynamic>)
      //     .map((e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
      //     .toList();

      final data = responseData['data'];

      if (data is List) {
        workPermitMakerList.value = data
            .map(
                (e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
            .where((item) => item.status != "0")
            .toList();

        log('----------=workPermitMakerList: ${workPermitMakerList.length}');
      } else {
        workPermitMakerList.clear(); // Safe fallback
        log("No valid list data received for workPermitMakerList.");
      }
      // workPermitMakerList.value = (await responseData['data'] as List<dynamic>)
      //     .map((e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
      //     .where((item) => item.status != "0") // status is a String
      //     .toList();

      log('----------=workPermitMakerList: ${(workPermitMakerList.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerywpMaker = ''.obs;

  List<WorkPermitListingAll> get filteredwpMakerList {
    final query = searchQuerywpMaker.value.toLowerCase();
    return workPermitMakerList
        .where((ind) =>
            ind.nameOfWorkpermit.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  //---------------------------------------------------
  RxList<WorkPermitListingAll> workPermitCheckerList =
      <WorkPermitListingAll>[].obs;

  Future getWorkPermitCheckerListing(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData = await globApiCall('get_work_permit_all_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      // workPermitCheckerList.value = (await responseData['data']
      //         as List<dynamic>)
      //     .map((e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
      //     .toList();
      final data = responseData['data'];

      if (data is List) {
        workPermitCheckerList.value = data
            .map(
                (e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
            .toList();

        log('----------=workPermitCheckerList: ${workPermitCheckerList.length}');
      } else {
        workPermitCheckerList.clear(); // Safe fallback on bad or empty data
        log("No valid list data received for workPermitCheckerList.");
      }
      log('----------=workPermitCheckerList: ${(workPermitCheckerList.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerywpChecker = ''.obs;

  List<WorkPermitListingAll> get filteredwpCheckerList {
    final query = searchQuerywpChecker.value.toLowerCase();
    return workPermitCheckerList
        .where((ind) =>
            ind.nameOfWorkpermit.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  void clearSearchData() {
    // Clear text in all search controllers
    searchWorkAllController.clear();
    searchWorkMakerController.clear();
    searchWorkCheckerController.clear();
    searchQueryworkpermit.value = '';
    searchQuerywpMaker.value = '';
    searchQuerywpChecker.value = '';
    // Reset active controller text
  }

  //---------------------------

  void handleSearchAll(String query) {
    searchQueryworkpermit.value = query;
  }

  void handleSearchDoer(String query) {
    searchQuerywpMaker.value = query;
  }

  void handleSearchChecker(String query) {
    searchQuerywpChecker.value = query;
  }
}
