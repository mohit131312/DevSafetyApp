import 'dart:developer';

import 'package:flutter/material.dart';
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
    personalDetails.value = personalDetailData;
    filteredDetails.value = personalDetailData;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  final List<Map<String, dynamic>> personalDetailData = [
    {
      'img': "assets/icons/profile_icon.png",
      'title': "Work Permit",
      "subtitle": "Work Permit detail",
      "text": "Open",
      'date': '12 Mar 2024, 02:22 PM',
    },
    {
      'img': "assets/icons/profile_icon.png",
      'title': "Work Permit",
      "subtitle": "Work Permit detail",
      "text": "Open",
      'date': '12 Mar 2024, 02:22 PM',
    },
    {
      'img': "assets/icons/profile_icon.png",
      'title': "Work Permit",
      "subtitle": "Work Permit detail",
      "text": "Closed",
      'date': '12 Mar 2024, 02:22 PM',
    },
    {
      'img': "assets/icons/profile_icon.png",
      'title': "Work Permit",
      "subtitle": "Work Permit detail",
      "text": "Accepted",
      'date': '12 Mar 2024, 02:22 PM',
    },
    {
      'img': "assets/icons/profile_icon.png",
      'title': "Work data",
      "subtitle": "Work Permit detail",
      "text": "Accepted",
      'date': '12 Mar 2024, 02:22 PM',
    },
  ];

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

      log('----------=categoryWorkList: ${(categoryWorkList.length)}');
      log('----------=buildingList: ${(buildingList.length)}');
      log('----------=sub_activity_lists: ${(subActivityWorkList.length)}');
      log('----------=CheckerUserList: ${(checkuserList.length)}');
      log('----------=projectfloorList: ${(projectfloorList.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }
}
