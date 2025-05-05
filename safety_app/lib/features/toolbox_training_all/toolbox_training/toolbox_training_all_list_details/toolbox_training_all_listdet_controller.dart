import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_all_list_details/toolbox_training_alllist_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';

import 'package:get/get.dart';

class ToolboxTrainingAllListdetController extends GetxController {
  var istoolboxExpanded = true.obs; // Observable to track expansion state

  void toolboxtoggleExpansion() {
    istoolboxExpanded.value = !istoolboxExpanded.value;
  }

  var istraineedetails = true.obs; // Observable to track expansion state

  void toggletraineedetailsExpansion() {
    istraineedetails.value = !istraineedetails.value;
  }

  var isprecaution = true.obs; // Observable to track expansion state

  void toggleExpansionisprecaution() {
    isprecaution.value = !isprecaution.value;
  }

  //------------------------------
  final TextEditingController reviewerController = TextEditingController();
  final TextEditingController makerController = TextEditingController();
  //--------------------------------
  String validationmsg = '';
  bool apiStatus = false;

  List<SafetyToolboxTraining> safetyToolboxTraining = [];
  List<ToolboxCategoryList> toolboxCategoryList = [];
  List<ToolboxInstructionsList> toolboxInstructionsList = [];
  List<TraineeLaboursList> traineeLaboursList = [];
  List<ErUser> makerUser = [];
  List<ErUser> reviewerUser = [];
  List<TbtAddedPhoto> tbtAddedPhotos = [];

  Future gettoolBoxAllDetails(projcetId, userId, userType, toolBoxId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
        "safety_toolbox_training_id": toolBoxId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_selected_toolbox_training_details', map);
      var data = await responseData['data'];
      log("Request body: $data");

      //-------------------------------------------------
      safetyToolboxTraining = (await data['safety_toolbox_training']
              as List<dynamic>)
          .map((e) => SafetyToolboxTraining.fromJson(e as Map<String, dynamic>))
          .toList();
      toolboxCategoryList = (await data['toolbox_category_list']
              as List<dynamic>)
          .map((e) => ToolboxCategoryList.fromJson(e as Map<String, dynamic>))
          .toList();
      toolboxInstructionsList =
          (await data['toolbox_instructions_list'] as List<dynamic>)
              .map((e) =>
                  ToolboxInstructionsList.fromJson(e as Map<String, dynamic>))
              .toList();
      traineeLaboursList = (await data['trainee_labours_list'] as List<dynamic>)
          .map((e) => TraineeLaboursList.fromJson(e as Map<String, dynamic>))
          .toList();
      makerUser = (await data['maker_user'] as List<dynamic>)
          .map((e) => ErUser.fromJson(e as Map<String, dynamic>))
          .toList();
      reviewerUser = (await data['reviewer_user'] as List<dynamic>)
          .map((e) => ErUser.fromJson(e as Map<String, dynamic>))
          .toList();
      tbtAddedPhotos = (await data['tbt_added_photos'] as List<dynamic>)
          .map((e) => TbtAddedPhoto.fromJson(e as Map<String, dynamic>))
          .toList();

      reviewerController.text = (safetyToolboxTraining[0].reviwerComment)!;
      makerController.text = (safetyToolboxTraining[0].makerComment)!;

      log('----------=safetyToolboxTraining: ${(safetyToolboxTraining.length)}');
      log('----------=toolboxCategoryList: ${(toolboxCategoryList.length)}');
      log('----------=toolboxInstructionsList: ${(toolboxInstructionsList.length)}');
      log('----------=traineeLaboursList: ${(traineeLaboursList.length)}');
      log('----------=maker: ${(makerUser.length)}');
      log('----------=rev: ${(reviewerUser.length)}');
      log('----------=tbtAddedPhotos: ${(tbtAddedPhotos.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  void resetData() {
    // Reset observables
    istoolboxExpanded.value = true;
    istraineedetails.value = true;
    isprecaution.value = true;

    // Clear text controllers
    reviewerController.clear();
    makerController.clear();

    // Clear all lists
    safetyToolboxTraining.clear();
    toolboxCategoryList.clear();
    toolboxInstructionsList.clear();
    traineeLaboursList.clear();
    makerUser.clear();
    reviewerUser.clear();
    tbtAddedPhotos.clear();

    // Reset validation and status
    validationmsg = '';
    apiStatus = false;

    // Log reset
    log("All data has been reset in ToolboxTrainingAllListdetController");
  }
}
