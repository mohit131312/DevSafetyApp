import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class IncidentReportController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var searchQueryIncident = ''.obs;
  var incidentDetails = <Map<String, dynamic>>[].obs;
  var incidentfilteredDetails = <Map<String, dynamic>>[].obs;

  var selectedOption = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      selectedOption.value = tabController.index;
      print("Selected Tab Index: ${selectedOption.value}");
    });
    incidentDetails.value = incidentDetailData;
    incidentfilteredDetails.value = incidentDetailData;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  final List<Map<String, dynamic>> incidentDetailData = [
    {
      'text2': "Critical",
      'title': "Incident Report ID",
      "subtitle": "Incident detail",
      "text": "Open",
      'date': 'Creation Date',
    },
    {
      'text2': "Critical",
      'title': "Incident Report ID",
      "subtitle": "Incident detail",
      "text": "Open",
      'date': 'Creation Date',
    },
    {
      'text2': "Critical",
      'title': "Incident Report ID",
      "subtitle": "Incident detail",
      "text": "Open",
      'date': 'Creation Date',
    },
    {
      'text2': "Critical",
      'title': "Incident Report ID",
      "subtitle": "Incident detail",
      "text": "Open",
      'date': 'Creation Date',
    },
    {
      'text2': "Critical",
      'title': "Incident Report ID",
      "subtitle": "Incident detail",
      "text": "Open",
      'date': 'Creation Date',
    },
  ];

  void changeSelection(int index) {
    selectedOption.value = index;
    print("Selected option changed to: $index");
    applyFilters();
  }

  void searchLabor(String query) {
    searchQueryIncident.value = query;
    applyFilters();
  }

  /// **Apply both search and selection filters**
  void applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(incidentDetails);

    // **Search Filter**
    if (searchQueryIncident.value.isNotEmpty) {
      filtered = filtered
          .where((item) => item['title']!
              .toLowerCase()
              .contains(searchQueryIncident.value.toLowerCase()))
          .toList();
    }

    // **Status Filter**
    if (selectedOption.value == 1) {
      filtered = filtered.where((item) => item['text'] == "Open").toList();
    } else if (selectedOption.value == 2) {
      filtered = filtered.where((item) => item['text'] == "Closed").toList();
    } else if (selectedOption.value == 3) {
      filtered = filtered.where((item) => item['text'] == "Accepted").toList();
    }

    // **Update filtered list**
    incidentfilteredDetails.value = filtered;
  }

  //-------------------------------------------

  List<PreventionMeasure> severitylevelList = [];
  List<PreventionMeasure> preventionMeasuresList = [];
  List<ContractorCompany> contractorCompanyList = [];
  List<InvolvedList> involvedIncidentLaboursList = [];
  List<InvolvedStaffList> involvedIncidentStaffList = [];
  List<InvolvedContractorUserList> involvedIncidentContractorList = [];
  List<InformedAsgineeUserList> assigneeIncidentList = [];
  List<BuildingList> buildingList = [];

  Future getSafetyIncidentData(projcetId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_incident_report_primary_data', map);
      var data = await responseData['data'];
      //  log("Request body: $data");

      // //-------------------------------------------------
      severitylevelList = (await data['severity_level'] as List<dynamic>)
          .map((e) => PreventionMeasure.fromJson(e as Map<String, dynamic>))
          .toList();

      preventionMeasuresList = (data['prevention_measures'] as List<dynamic>)
          .map((e) => PreventionMeasure.fromJson(e as Map<String, dynamic>))
          .toList();
      contractorCompanyList = (data['contractor_company'] as List<dynamic>)
          .map((e) => ContractorCompany.fromJson(e as Map<String, dynamic>))
          .toList();

      involvedIncidentLaboursList =
          (data['involved_labours_list'] as List<dynamic>)
              .map((e) => InvolvedList.fromJson(e as Map<String, dynamic>))
              .toList();
      involvedIncidentStaffList = (data['involved_staff_list'] as List<dynamic>)
          .map((e) => InvolvedStaffList.fromJson(e as Map<String, dynamic>))
          .toList();
      involvedIncidentContractorList = (data['involved_contractor_user_list']
              as List<dynamic>)
          .map((e) =>
              InvolvedContractorUserList.fromJson(e as Map<String, dynamic>))
          .toList();
      assigneeIncidentList =
          (data['informed_asginee_user_list'] as List<dynamic>)
              .map((e) =>
                  InformedAsgineeUserList.fromJson(e as Map<String, dynamic>))
              .toList();
      buildingList = (data['building_list'] as List<dynamic>)
          .map((e) => BuildingList.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------severitylevelList${severitylevelList.length}');
      log('----------preventionMeasuresList${preventionMeasuresList.length}');
      log('----------contractorCompanyList${contractorCompanyList.length}');
      log('---------- Involved Labours List: ${(involvedIncidentLaboursList.length)}');
      log('---------- Involved Staff List: ${(involvedIncidentStaffList.length)}');
      log('---------- Involved Contactor: ${(involvedIncidentContractorList.length)}');
      log('----------=assigneeList: ${(assigneeIncidentList.length)}');
      log('----------=buildingList: ${(buildingList.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }
}
