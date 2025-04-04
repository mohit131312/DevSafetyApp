import 'dart:developer';

import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

import 'select_project_model.dart';

class SelectProjectController extends GetxController {
  RxBool isCircleBlack = false.obs;
  RxBool isLoading = false.obs;
  void toggleCircleColor() {
    isCircleBlack.value = !isCircleBlack.value;
  }

  List<ProjectData> selectProject = [];
  var selectedProjectId = 0.obs;

  Future getProjectDetails(userId, roleId) async {
    try {
      Map<String, dynamic> map = {"role_id": roleId, "user_id": userId};

      print("Request body: $map");

      var responseData = await globApiCall('get_assign_safety_project', map);

      //

      selectProject = (responseData['data'] as List<dynamic>)
          .map((e) => ProjectData.fromJson(e as Map<String, dynamic>))
          .toList();

      print('----------data$selectProject');
      log('----------data${selectProject.length}');
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false; // Hide loader
    }
  }
}
