import 'dart:developer';
import 'package:flutter_app/features/login/login_screen.dart';
import 'package:flutter_app/features/select_project/select_project_controller.dart';
import 'package:flutter_app/features/select_project/select_project_screen.dart';
import 'package:flutter_app/features/select_role/select_role.dart';
import 'package:flutter_app/features/select_role/select_role_controller.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/gloabal_var.dart';
import 'package:get/get.dart';

import '../login/login_controller.dart';

class SplashController extends GetxController {
  late SelectProjectController selectProjectController;
  final LoginController loginController = Get.put(LoginController());

  @override
  Future<void> onInit() async {
    super.onInit();

    if (!Get.isRegistered<SelectProjectController>()) {
      selectProjectController = Get.put(SelectProjectController());
    } else {
      selectProjectController = Get.find<SelectProjectController>();
    }

    Future.delayed(Duration(seconds: 2), () async {
      await _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    try {
      log("Token is: ${ApiClient.gs.read('token')}");
      log("Login status: ${ApiClient.gs.read('login')}");

      if (ApiClient.gs.read('login') == true) {
        final userId = ApiClient.gs.read('user_id');
        final usernameOld = ApiClient.gs.read('username');
        final userimg = ApiClient.gs.read('user_img');
        final rolename = ApiClient.gs.read('role_name');
        usernameLogin.value = ApiClient.gs.read('username');

        final roleId = ApiClient.gs.read('role_id');
        if (roleId == null || roleId == 0) {
          log("Role ID is null or 0, navigating to SelectRole");
          final SelectRoleController selectRoleController =
              Get.put(SelectRoleController());
          await selectRoleController.getRoles(userId);
          Get.offAll(SelectRole(
            userId: userId,
            userImg: userimg,
          ));
          return;
        } else {
          log("User ID: $userId");
          log("Role ID: $roleId");
          log("usernameOld: $usernameOld");
          log("global usernameLogin: $usernameLogin");
          log("userimg: $userimg");
          log("rolename: $rolename");

          if (userId != null && roleId != null) {
            await selectProjectController.getProjectDetails(userId, roleId);
          }

          Get.offAll(() => SelectProjectScreen(
              userId: userId,
              roleId: roleId,
              userName: usernameLogin.value,
              userImg: userimg,
              userDesg: rolename));
        }
      } else {
        Get.offAll(LoginScreen());
        log("Navigating to Login Screen");
      }
    } catch (e) {
      log("Error in _checkLoginStatus: $e");
      Get.offAll(LoginScreen());
    }
  }
}
