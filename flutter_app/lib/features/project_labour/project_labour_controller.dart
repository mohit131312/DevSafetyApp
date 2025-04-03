import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/project_labour/project_model.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class ProjectLabourController extends GetxController {
  List<InvolvedLaboursList> labourList = [];
  Future getLabourDetails(projectId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projectId,
      };

      print("Request body: $map");

      var responseData = await globApiCall('get_project_labours_list', map);
      var data = await responseData['data'];
      labourList = (data['involved_labours_list'] as List<dynamic>)
          .map((e) => InvolvedLaboursList.fromJson(e as Map<String, dynamic>))
          .toList();
      print('----------labourList$labourList');
      log('----------labourList${labourList.length}');
    } catch (e) {
      print("Error: $e");
    }
  }

  var searchQuery = ''.obs;
  TextEditingController searchController = TextEditingController();

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<InvolvedLaboursList> get filteredLabours {
    final query = searchQuery.value.toLowerCase();
    return labourList
        .where((labour) =>
            labour.labourName.toLowerCase().contains(query) ||
            labour.labourId.toString().contains(query))
        .toList();
  }

  //-----------------------------------
}
