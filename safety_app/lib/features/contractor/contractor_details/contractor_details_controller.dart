import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/image_helper.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ContractorDetailsController extends GetxController {
  TextEditingController nameController = TextEditingController();
  var nameControllerFocusNode = FocusNode();

  TextEditingController contactnoController = TextEditingController();
  var contactnoFocusNode = FocusNode();

  TextEditingController secondarynameController = TextEditingController();
  var secondarynameFoucsNode = FocusNode();

  TextEditingController secondarycontactController = TextEditingController();
  var secondarycontactnoFocusNode = FocusNode();

  TextEditingController emailidController = TextEditingController();
  var emailidFocusNode = FocusNode();

  TextEditingController idproofController = TextEditingController();
  var idproofFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  var searchFocusNodeAll = FocusNode();
//------------------------------------------------------------

//------------------------------------------------------------

  var documentError = ''.obs;

  String validationmsg = '';
  var searchResults = <Map<String, dynamic>>[].obs;

  Future getSafetyContractorMatchedDetails(
      String id, BuildContext context) async {
    try {
      Map<String, dynamic> map = {"contractor_name": id};
      print("Request body: $map");

      var responseData =
          await globApiCall('get_safety_contractor_details', map);
      // log('----------------SearchResult----------------------${searchResults}');

      // log('API Response: ${responseData}');

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('data')) {
        searchResults.value =
            List<Map<String, dynamic>>.from(responseData['data']);
      } else {
        searchResults.clear();
      }
      if (responseData != null &&
          responseData.containsKey('validation-message')) {
        Map<String, dynamic> validationErrors =
            responseData['validation-message'];

        // Format error messages
        validationmsg = validationErrors.entries
            .map((entry) => '${entry.value.join(", ")}')
            .join("\n\n");

        // Show custom popup instead of snackbar
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomValidationPopup(message: validationmsg);
          },
        );
      } else {
        validationmsg = responseData['message'];

        print('successmsg-------------$validationmsg');
        // Show success message popup

        if (validationmsg != 'Data found succesfully') {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomValidationPopup(message: validationmsg);
            },
          );
        }
      }
      //    searchResults.value = List<Map<String, dynamic>>.from(data['labour']);
    } catch (e) {
      log("Error: $e");
      searchResults.clear();
      //  clearUserFields();
    }
  }

//--------------------------------------------------------
  var docImg = <XFile>[];

  var docImgCount = 0.obs;

  final maxPhotos = 1;

  // Future<void> pickDocImages(ImageSource source) async {
  //   final ImagePicker picker = ImagePicker();

  //   try {
  //     if (docImg.length < maxPhotos) {
  //       XFile? pickedFile;

  //       if (source == ImageSource.gallery) {
  //         pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //       } else {
  //         pickedFile = await picker.pickImage(source: ImageSource.camera);
  //       }

  //       if (pickedFile != null) {
  //         docImg.clear();
  //         docImg.add(pickedFile);
  //         docImgCount.value = docImg.length;
  //         log('Image selected: ${pickedFile.path}');
  //         log('_______________________${docImg.length}');
  //         log('_______________________${docImgCount}');
  //       }
  //     } else {
  //       log('Only one image is allowed.');
  //     }
  //   } catch (e) {
  //     log('Error picking image: $e');
  //   }
  // }
  Future<void> pickDocImages(ImageSource source) async {
    if (docImg.length >= maxPhotos) {
      log('Only one image is allowed.');
      return;
    }

    try {
      // Use your cropping helper
      final XFile? croppedImage =
          await ImageHelper.pickAndCropImage(source: source);

      if (croppedImage != null) {
        docImg.clear(); // Ensure only one image is kept
        docImg.add(croppedImage);
        docImgCount.value = docImg.length;
        if (docImgCount.value > 0) {
          documentError.value = "";
        }

        log('Image selected and cropped: ${croppedImage.path}');
        log('_______________________docImg.length: ${docImg.length}');
        log('_______________________docImgCount: ${docImgCount.value}');
      } else {
        log('${source == ImageSource.camera ? "Camera" : "Gallery"} image picking/cropping cancelled or failed');
      }
    } catch (e) {
      log('Error picking or cropping image: $e');
    }
  }

  void removeDocImage(int index) {
    docImg.clear();
    docImgCount.value = 0;
    log('_______________________${docImg.length}');
    log('_______________________${docImgCount}');
  }
//------------------------------------------------

  var selectedDoctType = ''.obs;
  var validityError = ''.obs;
  var selectedIdProofId = 0.obs;

  var selectedDateValidity = Rxn<DateTime>();

  void updateDateValidity(DateTime newDate) {
    selectedDateValidity.value = newDate;
    validityController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  var shouldValidate = false.obs; // Controls validation state

  void enableValidation() {
    shouldValidate.value = false;
  }

  TextEditingController validityController = TextEditingController();

//----------------------------------
}
