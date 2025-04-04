import 'dart:developer';

import 'package:flutter_app/utils/api_client.dart';
import 'package:get/get.dart';

import 'select_role_model.dart';

class SelectRoleController extends GetxController {
  var selectedIndex = (-1).obs;
  var roleId = 0.obs;
  var userId = 0.obs;
  var username = ''.obs;
  var userimg = ''.obs;
  var userDesg = ''.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  List<RolesArray> roleArray = [];
  Map<String, dynamic> selectRoleMap = {};

  @override
  void onInit() {
    super.onInit();

    selectRoleMap = ApiClient.gs.read('SelectRoleMap') ?? {};

    print(" method call ==============================================");

    if (selectRoleMap.isNotEmpty) {
      log('SelectRoleMap: ${selectRoleMap.toString()}');
      log('selectRoleMap lenght ${selectRoleMap.length}');
      userIdAndName();
      roleArray = (selectRoleMap['roles_array'] as List<dynamic>)
          .map((e) => RolesArray.fromJson(e as Map<String, dynamic>))
          .toList();

      log('selectRolearray lenght ${roleArray.length}');
    }
  }

  void userIdAndName() async {
    userId.value = await selectRoleMap['user_id'];
    username.value = await selectRoleMap['user_name'];
    userimg.value = await selectRoleMap['user_photo'];

    await ApiClient.gs.write('user_id', userId.value);
    await ApiClient.gs.write('username', username.value);
    await ApiClient.gs.write('user_img', userimg.value);

    log(" Stored User ID: ${userId.value}");
    log(" Stored Username: ${username.value}");
    log(" Stored User ID: ${userId.value}");
    log(" Stored Username: ${username.value}");
    log(" Stored Role ID: ${roleId.value}");
    log(" Stored userphoto ID: ${userimg.value}");
  }

  void selectRole(int index) async {
    if (index >= 0 && index < roleArray.length) {
      selectedIndex.value = index;
      roleId.value = roleArray[index].id;
      userDesg.value = roleArray[index].roleName;
      await ApiClient.gs.write('selected_index', selectedIndex.value);
      await ApiClient.gs.write('role_id', roleId.value);
      await ApiClient.gs.write('role_name', userDesg.value);

      log(" Stored Selected Index: ${selectedIndex.value}");
      log(" Stored Role ID: ${roleId.value}");
      log(" Stored Role name: ${userDesg.value}");
    } else {
      log(" Invalid role index");
    }
  }
}
