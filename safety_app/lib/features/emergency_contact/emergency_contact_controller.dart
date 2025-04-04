import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactController extends GetxController {
  Future<void> makeCall(String phoneNumber) async {
    // Ensure the phone number is valid for the 'tel' scheme
    final Uri callUri = Uri.parse('tel:$phoneNumber');
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(callUri.toString())) {
        // ignore: deprecated_member_use
        await launch(callUri.toString());
      } else {
        Get.snackbar(
          'Error',
          'Unable to launch dialer. Please check your number or phone settings.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while trying to make a call.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
