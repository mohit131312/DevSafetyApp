import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SafetyViolationDetailsController extends GetxController {
  var violationimg = <XFile>[];

  var violationImageCount = 0.obs;

  final maxPhotos = 5;

  Future<void> pickViolationImages() async {
    final ImagePicker picker = ImagePicker();

    if (violationimg.length < maxPhotos) {
      int remainingSlots = maxPhotos - violationimg.length;

      final List<XFile> pickedFiles = await picker.pickMultiImage();

      final List<XFile> limitedFiles =
          pickedFiles.take(remainingSlots).toList();

      violationimg.addAll(limitedFiles);
      violationImageCount.value = violationimg.length;

      log('-----------incidentImageCount------------$violationImageCount');
      log('-----------incidentimg-------------${violationimg.length}');
    }
  }

  void removeViolationImage(int index) {
    if (index >= 0 && index < violationimg.length) {
      violationimg.removeAt(index);
      violationImageCount.value = violationimg.length;

      log('Removed image at index $index from incidentimg. Remaining: ${violationImageCount.value}');
    }
  }

  ////////////
  ///

  var selectedidProoftype = ''.obs; // Observable for Blood Group selection
  final List<String> idprooftype = [
    'A+',
    'A-',
    'B+',
    'B-',
  ];
//----------------------------------------------
  @override
  void onInit() {
    super.onInit();
    filteredDetailsIncident.assignAll(checklistIncident);
    filteredDetailsAow.assignAll(checklistAow);
  }

  var selectedIncident = ''.obs;

  var searchQueryIncident = ''.obs;
  var filteredDetailsIncident = [].obs;
  final TextEditingController searchControllerIncident =
      TextEditingController();

  List<Map<String, dynamic>> getSelectedIncident() {
    return List<Map<String, dynamic>>.from(
      filteredDetailsIncident.where((item) => item['isChecked'] == true),
    );
  }

  var Incidents = RxList<String>([
    'A13 Wing',
    'A12 Wing',
    'A11 Wing',
    'A10 Wing',
    'A9 Wing',
    'A8 Wing',
    'A7 Wing',
    'A6 Wing',
    'A5 Wing',
    'A4 Wing',
    'A3 Wing',
    'A2 Wing',
    'A1 Wing',
  ]);
  var checklistIncident = [
    {'title': 'A13 Wing', 'isChecked': false},
    {'title': 'A12 Wing', 'isChecked': false},
    {'title': 'A11 Wing', 'isChecked': false},
    {'title': 'A13 Wing', 'isChecked': false},
    {'title': 'A12 Wing', 'isChecked': false},
    {'title': 'A11 Wing', 'isChecked': false},
    {'title': 'A13 Wing', 'isChecked': false},
    {'title': 'A12 Wing', 'isChecked': false},
    {'title': 'A11 Wing', 'isChecked': false},
    {'title': 'A13 Wing', 'isChecked': false},
    {'title': 'A12 Wing', 'isChecked': false},
    {'title': 'A11 Wing', 'isChecked': false},
  ];

  void toggleCheckboxIncident(int index) {
    filteredDetailsIncident[index]['isChecked'] =
        !filteredDetailsIncident[index]['isChecked'];
    filteredDetailsIncident.refresh();
  }

  void searchDataIncident(String query) {
    searchQueryIncident.value = query;
    if (query.isEmpty) {
      filteredDetailsIncident.assignAll(checklistIncident);
    } else {
      filteredDetailsIncident.assignAll(
        filteredDetailsIncident
            .where((item) => item['title']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  //--------------------------
  var selectedAow = ''.obs;

  var searchQueryAow = ''.obs;
  var filteredDetailsAow = [].obs;
  final TextEditingController searchControllerAow = TextEditingController();

  List<Map<String, dynamic>> getSelectedAow() {
    return List<Map<String, dynamic>>.from(
      filteredDetailsAow.where((item) => item['isChecked'] == true),
    );
  }

  var aow = RxList<String>([
    'A13 Wing',
    'A12 Wing',
    'A11 Wing',
    'A10 Wing',
    'A9 Wing',
    'A8 Wing',
    'A7 Wing',
    'A6 Wing',
    'A5 Wing',
    'A4 Wing',
    'A3 Wing',
    'A2 Wing',
    'A1 Wing',
  ]);
  var checklistAow = [
    {'title': 'A13 Wing', 'isChecked': false},
    {'title': 'A12 Wing', 'isChecked': false},
    {'title': 'A11 Wing', 'isChecked': false},
    {'title': 'A13 Wing', 'isChecked': false},
    {'title': 'A12 Wing', 'isChecked': false},
    {'title': 'A11 Wing', 'isChecked': false},
    {'title': 'A13 Wing', 'isChecked': false},
    {'title': 'A12 Wing', 'isChecked': false},
    {'title': 'A11 Wing', 'isChecked': false},
    {'title': 'A13 Wing', 'isChecked': false},
    {'title': 'A12 Wing', 'isChecked': false},
    {'title': 'A11 Wing', 'isChecked': false},
  ];

  void toggleCheckboxAow(int index) {
    filteredDetailsAow[index]['isChecked'] =
        !filteredDetailsAow[index]['isChecked'];
    filteredDetailsAow.refresh();
  }

  void searchDataAow(String query) {
    searchQueryIncident.value = query;
    if (query.isEmpty) {
      filteredDetailsAow.assignAll(checklistAow);
    } else {
      filteredDetailsAow.assignAll(
        filteredDetailsAow
            .where((item) => item['title']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  TextEditingController incidentController = TextEditingController();

  var selectViolation = ''.obs;
  var selectCategory = ''.obs;
  var selectViolationId = 0.obs;
  var selectCategoryId = 0.obs;

  var selectBreach = ''.obs; // Observable for Blood Group selection

  var selectObservation = ''.obs;
  var selectObservationId = 0.obs;

  var selectRisklevel = ''.obs;
  var selectRisklevelId = 0.obs;

  TextEditingController detailsController = TextEditingController();
  var detailsFocusNode = FocusNode();
  var turnArounttimeFocusNode = FocusNode();

  TextEditingController turnArounttimeController = TextEditingController();
  TextEditingController loactionofBreachController = TextEditingController();
  var loactionofBreachFocusNode = FocusNode();
// required this.involvedLaboursList,
//     required this.involvedStaffList,
//     required this.involvedContractorUserList,
//     required this.informedAsgineeUserList,
  //----------------------------------------------------------------------------
  List<Category> violationTypeList = [];
  List<Category> categoryList = [];
  List<Category> riskLevelList = [];
  List<Category> souceofObsList = [];
  List<InvolvedList> involvedLaboursList = [];
  List<InvolvedStaffList> involvedStaffList = [];
  List<InvolvedContractorUserList> involvedcontactor = [];
  List<InformedAsgineeUserList> assigneeList = [];

  Future getSafetyViolationData() async {
    try {
      Map<String, dynamic> map = {};

      print("Request body: $map");

      var responseData = await globApiCall(
          'get_safety_violation_debit_note_primary_data', map);
      var data = responseData['data'];

      // //-------------------------------------------------
      violationTypeList = (data['violation_type'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
      categoryList = (data['category'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
      riskLevelList = (data['risk_level'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
      souceofObsList = (data['source_of_observation'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
      involvedLaboursList = (data['involved_labours_list'] as List<dynamic>)
          .map((e) => InvolvedList.fromJson(e as Map<String, dynamic>))
          .toList();
      involvedStaffList = (data['involved_staff_list'] as List<dynamic>)
          .map((e) => InvolvedStaffList.fromJson(e as Map<String, dynamic>))
          .toList();
      involvedcontactor = (data['involved_contractor_user_list']
              as List<dynamic>)
          .map((e) =>
              InvolvedContractorUserList.fromJson(e as Map<String, dynamic>))
          .toList();
      assigneeList = (data['informed_asginee_user_list'] as List<dynamic>)
          .map((e) =>
              InformedAsgineeUserList.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------violationTypeList${violationTypeList.length}');
      log('----------contractorLists${categoryList.length}');
      log('----------riskLevelList${riskLevelList.length}');
      log('----------souceofObsList${souceofObsList.length}');
      log('---------- Involved Labours List: ${jsonEncode(involvedLaboursList)}');
      log('---------- Involved Staff List: ${jsonEncode(involvedStaffList)}');
      log('---------- Involved Contactor: ${jsonEncode(involvedcontactor)}');
      log('----------=assigneeList: ${jsonEncode(assigneeList)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
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

  //------------------------
  var photoError = ''.obs;
  var involvedError = ''.obs;
  var informedError = ''.obs;
  var assigneeError = ''.obs;

  void resetData() {
    violationimg.clear();
    violationImageCount.value = 0;

    selectedidProoftype.value = '';
    selectedIncident.value = '';
    searchQueryIncident.value = '';
    filteredDetailsIncident.assignAll(checklistIncident);

    selectedAow.value = '';
    searchQueryAow.value = '';
    filteredDetailsAow.assignAll(checklistAow);

    selectViolation.value = '';
    selectCategory.value = '';
    selectViolationId.value = 0;
    selectCategoryId.value = 0;

    selectBreach.value = '';
    selectObservation.value = '';
    selectObservationId.value = 0;

    selectRisklevel.value = '';
    selectRisklevelId.value = 0;

    detailsController.clear();
    turnArounttimeController.clear();
    loactionofBreachController.clear();

    violationTypeList.clear();
    categoryList.clear();
    riskLevelList.clear();
    souceofObsList.clear();
    involvedLaboursList.clear();
    involvedStaffList.clear();
    involvedcontactor.clear();
    assigneeList.clear();

    photoError.value = '';
    involvedError.value = '';
    informedError.value = '';
    assigneeError.value = '';

    log('All data has been reset.');
  }
}
