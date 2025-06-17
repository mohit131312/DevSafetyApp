import 'dart:developer';

import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/gloabal_var.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

import 'select_role_model.dart';

class SelectRoleController extends GetxController {
  var selectedIndex = (-1).obs;
  var roleId = 0.obs;
  var rolename = ''.obs;

  var userDesg = ''.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  RxList<RolesArray> roleArray = <RolesArray>[].obs;

  Map<String, dynamic> selectRoleMap = {};

  RxBool isRefreshing = false.obs;

  Future<void> getRoles(userId) async {
    shimmerrole.value = roleArray.length;
    isRefreshing.value = true;
    try {
      Map<String, dynamic> map = {"user_id": userId};

      var responseData = await globApiCall('safety_roles', map);
      log("📥 Raw Response: $responseData");
      final rolesArrayJson =
          await responseData['data']['roles_array'] as List<dynamic>;

      final roles = await rolesArrayJson
          .map((roleJson) => RolesArray.fromJson(roleJson))
          .toList();

      roleArray.assignAll(roles);
      log('safety_roles     selectRolearray lenght ${roleArray.length}');
    } catch (e) {
      print("Error: $e");
    } finally {
      isRefreshing.value = false;
    }
  }

  Future<void> selectRole(int index) async {
    if (index >= 0 && index < roleArray.length) {
      await ApiClient.gs.remove('selected_index');
      await ApiClient.gs.remove('role_id');
      await ApiClient.gs.remove('role_name');
      await ApiClient.gs.remove('userDesg');
      selectedIndex.value = index;
      roleId.value = roleArray[index].id;
      rolename.value = roleArray[index].roleName;
      userDesg.value = roleArray[index].roleName;
      await ApiClient.gs.write('selected_index', selectedIndex.value);
      await ApiClient.gs.write('role_id', roleId.value);
      await ApiClient.gs.write('role_name', rolename.value);
      await ApiClient.gs.write('userDesg', rolename.value);

      log(" Stored Selected Index: ${selectedIndex.value}");
      log(" Stored Role ID: ${roleId.value}");
      log(" Stored Role name: ${rolename.value}");
    } else {
      log(" Invalid role index");
    }
  }

  //--------------------------------
}
