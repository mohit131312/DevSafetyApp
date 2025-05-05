import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_all_model.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class WorkPermitController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var searchQuery = ''.obs;
  var personalDetails = <Map<String, dynamic>>[].obs;
  var filteredDetails = <Map<String, dynamic>>[].obs;

  late TabController tabController;

  var selectedOption = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
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

  void changeSelection(int index) {
    selectedOption.value = index;
    applyFilters();
  }

  void searchLabor(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  /// **Apply both search and selection filters**
  void applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(personalDetails);

    // **Search Filter**
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((item) => item['title']!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
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
    filteredDetails.value = filtered;
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

      // //-------------------------------------------------
      workPermitListingAll.value = (await responseData['data'] as List<dynamic>)
          .map((e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------=workPermitListingAll: ${(workPermitListingAll.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQueryworkpermit = ''.obs;
  TextEditingController searchWorkAllController = TextEditingController();
  TextEditingController searchWorkMakerController = TextEditingController();
  TextEditingController searchWorkCheckerController = TextEditingController();

  void updateSearchworkPermitQuery(String query) {
    searchQueryworkpermit.value = query;
  }

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
      workPermitMakerList.value = (await responseData['data'] as List<dynamic>)
          .map((e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
          .where((item) => item.status != "0") // status is a String
          .toList();

      log('----------=workPermitMakerList: ${(workPermitMakerList.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerywpMaker = ''.obs;

  void updateSearchwpMakerQuery(String query) {
    searchQuerywpMaker.value = query;
  }

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
      workPermitCheckerList.value = (await responseData['data']
              as List<dynamic>)
          .map((e) => WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------=workPermitCheckerList: ${(workPermitCheckerList.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuerywpChecker = ''.obs;

  void updateSearchwpCheckerQuery(String query) {
    searchQuerywpChecker.value = query;
  }

  List<WorkPermitListingAll> get filteredwpCheckerList {
    final query = searchQuerywpChecker.value.toLowerCase();
    return workPermitCheckerList
        .where((ind) =>
            ind.nameOfWorkpermit.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  void handleSearchByTab(int index, String query) {
    if (index == 0) {
      searchQueryworkpermit.value = query;
    } else if (index == 1) {
      searchQuerywpMaker.value = query;
    } else if (index == 2) {
      searchQuerywpChecker.value = query;
    }
  }
}
