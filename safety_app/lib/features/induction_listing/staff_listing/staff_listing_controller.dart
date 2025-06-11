import 'dart:developer';

import 'package:flutter_app/features/induction_listing/staff_listing/staff_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class StaffListingController extends GetxController {
  var isPersonalDetailsExpanded = true.obs;

  void toggleExpansion() {
    isPersonalDetailsExpanded.value = !isPersonalDetailsExpanded.value;
  }

  var isProfessionalDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionProfessional() {
    isProfessionalDetailsExpanded.value = !isProfessionalDetailsExpanded.value;
  }

  var isidproofDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionidProof() {
    isidproofDetailsExpanded.value = !isidproofDetailsExpanded.value;
  }

  var isprecautionDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionPrecaution() {
    isprecautionDetailsExpanded.value = !isprecautionDetailsExpanded.value;
  }

  //-------------------
  List<UserDetail> staffDetailsList = [];
  List<InductionTraining> staffInductionTrainingsList = [];
  List<DocumentDetail> staffDocumentDetailsList = [];
  List<EquipmentDetail> staffEquipmentDetailsList = [];
  List<InstructionDetail> staffInstructionDetailsList = [];
  List<ReasonOfVisit> staffReasonOfVisitList = [];
  bool statusApi = false;
  Future getStaffInductionListing(
    userId,
    userType,
    reasonId,
    inductedById,
    inductTrainingId,
    projectId,
  ) async {
    try {
      Map<String, dynamic> map = {
        "user_id": userId,
        "user_type": userType,
        "reason_of_visit": reasonId,
        "inducted_by_id": inductedById,
        "induction_training_id": inductTrainingId,
        "project_id": projectId,
      };

      print("Request body: $map");

      var responseData =
          await globApiCall('get_selected_induction_training_details', map);
      var data = await responseData['data'];
      log('Response data: $data');
      statusApi = await responseData['status'];

      staffDetailsList = (data['user_details'] as List<dynamic>?)
              ?.map((e) => UserDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      staffInductionTrainingsList = (data['induction_trainings']
                  as List<dynamic>?)
              ?.map(
                  (e) => InductionTraining.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      staffDocumentDetailsList = (data['document_details'] as List<dynamic>?)
              ?.map((e) => DocumentDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      staffEquipmentDetailsList = (data['equipment_details'] as List<dynamic>?)
              ?.map((e) => EquipmentDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      staffInstructionDetailsList = (data['instruction_details']
                  as List<dynamic>?)
              ?.map(
                  (e) => InstructionDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      staffReasonOfVisitList = (data['reason_of_visit'] as List<dynamic>?)
              ?.map((e) => ReasonOfVisit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

//---------------------- LOG LENGTH OF EACH LIST ----------------------
      log('------------------staffDetailsLis');
      log('staffDetailsList length: ${staffDetailsList.length}');
      log('staffInductionTrainingsList length: ${staffInductionTrainingsList.length}');
      log('documentDetailsList length: ${staffDocumentDetailsList.length}');
      log('equipmentDetailsList length: ${staffEquipmentDetailsList.length}');
      log('instructionDetailsList length: ${staffInstructionDetailsList.length}');
      log('reasonOfVisitList length: ${staffInstructionDetailsList.length}');
    } catch (e) {
      print("Error: $e");
    }
  }

  void resetData() {
    staffDetailsList.clear();
    staffInductionTrainingsList.clear();
    staffDocumentDetailsList.clear();
    staffEquipmentDetailsList.clear();
    staffInstructionDetailsList.clear();
    staffReasonOfVisitList.clear();
    statusApi = false;

    // Optionally reset expansion states
    isPersonalDetailsExpanded.value = true;
    isProfessionalDetailsExpanded.value = true;
    isidproofDetailsExpanded.value = true;
    isprecautionDetailsExpanded.value = true;
  }
}
