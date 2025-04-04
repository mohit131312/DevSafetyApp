import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/assign_checker/assign_checker_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_precaution/work_permit_precaution_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_undertaking/work_permit_under_controller.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WorkPermitPreviewController extends GetxController {
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

  String validationmsg = '';
  bool apiStatus = false;
  final NewWorkPermitController newWorkPermitController = Get.find();
  final WorkPermitUnderController workPermitUnderController = Get.find();
  final AssignCheckerController assignCheckerController =
      Get.put(AssignCheckerController());
  final WorkPermitPrecautionController workPermitPrecautionController =
      Get.find();
  Future<void> safetySaveWorkPermit(
      BuildContext c, userName, userId, projectId) async {
    List categoryDetailsList =
        await workPermitPrecautionController.getSelectedDataForPost();
    log("categoryDetailsList-------------------------------: $categoryDetailsList");
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());

      print("User ID: ${userId.toString()}");
      print("User Name: ${userName.toString()}");
      var request = await http.MultipartRequest("POST",
          Uri.parse('${RemoteServices.baseUrl}save_safety_work_permit'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['project_id'] = projectId.toString();
      //  request.fields['project_id'] = "1";
      request.fields['sub_activity_id'] =
          newWorkPermitController.selectedWorkActivityId.toString();
      // request.fields['sub_activity_id'] = "12";
      request.fields['toolbox_training_id'] = '';
      // request.fields['description'] = "abx";
      request.fields['description'] =
          newWorkPermitController.descWorkrController.text;

      //request.fields['name_of_workpermit'] = "aa";
      request.fields['name_of_workpermit'] =
          newWorkPermitController.nameworkpermitController.text;

      // request.fields['from_date_time'] = "2025-03-24 14:30:00";
      request.fields['from_date_time'] =
          newWorkPermitController.fromDateTime.value.toString();
      // request.fields['to_date_time'] = "2025-03-24 16:30:00";
      request.fields['to_date_time'] =
          newWorkPermitController.toDateTime.value.toString();

      request.fields['maker_id'] = userId.toString();
      request.fields['project_id'] = projectId.toString();
      request.fields['maker_id'] = "52";
      request.fields['location'] = "pune";
      for (int i = 0;
          i < workPermitUnderController.filteredDetailsUndertaking.length;
          i++) {
        request.fields['undertaking_${i + 1}'] =
            workPermitUnderController.filteredDetailsUndertaking[i]['isChecked']
                ? '1'
                : '0';
      }

      for (int i = 0;
          i < assignCheckerController.selectedassigneeDataIdsFinal.length;
          i++) {
        request.fields['checker_user_list[$i]'] =
            jsonEncode(assignCheckerController.selectedassigneeDataIdsFinal[i]);
      }

      request.files.add(await http.MultipartFile.fromPath(
        'maker_signature_photo',
        workPermitUnderController.signatureFile.path,
      ));
      request.fields['building_id_list'] =
          jsonEncode(newWorkPermitController.selectedBuildingIdListFinal);

      request.fields['category_details_list'] = jsonEncode(categoryDetailsList);

      log("Final Request Fields: ${jsonEncode(request.fields)}");
      log("Final Request Files: ${request.files.map((file) => file.filename).toList()}");

      await request.send().then((response) async {
        log("Response Status Code: ${response.statusCode}");

        await http.Response.fromStream(response).then((onValue) async {
          try {
            Map<String, dynamic> decoded = await jsonDecode(onValue.body);

            log('-------------------------decoded----------------$decoded');
            if (decoded.containsKey('validation-message')) {
              Navigator.pop(Get.context!);

              log("----------------------------------------------------------------------validation: ");

              Map<String, dynamic> validationErrors =
                  decoded['validation-message'];
              validationmsg = validationErrors.entries
                  .map((entry) => '${entry.value.join(", ")}')
                  .join("\n\n");

              await showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return CustomValidationPopup(message: validationmsg);
                },
              );
              Get.back();
            } else {
              validationmsg = await decoded['message'];
              apiStatus = await decoded['status'];
              log("----------------------------------------------------------------------msg: ");
              Navigator.pop(Get.context!, true);

              await showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return CustomValidationPopup(message: validationmsg);
                },
              );
              Get.back();
            }
          } catch (e) {
            Navigator.pop(Get.context!, true);

            log("Error parsing response: $e");
          }
        });
      });
    } catch (e) {
      Navigator.pop(Get.context!, true);
      //Get.back();

      log("----------------------------------------------------------------------Erooorrrrrrrrrrrrrrrrr: $e");
      await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CustomValidationPopup(
              message: "Something went wrong. Please try again.");
        },
      );
    }
  }

  void clearAllData() {
    // Clear work permit precaution selections
    workPermitPrecautionController.selectedWorkPermitData.clear();
    workPermitPrecautionController.workPermitError.value = "";

    // Clear assigned checkers
    assignCheckerController.selectedassigneeDataIdsFinal.clear();

    // Clear work permit undertaking selections
    // workPermitUnderController.filteredDetailsUndertaking.clear();
    workPermitUnderController.signatureFile = File('');

    // Clear new work permit details
    newWorkPermitController.selectedWorkActivityId.value = 0;
    newWorkPermitController.descWorkrController.clear();
    newWorkPermitController.nameworkpermitController.clear();
    newWorkPermitController.fromDateTime.value = "";
    newWorkPermitController.toDateTime.value = "";
    newWorkPermitController.selectedBuildingIdListFinal.clear();

    // Clear validation message
    validationmsg = "";
    apiStatus = false;

    log("All work permit data has been cleared.");
  }
}
