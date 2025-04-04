import 'dart:developer';

import 'package:flutter_app/utils/global_api_call.dart';
import 'package:get/get.dart';

class ProfileDetailsController extends GetxController {
  Map<String, dynamic> profiledetails = {};
  Future getProfileDetails() async {
    try {
      Map<String, dynamic> map = {};

      var responseData = await globApiCall('get_user_profile', map);

      profiledetails = await responseData['data'];

      print('----------profiledetails$profiledetails');
      log('----------profiledetails${profiledetails.length}');
    } catch (e) {
      print("Error: $e");
    }
  }
}
