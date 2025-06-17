import 'dart:developer';

import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';
import 'labour_details_model.dart';

class LabourDetailsController extends GetxController {
  List<LaboursDetail> laboursAllDetails = [];
  List<LaboursProjectDetail> laboursAllProjectDetails = [];
  List<DocumentDetail> alldocumentDetails = [];
  Future getLabourDetailsAll(labourid, projectId) async {
    try {
      Map<String, dynamic> map = {
        "labour_id": labourid,
        "project_id": projectId,
      };

      print("Request body: $map");

      var responseData = await globApiCall('get_project_labour_details', map);
      log("responseData body: $responseData");

      var data = await responseData['data'];
      if (responseData == null || responseData['data'] == null) {
        log("Error: responseData or data is null");
        return;
      }

      laboursAllDetails = (data['labours_details'] as List<dynamic>?)
              ?.map((e) => LaboursDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      laboursAllProjectDetails =
          (data['labours_project_details'] as List<dynamic>?)
                  ?.map((e) =>
                      LaboursProjectDetail.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];

      alldocumentDetails = (data['document_details'] as List<dynamic>?)
              ?.map((e) => DocumentDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      log('----------labourList${laboursAllDetails.length}');
      log('----------laboursProjectDetails${laboursAllProjectDetails.length}');
      log('----------documentDetails${alldocumentDetails.length}');
    } catch (e) {
      print("Error: $e");
    }
  }
}
