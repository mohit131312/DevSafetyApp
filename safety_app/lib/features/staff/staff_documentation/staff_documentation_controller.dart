import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class StaffDocumentationController extends GetxController {
  var aadhaarError = ''.obs;
  var documentError = ''.obs;
  var photoError = ''.obs;
  var validityError = ''.obs;
  var idNumberError = ''.obs;

  var staffAdharcard = <XFile>[];
  TextEditingController adharnoController = TextEditingController();
  TextEditingController idnoController = TextEditingController();
  TextEditingController validityController = TextEditingController();

  var validityText = ''.obs;
  var idnoText = ''.obs;
  @override
  void onInit() {
    super.onInit();
    validityController.addListener(() {
      validityText.value = validityController.text;
    });

    idnoController.addListener(() {
      idnoText.value = idnoController.text;
    });
  }

  var staffotherimg = <XFile>[];

  var otherImageCount = 0.obs;

  final maxPhotos2 = 1;
  var staffimg = <XFile>[].obs;
  var documentType = <String>[].obs;
  var documentTypeName = <String>[].obs;

  var idNumber = <String>[].obs;
  var validity = <String>[].obs;

  void addStaffImg() {
    if (documentType.contains(selectedIdProofId.value.toString())) {
      documentError.value = "This document type has already been added";
      return;
    }
    staffimg.addAll(staffotherimg);
    documentType.add(selectedIdProofId.value.toString());
    documentTypeName.add(selectedDoctType.value.toString());

    idNumber.add(idnoText.value);
    validity.add(
      validityController.text,
    );
    documentError.value = "";
    idNumberError.value = "";
    validityError.value = "";
    photoError.value = "";
    print('staffimg: ${staffimg.length}');

    print('documentType: ${documentType.length}');
    print('documentTypeName: ${documentTypeName.length}');

    print('idNumber: ${idNumber.length}');
    print('validity: ${validity.length}');
    staffimg.refresh();
    documentType.refresh();
    documentTypeName.refresh();
    idNumber.refresh();
    validity.refresh();
  }

  void clearAll() {
    staffotherimg.clear();
    selectedDoctType.value = '';
    idnoController.clear();
    validityController.clear();
    otherImageCount.value = staffotherimg.length;
    log('Removed image at index  from Other Images. Remaining: ${otherImageCount.value}');
  }

  void removeByIndex(int index) {
    staffimg.removeAt(index);
    documentType.removeAt(index);
    documentTypeName.removeAt(index);
    idNumber.removeAt(index);
    validity.removeAt(index);
    print('staffimg: ${staffimg.length}');
    print('documentType: ${documentType.length}');
    print('documentTypeName: ${documentTypeName.length}');
    print('idNumber: ${idNumber.length}');
    print('validity: ${validity.length}');
  }

  void removeByAll() {
    staffimg.clear();
    documentType.clear();
    documentTypeName.clear();
    idNumber.clear();
    validity.clear();
    print('staffimg: ${staffimg.length}');
    print('documentType: ${documentType.length}');
    print('documentTypeName: ${documentTypeName.length}');
    print('idNumber: ${idNumber.length}');
    print('validity: ${validity.length}');
  }

  Future<void> pickotherImages(ImageSource source) async {
    if (staffotherimg.length < maxPhotos2) {
      final ImagePicker picker = ImagePicker();
      if (source == ImageSource.gallery) {
        // Pick multiple images from the gallery
        final List<XFile> pickedFiles = await picker.pickMultiImage();
        if (pickedFiles.isNotEmpty) {
          staffotherimg.addAll(pickedFiles);
          log('Picked from Gallery: ${pickedFiles.length} images');
        }
      } else {
        // Capture a single image from the camera
        XFile? capturedFile =
            await picker.pickImage(source: ImageSource.camera);
        if (capturedFile != null) {
          staffotherimg.add(capturedFile);
          log('Captured from Camera: 1 image');
        }
      }

      otherImageCount.value = staffotherimg.length;
      log('-----------otherImageCount-------------${otherImageCount.value}');
    }
  }

  void removeOtherImage(int index) {
    if (index >= 0 && index < staffotherimg.length) {
      log('in removeOtherImage');

      staffotherimg.removeAt(index);
      otherImageCount.value = staffotherimg.length;
      log('Removed image at index $index from Other Images. Remaining: ${otherImageCount.value}');
    }
  }

  void removeAllOtherImage() {
    // otherImageCount.value = 0;
    staffimg.clear();
    validity.clear();
    documentType.clear();
    documentTypeName.clear();
    idNumber.clear();
  }

  var allstaffimgDataCount = 0.obs;
  var allstaffimgData = <XFile>[];

  var adharImageCount = 0.obs;
  final maxPhotos = 1;

  Future<void> pickadharImages() async {
    final ImagePicker picker = ImagePicker();

    if (staffAdharcard.length < maxPhotos) {
      int remainingSlots = maxPhotos - staffAdharcard.length;

      final List<XFile> pickedFiles = await picker.pickMultiImage();

      final List<XFile> limitedFiles =
          pickedFiles.take(remainingSlots).toList();

      staffAdharcard.addAll(limitedFiles);
      // updateAllstaffimgrImages();
      adharImageCount.value = staffAdharcard.length; // ✅ Correct update

      log('-----------adharImageCount------------$adharImageCount');
      log('-----------staffAdharcard-------------${staffAdharcard.length}');
    }
  }

  // // ✅ Function to remove an image from staffimgrAdharcard
  // void removeAdharImage(int index) {
  //   if (index >= 0 && index < staffimgrAdharcard.length) {
  //     staffimgrAdharcard.removeAt(index);
  //     adharImageCount.value = staffimgrAdharcard.length;
  //     // updateAllstaffimgrImages();

  //     log('Removed image at index $index from AdharCard. Remaining: ${adharImageCount.value}');
  //   }
  // }

  //-------------------- API Handling --------------------

  //---------------------
  var selectedDoctType = ''.obs;
  var selectedreasons = ''.obs;
  var selectedIdProofId = 0.obs; // Stores the selected document's ID

  var selectedDateValidity = Rxn<DateTime>();
  final TextEditingController dateController = TextEditingController();

  void updateDateValidity(DateTime newDate) {
    selectedDateValidity.value = newDate;
    validityController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  var shouldValidate = false.obs; // Controls validation state

  void enableValidation() {
    shouldValidate.value = false;
  }
}
