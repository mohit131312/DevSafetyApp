import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_details/work_permit_preview_maker_model.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class WorkPermitCheckerDetailsController extends GetxController {
  final GlobalKey signatureSectionKey = GlobalKey();

  var workpermitExpanded = true.obs;
  void toggleExpansionWorkpermit() {
    workpermitExpanded.value = !workpermitExpanded.value;
  }

  var isprecautionworkpermitExpanded = true.obs;

  void toggleExpansionPrecaution() {
    isprecautionworkpermitExpanded.value =
        !isprecautionworkpermitExpanded.value;
  }

  TextEditingController workPermitRemarksController = TextEditingController();
  FocusNode workPermitRemarksFocusNode = FocusNode();
  TextEditingController workPermitRemarksControllerenable =
      TextEditingController();

  List<WorkPermit> workPermitsCheckerDetails = [];
  List<SelectedSubActivity> subActivityWPCheckerDetails = [];
  Map<String, dynamic> buildingListWPCheckerList = {};
  Map<String, dynamic> categoryListWPCheckerList = {};
  List<CheckerInformation> checkerInformation = [];
  var savedSignatureUrlfetch = ''.obs;
  List<MakerInformation> makerInformation = [];
  List<SelectedToolboxTraining> selectedToolboxTrainingMaker = [];

  var userFound = false.obs;
  Future getWorkPermitCheckerDetails(
      projcetId, userId, userType, workpermitId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
        "work_permit_id": workpermitId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_selected_work_permit_details', map);
      var data = await responseData['data'];
      log("Request body: $data");

      //-------------------------------------------------
      workPermitsCheckerDetails = (await data['work_permits'] as List<dynamic>)
          .map((e) => WorkPermit.fromJson(e as Map<String, dynamic>))
          .toList();
      subActivityWPCheckerDetails = (await data['selected_sub_activity']
              as List<dynamic>)
          .map((e) => SelectedSubActivity.fromJson(e as Map<String, dynamic>))
          .toList();
      selectedToolboxTrainingMaker = (data['selected_toolbox_training']
                  as List<dynamic>?)
              ?.map((e) =>
                  SelectedToolboxTraining.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      checkerInformation = (await data['checker_information'] as List<dynamic>)
          .map((e) => CheckerInformation.fromJson(e as Map<String, dynamic>))
          .toList();

      buildingListWPCheckerList = (data['building_list'] != null &&
              data['building_list'] is Map<String, dynamic>)
          ? data['building_list']
          : {};

      categoryListWPCheckerList = (data['category_list'] != null &&
              data['category_list'] is Map<String, dynamic>)
          ? data['category_list']
          : {};

      makerInformation = (await data['maker_information'] as List<dynamic>)
          .map((e) => MakerInformation.fromJson(e as Map<String, dynamic>))
          .toList();
      workPermitsCheckerDetails[0].status != "0"
          ? userFound.value = true
          : userFound.value = false;
      workPermitRemarksController.text =
          await checkerInformation[0].checkerComment ?? '';
      savedSignatureUrlfetch.value =
          await '${checkerInformation[0].checkerSignaturePhoto ?? ''}';
      log('savedSignatureUrlOrBase64: ${savedSignatureUrlfetch.value}');

      log('----------=workPermitsMakerDetails: ${(workPermitsCheckerDetails.length)}');
      log('----------=subActivityWPMakerDetails: ${(subActivityWPCheckerDetails.length)}');
      log('----------=categoryListWPMakerList: ${(categoryListWPCheckerList.length)}');
      log('----------=building: ${(buildingListWPCheckerList.length)}');
      log('----------=CheckerInformation: ${(checkerInformation.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  //---------------------------------------
  var signatureattestationError = ''.obs;

  final SignatureController signatureCheckerController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  var savedCheckerSignature = Rxn<Uint8List>();

  void clearSafetyattestationSignature() {
    signatureCheckerController.clear();
    savedCheckerSignature.value = null;
    signatureattestationError.value = "";
  }

  File signatureFile = File('');

  Future<void> saveSafetyCheckerSignature() async {
    try {
      Uint8List? signatureBytes = await signatureCheckerController.toPngBytes();

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

  //-----------------------

  //----------------------------
  String validationmsg = '';
  bool apiStatus = false;

  Future<void> safetySaveWorkPermitCommentChecker(
      BuildContext c, wpId, status) async {
    log("status: $status");
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());

      var request = await http.MultipartRequest(
          "POST",
          Uri.parse(
              '${RemoteServices.baseUrl}save_work_permit_checker_comment'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['work_permit_id'] = wpId.toString();
      request.fields['checker_comment'] =
          workPermitRemarksController.text.toString();

      request.files.add(await http.MultipartFile.fromPath(
        'checker_signature_photo',
        signatureFile.path,
      ));
      request.fields['status'] = status.toString();

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

  void clearwpCheckerComment() {
    signatureCheckerController.clear();
    savedCheckerSignature.value = null;
    signatureattestationError.value = "";
    signatureFile = File('');
    validationmsg = "";
    apiStatus = false;

    workpermitExpanded.value = true;
    isprecautionworkpermitExpanded.value = true;
    userFound.value = false;

    // Clear text controllers
    workPermitRemarksController.clear();
    workPermitRemarksControllerenable.clear();

    // Clear lists and maps
    workPermitsCheckerDetails.clear();
    subActivityWPCheckerDetails.clear();
    selectedToolboxTrainingMaker.clear();
    checkerInformation.clear();
    makerInformation.clear();
    buildingListWPCheckerList.clear();
    categoryListWPCheckerList.clear();

    // Reset signature-related variables
    signatureCheckerController.clear();
    savedCheckerSignature.value = null;
    signatureattestationError.value = "";
    signatureFile = File('');
    savedSignatureUrlfetch.value = '';

    // Reset validation and API status
    validationmsg = '';
  }
}
