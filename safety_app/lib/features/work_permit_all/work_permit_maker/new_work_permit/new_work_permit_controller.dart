import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_model.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class NewWorkPermitController extends GetxController {
  final WorkPermitController workPermitController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  var selectedcategory = ''.obs;
  var selectedcategoryId = 0.obs;
  var selectedWorkActivity = ''.obs;
  var selectedWorkActivityId = 0.obs;
  var selectedtoolboxId = 0.obs;

  var selectedtoolboxtrainig = ''.obs; // Observable for Blood Group selection
  final List<String> toolboxtrainig = [
    'A',
    'B',
    'AB',
    'O',
  ];
  var buildings = RxList<String>([
    'A13 Wing',
    'A12 Wing',
  ]);
  var selectedBuilding = ''.obs;

  var selectedFloor = ''.obs;

  TextEditingController descWorkrController = TextEditingController();
  FocusNode dow = FocusNode();

  TextEditingController nameworkpermitController = TextEditingController();
  FocusNode nameofworkpermit = FocusNode();

  TextEditingController dateController = TextEditingController();

  //---------------

  RxString selectionError = ''.obs;

  //-----------------------------select building

  final TextEditingController searchControllerBuilding =
      TextEditingController();

  var selectedBuildingIdList = <int>[].obs;
  var selectedBuildingIdListFinal = <Map<String, dynamic>>[].obs;

  void toggleBuildingSelection(int id) {
    selectedBuildingIdList.clear(); //only added
    selectedBuildingIdListFinal.clear(); //only added
    selectedFloorIdsByBuilding.clear();
    if (selectedBuildingIdList.contains(id)) {
      selectedBuildingIdList.remove(id);
      selectedBuildingIdListFinal
          .removeWhere((element) => element['building_id'] == id);
    } else {
      selectedBuildingIdList.add(id);
    }
    print(
        "Selected selectedBuildingId IDs: ${selectedBuildingIdList.toList()}");
  }

  var searchQuery = ''.obs;

  void updateBuildingSearchQuery(String query) {
    searchQuery.value = query;
  }

  void addBuilding() {
    for (var id in selectedBuildingIdList) {
      if (!selectedBuildingIdListFinal
          .any((element) => element['building_id'] == id)) {
        selectedBuildingIdListFinal.add({
          'building_id': id,
          'floor_ids': <int>[], // Ensure correct type
        });
      }
    }
    selectedBuildingIdListFinal.refresh();
    print(
        "Selected selectedBuildingId IDs: ${selectedBuildingIdList.toList()}");
    log("Final Selected Buildings: ${selectedBuildingIdListFinal.toList()}");
  }

  void deleteBuilding(int index, int id) {
    // Remove the building from the final selection list
    selectedBuildingIdListFinal.removeAt(index);

    // Remove the building ID from the selected list
    selectedBuildingIdList.remove(id);

    // Remove associated floors for this building only
    selectedFloorIdsByBuilding.remove(id);

    selectedBuildingIdListFinal.refresh(); // Refresh the UI after update
    selectedFloorIdsByBuilding.refresh();

    print("Updated selectedBuildingIdList: ${selectedBuildingIdList.toList()}");
    print(
        "Updated selectedBuildingIdListFinal: ${selectedBuildingIdListFinal.toList()}");
    print(
        "Updated selectedFloorIdsByBuilding: ${selectedFloorIdsByBuilding.toString()}");
  }

  List<BuildingList> get filteredbuildingList {
    final query = searchQuery.value.toLowerCase();
    return workPermitController.buildingList
        .where((building) =>
            building.buildingName.toLowerCase().contains(query) ||
            building.id.toString().contains(query))
        .toList();
  }

  String getBuildingNameById(int id) {
    var building = workPermitController.buildingList.firstWhere(
        (b) => b.id == id,
        orElse: () => BuildingList(
            id: id, projectInfoId: 0, buildingNo: 0, buildingName: ''));

    return building.buildingName; // Safely return name
  }

  String getFloorNamesByIds(List<int> floorIds) {
    if (floorIds.isEmpty) return "No Floor Selected"; // Handle empty case

    List<String> floorNames = floorIds.map((id) {
      var floor = workPermitController.projectfloorList.firstWhere(
        (f) => f.id == id,
        orElse: () => ProjectWiseFloor(id: id, floorName: ''),
      );
      return floor.floorName.isNotEmpty ? floor.floorName : "Unknown Floor";
    }).toList();

    return floorNames.join(", "); // Return comma-separated names
  }

  //---------------------------------------
  final TextEditingController searchControllerFloor = TextEditingController();

  void toggleFloorSelection(int floorId, int buildingId) {
    print("Last Selected Building ID: $lastSelectedBuildingId");
    print("New Building ID: $buildingId");

    // Ensure this building has an entry in the map
    selectedFloorIdsByBuilding.putIfAbsent(buildingId, () => []);

    if (lastSelectedBuildingId != null &&
        lastSelectedBuildingId != buildingId) {
      // Nothing to clear here, since floors are now stored separately per building
    }

    List<int> selectedFloors = selectedFloorIdsByBuilding[buildingId]!;

    if (selectedFloors.contains(floorId)) {
      selectedFloors.remove(floorId);
    } else {
      selectedFloors.add(floorId);
    }

    lastSelectedBuildingId = buildingId; // Track last selected building

    selectedFloorIdsByBuilding.refresh(); // Refresh UI

    print(
        "Selected Floors for Building $buildingId: ${selectedFloors.toList()}");
    print(
        "All Selected Buildings & Floors: ${selectedFloorIdsByBuilding.toString()}");
  }

  var searchFloorQuery = ''.obs;

  void updateFloorSearchQuery(String query) {
    searchFloorQuery.value = query;
  }

  var selectedFloorIdsByBuilding =
      <int, List<int>>{}.obs; // Key: buildingId, Value: floor list
  int? lastSelectedBuildingId; // Store the last selected building

  void addfloorbuildFinal(int buildingId) {
    print(
        "Final ---new-  selectedFloorIdsByBuilding: $selectedFloorIdsByBuilding");

    lastSelectedBuildingId = buildingId; // Update last selected building ID

    // Find the building entry in the list
    int index = selectedBuildingIdListFinal.indexWhere(
      (element) => element['building_id'] == buildingId,
    );

    // Get selected floors for this building
    List<int> selectedFloors = selectedFloorIdsByBuilding[buildingId] ?? [];

    if (index != -1) {
      // If the building exists, update its floor list
      List<int> existingFloors =
          selectedBuildingIdListFinal[index]['floor_ids'];

      // Remove floors that are no longer selected
      existingFloors
          .removeWhere((floorId) => !selectedFloors.contains(floorId));

      // Add only the newly selected floors
      for (var floorId in selectedFloors) {
        if (!existingFloors.contains(floorId)) {
          existingFloors.add(floorId);
        }
      }

      selectedBuildingIdListFinal.refresh(); // Refresh UI
    } else {
      // If building does not exist, add a new entry
      selectedBuildingIdListFinal.add({
        'building_id': buildingId,
        'floor_ids': selectedFloors.toList(),
      });
    }

    print("Updated Floor IDs for Building ID: $buildingId");
    print(
        "Updated Final Selected Buildings: ${selectedBuildingIdListFinal.toList()}");
  }

  List<FloorModel> get filteredfloorList {
    final query = searchFloorQuery.value.toLowerCase();
    return floorworkPermitList
        .where((floor) =>
            floor.floorName.toLowerCase().contains(query) ||
            floor.id.toString().contains(query))
        .toList();
  }

  var floorworkPermitList = <FloorModel>[].obs;

  Future getSafetyfloorData(buildingId) async {
    try {
      Map<String, dynamic> map = {
        "building_id": buildingId,
      };

      log("Request body: $map");

      var responseData = await globApiCall('get_floor_list', map);

      //  log("Request body: $data");

      // //-------------------------------------------------
      floorworkPermitList.value = (await responseData['data'] as List<dynamic>)
          .map((e) => FloorModel.fromJson(e as Map<String, dynamic>))
          .toList();

      log('----------floorworkPermitList${floorworkPermitList.length}');

      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var workPermitRequiredList = <WorkPermitDetail>[].obs;

  Future getDocumentRequiredData(subActivityId) async {
    try {
      Map<String, dynamic> map = {
        "sub_activity_id": subActivityId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_categories_instructions_list', map);

      //  log("Request body: $data");

      // //-------------------------------------------------

      var data = await responseData['data'];
      workPermitRequiredList.value =
          (await data['work_permit_detail_lists'] as List<dynamic>)
              .map((e) => WorkPermitDetail.fromJson(e as Map<String, dynamic>))
              .toList();

      log('----------workPermitRequiredList${workPermitRequiredList.length}');

      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var buildingfloorerror = ''.obs;
  bool validateBuildingSelection() {
    if (selectedBuildingIdListFinal.isEmpty) {
      buildingfloorerror.value = "Please select at least one building";
      return false;
    }

    // Check if each building has at least one floor selected
    bool hasEmptyFloors = selectedBuildingIdListFinal.any((building) {
      List<int> floorIds = List<int>.from(building["floor_ids"] ?? []);
      return floorIds.isEmpty;
    });

    if (hasEmptyFloors) {
      buildingfloorerror.value =
          "Each building must have at least one floor selected";
      return false;
    }

    buildingfloorerror.value = "";
    return true;
  }

  var workDuration = ''.obs;
  var workDurationError = ''.obs;
  void validateWorkDuration() {
    // ignore: unnecessary_null_comparison
    if (workDuration.value == null || workDuration.value.isEmpty) {
      workDurationError.value = 'Please select a work duration';
    } else {
      workDurationError.value = '';
    }
  }

  var fromDateTime = ''.obs;
  var toDateTime = ''.obs;

  void resetData() {
    selectedcategory.value = '';
    selectedcategoryId.value = 0;
    selectedWorkActivity.value = '';
    selectedWorkActivityId.value = 0;

    selectedtoolboxtrainig.value = '';
    selectedBuilding.value = '';
    selectedFloor.value = '';

    descWorkrController.clear();
    nameworkpermitController.clear();
    dateController.clear();

    selectionError.value = '';

    searchControllerBuilding.clear();
    selectedBuildingIdList.clear();
    selectedBuildingIdListFinal.clear();

    searchQuery.value = '';

    searchControllerFloor.clear();
    searchFloorQuery.value = '';

    selectedFloorIdsByBuilding.clear();
    lastSelectedBuildingId = null;

    floorworkPermitList.clear();
    workPermitRequiredList.clear();

    buildingfloorerror.value = '';
    workDuration.value = '';
    workDurationError.value = '';
    fromDateTime.value = '';
    toDateTime.value = '';

    print("All data cleared in NewWorkPermitController!");
  }
}
