import 'dart:convert';
import 'dart:developer';

import 'package:flutter_app/features/select_role/select_role_controller.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/gloabal_var.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/validation.dart';
import 'package:flutter_app/utils/validation_invalid.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../utils/validation_popup.dart'; // Import the package

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var userNameFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    username.value = '';
    password.value = '';
    super.dispose();
  }

  String? usernameValidator(String? value) {
    return Validator.validateEmail(value);
  }

  String? passwordValidator(String? value) {
    return Validator.validatePassword(value);
  }

  // Check for network connectivity
  Future<bool> isInternetAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Map<String, dynamic> selectRoleMap = {};
  String validationmsg = '';
  var userId = 0.obs;
  var userimg = ''.obs;
  Future login() async {
    try {
      Map<String, dynamic> map = {
        "email": usernameController.text,
        "password": passwordController.text,
        "FCM_token": "fabf21102951024b",
      };

      print("Request body: $map");

      var response = await RemoteServices.postMethod('safety-login', map);

      validationmsg = '';
      print("response is ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        validationmsg = responseData['message'] ?? "";
        if (validationmsg.isNotEmpty) {
          if (validationmsg == "Invalid Password") {
            await showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return CustomValidationPopupInvalid(message: validationmsg);
              },
            );
          } else if (validationmsg == "User not found") {
            await showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return CustomValidationPopup(message: validationmsg);
              },
            );
          } else {
            // await showDialog(
            //   context: Get.context!,
            //   builder: (BuildContext context) {
            //     return ValidationPopChang(message: validationmsg);
            //   },
            // );
          }
        }
        String accessToken = responseData['data']['access_token'];
        ApiClient.gs.write('token', accessToken);
        ApiClient.gs.write('login', true);
        logStatus = true;
        log("token is ${ApiClient.gs.read('token')}");
        log("login is ${ApiClient.gs.read('login')}");

        selectRoleMap = await responseData['data'];
        usernameLogin.value = await selectRoleMap['user_name'];
        userId.value = await selectRoleMap['user_id'];
        userimg.value = await selectRoleMap['user_photo'];

        await ApiClient.gs.write('user_id', userId.value);
        await ApiClient.gs.write('user_img', userimg.value);
        print('selectRoleMap: $selectRoleMap');
        print('usernameLogin.value: ${usernameLogin.value}');
        await ApiClient.gs.write('username', usernameLogin.value);

        await ApiClient.gs.write('SelectRoleMap', selectRoleMap);
        final SelectRoleController selectRoleController =
            Get.put(SelectRoleController());
        await selectRoleController.getRoles(userId.value);
        log('selectRoleMap: ${selectRoleMap.length}');
        return true;

        // if (formKey.currentState?.validate() ?? false) {
        //   print("Login Success: ${responseData['message']}");

        // }
      } else {
        print("Login Failed: ${response.body}");

        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // Future<void> userIdAndName() async {
  //   userId.value = await selectRoleMap['user_id'];
  //   // username.value = await selectRoleMap['user_name'];
  //   userimg.value = await selectRoleMap['user_photo'];

  //   await ApiClient.gs.write('user_id', userId.value);
  //   await ApiClient.gs.write('user_img', userimg.value);

  //   log(" Stored User ID: ${userId.value}");
  //   log(" Stored usernameLogin: ${usernameLogin.value}");
  //   log(" Stored User ID: ${userId.value}");
  //   log(" Stored usernameLogin: ${usernameLogin.value}");
  //   log(" Stored userphoto ID: ${userimg.value}");
  // }
}
