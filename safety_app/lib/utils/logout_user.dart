import 'dart:developer';

import 'package:flutter_app/features/login/login_screen.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:get/get.dart';

String baseUrl = "http://192.168.1.72/Kumar/KumarProperties/storage/app/";
String baseUrl2 = "http://192.168.1.72/Kumar/KumarProperties/";

bool logStatus = true;
void logout() {
  print("Before ${ApiClient.gs.read("login")}");
  ApiClient.gs.write('token', "");
  ApiClient.gs.write('user_id', "");
  ApiClient.gs.write('username', "");
  ApiClient.gs.write('tokrole_iden', "");

  ApiClient.gs.write('login', false);
  ApiClient.gs.remove('SelectRoleMap');
  logStatus = false;
  ApiClient.gs.erase();

  log("token is ${ApiClient.gs.read('token')}");
  log("login is ${ApiClient.gs.read('login')}");
  Get.offAll(() => LoginScreen());
}
