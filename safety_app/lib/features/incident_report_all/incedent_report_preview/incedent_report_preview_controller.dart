import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_attestation/incident_attestation_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_details/incident_details_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_more_details/incident_more_details_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_assigne/select_assigne_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_informed_people/select_informed_people_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_injured/select_injured_controller.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class IncedentReportPreviewController extends GetxController {
  var isincidentdetailsDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionIncedenet() {
    isincidentdetailsDetailsExpanded.value =
        !isincidentdetailsDetailsExpanded.value;
  }

  var isinvolvepeople = true.obs; // Observable to track expansion state

  void toggleExpansionpeople() {
    isinvolvepeople.value = !isinvolvepeople.value;
  }

  var isinformedpeople = true.obs; // Observable to track expansion state

  void toggleInformedExpansionpeople() {
    isinformedpeople.value = !isinformedpeople.value;
  }

  var isprecautionDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionPrecaution() {
    isprecautionDetailsExpanded.value = !isprecautionDetailsExpanded.value;
  }

  ScrollController scrollLabourController = ScrollController();
  ScrollController scrollStaffController = ScrollController();
  ScrollController scrollContractorController = ScrollController();
  ScrollController scrollAssigneeInformedController = ScrollController();

  @override
  void dispose() {
    scrollLabourController.dispose();
    scrollStaffController.dispose();
    scrollContractorController.dispose();
    scrollAssigneeInformedController.dispose();

    super.dispose();
  }

  final IncidentReportController incidentReportController = Get.find();
  final IncidentDetailsController incidentDetailsController = Get.find();
  final IncidentMoreDetailsController incidentMoreDetailsController =
      Get.find();
  final SelectInformedIncidentController selectInformedIncidentController =
      Get.find();
  final SelectInjuredController selectInjuredController = Get.find();
  final SelectAssigneController selectAssigneController = Get.find();
  final IncidentAttestationController incidentAttestationController =
      Get.find();
  final LocationController locationController = Get.find();
  String validationmsg = '';

  Future<void> safetySaveIncidentReport(
      BuildContext c, userName, userId, projectId) async {
    // var firstSelectedAssignee = await selectSafetyAssigneeController
    //         .selectedassigneeDataIdsFinal.isNotEmpty
    //     ? selectSafetyAssigneeController.selectedassigneeDataIdsFinal[0]
    //     : null;

    //   selectSafetyInformedPeopleController.convertAssigneeIdsToMap();

    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());

      int assigneeId =
          await selectAssigneController.selectedassigneeDataIdsFinal[0];
      print("User ID: ${userId.toString()}");
      print("User Name: ${userName.toString()}");
      print(" assigneeId: ${assigneeId.toString()}");
      // print("Labour ID: ${addLabourController.labourId.toString()}");
      // print("firstSelectedAssignee ID: ${firstSelectedAssignee.toString()}");
      var request = await http.MultipartRequest("POST",
          Uri.parse('${RemoteServices.baseUrl}save_safety_incident_report'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['project_id'] = projectId.toString();
      request.fields['building_id'] =
          incidentDetailsController.selectBuildingId.toString();
      request.fields['floor_id'] =
          incidentDetailsController.selectFloorId.toString();

      request.fields['contractor_company_id'] =
          incidentDetailsController.selectCompanyId.toString();

      request.fields['incident_details'] =
          incidentDetailsController.incidentController.text;
      request.fields['severity_level_id'] =
          incidentDetailsController.selectSeverityId.toString();

      request.fields['assignee_id'] = assigneeId.toString();
      request.fields['assigner_id'] = userId.toString();
      //request.fields['assigner_id'] = '53';
      request.fields['user_id'] = userId.toString();
      // request.fields['user_name'] = userName.toString();
      request.fields['location'] = locationController.locationString.value;
      request.fields['root_cause'] =
          incidentMoreDetailsController.rootcauseController.text;
      for (int i = 0;
          i < selectInjuredController.combinedIncidentIdsFinal.length;
          i++) {
        request.fields['involved_person_list[$i]'] =
            jsonEncode(selectInjuredController.combinedIncidentIdsFinal[i]);
      }
      print("Final request fields: ${request.fields}");
      for (int i = 0;
          i < incidentMoreDetailsController.selectedIncidentMeasuresList.length;
          i++) {
        request.fields['prevention_measures[$i]'] = jsonEncode(
            incidentMoreDetailsController.selectedIncidentMeasuresList[i]);
      }
      print("Final request fields: ${request.fields}");

      for (int i = 0;
          i <
              selectInformedIncidentController
                  .selectedAssIncidentIdsFinalMap.length;
          i++) {
        request.fields['informed_person_list[$i]'] = jsonEncode(
            selectInformedIncidentController.selectedAssIncidentIdsFinalMap[i]);
      }
      print("Finalinformed_person_list request fields: ${request.fields}");

      for (var image in incidentDetailsController.incidentimg) {
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
        incidentAttestationController.signatureFile.path,
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

  void clearData() {
    incidentDetailsController.incidentController.clear();
    incidentDetailsController.selectBuildingId.value = 0;
    incidentDetailsController.selectBuilding.value = '';
    incidentDetailsController.selectFloorId.value = 0;
    incidentDetailsController.selectFloor.value = '';
    incidentDetailsController.selectCompanyId.value = 0;
    incidentDetailsController.selectCompany.value = '';
    incidentDetailsController.selectSeverityId.value = 0;
    incidentDetailsController.selectSeverity.value = '';
    incidentDetailsController.incidentimg.clear();

    incidentMoreDetailsController.rootcauseController.clear();
    incidentMoreDetailsController.selectedIncidentMeasuresList.clear();
    incidentMoreDetailsController.selectedMoreIncidentIds.clear();

    selectInjuredController.combinedIncidentIdsFinal.clear();

    selectInformedIncidentController.selectedAssIncidentIdsFinalMap.clear();
    selectInformedIncidentController.selectedAssIncidentIdsFinal.clear();

    selectAssigneController.selectedassigneeDataIdsFinal.clear();

    // Clear signature
    incidentAttestationController.signatureFile = File('');

    // Log data clearance
    log("Incident Report Preview data cleared.");
  }
}
