import 'dart:developer';
import 'dart:async';

import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_all_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

// module 8 mobile
// entitle_id 3=induction training,5 toolbox training, 6 work permit ,23 safety actnable/violation,25 incident report
// or entitlement_modeule_id safety module entitle list id
class HomeScreenController extends GetxController {
  RxList<WorkPermitListingAll> workPermitListing = <WorkPermitListingAll>[].obs;

  Future getWorkPermitAllListing(projcetId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
      };

      log("Request body: $map");

      var responseData = await globApiCall('get_today_work_permit_list', map);
      //  log("Request body: $data");

      // //-------------------------------------------------
      workPermitListing.value = (responseData['data'] as List<dynamic>?)
              ?.map((e) =>
                  WorkPermitListingAll.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      log('----------=workPermitListing: ${(workPermitListing.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  RxList<Map<String, dynamic>> workCard = <Map<String, dynamic>>[].obs;

  Future<void> getCardListing(projectId, userId) async {
    try {
      Map<String, dynamic> requestBody = {
        "project_id": projectId,
        "user_id": userId,
      };

      log("🔄 Requesting Work Permits: $requestBody");

      var responseData =
          await globApiCall('get_projectwise_status', requestBody);

      if (responseData['status'] == true && responseData['data'] != null) {
        final dataMap = Map<String, dynamic>.from(responseData['data']);

        // Convert each category's data into a card format
        workCard.value = dataMap.entries.map((entry) {
          final categoryName = entry.key;
          final Map<String, dynamic> values =
              Map<String, dynamic>.from(entry.value);

          final fields = <String, dynamic>{};

          if (values.containsKey('openWorkPermits'))
            fields['open'] = values['openWorkPermits'];
          if (values.containsKey('rejectedWorkPermits'))
            fields['rejected'] = values['rejectedWorkPermits'];
          if (values.containsKey('closedWorkPermits'))
            fields['closed'] = values['closedWorkPermits'];
          if (values.containsKey('acceptedWorkPermits'))
            fields['accepted'] = values['acceptedWorkPermits'];
          if (values.containsKey('resolvedViolationDebitNote'))
            fields['resolved'] = values['resolvedViolationDebitNote'];
          if (values.containsKey('openIncidentReport'))
            fields['open'] = values['openIncidentReport'];
          if (values.containsKey('acceptedIncidentReport'))
            fields['accepted'] = values['acceptedIncidentReport'];
          if (values.containsKey('closedIncidentReport'))
            fields['closed'] = values['closedIncidentReport'];
          if (values.containsKey('openToolBoxTrainingCount'))
            fields['open'] = values['openToolBoxTrainingCount'];
          if (values.containsKey('closedToolBoxTrainingCount'))
            fields['closed'] = values['closedToolBoxTrainingCount'];
          if (values.containsKey('acceptedToolBoxTrainingCount'))
            fields['accepted'] = values['acceptedToolBoxTrainingCount'];
          if (values.containsKey('openViolationDebitNote'))
            fields['open'] = values['openViolationDebitNote'];
          if (values.containsKey('resolvedViolationDebitNote'))
            fields['resolved'] = values['resolvedViolationDebitNote'];
          if (values.containsKey('closedViolationDebitNote'))
            fields['closed'] = values['closedViolationDebitNote'];

          // Return card data
          return {
            'title': categoryName,
            'data': fields, // Only include the existing fields
          };
        }).toList();
        log("✅ Card Data Loaded: ${workCard.length}");
      } else {
        log("⚠️ No data found or invalid response.");
      }
    } catch (e, stackTrace) {
      log("❌ Error fetching work permits: $e\n$stackTrace");
    }
  }
}
