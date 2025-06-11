import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/validation.dart';
import 'package:flutter_app/utils/validation_pop_chang.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  var passwordRequirements = [
    PasswordRequirement(text: 'Min 4 Characters', isValid: false.obs),
    PasswordRequirement(text: 'Max 30 Characters', isValid: false.obs),
  ].obs;

  void checkPasswordRequirements(String password) {
    // Reset all requirements to false
    for (var req in passwordRequirements) {
      req.isValid.value = false;
    }

    // Check each password requirement
    if (password.length >= 4) {
      passwordRequirements[0].isValid.value = true;
    }
    if (password.length == 30) {
      passwordRequirements[1].isValid.value = true;
    }
  }

  final RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9@]+$');

  void updatePasswordRequirements(String password) {
    checkPasswordRequirements(password);
  }

  String? newPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 4) {
      return "Password must be at least 4 characters long";
    }
    if (value.length > 30) {
      return "Password cannot exceed 30 characters";
    }
    if (!passwordRegex.hasMatch(value)) {
      return "Password can only contain letters, numbers, and '@'";
    }
    return null; // No validation error
  }

  // Validate Confirm Password
  String? confirmPasswordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter confirm password";
    }
    if (!passwordRegex.hasMatch(value)) {
      return "Password cannot contain special characters";
    }
    return Validator.validateConfirmPassword(value, newPassword.value);
  }

  var apiStatus = false.obs;

  Future<void> submit(BuildContext context, userId) async {
    if (formKey.currentState?.validate() ?? false) {
      if (logStatus == true) {
        // Show loading popup
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup(),
        );
        Map<String, dynamic> map = {
          "password": newPasswordController.text,
          "confirm_password": confirmPasswordController.text,
          "user_id": userId,
        };
        // ignore: unused_local_variable
        var response = await getChangePassword(map, context);

        // Close loading popup
        if (validationchangepass == 'Password changed successfully') {
          Navigator.pop(context);
          Navigator.pop(context);
          formKey.currentState?.reset();
          Get.back(); // Go back to the previous screen
        } else {
          Navigator.pop(context);
        }
      } else {
        logout();
      }
    }
  }

  String validationchangepass = '';

  Future getChangePassword(Map<String, dynamic> map, context) async {
    try {
      log('api change_safety_password ---------------$map');

      // ignore: unused_local_variable
      var responseData = await globApiCall('change_safety_password', map);

      if (responseData != null) {
        if (responseData.containsKey('validation-message')) {
          Map<String, dynamic> validationErrors =
              responseData['validation-message'];

          // Format validation errors
          validationchangepass = validationErrors.entries
              .map((entry) => ' ${entry.value.join(", ")}')
              .join("\n\n");

          log('Validation Errors: $validationchangepass');

          // Show validation message popup
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomValidationPopup(message: validationchangepass);
            },
          );

          return; // Stop execution if validation errors exist
        }

        if (responseData["status"] == true) {
          validationchangepass = responseData['message'];

          log('Success Message: $validationchangepass');
          apiStatus.value = true;

          // Show success message popup
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return ValidationPopChang(message: validationchangepass);
            },
          );
        } else {
          validationchangepass =
              responseData['message'] ?? "Something went wrong.";

          log('Failure Message: $validationchangepass');

          // Show failure message popup
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomValidationPopup(message: validationchangepass);
            },
          );
        }
      } else {
        log("Error: Empty response from API");

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomValidationPopup(
                message: "Something went wrong. Please try again.");
          },
        );
      }
    } catch (e) {
      log("Exception: $e");

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomValidationPopup(
              message: "Something went wrong. Please try again.");
        },
      );
    }
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

class PasswordRequirement {
  String text;
  RxBool isValid;

  PasswordRequirement({required this.text, required this.isValid});
}
