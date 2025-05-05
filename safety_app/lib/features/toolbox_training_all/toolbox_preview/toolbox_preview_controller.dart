import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/select_reviewer/select_reviewer_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/seletc_trainee/select_trainee_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_add_trainee/toolbox_add_trainee_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_attestation/toolbox_attestation_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_t_details/toolbox_t_details_controller.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ToolboxPreviewController extends GetxController {
  var istoolboxExpanded = true.obs; // Observable to track expansion state
  final LocationController locationController = Get.find();
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
  final ToolboxTDetailsController toolboxTDetailsController = Get.find();
  final SelectReviewerController selectReviewerController = Get.find();
  final ToolboxAddTraineeController toolboxAddTraineeController = Get.find();

  final ToolboxAttestationController toolboxAttestationController = Get.find();
  final SelectTraineeController selectTraineeController = Get.find();

  //--------------------------------
  String validationmsg = '';
  bool apiStatus = false;

  Future<void> safetySaveToolbox(
      BuildContext c, userName, userId, projectId) async {
    int reviwerId =
        await selectReviewerController.selectedassigneeDataIdsFinal[0];
    List<Map<String, dynamic>> listWithoutSignature = await Future.wait(
      toolboxAddTraineeController.combinedIncidentIdsFinal
          .map((e) async => {
                "user_type": e["user_type"],
                "trainees_id": e["trainees_id"],
                "trainees_sign_behalf": e["trainees_sign_behalf"],
              })
          .toList(),
    );

    log("🔹 List Without Signature: $listWithoutSignature");
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());

      print("User ID: ${userId.toString()}");
      print("User Name: ${userName.toString()}");
      var request = await http.MultipartRequest("POST",
          Uri.parse('${RemoteServices.baseUrl}save_toolbox_training_assigner'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['project_id'] = projectId.toString();

      request.fields['toolbox_category_id'] =
          toolboxTDetailsController.selectCategoryId.value.toString();
      request.fields['details'] =
          toolboxTDetailsController.detailsController.text;
      request.fields['name_of_tb_training'] =
          toolboxTDetailsController.tbtController.text;
      request.fields['maker_id'] = userId.toString();
      request.fields['location'] = locationController.locationString.value;
      request.fields['work_permit_id'] =
          toolboxTDetailsController.selectWorkPermitId.value.toString();

      request.fields['reviwer_id'] = reviwerId.toString();

      request.files.add(await http.MultipartFile.fromPath(
        'maker_signature_photo',
        toolboxAttestationController.signatureFile.path,
      ));
      request.fields['trainees_id_list'] = jsonEncode(listWithoutSignature);

      for (int i = 0;
          i < toolboxTDetailsController.selectedInstructionIds.length;
          i++) {
        request.fields['toolbox_instrunction_lists[$i]'] =
            toolboxTDetailsController.selectedInstructionIds[i]
                .toInt()
                .toString();
      }
      for (var image in toolboxAddTraineeController.traineeimg) {
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
      for (var trainee
          in toolboxAddTraineeController.combinedIncidentIdsFinal) {
        if (trainee["trainees_signature_photo"] != null &&
            trainee["trainees_signature_photo"].toString().isNotEmpty) {
          File imageFile = File(trainee["trainees_signature_photo"]!);
          if (imageFile.existsSync()) {
            request.files.add(await http.MultipartFile.fromPath(
              'trainees_signature_photo[]', // Using array format for multiple images
              imageFile.path,
            ));
          } else {
            log("File not found: ${imageFile.path}");
          }
        }
      }

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

  void resetAllData() {
    // Reset expansion states
    istoolboxExpanded.value = true;
    istraineedetails.value = true;
    isprecaution.value = true;

    // Clear form fields in ToolboxTDetailsController
    toolboxTDetailsController.detailsController.clear();
    toolboxTDetailsController.tbtController.clear();
    toolboxTDetailsController.selectCategoryId.value = 0;
    toolboxTDetailsController.selectedInstructionIds.clear();

    // Reset SelectReviewerController
    selectReviewerController.selectedassigneeDataIdsFinal.clear();

    // Reset ToolboxAddTraineeController
    toolboxAddTraineeController.traineeimg.clear();
    toolboxAddTraineeController.combinedIncidentIdsFinal.clear();

    // Reset ToolboxAttestationController
    toolboxAttestationController.signatureFile = File('');

    // Reset validation messages and API status
    validationmsg = '';
    apiStatus = false;

    log("All data has been reset");
  }
}
