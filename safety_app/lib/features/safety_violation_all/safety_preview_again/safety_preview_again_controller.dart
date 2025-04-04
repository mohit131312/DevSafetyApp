import 'package:get/get.dart';

class SafetyPreviewAgainController extends GetxController {
  var issafetyDetailsExpanded = true.obs; // Observable to track expansion state

  void toggleExpansionSafety() {
    issafetyDetailsExpanded.value = !issafetyDetailsExpanded.value;
  }

  var isinvolvepeople = true.obs; // Observable to track expansion state

  void toggleInvolvedExpansionpeople() {
    isinvolvepeople.value = !isinvolvepeople.value;
  }

  var isinformedpeople = true.obs; // Observable to track expansion state

  void toggleExpansionisinformedpeople() {
    isinformedpeople.value = !isinformedpeople.value;
  }
}
