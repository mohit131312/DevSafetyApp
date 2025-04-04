import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class ToolboxTrainingController extends GetxController
    with GetSingleTickerProviderStateMixin {
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

  List<ToolboxCategoryList> toolboxCategoryList = [];
  List<TraineesList> traineesLaboursList = [];
  List<TraineesListStaff> traineesstaffList = [];
  List<TraineesContractorUserList> traineesContractorList = [];
  List<ReviwerUserList> reviewerList = [];
  List<WorkPermit> workPermitList = [];

  Future getSafetyIncidentData(projcetId, userId) async {
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
}
