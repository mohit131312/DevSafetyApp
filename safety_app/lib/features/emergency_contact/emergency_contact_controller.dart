import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactController extends GetxController {
  Future<void> makeCall(String phoneNumber) async {
    final Uri callUri = Uri.parse('tel:$phoneNumber');
    try {
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
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
        'An error occurred while trying to make a call: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
