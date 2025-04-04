import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/staff/staff_add/add_staff_controller.dart';
import 'package:flutter_app/features/staff/staff_documentation/staff_documentation_controller.dart';
import 'package:flutter_app/features/staff/staff_precaution/staff_precaution_controller.dart';
import 'package:flutter_app/features/staff/staff_undertaking/staff_undertaking_controller.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StaffPreviewController extends GetxController {
  final StaffUndertakingController staffUndertakingController = Get.find();
  final StaffDocumentationController staffDocumentationController = Get.find();
  final AddStaffController addStaffController = Get.find();

  final StaffPrecautionController staffPrecautionController = Get.find();
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

  Future<void> safetySaveStaff(
      BuildContext c, categoryId, userName, userId, projectId) async {
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());
      int newUser = addStaffController.userFound.value ? 0 : 1;
      print("User ID: ${userId.toString()}");
      print("User Name: ${userName.toString()}");
      print("StaffID ID: ${addStaffController.staffID.toString()}");
      var request = await http.MultipartRequest(
          "POST",
          Uri.parse(
              '${RemoteServices.baseUrl}safety_save_staff_induction_training'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['user_type'] = categoryId.toString();
      request.fields['project_id'] = projectId.toString();
      request.fields['new_user'] = newUser.toString();
      request.fields['staff_name'] =
          addStaffController.staffnameController.text;
      request.fields['gender'] = addStaffController.selectedGenderLabel;
      request.fields['literacy'] = addStaffController.selectedLiteratre.value;

      request.fields['marital_status'] =
          addStaffController.selectedmarried.value;

      request.fields['blood_group'] =
          addStaffController.selectedBloodGroup.value;

      request.fields['birth_date'] = addStaffController.dateController.text;
      request.fields['age'] = addStaffController.age.toString();
      request.fields['contact_number'] =
          addStaffController.contactnumberController.text;
      request.fields['adhaar_card_no'] =
          staffDocumentationController.adharnoController.text;
      // request.fields['contact_number'] =
      //     addStaffController.contactnumberController.text;
      // request.fields['adhaar_card_no'] =
      //     staffDocumentationController.adharnoController.text;
      request.fields['current_street_name'] =
          addStaffController.addressControllers[0].text;

      request.fields['current_city'] =
          addStaffController.addressControllers[1].text;
      request.fields['current_taluka'] =
          addStaffController.addressControllers[2].text;
      request.fields['current_district'] =
          addStaffController.selectedDistrictId.toString();
      request.fields['current_state'] =
          addStaffController.selectedStateId.toString();
      request.fields['current_pincode'] =
          addStaffController.addressControllers[3].text;
      request.fields['permanent_street_name'] =
          addStaffController.permanantAddressController[0].text;
      request.fields['permanent_city'] =
          addStaffController.permanantAddressController[1].text;
      request.fields['permanent_taluka'] =
          addStaffController.permanantAddressController[2].text;
      request.fields['permanent_district'] =
          addStaffController.selectedPermanantDistrictId.toString();
      ;
      request.fields['permanent_state'] =
          addStaffController.selectedPermanantStateId.toString();
      request.fields['permanent_pincode'] =
          addStaffController.permanantAddressController[3].text;

      print(
          "Document Type Length: ${staffDocumentationController.documentType.length}");
      print(
          "ID Number Length: ${staffDocumentationController.idNumber.length}");
      print("Validity Length: ${staffDocumentationController.validity.length}");
      for (int i = 0;
          i < staffDocumentationController.documentType.length;
          i++) {
        request.fields['document_type[$i]'] =
            staffDocumentationController.documentType[i];
        print(staffDocumentationController.documentType[i]);
      }

      for (int i = 0; i < staffDocumentationController.idNumber.length; i++) {
        request.fields['id_number[$i]'] =
            staffDocumentationController.idNumber[i];
        print(staffDocumentationController.idNumber[i]);
      }

      for (int i = 0; i < staffDocumentationController.validity.length; i++) {
        request.fields['validity[$i]'] =
            staffDocumentationController.validity[i];
        print(staffDocumentationController.validity[i]);
      }

      request.fields['signature_flag'] =
          // ignore: unnecessary_null_comparison
          staffUndertakingController.signatureFile != null ? "1" : "0";

      request.fields['signature_behalf_of'] =
          staffUndertakingController.checkboxValueBehalf.toString();
      for (int i = 0;
          i < staffUndertakingController.filteredDetailsUndertaking.length;
          i++) {
        request.fields['undertaking_instruction_${i + 1}'] =
            staffUndertakingController.filteredDetailsUndertaking[i]
                    ['isChecked']
                ? '1'
                : '0';
      }

      request.fields['user_id'] = userId.toString();
      request.fields['user_name'] = userName.toString();
      request.fields['location'] = "pune";

      for (int i = 0;
          i < staffPrecautionController.selectedItemIds.length;
          i++) {
        request.fields['equipment_list[$i]'] =
            staffPrecautionController.selectedItemIds[i].toInt().toString();
      }

      for (int i = 0;
          i < staffPrecautionController.selectedItemInstruction.length;
          i++) {
        request.fields['instruction_list[$i]'] = staffPrecautionController
            .selectedItemInstruction[i]
            .toInt()
            .toString();
      }
      request.fields['emergency_contact_name'] =
          addStaffController.econtactnameController.text;
      request.fields['emergency_contact_number'] =
          addStaffController.econtactnumberController.text;
      request.fields['emergency_contact_relation'] =
          addStaffController.econtactrelationController.text;
      request.fields['staff_id'] = addStaffController.staffID.toString();
      request.fields['reason_of_visit'] =
          addStaffController.selectedReasonId.toString();

      if (addStaffController.profilePhoto.value.isNotEmpty) {
        log("Adding profile photo: ${addStaffController.profilePhoto.value}");

        request.files.add(await http.MultipartFile.fromPath(
          'profile_photo',
          addStaffController.profilePhoto.value,
        ));
      }

      for (var image in staffDocumentationController.staffimg) {
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
        staffUndertakingController.signatureFile.path,
      ));

      log("Final Request Fields: ${jsonEncode(request.fields)}");
      log("Final Request Files: ${request.files.map((file) => file.filename).toList()}"); //  Correct way to log files

      await request.send().then((response) async {
        log("Response Status Code: ${response.statusCode}");

        await http.Response.fromStream(response).then((onValue) async {
          try {
            Map<String, dynamic> decoded = jsonDecode(onValue.body);

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
              validationmsg = decoded['message'];
              log("----------------------------------------------------------------------msg: ");
              Navigator.pop(Get.context!, true);

              await showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return CustomValidationPopup(message: validationmsg);
                },
              );
              Get.back();

              // Get.to(StaffSubmit(
              //   userId: userId,
              //   userName: userName,
              //   projectId: projectId,
              // ));
            }
          } catch (e) {
            Navigator.pop(Get.context!, true);

            log("Error parsing response: $e");
          }
        });
      });
    } catch (e) {
      Navigator.pop(Get.context!, true);

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
    addStaffController.staffnameController.clear();
    addStaffController.dateController.clear();
    addStaffController.econtactnameController.clear();
    addStaffController.econtactnumberController.clear();
    addStaffController.econtactrelationController.clear();
    // addStaffController.selectedGenderLabel =0;
    addStaffController.selectedLiteratre.value = '';
    addStaffController.selectedmarried.value = '';
    addStaffController.selectedBloodGroup.value = '';
    addStaffController.selectedDistrictId.value = 0;
    addStaffController.selectedStateId.value = 0;
    addStaffController.selectedPermanantDistrictId.value = 0;
    addStaffController.selectedPermanantStateId.value = 0;
    addStaffController.selectedReasonId.value = 0;
    addStaffController.profilePhoto.value = '';

    for (var controller in addStaffController.addressControllers) {
      controller.clear();
    }
    for (var controller in addStaffController.permanantAddressController) {
      controller.clear();
    }

    // Clearing staffPrecautionController fields
    staffPrecautionController.selectedItemIds.clear();
    staffPrecautionController.selectedItemInstruction.clear();

    // Clearing staffUndertakingController fields
    staffUndertakingController.signatureFile = File('');
    staffUndertakingController.checkboxValueBehalf = 0;
    for (var undertaking
        in staffUndertakingController.filteredDetailsUndertaking) {
      undertaking['isChecked'] = false;
      staffUndertakingController.isCheckedUndertaking.value = false;
    }

    // Clearing staffDocumentationController fields
    staffDocumentationController.documentType.clear();
    staffDocumentationController.idNumber.clear();
    staffDocumentationController.validity.clear();
    staffDocumentationController.staffimg.clear();
    staffDocumentationController.documentType.assignAll([]);
    staffDocumentationController.idNumber.assignAll([]);
    staffDocumentationController.validity.assignAll([]);
    staffDocumentationController.staffimg.assignAll([]);

    log("All fields cleared successfully!");
  }
}
