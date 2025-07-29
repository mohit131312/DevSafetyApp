import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_all_list_details/toolbox_training_alllist_model.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class ToolboxTrainingMakerController extends GetxController {
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

  //------------------------------
  final TextEditingController reviewerMakerController = TextEditingController();
  final TextEditingController makerMakerController = TextEditingController();
  FocusNode makerFocusNode = FocusNode();
  GlobalKey signkey = GlobalKey();
  //--------------------------------
  String validationmsg = '';
  bool apiStatus = false;

  List<SafetyToolboxTraining> safetyToolboxMakerTraining = [];
  List<ToolboxCategoryList> toolboxMakerCategoryList = [];
  List<ToolboxInstructionsList> toolboxMakerInstructionsList = [];
  List<TraineeLaboursList> traineeMakerLaboursList = [];
  List<ErUser> makerMakerUser = [];
  List<ErUser> reviewerMakerUser = [];
  List<TbtAddedPhoto> tbtMakerAddedPhotos = [];

  var savedSignatureUrlfetch = ''.obs;

  var userFound = false.obs;
  Future gettoolBoxMakerDetails(projcetId, userId, userType, toolBoxId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
        "safety_toolbox_training_id": toolBoxId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_selected_toolbox_training_details', map);
      var data = await responseData['data'];
      log("Request body: $data");

      //-------------------------------------------------
      safetyToolboxMakerTraining = (await data['safety_toolbox_training']
              as List<dynamic>)
          .map((e) => SafetyToolboxTraining.fromJson(e as Map<String, dynamic>))
          .toList();
      toolboxMakerCategoryList = (await data['toolbox_category_list']
              as List<dynamic>)
          .map((e) => ToolboxCategoryList.fromJson(e as Map<String, dynamic>))
          .toList();
      toolboxMakerInstructionsList =
          (await data['toolbox_instructions_list'] as List<dynamic>)
              .map((e) =>
                  ToolboxInstructionsList.fromJson(e as Map<String, dynamic>))
              .toList();
      traineeMakerLaboursList = (await data['trainee_labours_list']
              as List<dynamic>)
          .map((e) => TraineeLaboursList.fromJson(e as Map<String, dynamic>))
          .toList();
      makerMakerUser = (await data['maker_user'] as List<dynamic>)
          .map((e) => ErUser.fromJson(e as Map<String, dynamic>))
          .toList();
      reviewerMakerUser = (await data['reviewer_user'] as List<dynamic>)
          .map((e) => ErUser.fromJson(e as Map<String, dynamic>))
          .toList();
      tbtMakerAddedPhotos = (await data['tbt_added_photos'] as List<dynamic>)
          .map((e) => TbtAddedPhoto.fromJson(e as Map<String, dynamic>))
          .toList();

      reviewerMakerController.text =
          safetyToolboxMakerTraining[0].reviwerComment ?? '';
      // ignore: unrelated_type_equality_checks
      safetyToolboxMakerTraining[0].status == 2
          ? userFound.value = true
          : userFound.value = false;
      print('status ----${userFound.value}');
      makerMakerController.text =
          safetyToolboxMakerTraining[0].makerComment ?? '';
      savedSignatureUrlfetch.value =
          safetyToolboxMakerTraining[0].makerPhotoSignatureAfter ?? '';
      log('savedSignatureUrlOrBase64: ${savedSignatureUrlfetch.value}');

      log('----------=safetyToolboxTraining: ${(safetyToolboxMakerTraining.length)}');
      log('----------=toolboxCategoryList: ${(toolboxMakerCategoryList.length)}');
      log('----------=toolboxInstructionsList: ${(toolboxMakerInstructionsList.length)}');
      log('----------=traineeLaboursList: ${(traineeMakerLaboursList.length)}');
      log('----------=maker: ${(makerMakerUser.length)}');
      log('----------=rev: ${(reviewerMakerUser.length)}');
      log('----------=tbtAddedPhotos: ${(tbtMakerAddedPhotos.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  var signatureattestationError = ''.obs;

  final SignatureController signatureattestationController =
      SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  var savedAttestationSignature = Rxn<Uint8List>();

  void clearSafetyattestationSignature() {
    signatureattestationController.clear();
    savedAttestationSignature.value = null;
    signatureattestationError.value = "";
  }

  File signatureFile = File('');

  Future<void> saveSafetyattestationSignature() async {
    try {
      const int signatureWidth = 360;
      const int signatureHeight = 206;

      Uint8List? signatureBytes =
          await signatureattestationController.toPngBytes(
        width: signatureWidth,
        height: signatureHeight,
      );

      if (signatureBytes != null) {
        // Save as a file
        Directory tempDir = await getTemporaryDirectory();
        signatureFile = File('${tempDir.path}/signature.png');
        await signatureFile.writeAsBytes(signatureBytes);

        print("Signature saved at: ${signatureFile.path}");
      } else {
        print("Signature is null");
      }
    } catch (e) {
      print("Error saving signature: $e");
      signatureattestationError.value = "";
    }
  }

  Future<void> safetySaveMakerComment(
    BuildContext c,
    tool,
  ) async {
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());

      var request = await http.MultipartRequest("POST",
          Uri.parse('${RemoteServices.baseUrl}save_toolbox_training_comment'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['safety_toolbox_training_id'] = tool.toString();
      request.fields['maker_comment'] = makerMakerController.text.toString();

      request.files.add(await http.MultipartFile.fromPath(
        'maker_photo_signature_after',
        signatureFile.path,
      ));
      request.fields['status'] = 2.toString();

      log("Final Request Fields: ${jsonEncode(request.fields)}");
      log("Final Request Files: ${request.files.map((file) => file.filename).toList()}");

      await request.send().then((response) async {
        log("Response Status Code: ${response.statusCode}");

        await http.Response.fromStream(response).then((onValue) async {
          try {
            Map<String, dynamic> decoded = await jsonDecode(onValue.body);

            log('-------------------------decoded----------------$decoded');
            if (decoded.containsKey('validation-message')) {
              Navigator.pop(Get.context!);

              log("----------------------------------------------------------------------validation: ");

              Map<String, dynamic> validationErrors =
                  decoded['validation-message'];
              validationmsg = validationErrors.entries
                  .map((entry) => '${entry.value.join(", ")}')
                  .join("\n\n");

              await showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return CustomValidationPopup(message: validationmsg);
                },
              );
              Get.back();
            } else {
              validationmsg = await decoded['message'];
              apiStatus = await decoded['status'];
              log("----------------------------------------------------------------------msg: ");
              Navigator.pop(Get.context!, true);

              // await showDialog(
              //   context: Get.context!,
              //   builder: (BuildContext context) {
              //     return ValidationPopChang(message: validationmsg);
              //   },
              // );
              Get.back();
            }
          } catch (e) {
            Navigator.pop(Get.context!, true);

            log("Error parsing response: $e");
          }
        });
      });
    } catch (e) {
      Navigator.pop(Get.context!, true);
      //Get.back();

      log("----------------------------------------------------------------------Erooorrrrrrrrrrrrrrrrr: $e");
      await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CustomValidationPopup(
              message: "Something went wrong. Please try again.");
        },
      );
    }
  }

  void cleartoolboxComment() {
    signatureattestationController.clear();
    savedAttestationSignature.value = null;
    signatureattestationError.value = "";
    signatureFile = File('');
    validationmsg = "";
    apiStatus = false;
    istoolboxExpanded.value = true;
    istraineedetails.value = true;
    isprecaution.value = true;
    userFound.value = false;
    savedSignatureUrlfetch.value = '';
    signatureattestationError.value = '';
    savedAttestationSignature.value = null;

    // Clear text controllers
    reviewerMakerController.clear();
    makerMakerController.clear();

    // Clear lists
    safetyToolboxMakerTraining.clear();
    toolboxMakerCategoryList.clear();
    toolboxMakerInstructionsList.clear();
    traineeMakerLaboursList.clear();
    makerMakerUser.clear();
    reviewerMakerUser.clear();
    tbtMakerAddedPhotos.clear();

    // Reset status and validation

    log("ToolboxTrainingMakerController: All data has been reset.");
  }
}
