import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class ToolboxTDetailsController extends GetxController {
  //------------------------------------------------

  RxList<Instruction> instructionListData = <Instruction>[].obs;
  var isAllSelected = false.obs; // Track "Select All" state

  Future getInstructionData(projcetId, userId, makerId) async {
    try {
      Map<String, dynamic> map = {
        "toolbox_category_id": projcetId,
        "project_id": userId,
        "maker_id": userId,
      };

      log("Request body: $map");

      var responseData = await globApiCall('get_topics_instructions_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------

      if (responseData['data'] is List) {
        instructionListData.value = (responseData['data'] as List<dynamic>)
            .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
            .toList();
        log('----------instructionListData: ${instructionListData.length}');
      } else {
        log("Error: Unexpected data format: ${responseData['data']}");
      }

      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  //-------------------
  var selectCategory = ''.obs;
  var selectContractor = ''.obs;
  var selectContractorId = 0.obs;

  var selectCategoryId = 0.obs;
  var selectWorkPermit = ''.obs;
  var selectWorkPermitId = 0.obs;

  //---------------------------

  final TextEditingController tbtController = TextEditingController();
  FocusNode tbtFocusNode = FocusNode();
  final TextEditingController detailsController = TextEditingController();
  FocusNode detailsFocusNode = FocusNode();

  final TextEditingController instructionController = TextEditingController();

  //-----------------------------
  var selectedInstructionIds = <int>[].obs;

  void toggleInstructionSelection(int id) {
    if (selectedInstructionIds.contains(id)) {
      selectedInstructionIds.remove(id);
    } else {
      selectedInstructionIds.add(id);
    }
    isAllSelected.value =
        selectedInstructionIds.length == instructionListData.length;

    print(
        "Selected selectedInstructionIds IDs: ${selectedInstructionIds.toList()}");
  }

  void toggleSelectAll() {
    if (isAllSelected.value) {
      selectedInstructionIds.clear();
    } else {
      selectedInstructionIds.assignAll(instructionListData.map((e) => e.id));
    }
    isAllSelected.toggle();
    print(
        "Selected selectedInstructionIds IDs: ${selectedInstructionIds.toList()}");
  }

  var searchQuery = ''.obs;

  void updateInstructiontSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<Instruction> get filteredInstruction {
    final query = searchQuery.value.toLowerCase();
    return instructionListData
        .where((inst) =>
            inst.toolboxDetails.toLowerCase().contains(query) ||
            inst.id.toString().contains(query))
        .toList();
  }

  var instructionError = ''.obs;
  bool validateInstructionSelection() {
    if (selectedInstructionIds.isEmpty) {
      instructionError.value = "At least one instruction must be selected.";
      return false;
    }
    instructionError.value = ""; // Clear error if valid
    return true;
  }

  void resetTdetailsAllData() {
    // Reset category and work permit selections
    selectCategory.value = '';
    selectCategoryId.value = 0;
    selectWorkPermit.value = '';
    selectWorkPermitId.value = 0;

    // Clear text controllers
    tbtController.clear();
    detailsController.clear();
    instructionController.clear();

    // Clear focus nodes
    tbtFocusNode.unfocus();
    detailsFocusNode.unfocus();

    // Clear instruction selections
    selectedInstructionIds.clear();
    isAllSelected.value = false;

    // Reset instruction list
    instructionListData.clear();

    // Reset search query
    searchQuery.value = '';

    // Reset validation error
    instructionError.value = '';

    log("ToolboxTDetailsController data has been reset");
  }

  //--------------------------------
  final GlobalKey categoryKey = GlobalKey();
  final GlobalKey contractorKey=GlobalKey();
  final GlobalKey reviewerKey = GlobalKey();
  final GlobalKey instructionKey = GlobalKey();
}
