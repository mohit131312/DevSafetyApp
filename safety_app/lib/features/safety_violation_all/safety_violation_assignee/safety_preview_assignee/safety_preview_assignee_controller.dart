import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SafetyPreviewAssigneeController extends GetxController {
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

  var assignerincidentimg = <XFile>[];

  var assignerincidentImageCount = 0.obs;

  final maxPhotos = 5;

  Future<void> pickAssignorImages() async {
    final ImagePicker picker = ImagePicker();

    if (assignerincidentimg.length < maxPhotos) {
      int remainingSlots = maxPhotos - assignerincidentimg.length;

      final List<XFile> pickedFiles = await picker.pickMultiImage();

      final List<XFile> limitedFiles =
          pickedFiles.take(remainingSlots).toList();

      assignerincidentimg.addAll(limitedFiles);
      assignerincidentImageCount.value =
          assignerincidentimg.length; // ✅ Correct update

      log('-----------incidentImageCount------------$assignerincidentImageCount');
      log('-----------assignerincidentimg-------------${assignerincidentimg.length}');
    }
  }

  void removeAssignorImage(int index) {
    if (index >= 0 && index < assignerincidentimg.length) {
      assignerincidentimg.removeAt(index);
      assignerincidentImageCount.value = assignerincidentimg.length;

      log('Removed image at index $index from incidentimg. Remaining: ${assignerincidentImageCount.value}');
    }
  }
}
