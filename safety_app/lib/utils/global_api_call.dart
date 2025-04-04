import 'dart:convert';
import 'dart:developer';

import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/logout_user.dart';

Future globApiCall(String url, map) async {
  log("token is ${ApiClient.gs.read('token')}");
  log("api name  is $url");

  log('--------------------$map');

  var response = await RemoteServices.postMethodWithToken(url, map);

  if (response.statusCode == 200) {
    //  log('--------------------${jsonDecode(response.body)}');
    Map<String, dynamic> responseData = jsonDecode(response.body);
    if (responseData['status'] == false) {
      if (responseData['message'] == "User not found") {
        logout();
      } else {
        return responseData;
      }
    } else {
      return responseData;
    }
  } else {
    log('error');
  }
}
