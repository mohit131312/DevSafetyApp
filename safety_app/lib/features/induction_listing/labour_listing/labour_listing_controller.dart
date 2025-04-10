import 'dart:developer';

import 'package:flutter_app/features/induction_listing/labour_listing/labour_listing_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class LabourListingController extends GetxController {
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
  List<LabourDetail> labourDetailsList = [];
  List<TradeName> tradeNameList = [];
  List<InductionTraining> inductionTrainingsList = [];
  List<DocumentDetail> documentDetailsList = [];
  List<EquipmentDetail> equipmentDetailsList = [];
  List<InstructionDetail> instructionDetailsList = [];
  List<ReasonOfVisit> reasonOfVisitList = [];
  List<ContractorCompanyDetail> contractorCompanyDetailsList = [];
  List<SkillLevel> skillLevelList = [];
  bool statusApi = false;
  Future getInductionListing(userId, userType, reasonId, inductedById,
      inductTrainingId, projectId, tradeId, contCompId) async {
    try {
      Map<String, dynamic> map = {
        "user_id": userId,
        "user_type": userType,
        "reason_of_visit": reasonId,
        "inducted_by_id": inductedById,
        "induction_training_id": inductTrainingId,
        "project_id": projectId,
        "trade_id": tradeId,
        "contractor_company_id": contCompId,
      };

      print("Request body: $map");

      var responseData =
          await globApiCall('get_selected_induction_training_details', map);
      var data = await responseData['data'];
      log('Response data: $data');
      statusApi = await responseData['status'];

      labourDetailsList = (data['user_details'] as List<dynamic>?)
              ?.map((e) => LabourDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      tradeNameList = (data['trade_name'] as List<dynamic>?)
              ?.map((e) => TradeName.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      inductionTrainingsList = (data['induction_trainings'] as List<dynamic>?)
              ?.map(
                  (e) => InductionTraining.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      documentDetailsList = (data['document_details'] as List<dynamic>?)
              ?.map((e) => DocumentDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      equipmentDetailsList = (data['equipment_details'] as List<dynamic>?)
              ?.map((e) => EquipmentDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      instructionDetailsList = (data['instruction_details'] as List<dynamic>?)
              ?.map(
                  (e) => InstructionDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      reasonOfVisitList = (data['reason_of_visit'] as List<dynamic>?)
              ?.map((e) => ReasonOfVisit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      contractorCompanyDetailsList = (data['contractor_company_details']
                  as List<dynamic>?)
              ?.map((e) =>
                  ContractorCompanyDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      skillLevelList = (data['skill_level'] as List<dynamic>?)
              ?.map((e) => SkillLevel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

//---------------------- LOG LENGTH OF EACH LIST ----------------------
      log('labourDetailsList length: ${labourDetailsList.length}');
      log('tradeNameList length: ${tradeNameList.length}');
      log('inductionTrainingsList length: ${inductionTrainingsList.length}');
      log('documentDetailsList length: ${documentDetailsList.length}');
      log('equipmentDetailsList length: ${equipmentDetailsList.length}');
      log('instructionDetailsList length: ${instructionDetailsList.length}');
      log('reasonOfVisitList length: ${reasonOfVisitList.length}');
      log('contractorCompanyDetailsList length: ${contractorCompanyDetailsList.length}');
      log('skill_level length: ${skillLevelList.length}');
    } catch (e) {
      print("Error: $e");
    }
  }
}
