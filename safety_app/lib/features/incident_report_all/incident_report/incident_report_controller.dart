import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_listing_model.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class IncidentReportController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var searchQueryIncident = ''.obs;
  var incidentDetails = <Map<String, dynamic>>[].obs;
  var incidentfilteredDetails = <Map<String, dynamic>>[].obs;
  TextEditingController activeController = TextEditingController();

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
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  //-------------------------------------------
  void resetAllLists() {
    severitylevelList.clear();
    preventionMeasuresList.clear();
    contractorCompanyList.clear();
    involvedIncidentLaboursList.clear();
    involvedIncidentStaffList.clear();
    involvedIncidentContractorList.clear();
    assigneeIncidentList.clear();
    buildingList.clear();

    print("All lists have been reset.");
  }

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

  //----------------------------------------------------------------------------
  RxList<IncidentReportList> incidentReportListingAll =
      <IncidentReportList>[].obs;

  Future getIncidentReportAllListing(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_incident_report_all_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      incidentReportListingAll.value = (await responseData['data']
              as List<dynamic>)
          .map((e) => IncidentReportList.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------=incidentReportListingAll: ${(incidentReportListingAll.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQueryIncidentAll = ''.obs;
  TextEditingController searchIncidentAllController = TextEditingController();
  TextEditingController searchIncidentAssignorController =
      TextEditingController();
  TextEditingController searchIncidentAssigneeController =
      TextEditingController();

  void updateSearchIncidentAllQuery(String query) {
    searchQueryIncidentAll.value = query;
  }

  List<IncidentReportList> get filteredIncidentAllList {
    final query = searchQueryIncidentAll.value.toLowerCase();
    return incidentReportListingAll
        .where((ind) =>
            ind.incidentDetails!.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  //----------------------------------------------------------------------------
  RxList<IncidentReportList> incidentReportListingAssignor =
      <IncidentReportList>[].obs;

  Future getIncidentReportAssignorListing(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_incident_report_all_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      // incidentReportListingAssignor.value = (await responseData['data']
      //         as List<dynamic>)
      //     .map((e) => IncidentReportList.fromJson(e as Map<String, dynamic>))
      //     .toList();

      incidentReportListingAssignor.value = (await responseData['data']
              as List<dynamic>)
          .map((e) => IncidentReportList.fromJson(e as Map<String, dynamic>))
          .where((item) => item.status != 0) // integer comparison
          .toList();

      log('----------=incidentReportListingAssignor: ${(incidentReportListingAssignor.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQueryIncidentAssignor = ''.obs;

  void updateSearchIncidentAssignorQuery(String query) {
    searchQueryIncidentAssignor.value = query;
  }

  List<IncidentReportList> get filteredIncidentAssignorList {
    final query = searchQueryIncidentAssignor.value.toLowerCase();
    return incidentReportListingAssignor
        .where((ind) =>
            ind.incidentDetails!.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  //-----------------------------------------------------
  RxList<IncidentReportList> incidentReportListingAssignee =
      <IncidentReportList>[].obs;

  Future getIncidentReportAssigneeListing(projcetId, userId, userType) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_incident_report_all_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      incidentReportListingAssignee.value = (await responseData['data']
              as List<dynamic>)
          .map((e) => IncidentReportList.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------=incidentReportListingAssignee: ${(incidentReportListingAssignee.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQueryIncidentAssignee = ''.obs;

  void updateSearchIncidentAssigneeQuery(String query) {
    searchQueryIncidentAssignee.value = query;
  }

  List<IncidentReportList> get filteredIncidentAssigneeList {
    final query = searchQueryIncidentAssignee.value.toLowerCase();
    return incidentReportListingAssignee
        .where((ind) =>
            ind.incidentDetails!.toLowerCase().contains(query) ||
            ind.id.toString().contains(query))
        .toList();
  }

  void handleSearchByTab(int index, String query) {
    if (index == 0) {
      searchQueryIncidentAll.value = query;
    } else if (index == 1) {
      searchQueryIncidentAssignor.value = query;
    } else if (index == 2) {
      searchQueryIncidentAssignee.value = query;
    }
  }

  void resetIncidentData() {
    // Clear all listings
    incidentReportListingAll.clear();
    incidentReportListingAssignor.clear();
    incidentReportListingAssignee.clear();

    // Reset search queries
    searchQueryIncidentAll.value = '';
    searchQueryIncidentAssignor.value = '';
    searchQueryIncidentAssignee.value = '';

    // Clear text fields
    searchIncidentAllController.clear();
    searchIncidentAssignorController.clear();
    searchIncidentAssigneeController.clear();

    log("Incident data reset completed.");
  }

  void clearSearchData() {
    // Clear text in all search controllers
    searchIncidentAllController.clear();
    searchIncidentAssignorController.clear();
    searchIncidentAssigneeController.clear();
    activeController.clear();
    // Reset search query variables
    searchQueryIncidentAll.value = '';
    searchQueryIncidentAssignor.value = '';
    searchQueryIncidentAssignee.value = '';
    // Notify UI of changes
    log('Search data cleared');
  }
}
