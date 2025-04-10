import 'dart:developer';

import 'package:flutter_app/features/induction_listing/contractor_listing/contractor_listing_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class ContractorListingController extends GetxController {
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
  List<UserDetail> contractorDetailsList = [];
  List<InductionTraining> contractorInductionTrainingsList = [];
  List<ReasonOfVisit> contractorReasonOfVisitList = [];
  bool statusApi = false;
  Future getContractorInductionListing(
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

      contractorDetailsList = (data['user_details'] as List<dynamic>?)
              ?.map((e) => UserDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      contractorInductionTrainingsList = (data['induction_trainings']
                  as List<dynamic>?)
              ?.map(
                  (e) => InductionTraining.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      contractorReasonOfVisitList = (data['reason_of_visit'] as List<dynamic>?)
              ?.map((e) => ReasonOfVisit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

//---------------------- LOG LENGTH OF EACH LIST ----------------------
      log('------------------contractorDetailsList');
      log('contractorDetailsList length: ${contractorDetailsList.length}');
      log('contractorInductionTrainingsList length: ${contractorInductionTrainingsList.length}');
      log('contractorReasonOfVisitList length: ${contractorReasonOfVisitList.length}');
    } catch (e) {
      print("Error: $e");
    }
  }
}
