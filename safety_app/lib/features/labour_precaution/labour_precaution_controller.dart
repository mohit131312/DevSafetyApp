import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/induction_training/induction_training_add_model.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:get/get.dart';

class LabourPrecautionController extends GetxController {
  RxList<IdProofList> filteredDetailsEquipment = <IdProofList>[].obs;
  final TextEditingController searchControllerEquipment =
      TextEditingController();
  final InductionTrainingController inductionTrainingController =
      Get.put(InductionTrainingController());

  @override
  void onInit() {
    super.onInit();
    filteredDetailsEquipment
        .assignAll(inductionTrainingController.safetyEquipmentList.toList());
    filteredDetailsInstruction
        .assignAll(inductionTrainingController.instructionsList.toList());
    selectedItemInstruction.clear();
    selectedItemIds.clear();

    log('----------------------filteredDetailsEquipment: ${filteredDetailsEquipment}');
    log('----------------------filteredDetailsInstruction: ${filteredDetailsInstruction}');
  }

  var searchQueryEquipment = ''.obs;
  RxList<int> selectedItemIds = <int>[].obs;
  RxBool isSelectAll = false.obs;

  void searchDataEquipment(String query) {
    searchQueryEquipment.value = query;

    if (query.isEmpty) {
      filteredDetailsEquipment
          .assignAll(inductionTrainingController.safetyEquipmentList.toList());
    } else {
      filteredDetailsEquipment.assignAll(
        inductionTrainingController.safetyEquipmentList
            .where((item) =>
                item.listDetails.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }

    // Preserve all selected items globally (do not reset selectedItemIds)
    log('Search Query: $query');
    log('Filtered Equipment List: ${filteredDetailsEquipment}');
    log('---------------- inductionTrainingController.safetyEquipmentList------${inductionTrainingController.safetyEquipmentList}');
    log('Selected Items: $selectedItemIds');
  }

  List<Map<String, dynamic>> getSelectedEquipment() {
    return filteredDetailsEquipment
        .where((item) => selectedItemIds.contains(item.id))
        .map((item) => {
              "id": item.id,
              "title": item.listDetails,
            })
        .toList();
  }

  void toggleSelectAll() {
    if (isSelectAll.value) {
      selectedItemIds.clear();
    } else {
      selectedItemIds.assignAll(
        inductionTrainingController.safetyEquipmentList
            .map((e) => e.id)
            .toList(),
      );
    }
    isSelectAll.value = selectedItemIds.length ==
        inductionTrainingController.safetyEquipmentList.length;
    log('Selected Items: $selectedItemIds');
  }

  RxString selectionError = ''.obs; // Holds error message

  bool validateSelection() {
    if (selectedItemIds.isEmpty) {
      selectionError.value = "Please select at least one equipment.";
      return false;
    }
    selectionError.value = ""; // Clear error if valid
    return true; // Validation passed
  }

  void toggleSelection(int id) {
    if (selectedItemIds.contains(id)) {
      selectedItemIds.remove(id);
    } else {
      selectedItemIds.add(id);
    }

    isSelectAll.value = selectedItemIds.length ==
        inductionTrainingController.safetyEquipmentList.length;
    log('Selected Items: $selectedItemIds');

    // Clear validation error when at least one checkbox is selected
    if (selectedItemIds.isNotEmpty) {
      selectionError.value = "";
    }

    log('Selected Items: $selectedItemIds');
  }

  //---------------------------Instruction Given
  RxList<InstructionsListElement> filteredDetailsInstruction =
      <InstructionsListElement>[].obs;

  final TextEditingController searchControllerInstruction =
      TextEditingController();

  var searchQueryInstruction = ''.obs;
  RxList<int> selectedItemInstruction = <int>[].obs;
  RxBool isSelectAllInstruction = false.obs;

  void searchDataInstruction(String query) {
    searchQueryInstruction.value = query;

    if (query.isEmpty) {
      filteredDetailsInstruction
          .assignAll(inductionTrainingController.instructionsList.toList());
    } else {
      filteredDetailsInstruction.assignAll(
        inductionTrainingController.instructionsList
            .where((item) => item.inductionDetails
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList(),
      );
    }

    log('Search Query: $query');
    log('Filtered filteredDetailsInstruction List: ${filteredDetailsInstruction}');
    log('---------------- inductionTrainingController.InstructionList------${inductionTrainingController.safetyEquipmentList}');
    log('Selected selectedItemInstruction: $selectedItemInstruction');
  }

  List<Map<String, dynamic>> getSelectedInstruction() {
    return filteredDetailsInstruction
        .where((item) => selectedItemInstruction.contains(item.id))
        .map((item) => {
              "id": item.id,
              "title": item.inductionDetails,
            })
        .toList();
  }

  void toggleSelectAllInstruction() {
    if (isSelectAllInstruction.value) {
      selectedItemInstruction.clear();
    } else {
      selectedItemInstruction.assignAll(
        inductionTrainingController.instructionsList.map((e) => e.id).toList(),
      );
    }
    isSelectAllInstruction.value = selectedItemInstruction.length ==
        inductionTrainingController.instructionsList.length;
    log('Selected selectedItemInstruction: $selectedItemInstruction');
  }

  void toggleSelectionInstruction(int id) {
    if (selectedItemInstruction.contains(id)) {
      selectedItemInstruction.remove(id);
    } else {
      selectedItemInstruction.add(id);
    }

    // Update "Select All" state based on the full list
    isSelectAllInstruction.value = selectedItemInstruction.length ==
        inductionTrainingController.instructionsList.length;
    log('Selected selectedItemInstruction: $selectedItemInstruction');
    // ✅ Clear validation error when at least one checkbox is selected
    if (selectedItemInstruction.isNotEmpty) {
      selectionInstructionError.value = "";
    }

    log('Selected selectedItemInstruction: $selectedItemInstruction');
  }

  RxString selectionInstructionError = ''.obs; // Holds error message

  bool validateInstructionSelection() {
    if (selectedItemInstruction.isEmpty) {
      selectionInstructionError.value =
          "Please select at least one instruction.";
      return false; // Validation failed
    }
    selectionInstructionError.value = ""; // Clear error if valid
    return true; // Validation passed
  }
}
