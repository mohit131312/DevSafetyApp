import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/incident_report_all/incident_details/incident_details_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class IncidentDetailsController extends GetxController {
  var incidentimg = <XFile>[];

  var incidentImageCount = 0.obs;

  final maxPhotos = 10;

  Future<void> pickIncidentImages({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    if (incidentimg.length < maxPhotos) {
      int remainingSlots = maxPhotos - incidentimg.length;

      if (source == ImageSource.gallery) {
        final List<XFile> pickedFiles = await picker.pickMultiImage();
        final List<XFile> limitedFiles =
            pickedFiles.take(remainingSlots).toList();
        incidentimg.addAll(limitedFiles);
        log('Picked from Gallery: ${limitedFiles.length} images');
      } else if (source == ImageSource.camera) {
        final XFile? capturedFile =
            await picker.pickImage(source: ImageSource.camera);
        if (capturedFile != null) {
          incidentimg.add(capturedFile);
          log('Captured from Camera: 1 image');
        }
      }

      incidentImageCount.value = incidentimg.length;
      log('incidentImageCount: ${incidentImageCount.value}');
    }
  }

  void removeAdharImage(int index) {
    if (index >= 0 && index < incidentimg.length) {
      incidentimg.removeAt(index);
      incidentImageCount.value = incidentimg.length;

      log('Removed image at index $index from incidentimg. Remaining: ${incidentImageCount.value}');
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
  var incidentFocusNode = FocusNode();

//-------------------------------------------------
  var selectSeverity = ''.obs;
  var selectSeverityId = 0.obs;

  var selectBuilding = ''.obs;
  var selectBuildingId = 0.obs;
  var selectFloor = ''.obs;
  var selectFloorId = 0.obs;
  var selectCompany = ''.obs;
  var selectCompanyId = 0.obs;

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

  var floorList = <FloorModel>[].obs;

  Future getSafetyIncidentData(buildingId) async {
    try {
      Map<String, dynamic> map = {
        "building_id": buildingId,
      };

      log("Request body: $map");

      var responseData = await globApiCall('get_floor_list', map);

      //  log("Request body: $data");

      // //-------------------------------------------------
      floorList.value = (await responseData['data'] as List<dynamic>)
          .map((e) => FloorModel.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------floorList${floorList.length}');

      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  //------------------

  var photoError = ''.obs;
  var involvedError = ''.obs;
  var informedError = ''.obs;
  var assigneeError = ''.obs;

  void resetData() {
    incidentimg.clear();
    incidentImageCount.value = 0;

    selectedidProoftype.value = '';
    selectedIncident.value = '';
    searchQueryIncident.value = '';
    filteredDetailsIncident.assignAll(checklistIncident);

    selectedAow.value = '';
    searchQueryAow.value = '';
    filteredDetailsAow.assignAll(checklistAow);

    incidentController.clear();
    incidentFocusNode.unfocus();

    selectSeverity.value = '';
    selectSeverityId.value = 0;
    selectBuilding.value = '';
    selectBuildingId.value = 0;
    selectFloor.value = '';
    selectFloorId.value = 0;
    selectCompany.value = '';
    selectCompanyId.value = 0;

    floorList.clear();

    photoError.value = '';
    involvedError.value = '';
    informedError.value = '';
    assigneeError.value = '';

    log('IncidentDetailsController data has been reset.');
  }
}
