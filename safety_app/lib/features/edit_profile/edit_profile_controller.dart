import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/validation_pop_chang.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  String validationmsg = '';

  Future getEditProfileDetails(
      Map<String, dynamic> updatedData, context) async {
    try {
      log('api ---------------$updatedData');

      var responseData = await globApiCall('edit_safety_profile', updatedData);

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
            return ValidationPopChang(message: validationmsg);
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
}
