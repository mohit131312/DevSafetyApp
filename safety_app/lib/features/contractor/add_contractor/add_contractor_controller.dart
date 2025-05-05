import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/contractor/contractor_details/contractor_details_controller.dart';
import 'package:flutter_app/features/contractor/service_details/service_details_controller.dart';
import 'package:flutter_app/features/contractor/service_undertaking/service_undertaking_controller.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/match_user_contractor.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';

class AddContractorController extends GetxController {
  var userFound = false.obs;

  final ContractorDetailsController contractorDetailsController =
      Get.put(ContractorDetailsController());
  final ServiceDetailsController serviceDetailsController =
      Get.put(ServiceDetailsController());
  final ServiceUndertakingController serviceUndertakingController =
      Get.put(ServiceUndertakingController());

//----------------------------------------------------------------------
  TextEditingController contractorfirmnameController = TextEditingController();
  var contractorfirmnameFocusNode = FocusNode();

  //------------------------------------
  TextEditingController gstnController = TextEditingController();
  var gstnFocusNode = FocusNode();

  var selectedreasons = ''.obs;
  var selectedReasonId = 0.obs;

  //---------------------------------------------
  var selectedContractorgrp = ''.obs; // Observable for Blood Group selection
  final List<String> contractorgrp = [
    'A+',
    'A-',
    'B+',
    'B-',
  ];

  var selectedServiceArea = ''.obs; // Observable for Blood Group selection
  final List<String> serviceArea = [
    'A+',
    'A-',
    'B+',
    'B-',
  ];

  //---------------------------------------------
  TextEditingController searchController = TextEditingController();
  var searchFocusNodeAll = FocusNode();
  var searchResults = <Map<String, dynamic>>[].obs;
  var selectedContractorDetails = <String, dynamic>{}.obs;
  int contactorId = 1;

  String validationmsg = '';
  Future<void> getSafetyContractorMatchedDetails(
      String id, BuildContext context) async {
    try {
      Map<String, dynamic> map = {"contractor_company_name": id};
      print("Request body: $map");

      var responseData =
          await globApiCall('get_safety_contractors_firm_list', map);
      log('API Response: ${responseData}');

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('data')) {
        var data = await responseData['data'];

        if (data is Map<String, dynamic> && data.isNotEmpty) {
          searchResults.assignAll(data.values
              .map((contractor) => contractor as Map<String, dynamic>)
              .toList());

          log('------searchResults---------${searchResults.length}');

          if (searchResults.length > 1) {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const MatchUserContractor();
              },
            );

            if (selectedContractorDetails.isNotEmpty) {
              contractorfirmnameController.text =
                  await selectedContractorDetails['contractor_company_name'] ??
                      '';
              contactorId = await selectedContractorDetails['contractor_id'];
              contractorfirmnameController.text =
                  await selectedContractorDetails['contractor_company_name'] ??
                      '';
              gstnController.text =
                  await selectedContractorDetails['gstn_number'] ?? '';

              contractorDetailsController.nameController.text =
                  await selectedContractorDetails['contractor_name'] ?? '';
              contractorDetailsController.emailidController.text =
                  await selectedContractorDetails['contractor_email'] ?? '';
              contractorDetailsController.contactnoController.text =
                  await selectedContractorDetails['contractor_phone_no'] ?? '';
              contractorDetailsController.secondarynameController.text =
                  await selectedContractorDetails[
                          'secondary_contact_person_name'] ??
                      '';
              contractorDetailsController.secondarycontactController.text =
                  await selectedContractorDetails[
                          'secondary_contact_person_number'] ??
                      '';
              serviceDetailsController.activityExist =
                  await selectedContractorDetails['activities'] ?? '';
              List<dynamic> activities =
                  selectedContractorDetails['activities'] ?? [];

              if (activities.isNotEmpty) {
                serviceDetailsController.selectActivityIdList.clear();
                serviceDetailsController.selectSubActivityIdList.clear();

                for (var activity in activities) {
                  serviceDetailsController.selectActivityIdList
                      .add(activity['activity_id'].toString());
                  serviceDetailsController.selectSubActivityIdList
                      .add(activity['sub_activity_id'].toString());
                }

                log('Activity ID List: ${serviceDetailsController.selectActivityIdList}');
                log('Sub-Activity ID List: ${serviceDetailsController.selectSubActivityIdList}');
              }

              log('------serviceDetailsController.activityExist---------${serviceDetailsController.activityExist.length}');
              userFound.value = true;
            }
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomLoadingPopup());

            selectedContractorDetails.value = searchResults.first;
            if (selectedContractorDetails.isNotEmpty) {
              contractorfirmnameController.text =
                  await selectedContractorDetails['contractor_company_name'] ??
                      '';
              contactorId = await selectedContractorDetails['contractor_id'];

              gstnController.text =
                  await selectedContractorDetails['gstn_number'] ?? '';

              contractorDetailsController.nameController.text =
                  await selectedContractorDetails['contractor_name'] ?? '';
              contractorDetailsController.emailidController.text =
                  await selectedContractorDetails['contractor_email'] ?? '';
              contractorDetailsController.contactnoController.text =
                  await selectedContractorDetails['contractor_phone_no'] ?? '';
              contractorDetailsController.secondarynameController.text =
                  await selectedContractorDetails[
                          'secondary_contact_person_name'] ??
                      '';
              contractorDetailsController.secondarycontactController.text =
                  await selectedContractorDetails[
                          'secondary_contact_person_number'] ??
                      '';
              serviceDetailsController.activityExist =
                  await selectedContractorDetails['activities'] ??
                      ''; // Extract activities
              List<dynamic> activities =
                  selectedContractorDetails['activities'] ?? [];

              if (activities.isNotEmpty) {
                serviceDetailsController.selectActivityIdList.clear();
                serviceDetailsController.selectSubActivityIdList.clear();

                for (var activity in activities) {
                  serviceDetailsController.selectActivityIdList
                      .add(activity['activity_id'].toString());
                  serviceDetailsController.selectSubActivityIdList
                      .add(activity['sub_activity_id'].toString());
                }

                log('Activity ID List: ${serviceDetailsController.selectActivityIdList}');
                log('Sub-Activity ID List: ${serviceDetailsController.selectSubActivityIdList}');
              }

              log('------serviceDetailsController.activityExist---------${serviceDetailsController.activityExist.length}');
              userFound.value = true;
            }
            userFound.value = true;

            Navigator.pop(context);
          }
        } else {
          searchResults.clear();
        }
      } else {
        searchResults.clear();
      }

      if (responseData.containsKey('validation-message')) {
        Map<String, dynamic> validationErrors =
            responseData['validation-message'];

        validationmsg = validationErrors.entries
            .map((entry) => '${entry.value.join(", ")}')
            .join("\n\n");

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomValidationPopup(message: validationmsg);
          },
        );
      } else {
        validationmsg = responseData['message'] ?? 'No message received';

        print('Success message: $validationmsg');

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomValidationPopup(message: validationmsg);
          },
        );

        if (validationmsg == 'Contractor company name not found') {
          clearUserFieldsFinalContractor();
        }
      }
    } catch (e) {
      log("Error: $e");
      userFound.value = false;
      clearUserFieldsFinalContractor();
      searchResults.clear();
    }
  }

//-------------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  void clearUserFieldsFinalContractor() {
    contractorfirmnameController.clear();
    gstnController.clear();
    selectedReasonId.value = 0;
    selectedreasons.value = '';
    contactorId = 0;
    userFound.value = false;

    print(" Add Contractor Data Cleared");

    /// Clear Contractor Details
    contractorDetailsController.nameController.clear();
    contractorDetailsController.emailidController.clear();
    contractorDetailsController.contactnoController.clear();
    contractorDetailsController.secondarynameController.clear();
    contractorDetailsController.secondarycontactController.clear();
    contractorDetailsController.idproofController.clear();
    contractorDetailsController.selectedIdProofId.value = 0;
    contractorDetailsController.selectedDoctType.value = '';
    contractorDetailsController.docImg.clear();
    contractorDetailsController.docImgCount.value = 0;
    contractorDetailsController.validityController.clear();
    print(" Contractor Details Cleared");

    serviceDetailsController.selectActivityIdList.clear();
    serviceDetailsController.selectSubActivityIdList.clear();
    serviceDetailsController.activityExist.clear();
    serviceDetailsController.selectedactivity.value = '';
    serviceDetailsController.selectedActivityId.value = 0;
    serviceDetailsController.selectedSubactivity.value = '';
    serviceDetailsController.selectedSubActivityId.value = 0;
    // Clear selected lists
    serviceDetailsController.selectActivityList.clear();
    serviceDetailsController.selectSubActivityList.clear();
    contractorDetailsController.secondarycontactController.clear();
    contractorDetailsController.secondarynameController.clear();
    print(" Service Details Cleared");

    serviceUndertakingController.clearContactorAllCheckboxes();

    for (var item in serviceUndertakingController.filteredDetailsUndertaking) {
      item['isChecked'] = false;
    }

    print(" Service Undertaking Cleared");

    log("🔄 All data cleared successfully.");
  }
}
