import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_attestaion/safety_attestaion_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_assignee/select_safety_assignee_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_informed_people/select_safety_informed_people_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_involved_person/select_involved_person_controller.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SafetyPreviewController extends GetxController {
  var issafetyDetailsExpanded = true.obs;

  void toggleExpansionSafety() {
    issafetyDetailsExpanded.value = !issafetyDetailsExpanded.value;
  }

  var isinvolvepeople = true.obs;

  void toggleInvolvedExpansionpeople() {
    isinvolvepeople.value = !isinvolvepeople.value;
  }

  var isinformedpeople = true.obs;

  void toggleExpansionisinformedpeople() {
    isinformedpeople.value = !isinformedpeople.value;
  }

  //-----------------------------------------------------------------------------------
  final LocationController locationController = Get.find();

  final SelectSafetyAssigneeController selectSafetyAssigneeController =
      Get.find();

  final SafetyAttestaionController safetyAttestaionController = Get.find();

  final SafetyViolationDetailsController safetyViolationDetailsController =
      Get.find();

  final SelectInvolvedPersonController selectInvolvedPersonController =
      Get.find();
  final SelectSafetyInformedPeopleController
      selectSafetyInformedPeopleController = Get.find();

  String validationmsg = '';

  Future<void> safetySaveSafetyViolation(
      BuildContext c, userName, userId, projectId) async {
    // var firstSelectedAssignee = await selectSafetyAssigneeController
    //         .selectedassigneeDataIdsFinal.isNotEmpty
    //     ? selectSafetyAssigneeController.selectedassigneeDataIdsFinal[0]
    //     : null;

    selectSafetyInformedPeopleController.convertAssigneeIdsToMap();

    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());

      int assigneeId =
          await selectSafetyAssigneeController.selectedassigneeDataIdsFinal[0];
      print("User ID: ${userId.toString()}");
      print("User Name: ${userName.toString()}");
      print(" assigneeId: ${assigneeId.toString()}");
      // print("Labour ID: ${addLabourController.labourId.toString()}");
      // print("firstSelectedAssignee ID: ${firstSelectedAssignee.toString()}");
      var request = await http.MultipartRequest(
          "POST",
          Uri.parse(
              '${RemoteServices.baseUrl}save_safety_violation_debit_note'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['violation_type_id'] =
          safetyViolationDetailsController.selectViolationId.toString();
      request.fields['category_id'] =
          safetyViolationDetailsController.selectCategoryId.toString();

      request.fields['details'] =
          safetyViolationDetailsController.detailsController.text;

      request.fields['location_of_breach'] =
          safetyViolationDetailsController.loactionofBreachController.text;
      request.fields['risk_level_id'] =
          safetyViolationDetailsController.selectRisklevelId.toString();
      request.fields['turn_around_time'] =
          // "2025-04-23T14:30:00Z";
          safetyViolationDetailsController.turnArounttimeController.text;
      request.fields['source_of_observation_id'] =
          safetyViolationDetailsController.selectObservationId.toString();

      request.fields['assignee_id'] = assigneeId.toString();
      request.fields['assigner_id'] = userId.toString();
      //request.fields['assigner_id'] = '53';
      request.fields['user_id'] = userId.toString();
      request.fields['project_id'] = projectId.toString();
      // request.fields['user_name'] = userName.toString();
      request.fields['location'] = locationController.locationString.value;
      for (int i = 0;
          i < selectInvolvedPersonController.combinedSelectedIdsFinal.length;
          i++) {
        request.fields['involved_person_list[$i]'] = jsonEncode(
            selectInvolvedPersonController.combinedSelectedIdsFinal[i]);
      }
      print("Final request fields: ${request.fields}");

      for (int i = 0;
          i <
              selectSafetyInformedPeopleController
                  .selectedAssigneeIdsFinalMap.length;
          i++) {
        request.fields['informed_person_list[$i]'] = jsonEncode(
            selectSafetyInformedPeopleController
                .selectedAssigneeIdsFinalMap[i]);
      }
      print("Finalinformed_person_list request fields: ${request.fields}");

      for (var image in safetyViolationDetailsController.violationimg) {
        if (image.path.isNotEmpty && File(image.path).existsSync()) {
          log("File exists, attaching: ${image.path}");

          request.files.add(await http.MultipartFile.fromPath(
            'photo_path[]',
            image.path,
          ));
        } else {
          log(" File not found: ${image.path}");
        }
      }
      request.files.add(await http.MultipartFile.fromPath(
        'signature_photo',
        safetyAttestaionController.signatureFile.path,
      ));

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

  void clearAllFields() {
    // Clear text controllers
    safetyViolationDetailsController.detailsController.clear();
    safetyViolationDetailsController.loactionofBreachController.clear();
    safetyViolationDetailsController.turnArounttimeController.clear();
    selectInvolvedPersonController.tabController
        .animateTo(0); // or tabController.index = 0;

    // Reset selected IDs
    safetyViolationDetailsController.selectViolationId.value = 0;
    safetyViolationDetailsController.selectViolation.value = '';
    safetyViolationDetailsController.selectCategoryId.value = 0;
    safetyViolationDetailsController.selectCategory.value = '';
    safetyViolationDetailsController.selectRisklevelId.value = 0;
    safetyViolationDetailsController.selectRisklevel.value = '';
    safetyViolationDetailsController.selectObservationId.value = 0;
    safetyViolationDetailsController.selectObservation.value = '';

    safetyViolationDetailsController.violationimg.clear();
    safetyAttestaionController.signatureFile = File('');

    selectSafetyAssigneeController.selectedassigneeDataIdsFinal.clear();
    selectSafetyAssigneeController.selectedassigneeDataIds.clear();

    selectSafetyInformedPeopleController.selectedAssigneeIdsFinal.clear();
    selectSafetyInformedPeopleController.selectedAssigneeIds.clear();
    selectSafetyInformedPeopleController.selectedAssigneeIdsFinalMap.clear();

    selectInvolvedPersonController.selectedStaffIdsFinal.clear();
    selectInvolvedPersonController.selectedContractorIdsFinal.clear();
    selectInvolvedPersonController.selectedLabourIdsFinal.clear();
    selectInvolvedPersonController.selectedStaffIds.clear();
    selectInvolvedPersonController.selectedContractorIds.clear();
    selectInvolvedPersonController.selectedLabourIds.clear();
    selectInvolvedPersonController.combinedSelectedIdsFinal.clear();

    safetyAttestaionController.clearSafetyattestationSignature();

    log("All fields cleared successfully.");
  }
}
