import 'package:get/get.dart';

class ToolboxPreviewAgainController extends GetxController {
  var istoolboxExpanded = true.obs; // Observable to track expansion state

  void toolboxtoggleExpansion() {
    istoolboxExpanded.value = !istoolboxExpanded.value;
  }

  var istraineedetails = true.obs; // Observable to track expansion state

  void toggletraineedetailsExpansion() {
    istraineedetails.value = !istraineedetails.value;
  }

  var isprecaution = true.obs; // Observable to track expansion state

  void toggleExpansionisprecaution() {
    isprecaution.value = !isprecaution.value;
  }
}
