import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_detailsAll/incide_report_details_all_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class IncidentReportDetailsAllController extends GetxController {
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
  List<SafetyIncidentReport> safetyIncidentReport = [];
  List<SeverityLevel> severityLevel = [];
  List<FloorAreaOfWork> floorAreaOfWork = [];
  List<ContractorCompany> contractorCompany = [];
  List<BuildingList> buildingList = [];
  List<InvolvedList> involvedLaboursList = [];
  Map<String, Staff> involvedStaffList = {};
  Map<String, InvolvedContractorUserList> involvedContractorUserList = {};
  List<InformedPersonsList> informedPersonsList = [];
  List<PreventionMeasure> preventionMeasures = [];
  List<Photo> photos = [];
  List<AsgineUserList> asgineeUserList = [];
  List<AsgineUserList> asginerUserList = [];
  List<AsgineeAddPhoto> asgineeAddPhotos = [];

  Future getIncidentReportAllDetails(projcetId, userId, userType, iRId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
        "incident_report_id": iRId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_incident_report_selected_details', map);
      var data = await responseData['data'];
      log("Request body: $data");

      //-------------------------------------------------
      safetyIncidentReport = (await data['safety_incident_report']
              as List<dynamic>)
          .map((e) => SafetyIncidentReport.fromJson(e as Map<String, dynamic>))
          .toList();
      severityLevel = (data['severity_level'] as List<dynamic>)
          .map((e) => SeverityLevel.fromJson(e))
          .toList();

      floorAreaOfWork = (data['floor_area_of_work'] as List<dynamic>)
          .map((e) => FloorAreaOfWork.fromJson(e))
          .toList();

      contractorCompany = (data['contractor_company'] as List<dynamic>)
          .map((e) => ContractorCompany.fromJson(e))
          .toList();

      buildingList = (data['building_list'] as List<dynamic>)
          .map((e) => BuildingList.fromJson(e))
          .toList();

      involvedLaboursList = (data['involved_labours_list'] as List<dynamic>)
          .map((e) => InvolvedList.fromJson(e))
          .toList();

      involvedStaffList = {};
      if (data['involved_staff_list'] is Map<String, dynamic>) {
        involvedStaffList =
            (data['involved_staff_list'] as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, Staff.fromJson(value)));
      }

      // Safely parse involved_contractor_user_list (handles null)
      involvedContractorUserList = {};
      if (data['involved_contractor_user_list'] is Map<String, dynamic>) {
        involvedContractorUserList =
            (data['involved_contractor_user_list'] as Map<String, dynamic>).map(
                (key, value) =>
                    MapEntry(key, InvolvedContractorUserList.fromJson(value)));
      }

      preventionMeasures = (data['prevention_measures'] as List<dynamic>)
          .map((e) => PreventionMeasure.fromJson(e))
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
      } else {
        incidentAssigneeAllController.text = '';
      }
      incidentAssigneeAssignorController.text =
          safetyIncidentReport[0].assignerComment.toString();
      log('safetyIncidentReport count: ${safetyIncidentReport.length}');
      log('severityLevel count: ${severityLevel.length}');
      log('floorAreaOfWork count: ${floorAreaOfWork.length}');
      log('contractorCompany count: ${contractorCompany.length}');
      log('buildingList count: ${buildingList.length}');
      log('involvedLaboursList count: ${involvedLaboursList.length}');
      log('involvedStaffList keys count: ${involvedStaffList.length}');
      log('involvedContractorUserList keys count: ${involvedContractorUserList.length}');
      log('informedPersonsList count: ${informedPersonsList.length}');
      log('preventionMeasures count: ${preventionMeasures.length}');
      log('photos count: ${photos.length}');
      log('asgineeUserList count: ${asgineeUserList.length}');
      log('asginerUserList count: ${asginerUserList.length}');
      log('asgineeAddPhotos count: ${asgineeAddPhotos.length}');
    } catch (e) {
      print("Error: $e");
    }
  }

  void resetData() {
    safetyIncidentReport.clear();
    severityLevel.clear();
    floorAreaOfWork.clear();
    contractorCompany.clear();
    buildingList.clear();
    involvedLaboursList.clear();
    involvedStaffList.clear(); // Clears the map
    involvedContractorUserList.clear(); // Clears the map
    informedPersonsList.clear();
    preventionMeasures.clear();
    photos.clear();
    asgineeUserList.clear();
    asginerUserList.clear();
    asgineeAddPhotos.clear();
    incidentAssigneeAllController.clear();
    incidentReportController.clear();
    incidentAssigneeAssignorController.clear();
  }

  TextEditingController incidentReportController = TextEditingController();
  TextEditingController incidentAssigneeAllController = TextEditingController();
  TextEditingController incidentAssigneeAssignorController =
      TextEditingController();
}
