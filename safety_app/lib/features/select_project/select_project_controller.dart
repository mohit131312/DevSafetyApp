import 'dart:developer';

import 'package:flutter_app/features/home/permission/permission_model.dart';
import 'package:flutter_app/utils/gloabal_var.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

import 'select_project_model.dart';

class SelectProjectController extends GetxController {
  RxBool isCircleBlack = false.obs;
  RxBool isRefreshing = false.obs; // Add loading state for refresh
  RxBool isLoading = false.obs;
  var selectedProjectIndex =
      (-1).obs; // This will track the index of the selected project
  void selectProjectAtIndex(int index) {
    selectedProjectIndex.value = index;
  }

  void toggleCircleColor() {
    isCircleBlack.value = !isCircleBlack.value;
  }

  RxList<ProjectData> selectProject = <ProjectData>[].obs;

  Future getProjectDetails(userId, roleId) async {
    shimmerproject.value = selectProject.length;
    isRefreshing.value = true;
    try {
      Map<String, dynamic> map = {"role_id": roleId, "user_id": userId};

      var responseData = await globApiCall('get_assign_safety_project', map);
      log("📥 Raw Response: $responseData");
      final selectProjectModel = SelectProject.fromJson(responseData);

      final projects = selectProjectModel.data.assignProjectInfo;

      selectProject.assignAll(projects);

      print('Project Count: ${selectProject.length}');
    } catch (e) {
      print("Error: $e");
    } finally {
      isRefreshing.value = false; // Stop shimmer effect
    }
  }

  //-----------------------------------------------------
  RxList<MapEntry<String, The23>> selectRoles = <MapEntry<String, The23>>[].obs;
  RxList<int> entitlementIds = <int>[].obs;

  RxList<int> projectIds = <int>[].obs;
  RxString roleMessage = ''.obs;
  RxInt roleStatus = 100.obs;
  RxInt safetyAdmin = 0.obs;
  Future getRolesDetails(userId, roleId, projectId) async {
    try {
      isLoading.value = true;

      Map<String, dynamic> map = {
        "role_id": roleId,
        "user_id": userId,
        "project_id": projectId,
      };

      var responseData = await globApiCall('get_roles_details', map);
      log("📥 Raw Permission Response: $responseData");

      final permissionModel = await Permission.fromJson(responseData);

      final rolesMap =
          await permissionModel.data?.rolesArry?.entitlementMap ?? {};

      // Clear and assign new data
      selectRoles.assignAll(rolesMap.entries);
      // These fields come directly from `data`, not rolesArry
      final entitlementList = await permissionModel.data?.entitlementId ?? [];
      entitlementIds.assignAll(entitlementList);

      final projectsList = await permissionModel.data?.projects ?? [];
      projectIds.assignAll(projectsList);

      roleMessage.value = await permissionModel.data?.rolemessage ?? '';
      roleStatus.value = await permissionModel.data?.rolestatus ?? 0;
      safetyAdmin.value = await permissionModel.data?.safetyAdmin ?? 0;

      log('Roles Count: ${selectRoles.length}');
      log('Entitlement IDs: $entitlementIds');
      log('Projects: $projectIds');
      log('Role Message: ${roleMessage.value}');
      log('Role Status: ${roleStatus.value}');
      log('Safety Admin: ${safetyAdmin.value}');
      log('Roles Count: ${selectRoles.length}');
      log("📥 -------------------------: $selectRoles");
    } catch (e) {
      print("Error loading roles: $e");
    } finally {}
  }

  Future<void> resetRolesData() async {
    selectRoles.clear();
    entitlementIds.clear();
    projectIds.clear();
    roleMessage.value = '';
    roleStatus.value = 100;
    safetyAdmin.value = 0;
    print("All project data clear");
  }
}
