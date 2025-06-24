import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_all/safety_violation_details_all_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class SafetyViolationDetailsCotroller extends GetxController {
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

  @override
  void dispose() {
    scrollLabourController.dispose();
    scrollStaffController.dispose();
    scrollContractorController.dispose();
    scrolldataController.dispose();
    super.dispose();
  }

  ScrollController scrollLabourController = ScrollController();
  ScrollController scrollStaffController = ScrollController();
  ScrollController scrollContractorController = ScrollController();
  ScrollController scrolldataController = ScrollController();

  List<ViolationDebitNote> violationDebitNote = [];
  List<Category> violationType = [];
  List<Category> category = [];
  List<Category> riskLevel = [];
  List<Category> sourceOfObservation = [];
  List<InvolvedLaboursList> involvedLaboursList = [];
  List<InvolvedStaffList> involvedstaffList = [];
  List<InvolvedContractorUserList> involvedContractorUserList = [];
  List<InformedPersonsList> informedPersonsList = [];
  List<Photo> photos = [];
  List<AsgineUserList> asgineeUserList = [];
  List<AsgineUserList> asginerUserList = [];
  List<AsgineeAddPhoto> asgineeAddPhotos = [];

  Future getSafetyViolationAllDetails(projcetId, userId, userType, iRId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
        "violation_debit_note_id": iRId,
      };

      log("Request body: $map");

      var responseData = await globApiCall(
          'get_safety_violation_debit_note_selected_details', map);
      var data = await responseData['data'];
      log("Request body: $data");

      //-------------------------------------------------
      violationDebitNote = (await data['violation_debit_note'] as List<dynamic>)
          .map((e) => ViolationDebitNote.fromJson(e as Map<String, dynamic>))
          .toList();
      violationType = (data['violation_type'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList();

      category = (data['category'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList();

      riskLevel = (data['risk_level'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList();

      sourceOfObservation = (data['source_of_observation'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList();

      involvedLaboursList = (data['involved_labours_list'] as List<dynamic>)
          .map((e) => InvolvedLaboursList.fromJson(e))
          .toList();
      involvedstaffList = (data['involved_staff_list'] as List<dynamic>)
          .map((e) => InvolvedStaffList.fromJson(e))
          .toList();

      // involvedStaffList = {};
      // if (data['involved_staff_list'] is Map<String, dynamic>) {
      //   involvedStaffList = (data['involved_staff_list']
      //           as Map<String, dynamic>)
      //       .map((key, value) => MapEntry(key, InvolvedStaff.fromJson(value)));
      // }
      involvedContractorUserList =
          (data['involved_contractor_user_list'] as List<dynamic>)
              .map((e) => InvolvedContractorUserList.fromJson(e))
              .toList();

      informedPersonsList = (data['informedPersonsList'] as List<dynamic>)
          .map((e) => InformedPersonsList.fromJson(e))
          .toList();

      photos = (data['photos'] as List<dynamic>)
          .map((e) => Photo.fromJson(e))
          .toList();

      asgineeUserList = (data['asginee_user_list'] as List<dynamic>)
          .map((e) => AsgineUserList.fromJson(e))
          .toList();

      asginerUserList = (data['asginer_user_list'] as List<dynamic>)
          .map((e) => AsgineUserList.fromJson(e))
          .toList();

      asgineeAddPhotos = (data['asginee_add_photos'] as List<dynamic>)
          .map((e) => AsgineeAddPhoto.fromJson(e))
          .toList();
      if (asgineeAddPhotos.isNotEmpty) {
        incidentAssigneeAllController.text =
            asgineeAddPhotos[0].assigneeComment.toString();
      }
      incidentAssigneeAssignorController.text =
          violationDebitNote[0].assignerComment.toString();

      log('violation_debit_note count: ${violationDebitNote.length}');
      log('violationType count: ${violationType.length}');
      log('category count: ${category.length}');
      log('riskLevel count: ${riskLevel.length}');
      log('involvedLaboursList count: ${involvedLaboursList.length}');
      log('involvedStaffList keys count: ${involvedstaffList.length}');
      log('involvedContractorUserList keys count: ${involvedContractorUserList.length}');
      log('informedPersonsList count: ${informedPersonsList.length}');
      log('photos count: ${photos.length}');
      log('asgineeUserList count: ${asgineeUserList.length}');
      log('asginerUserList count: ${asginerUserList.length}');
      // log('asgineeAddPhotos count: ${asgineeAddPhotos.length}');
    } catch (e) {
      print("Error: $e");
    }
  }

  TextEditingController incidentAssigneeAllController = TextEditingController();
  TextEditingController incidentAssigneeAssignorController =
      TextEditingController();

  //-------------------------

  void resetData() {
    // Clear text fields
    incidentAssigneeAllController.clear();
    incidentAssigneeAssignorController.clear();
    // Reset UI toggles
    isincidentdetailsDetailsExpanded.value = true;
    isinvolvepeople.value = true;
    isinformedpeople.value = true;
    isprecautionDetailsExpanded.value = true;
    // Clear lists and maps
    violationDebitNote.clear();
    violationType.clear();
    category.clear();
    riskLevel.clear();
    sourceOfObservation.clear();
    involvedLaboursList.clear();
    involvedstaffList.clear();
    involvedContractorUserList.clear();
    informedPersonsList.clear();
    photos.clear();
    asgineeUserList.clear();
    asginerUserList.clear();
    asgineeAddPhotos.clear();

    // Reset UI expansion toggles
    isincidentdetailsDetailsExpanded.value = true;
    isinvolvepeople.value = true;
    isinformedpeople.value = true;
    isprecautionDetailsExpanded.value = true;

    log("All data and form fields have been reset.");
  }
}
