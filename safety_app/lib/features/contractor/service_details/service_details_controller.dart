import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';

import 'service_details_model.dart';

class ServiceDetailsController extends GetxController {
  String validationmsg = '';
  var subActivityMatchedList = <SubAct>[].obs;

  Future getSubActivtyList(id, context) async {
    try {
      log('api ---------------$id');

      Map<String, dynamic> map = {
        "activity_id": id,
      };
      var responseData = await globApiCall('get_subactivity_list', map);
      if (responseData != null && responseData.containsKey('data')) {
        var subActivities = responseData['data'];

        if (subActivities is List) {
          subActivityMatchedList.assignAll(
            subActivities.map((e) => SubAct.fromJson(e)).toList(),
          );
        } else {
          log("Unexpected data format in response: $subActivities");
          subActivityMatchedList.clear();
        }
      } else {
        log("No sub-activities found for ID: $id");
        subActivityMatchedList.clear();
      }
      if (responseData != null &&
          responseData.containsKey('validation-message')) {
        Map<String, dynamic> validationErrors =
            responseData['validation-message'];

        // Format error messages
        validationmsg = validationErrors.entries
            .map((entry) => '${entry.value.join(", ")}')
            .join("\n\n");

        // Show custom popup instead of snackbar
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomValidationPopup(message: validationmsg);
          },
        );
      } else {
        validationmsg = responseData['message'];

        print('successmsg-------------$validationmsg');
        // Show success message popup
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomValidationPopup(message: validationmsg);
          },
        );
      }
    } catch (e) {
      log("Error: $e");

      // Show error popup
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomValidationPopup(
              message: "Something went wrong. Please try again.");
        },
      );
    }
  }

  var selectedactivity = ''.obs; // Observable for Blood Group selection
  var selectedActivityId = 0.obs;
  var selectedSubactivity = ''.obs; // Observable for Blood Group selection
  var selectedSubActivityId = 0.obs;
  var selectActivityList = <String>[].obs;
  var selectActivityIdList = <String>[].obs;
  var selectSubActivityList = <String>[].obs;
  var selectSubActivityIdList = <String>[].obs;

  void addActivity(String activityName, int activityId, String subactivityName,
      int subactivityId) {
    if (!selectSubActivityList.contains(subactivityName)) {
      selectActivityList.add(activityName);
      selectActivityIdList.add(activityId.toString());
      selectSubActivityList.add(subactivityName);
      selectSubActivityIdList.add(subactivityId.toString());
    }
    print("Current Activity List: $selectActivityList");
    print("Current Activity ID List: $selectActivityIdList");
    print("Current Sub-Activity List: $selectSubActivityList");
    print("Current Sub-Activity ID List: $selectSubActivityIdList");
  }

  void removeActivity(int activityId) {
    if (activityId != -1) {
      selectActivityList.removeAt(activityId);
      selectActivityIdList.removeAt(activityId);
    }
    print("Updated Activity List: $selectActivityList");
    print("Updated Activity ID List: $selectActivityIdList");
  }

  void removeSubActivity(int subactivityId) {
    if (subactivityId != -1) {
      selectSubActivityList.removeAt(subactivityId);
      selectSubActivityIdList.removeAt(subactivityId);
    }
    print("Current Sub-Activity List: $selectSubActivityList");
    print("Current Sub-Activity ID List: $selectSubActivityIdList");
  }

  var activityError = ''.obs;
  var subActivityError = ''.obs;

  void clearAll() {
    selectedactivity.value = '';
    selectedActivityId.value = 0;
    selectedSubactivity.value = '';
    selectedSubActivityId.value = 0;

    selectActivityList.clear();
    selectActivityIdList.clear();
    selectSubActivityList.clear();
    selectSubActivityIdList.clear();
  }

  void clearOne() {
    selectedactivity.value = '';
    selectedActivityId.value = 0;
    selectedSubactivity.value = '';
    selectedSubActivityId.value = 0;
  }

  //------------------------------------------------------------
  List activityExist = [];
}
