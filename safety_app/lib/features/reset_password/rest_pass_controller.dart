import 'package:flutter_app/utils/validation.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  var email = ''.obs;

  String? emailValidator(String? value) {
    return Validator.validateEmail(value); // Reusable email validation
  }
}
