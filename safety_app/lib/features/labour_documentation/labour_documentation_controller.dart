import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/image_helper.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class LabourDocumentationController extends GetxController {
  var aadhaarError = ''.obs;
  var documentError = ''.obs;
  var photoError = ''.obs;
  var validityError = ''.obs;
  var idNumberError = ''.obs;

  var labourAdharcard = <XFile>[];
  TextEditingController adharnoController = TextEditingController();
  FocusNode adharnoFocus = FocusNode();
  TextEditingController idnoController = TextEditingController();
  TextEditingController validityController = TextEditingController();

  var validityText = ''.obs;
  var idnoText = ''.obs;
  var validatiyoptional = "".obs;
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

  var labourotherimg = <XFile>[];

  var otherImageCount = 0.obs;

  final maxPhotos2 = 1;
  var labourimg = <XFile>[].obs;
  var documentType = <String>[].obs;
  var documentTypeName = <String>[].obs;

  var idNumber = <String>[].obs;
  var validity = <String>[].obs;

  Future<bool> addImg() async {
    if (documentType.contains(selectedIdProofId.value.toString())) {
      documentError.value = "This document type has already been added";
      return false;
    }
    labourimg.addAll(labourotherimg);
    documentType.add(selectedIdProofId.value.toString());
    documentTypeName.add(selectedDoctType.value
        .replaceAll(' *', '')); // Remove asterisk for consistency
    idNumber.add(idnoText.value);
    validity.add(
      validityController.text,
    );
    documentError.value = "";
    idNumberError.value = "";
    validityError.value = "";
    photoError.value = "";
    print('labourimg: ${labourimg.length}');

    print('documentType: ${documentType.length}');
    print('documentTypeName: ${documentTypeName.length}');

    print('idNumber: ${idNumber.length}');
    print('validity: ${validity.length}');
    labourimg.refresh();
    documentType.refresh();
    documentTypeName.refresh();
    idNumber.refresh();
    validity.refresh();
    return true;
  }

  void clearAll() {
    labourotherimg.clear();
    selectedDoctType.value = '';
    idnoController.clear();
    validityController.clear();
    otherImageCount.value = labourotherimg.length;
    log('Removed image at index  from Other Images. Remaining: ${otherImageCount.value}');
  }

  void removeByIndex(int index) {
    labourimg.removeAt(index);
    documentType.removeAt(index);
    documentTypeName.removeAt(index);
    idNumber.removeAt(index);
    validity.removeAt(index);
    print('labourimg: ${labourimg.length}');
    print('documentType: ${documentType.length}');
    print('documentTypeName: ${documentTypeName.length}');
    print('idNumber: ${idNumber.length}');
    print('validity: ${validity.length}');
  }

  void removeByAll() {
    labourimg.clear();
    documentType.clear();
    documentTypeName.clear();
    idNumber.clear();
    validity.clear();
    print('labourimg: ${labourimg.length}');
    print('documentType: ${documentType.length}');
    print('documentTypeName: ${documentTypeName.length}');
    print('idNumber: ${idNumber.length}');
    print('validity: ${validity.length}');
  }

  // Future<void> pickotherImages(ImageSource source) async {
  //   if (labourotherimg.length < maxPhotos2) {
  //     final ImagePicker picker = ImagePicker();
  //     if (source == ImageSource.gallery) {
  //       // Pick multiple images from the gallery
  //       final List<XFile> pickedFiles = await picker.pickMultiImage();
  //       if (pickedFiles.isNotEmpty) {
  //         labourotherimg.addAll(pickedFiles);
  //         log('Picked from Gallery: ${pickedFiles.length} images');
  //       }
  //     } else {
  //       // Capture a single image from the camera
  //       //   XFile? capturedFile =
  //       //       await picker.pickImage(source: ImageSource.camera);
  //       //   if (capturedFile != null) {
  //       //     labourotherimg.add(capturedFile);
  //       //     log('Captured from Camera: 1 image');
  //       //   }
  //       // }

  //       // otherImageCount.value = labourotherimg.length;
  //       // log('-----------otherImageCount-------------${otherImageCount.value}');

  //       //-----------------------------------

  //       final XFile? croppedImage = await ImageHelper.pickAndCropImage(
  //         source: ImageSource.camera,
  //       );

  //       if (croppedImage != null) {
  //         labourotherimg.add(croppedImage);
  //         log('Captured and cropped from Camera: 1 image');
  //       } else {
  //         log('Camera image picking/cropping cancelled or failed');
  //       }
  //     }

  //     otherImageCount.value = labourotherimg.length;
  //     log('-----------otherImageCount-------------${otherImageCount.value}');
  //   }
  // }

  Future<void> pickotherImages(ImageSource source) async {
    if (labourotherimg.length < maxPhotos2) {
      final XFile? croppedImage = await ImageHelper.pickAndCropImage(
        source: source,
      );

      if (croppedImage != null) {
        labourotherimg.add(croppedImage);
        log('Picked and cropped from ${source == ImageSource.camera ? "Camera" : "Gallery"}: 1 image');
      } else {
        log('${source == ImageSource.camera ? "Camera" : "Gallery"} image picking/cropping cancelled or failed');
      }

      otherImageCount.value = labourotherimg.length;
      if (otherImageCount.value > 0) {
        photoError.value = "";
      }
      log('-----------otherImageCount-------------${otherImageCount.value}');
    }
  }

  void removeOtherImage(int index) {
    if (index >= 0 && index < labourotherimg.length) {
      log('in removeOtherImage');

      labourotherimg.removeAt(index);
      otherImageCount.value = labourotherimg.length;
      log('Removed image at index $index from Other Images. Remaining: ${otherImageCount.value}');
    }
  }

  void removeAllOtherImage() {
    // otherImageCount.value = 0;
    labourimg.clear();
    validity.clear();
    documentType.clear();
    documentTypeName.clear();
    idNumber.clear();
  }

  var alllabourImgDataCount = 0.obs;
  var alllabourImgData = <XFile>[];

  var adharImageCount = 0.obs;
  final maxPhotos = 1;

  Future<void> pickadharImages() async {
    final ImagePicker picker = ImagePicker();

    if (labourAdharcard.length < maxPhotos) {
      int remainingSlots = maxPhotos - labourAdharcard.length;

      final List<XFile> pickedFiles = await picker.pickMultiImage();

      final List<XFile> limitedFiles =
          pickedFiles.take(remainingSlots).toList();

      labourAdharcard.addAll(limitedFiles);
      // updateAllLabourImages();
      adharImageCount.value = labourAdharcard.length; // ✅ Correct update

      log('-----------adharImageCount------------$adharImageCount');
      log('-----------labourAdharcard-------------${labourAdharcard.length}');
    }
  }

  // // ✅ Function to remove an image from labourAdharcard
  // void removeAdharImage(int index) {
  //   if (index >= 0 && index < labourAdharcard.length) {
  //     labourAdharcard.removeAt(index);
  //     adharImageCount.value = labourAdharcard.length;
  //     // updateAllLabourImages();

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
    if (validityController.text.isEmpty) {
      validityError.value = "Validity is required";
    } else {
      validityError.value = "";
    }
  }

  var shouldValidate = false.obs; // Controls validation state

  void enableValidation() {
    shouldValidate.value = false;
  }

  //---------------------
  void clearAllData() {
    clearAll(); // Clears labourotherimg, selectedDoctType, idnoController, validityController, and otherImageCount
    removeByAll(); // Clears labourimg, documentType, documentTypeName, idNumber, and validity
    labourAdharcard.clear(); // Clears Aadhaar images
    adharnoController.clear(); // Clears Aadhaar number input
    adharImageCount.value = 0; // Resets Aadhaar image count
    selectedIdProofId.value = 0; // Resets selected document ID
    selectedreasons.value = ''; // Resets selected reasons
    selectedDateValidity.value = null; // Resets selected validity date
    dateController.clear(); // Clears date input
    aadhaarError.value = ''; // Clears Aadhaar error
    documentError.value = ''; // Clears document error
    photoError.value = ''; // Clears photo error
    validityError.value = ''; // Clears validity error
    idNumberError.value = ''; // Clears ID number error
    // shouldValidate.value = false; // Resets validation state
  }

  //-------------------------------------

  // Method to check if all compulsory documents are added
  bool areAllCompulsoryDocumentsAdded() {
    final compulsoryDocs = Get.find<InductionTrainingController>()
        .idProofList
        .where((idproof) => idproof.compulsory == 1)
        .map((idproof) => idproof.listDetails)
        .toList();

    // Check if all compulsory documents are present in documentTypeName
    return compulsoryDocs.every((doc) => documentTypeName.contains(doc));
  }

  // Method to get missing compulsory document names
  List<String> getMissingCompulsoryDocuments() {
    final compulsoryDocs = Get.find<InductionTrainingController>()
        .idProofList
        .where((idproof) => idproof.compulsory == 1)
        .map((idproof) => idproof.listDetails)
        .toList();

    return compulsoryDocs
        .where((doc) => !documentTypeName.contains(doc))
        .toList();
  }
}
