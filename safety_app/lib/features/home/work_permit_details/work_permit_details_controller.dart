import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_details/work_permit_preview_maker_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class WorkPermitDetailsController extends GetxController {
  var workpermitExpanded = true.obs; // Observable to track expansion state

  void toggleExpansionWorkpermit() {
    workpermitExpanded.value = !workpermitExpanded.value;
  }

  var isprecautionworkpermitExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionPrecaution() {
    isprecautionworkpermitExpanded.value =
        !isprecautionworkpermitExpanded.value;
  }

  TextEditingController workPermitRemarksController = TextEditingController();
  TextEditingController workPermitRemarksControllerenable =
      TextEditingController();

  List<WorkPermit> workPermitsHomeDetails = [];
  List<SelectedSubActivity> subActivityHomeDetails = [];
  Map<String, dynamic> buildingListHomeList = {};
  Map<String, dynamic> categoryListHomeList = {};
  List<CheckerInformation> checkerInformation = [];
  List<MakerInformation> makerInformation = [];
  List<SelectedToolboxTraining> selectedToolboxTrainingMaker = [];

  Future getWorkPermitAllDetails(
      projcetId, userId, userType, workpermitId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
        "work_permit_id": workpermitId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_selected_work_permit_details', map);
      var data = await responseData['data'];
      log("Request body: $data");

      //-------------------------------------------------
      workPermitsHomeDetails = (await data['work_permits'] as List<dynamic>)
          .map((e) => WorkPermit.fromJson(e as Map<String, dynamic>))
          .toList();
      subActivityHomeDetails = (await data['selected_sub_activity']
              as List<dynamic>)
          .map((e) => SelectedSubActivity.fromJson(e as Map<String, dynamic>))
          .toList();
      selectedToolboxTrainingMaker =
          (await data['selected_toolbox_training'] as List<dynamic>)
              .map((e) =>
                  SelectedToolboxTraining.fromJson(e as Map<String, dynamic>))
              .toList();
      checkerInformation = (await data['checker_information'] as List<dynamic>)
          .map((e) => CheckerInformation.fromJson(e as Map<String, dynamic>))
          .toList();
      makerInformation = (await data['maker_information'] as List<dynamic>)
          .map((e) => MakerInformation.fromJson(e as Map<String, dynamic>))
          .toList();

      buildingListHomeList = (data['building_list'] != null &&
              data['building_list'] is Map<String, dynamic>)
          ? data['building_list']
          : {};

      categoryListHomeList = (data['category_list'] != null &&
              data['category_list'] is Map<String, dynamic>)
          ? data['category_list']
          : {};

      workPermitRemarksControllerenable.text =
          checkerInformation[0].checkerComment ?? '';

      workPermitRemarksController.text =
          workPermitsHomeDetails[0].makerComment ?? '';
      // savedSignatureUrlfetch.value =
      //     await '${workPermitsMakerDetails[0].makerSignaturePhotoAfter ?? ''}';
      // log('savedSignatureUrlOrBase64: ${savedSignatureUrlfetch.value}');

      log('----------=workPermitsHomeDetails: ${(workPermitsHomeDetails.length)}');
      log('----------=subActivityHomeDetails: ${(subActivityHomeDetails.length)}');
      log('----------=categoryListWPMakerList: ${(categoryListHomeList.length)}');
      log('----------=building: ${(buildingListHomeList.length)}');
      log('----------=CheckerInformation: ${(checkerInformation.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }
}
