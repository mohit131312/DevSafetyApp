import 'package:get/get.dart';

class WorkPermitCheckerDetailscontroller extends GetxController {
  var workpermitExpanded = true.obs; // Observable to track expansion state

  void toggleExpansionWorkpermit() {
    workpermitExpanded.value = !workpermitExpanded.value;
  }

  var isprecautionworkpermitExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionPrecaution() {
    isprecautionworkpermitExpanded.value =
        !isprecautionworkpermitExpanded.value;
  }
}
