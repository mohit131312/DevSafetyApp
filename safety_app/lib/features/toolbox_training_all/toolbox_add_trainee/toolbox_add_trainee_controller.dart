import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/toolbox_training_all/seletc_trainee/select_trainee_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class ToolboxAddTraineeController extends GetxController {
  var traineeimg = <XFile>[];
  final SelectTraineeController selectTraineeController =
      Get.put(SelectTraineeController());
  var traineeImageCount = 0.obs;

  final maxPhotos = 10;

  // Future<void> picktraineeImages() async {
  //   final ImagePicker picker = ImagePicker();

  //   if (traineeimg.length < maxPhotos) {
  //     int remainingSlots = maxPhotos - traineeimg.length;

  //     final List<XFile> pickedFiles = await picker.pickMultiImage();

  //     final List<XFile> limitedFiles =
  //         pickedFiles.take(remainingSlots).toList();

  //     traineeimg.addAll(limitedFiles);
  //     traineeImageCount.value = traineeimg.length; // ✅ Correct update

  //     log('-----------incidentImageCount------------$traineeImageCount');
  //     log('-----------incidentimg-------------${traineeimg.length}');
  //   }
  // }

  Future<void> picktraineeImages({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    if (traineeimg.length < maxPhotos) {
      int remainingSlots = maxPhotos - traineeimg.length;

      if (source == ImageSource.gallery) {
        final List<XFile> pickedFiles = await picker.pickMultiImage();
        final List<XFile> limitedFiles =
            pickedFiles.take(remainingSlots).toList();
        traineeimg.addAll(limitedFiles);
        log('Picked from Gallery: ${limitedFiles.length} images');
      } else if (source == ImageSource.camera) {
        final XFile? capturedFile =
            await picker.pickImage(source: ImageSource.camera);
        if (capturedFile != null) {
          traineeimg.add(capturedFile);
          log('Captured from Camera: 1 image');
        }
      }

      traineeImageCount.value = traineeimg.length;
      log('-----------traineeImageCount------------$traineeImageCount');
      log('-----------traineeimg-------------${traineeimg.length}');
    }
  }

  void removetraineeImage(int index) {
    if (index >= 0 && index < traineeimg.length) {
      traineeimg.removeAt(index);
      traineeImageCount.value = traineeimg.length;

      log('Removed image at index $index from incidentimg. Remaining: ${traineeImageCount.value}');
    }
  }

  var isTraineeExpanded = true.obs; // Observable to track expansion state

  void toggleTraineeExpansion() {
    isTraineeExpanded.value = !isTraineeExpanded.value;
  }

  ScrollController scrollLabourController = ScrollController();
  ScrollController scrollStaffController = ScrollController();
  ScrollController scrollContractorController = ScrollController();

  @override
  void dispose() {
    scrollLabourController.dispose();
    scrollStaffController.dispose();
    scrollContractorController.dispose();
    super.dispose();
  }

  var involvedError = ''.obs;

  var signatureVisibility = <int, bool>{}.obs; // Track signature visibility
  var signatureControllers =
      <int, SignatureController>{}.obs; // Store controllers per item

  void toggleSignature(int index) {
    signatureVisibility[index] = !(signatureVisibility[index] ?? false);
    signatureVisibility.refresh();
    if (!signatureControllers.containsKey(index)) {
      signatureControllers[index] = SignatureController(
        penStrokeWidth: 3,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white,
      );
    }
    signatureControllers.refresh();
  }

  void clearSignature(int index) {
    signatureControllers[index]?.clear();
    signatureVisibility.refresh();
  }

  var combinedIncidentIdsFinal = <Map<String, String>>[].obs;

  Future<String?> saveSignature(int userId) async {
    try {
      if (!signatureControllers.containsKey(userId)) {
        log("❌ No signature controller found for user $userId");
        return null;
      }

      Uint8List? signatureBytes =
          await signatureControllers[userId]?.toPngBytes();

      if (signatureBytes != null && signatureBytes.isNotEmpty) {
        Directory tempDir = await getTemporaryDirectory();
        File signatureFile = File('${tempDir.path}/signature_$userId.png');
        await signatureFile.writeAsBytes(signatureBytes);
        log("✅ Signature saved at: ${signatureFile.path} for user $userId");
        return signatureFile.path;
      } else {
        log("⚠️ Signature for user $userId is empty or null.");
        return null;
      }
    } catch (e) {
      log("❌ Error saving signature for user $userId: $e");
      return null;
    }
  }

  var traineeSignBehalf = <int, bool>{}.obs;

  void toggleTraineeSignBehalf(int labourId) {
    traineeSignBehalf[labourId] = !(traineeSignBehalf[labourId] ?? false);
    update();
  }

  var signatureSaveMessages = <String, String>{}.obs;
  Future<void> updateCombinedList(status, id) async {
    combinedIncidentIdsFinal.clear();
    for (var e in selectTraineeController.selectedIncidentLabourIdsFinal) {
      int userId = e["id"];

      if (!signatureControllers.containsKey(userId)) {
        log("❌ No signature controller found for user $userId");
        continue;
      }

      //
      String? signaturePath = await saveSignature(userId);
      String traineesSignBehalf = traineeSignBehalf[userId] == true ? "1" : "0";

      combinedIncidentIdsFinal.add({
        "user_type": "1",
        "trainees_id": userId.toString(),
        "trainees_sign_behalf": traineesSignBehalf,
        "trainees_signature_photo": signaturePath ?? "",
      });
      if (status && userId == id) {
        if (signaturePath != null && signaturePath.isNotEmpty) {
          // If signature is not empty, show success
          signatureSaveMessages[userId.toString()] =
              "Signature saved successfully.";
        } else {
          // If signature is empty, show the error message for that specific user
          signatureSaveMessages[userId.toString()] =
              "Signature cannot be empty";
        }

        // Clear the message after 3 seconds
        Future.delayed(Duration(seconds: 3), () {
          signatureSaveMessages.remove(userId.toString());
        });
      }
    }

    log("✅ Updated Combined List: ${combinedIncidentIdsFinal.toList()}");
  }

  void removeIncidentData2(int id) {
    log("Removing  ID: $id");

    signatureVisibility.remove(id);
    signatureControllers.remove(id);
    combinedIncidentIdsFinal.remove(id);
    clearSignature(id);
    combinedIncidentIdsFinal
        .removeWhere((element) => element["user_id"] == id.toString());

    signatureVisibility.refresh();
    signatureControllers.refresh();
    traineeSignBehalf.remove(id);
    traineeSignBehalf.refresh();
    combinedIncidentIdsFinal.refresh();

    log("Updated traineeSignBehalf: ${traineeSignBehalf}");

    log("Updated combinedIncidentIdsFinal: ${combinedIncidentIdsFinal.toList()}");
    log("Updated signatureVisibility: ${signatureVisibility}");
    log("Updated signatureVisibility: ${signatureControllers}");
  }

  var photoError = ''.obs;
  void validateTraineeImage() {
    if (traineeImageCount.value == 0) {
      photoError.value = "Please select at least one image.";
    } else {
      photoError.value = "";
    }
  }

  var trainnerError = ''.obs;
  void validateIncidentSelection() {
    signatureVisibility.refresh();

    if (combinedIncidentIdsFinal.isEmpty) {
      trainnerError.value =
          "Please add at least one trainee & Signature is required for all trainees.";
      trainnerError.value = "";
      log("🚨 Trainner Error: ${trainnerError.value}");
      return;
    } else {
      trainnerError.value = "";
    }
    bool allTraineesSigned = true;
    for (var trainee in selectTraineeController.addIncidentInvolvePerson) {
      final signatureController = signatureControllers[trainee.id];

      if (signatureController == null || signatureController.isEmpty) {
        allTraineesSigned = false;
        break;
      }
    }

    // Show error message if any trainee has not signed
    if (!allTraineesSigned) {
      trainnerError.value =
          "All trainees must enter their signature before proceeding.";
      log("🚨 Signature Error: ${trainnerError.value}");
      return;
    }

    log("✅ Validation Passed: All trainees have signed.");
    bool isSignatureMissing = combinedIncidentIdsFinal.any((entry) {
      return (entry["trainees_signature_photo"] ?? "").isEmpty;
    });

    if (isSignatureMissing) {
      trainnerError.value =
          "Please add at least one trainee & Signature is required for all trainees.";
      log("🚨 Signature Error: ${trainnerError.value}");
    }
  }

  void clearAllData() {
    // Reset trainee images
    traineeimg.clear();
    traineeImageCount.value = 0;

    // Reset trainee expansion state
    isTraineeExpanded.value = true;

    // Clear signature-related data
    signatureVisibility.clear();
    signatureControllers.forEach((key, controller) => controller.clear());
    signatureControllers.clear();

    // Clear trainee sign on behalf data
    traineeSignBehalf.clear();

    // Clear combined incident list
    combinedIncidentIdsFinal.clear();

    // Clear errors
    photoError.value = '';
    trainnerError.value = '';
    involvedError.value = '';

    log("✅ ToolboxAddTraineeController data has been cleared");
  }
}
