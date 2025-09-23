import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/contractor/add_contractor/add_contractor_controller.dart';
import 'package:flutter_app/features/contractor/contractor_details/contractor_details_controller.dart';
import 'package:flutter_app/features/contractor/service_details/service_details_controller.dart';
import 'package:flutter_app/features/contractor/service_undertaking/service_undertaking_controller.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContractorPreviewController extends GetxController {
  var isPersonalDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansion() {
    isPersonalDetailsExpanded.value = !isPersonalDetailsExpanded.value;
  }

  final LocationController locationController = Get.find();

  var isidproofDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionidProof() {
    isidproofDetailsExpanded.value = !isidproofDetailsExpanded.value;
  }

  var isprecautionDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionPrecaution() {
    isprecautionDetailsExpanded.value = !isprecautionDetailsExpanded.value;
  }

  //----------------------------------------------------------------------

  final AddContractorController addContractorController = Get.find();
  final ContractorDetailsController contractorDetailsController = Get.find();
  final ServiceDetailsController serviceDetailsController = Get.find();

  final ServiceUndertakingController serviceUndertakingController = Get.find();

  String validationmsg = '';

  //-----------------------------------------------------------------

  Future<void> safetySaveContactor(
      BuildContext c, categoryId, userName, userId, projectId) async {
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());
      int newUser = addContractorController.userFound.value ? 0 : 1;
      print("User ID: ${userId.toString()}");
      print("User Name: ${userName.toString()}");
      print("Contactor ID: ${addContractorController.contactorId.toString()}");
      var request = await http.MultipartRequest(
          "POST",
          Uri.parse(
              '${RemoteServices.baseUrl}safety_save_contractor_induction_training'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['user_type'] = categoryId.toString();
      request.fields['project_id'] = projectId.toString();
      request.fields['contractor_id'] = addContractorController.userFound.value
          ? addContractorController.contactorId.toString()
          : '';
      request.fields['new_user'] = newUser.toString();
      request.fields['contractor_company_name'] =
          addContractorController.contractorfirmnameController.text;

      request.fields['gstn_number'] =
          addContractorController.gstnController.text;
      request.fields['reason_of_visit'] =
          addContractorController.selectedReasonId.toString();

      request.fields['contractor_name'] =
          contractorDetailsController.nameController.text;
      request.fields['contractor_email'] =
          contractorDetailsController.emailidController.text;
      request.fields['secondary_name'] =
          contractorDetailsController.secondarynameController.text;
      request.fields['secondary_contact_number'] =
          contractorDetailsController.secondarycontactController.text;
      request.fields['contractor_phone_no'] =
          contractorDetailsController.contactnoController.text;
      request.fields['document_type'] =
          contractorDetailsController.selectedIdProofId.value.toString();
      request.fields['id_number'] =
          contractorDetailsController.idproofController.text;

      request.fields['signature_flag'] =
          // ignore: unnecessary_null_comparison
          serviceUndertakingController.signatureFile != null ? "1" : "0";

      request.fields['signature_behalf_of'] =
          serviceUndertakingController.checkboxValueBehalf.toString();
      for (int i = 0;
          i < serviceUndertakingController.filteredDetailsUndertaking.length;
          i++) {
        request.fields['undertaking_instruction_${i + 1}'] =
            serviceUndertakingController.filteredDetailsUndertaking[i]
                    ['isChecked']
                ? '1'
                : '0';
      }

      request.fields['user_id'] = userId.toString();
      request.fields['user_name'] = userName.toString();
      request.fields['location'] = locationController.locationString.value;
      request.fields['validity'] =
          contractorDetailsController.validityController.text;

      for (int i = 0;
          i < serviceDetailsController.selectActivityIdList.length;
          i++) {
        request.fields['activity_id[$i]'] =
            serviceDetailsController.selectActivityIdList[i].toString();
      }
      for (int i = 0;
          i < serviceDetailsController.selectSubActivityIdList.length;
          i++) {
        request.fields['sub_activity_id[$i]'] =
            serviceDetailsController.selectSubActivityIdList[i].toString();
      }

      // if (contractorDetailsController.docImg.isNotEmpty) {
      //   var image = contractorDetailsController.docImg.first;

      //   if (image.path.isNotEmpty && File(image.path).existsSync()) {
      //     log("File exists, attaching: ${image.path}");

      //     request.files.add(await http.MultipartFile.fromPath(
      //       'document_photo',
      //       image.path,
      //     ));
      //   } else {
      //     log("File not found: ${image.path}");
      //   }
      // } else {
      //   log("No image available to upload");
      // }

      request.files.add(await http.MultipartFile.fromPath(
        'document_photo',
        contractorDetailsController.docImg.first.path,
      ));
      //
      request.files.add(await http.MultipartFile.fromPath(
        'wc_policy',
        contractorDetailsController.wcPolicyFile.first.path,
      ));


      request.files.add(await http.MultipartFile.fromPath(
        'work_permit',
        contractorDetailsController.workPermitFile.first.path,
      ));


      request.files.add(await http.MultipartFile.fromPath(
        'signature_photo',
        serviceUndertakingController.signatureFile.path,
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

              // await showDialog(
              //   context: Get.context!,
              //   builder: (BuildContext context) {
              //     return ValidationPopChang(message: validationmsg);
              //   },
              // );
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
}
