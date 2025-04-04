import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/Labour_add/add_labour_controller.dart';
import 'package:flutter_app/features/labour_precaution/labour_precaution_controller.dart';
import 'package:flutter_app/features/labour_professional_details/labour_profess_details_controller.dart';
import 'package:flutter_app/features/labour_undertaking/labour_undertaking_controller.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../labour_documentation/labour_documentation_controller.dart';

class LabourPreviewController extends GetxController {
  final LabourUndertakingController labourUndertakingController = Get.find();
  final LabourDocumentationController labourDocumentationController =
      Get.find();
  final AddLabourController addLabourController = Get.find();
  final LabourProfessDetailsController labourProfessDetailsController =
      Get.find();

  final LabourPrecautionController labourPrecautionController = Get.find();
  var isPersonalDetailsExpanded = true.obs;

  void toggleExpansion() {
    isPersonalDetailsExpanded.value = !isPersonalDetailsExpanded.value;
  }

  var isProfessionalDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionProfessional() {
    isProfessionalDetailsExpanded.value = !isProfessionalDetailsExpanded.value;
  }

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

  String validationmsg = '';

  //-----------------------------------------------------------------

  Future<void> safetySaveLabour(
      BuildContext c, categoryId, userName, userId, projectId) async {
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());
      int newUser = addLabourController.userFound.value ? 0 : 1;
      print("User ID: ${userId.toString()}");
      print("User Name: ${userName.toString()}");
      print("Labour ID: ${addLabourController.labourId.toString()}");
      var request = await http.MultipartRequest(
          "POST",
          Uri.parse(
              '${RemoteServices.baseUrl}safety_save_labour_induction_training'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['user_type'] = categoryId.toString();
      request.fields['project_id'] = projectId.toString();
      request.fields['new_user'] = newUser.toString();
      request.fields['labour_name'] =
          addLabourController.labournameController.text;
      request.fields['gender'] = addLabourController.selectedGenderLabel;
      request.fields['literacy'] = addLabourController.selectedLiteratre.value;

      request.fields['marital_status'] =
          addLabourController.selectedmarried.value;

      request.fields['blood_group'] =
          addLabourController.selectedBloodGroup.value;

      request.fields['birth_date'] = addLabourController.dateController.text;
      request.fields['age'] = addLabourController.age.toString();
      request.fields['contact_number'] =
          addLabourController.contactnumberController.text;
      request.fields['adhaar_card_no'] =
          labourDocumentationController.adharnoController.text;
      // request.fields['contact_number'] =
      //     addLabourController.contactnumberController.text;
      // request.fields['adhaar_card_no'] =
      //     labourDocumentationController.adharnoController.text;
      request.fields['current_street_name'] =
          addLabourController.addressControllers[0].text;

      request.fields['current_city'] =
          addLabourController.addressControllers[1].text;
      request.fields['current_taluka'] =
          addLabourController.addressControllers[2].text;
      request.fields['current_district'] =
          addLabourController.selectedDistrictId.toString();
      request.fields['current_state'] =
          addLabourController.selectedStateId.toString();
      request.fields['current_pincode'] =
          addLabourController.addressControllers[3].text;
      request.fields['permanent_street_name'] =
          addLabourController.permanantAddressController[0].text;
      request.fields['permanent_city'] =
          addLabourController.permanantAddressController[1].text;
      request.fields['permanent_taluka'] =
          addLabourController.permanantAddressController[2].text;
      request.fields['permanent_district'] =
          addLabourController.selectedPermanantDistrictId.toString();
      ;
      request.fields['permanent_state'] =
          addLabourController.selectedPermanantStateId.toString();
      request.fields['permanent_pincode'] =
          addLabourController.permanantAddressController[3].text;
      request.fields['experience_in_years'] =
          labourProfessDetailsController.selectedyoe.value.toInt().toString();
      request.fields['trade'] =
          labourProfessDetailsController.selectedTradeId.value.toString();
      request.fields['skill_level'] =
          labourProfessDetailsController.selectedSkillLevel.value;

      request.fields['contractor_firm_id'] =
          labourProfessDetailsController.selectedContractorId.value.toString();

      print(
          "Document Type Length: ${labourDocumentationController.documentType.length}");
      print(
          "ID Number Length: ${labourDocumentationController.idNumber.length}");
      print(
          "Validity Length: ${labourDocumentationController.validity.length}");
      for (int i = 0;
          i < labourDocumentationController.documentType.length;
          i++) {
        request.fields['document_type[$i]'] =
            labourDocumentationController.documentType[i];
        print(labourDocumentationController.documentType[i]);
      }

      for (int i = 0; i < labourDocumentationController.idNumber.length; i++) {
        request.fields['id_number[$i]'] =
            labourDocumentationController.idNumber[i];
        print(labourDocumentationController.idNumber[i]);
      }

      for (int i = 0; i < labourDocumentationController.validity.length; i++) {
        request.fields['validity[$i]'] =
            labourDocumentationController.validity[i];
        print(labourDocumentationController.validity[i]);
      }

      request.fields['signature_flag'] =
          // ignore: unnecessary_null_comparison
          labourUndertakingController.signatureFile != null ? "1" : "0";

      request.fields['signature_behalf_of'] =
          labourUndertakingController.checkboxValueBehalf.toString();
      for (int i = 0;
          i < labourUndertakingController.filteredDetailsUndertaking.length;
          i++) {
        request.fields['undertaking_instruction_${i + 1}'] =
            labourUndertakingController.filteredDetailsUndertaking[i]
                    ['isChecked']
                ? '1'
                : '0';
      }

      request.fields['user_id'] = userId.toString();
      request.fields['user_name'] = userName.toString();
      request.fields['location'] = "pune";

      for (int i = 0;
          i < labourPrecautionController.selectedItemIds.length;
          i++) {
        request.fields['equipment_list[$i]'] =
            labourPrecautionController.selectedItemIds[i].toInt().toString();
      }

      for (int i = 0;
          i < labourPrecautionController.selectedItemInstruction.length;
          i++) {
        request.fields['instruction_list[$i]'] = labourPrecautionController
            .selectedItemInstruction[i]
            .toInt()
            .toString();
      }
      request.fields['emergency_contact_name'] =
          addLabourController.econtactnameController.text;
      request.fields['emergency_contact_number'] =
          addLabourController.econtactnumberController.text;
      request.fields['emergency_contact_relation'] =
          addLabourController.econtactrelationController.text;
      request.fields['labour_id'] = addLabourController.labourId.toString();
      request.fields['reason_of_visit'] =
          addLabourController.selectedReasonId.toString();

      if (addLabourController.profilePhoto.value.isNotEmpty) {
        log("Adding profile photo: ${addLabourController.profilePhoto.value}");

        request.files.add(await http.MultipartFile.fromPath(
          'profile_photo',
          addLabourController.profilePhoto.value,
        ));
      }

      for (var image in labourDocumentationController.labourimg) {
        if (image.path.isNotEmpty && File(image.path).existsSync()) {
          log("File exists, attaching: ${image.path}");

          request.files.add(await http.MultipartFile.fromPath(
            'document_photo[]',
            image.path,
          ));
        } else {
          log(" File not found: ${image.path}");
        }
      }

      request.files.add(await http.MultipartFile.fromPath(
        'signature_photo',
        labourUndertakingController.signatureFile.path,
      ));

      log("Final Request Fields: ${jsonEncode(request.fields)}");
      log("Final Request Files: ${request.files.map((file) => file.filename).toList()}"); // ✅ Correct way to log files

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

  void clear() {
    addLabourController.labournameController.clear();
    addLabourController.dateController.clear();
    addLabourController.econtactnameController.clear();
    addLabourController.econtactnumberController.clear();
    addLabourController.econtactrelationController.clear();
    // addLabourController.selectedGenderLabel =0;
    addLabourController.selectedLiteratre.value = '';
    addLabourController.selectedmarried.value = '';
    addLabourController.selectedBloodGroup.value = '';
    addLabourController.selectedDistrictId.value = 0;
    addLabourController.selectedStateId.value = 0;
    addLabourController.selectedPermanantDistrictId.value = 0;
    addLabourController.selectedPermanantStateId.value = 0;
    addLabourController.selectedReasonId.value = 0;
    addLabourController.profilePhoto.value = '';

    for (var controller in addLabourController.addressControllers) {
      controller.clear();
    }
    for (var controller in addLabourController.permanantAddressController) {
      controller.clear();
    }

    // Clearing LabourProfessDetailsController fields
    labourProfessDetailsController.selectedyoe.value = 0;
    labourProfessDetailsController.selectedTradeId.value = '';
    labourProfessDetailsController.selectedSkillLevel.value = '';
    labourProfessDetailsController.selectedContractorId.value = '';

    // Clearing LabourPrecautionController fields
    labourPrecautionController.selectedItemIds.clear();
    labourPrecautionController.selectedItemInstruction.clear();

    // Clearing LabourUndertakingController fields
    labourUndertakingController.signatureFile = File('');
    labourUndertakingController.checkboxValueBehalf = 0;
    for (var undertaking
        in labourUndertakingController.filteredDetailsUndertaking) {
      undertaking['isChecked'] = false;
      labourUndertakingController.isCheckedUndertaking.value = false;
    }

    // Clearing LabourDocumentationController fields
    labourDocumentationController.documentType.clear();
    labourDocumentationController.idNumber.clear();
    labourDocumentationController.validity.clear();
    labourDocumentationController.labourimg.clear();
    labourDocumentationController.documentType.assignAll([]);
    labourDocumentationController.idNumber.assignAll([]);
    labourDocumentationController.validity.assignAll([]);
    labourDocumentationController.labourimg.assignAll([]);

    log("All fields cleared successfully!");
  }
}
