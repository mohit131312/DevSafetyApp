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

class WorkPermitPreviewMakerController extends GetxController {
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

  TextEditingController workPermitRemarksController = TextEditingController();
  FocusNode workPermitmakerFocusNode = FocusNode();
  final GlobalKey signatureSectionKey = GlobalKey();

  TextEditingController workPermitRemarksControllerenable =
      TextEditingController();

  List<WorkPermit> workPermitsMakerDetails = [];
  List<SelectedSubActivity> subActivityWPMakerDetails = [];
  Map<String, dynamic> buildingListWPMakerList = {};
  Map<String, dynamic> categoryListWPMakerList = {};
  // CategoryList categoryList = {} as CategoryList;
  List<CheckerInformation> checkerInformation = [];
  List<MakerInformation> makerInformation = [];
  List<SelectedToolboxTraining> selectedToolboxTrainingMaker = [];

  var savedSignatureUrlfetch = ''.obs;

  var userFound = false.obs;

  Future getWorkPermitMakerDetails(
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
      workPermitsMakerDetails = (await data['work_permits'] as List<dynamic>)
          .map((e) => WorkPermit.fromJson(e as Map<String, dynamic>))
          .toList();
      subActivityWPMakerDetails = (await data['selected_sub_activity']
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
      makerInformation = (await data['maker_information'] as List<dynamic>)
          .map((e) => MakerInformation.fromJson(e as Map<String, dynamic>))
          .toList();

      buildingListWPMakerList = (data['building_list'] != null &&
              data['building_list'] is Map<String, dynamic>)
          ? data['building_list']
          : {};

      categoryListWPMakerList = (data['category_list'] != null &&
              data['category_list'] is Map<String, dynamic>)
          ? data['category_list']
          : {};

      workPermitRemarksControllerenable.text =
          checkerInformation[0].checkerComment ?? '';

      workPermitsMakerDetails[0].status == "3"
          ? userFound.value = true
          : userFound.value = false;
      workPermitRemarksController.text =
          workPermitsMakerDetails[0].makerComment ?? '';
      savedSignatureUrlfetch.value =
          await '${workPermitsMakerDetails[0].makerSignaturePhotoAfter ?? ''}';
      log('-------------status--------------: ${workPermitsMakerDetails[0].status}');
      log('-------------userFound.value--------------: ${userFound.value}');
      log('savedSignatureUrlOrBase64: ${savedSignatureUrlfetch.value}');

      log('----------=workPermitsMakerDetails: ${(workPermitsMakerDetails.length)}');
      log('----------=subActivityWPMakerDetails: ${(subActivityWPMakerDetails.length)}');
      log('----------=categoryListWPMakerList: ${(categoryListWPMakerList.length)}');
      log('----------=building: ${(buildingListWPMakerList.length)}');
      log('----------=CheckerInformation: ${(checkerInformation.length)}');
      log('----------=makerInformation: ${(makerInformation.length)}');
      log('----------=selectedToolboxTrainingMaker: ${(selectedToolboxTrainingMaker.length)}');
      //-------------------------------------------------
    } catch (e) {
      print("Error: $e");
    }
  }

  //---------------------------------------
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
      Uint8List? signatureBytes =
          await signatureattestationController.toPngBytes();

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

  Future<void> safetySaveWorkPermitComment(
    BuildContext c,
    wpId,
  ) async {
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());

      var request = await http.MultipartRequest("POST",
          Uri.parse('${RemoteServices.baseUrl}save_work_permit_maker_comment'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['work_permit_id'] = wpId.toString();
      request.fields['maker_comment'] =
          workPermitRemarksController.text.toString();

      request.files.add(await http.MultipartFile.fromPath(
        'maker_signature_photo_after',
        signatureFile.path,
      ));
      request.fields['status'] = 3.toString();

      log("Final Request Fields: ${jsonEncode(request.fields)}");
      log("Final Request Files: ${request.files.map((file) => file.filename).toList()}");

      await request.send().then((response) async {
        log("Response Status Code: ${response.statusCode}");

        await http.Response.fromStream(response).then((onValue) async {
          log("Response Body: ${onValue.body}");

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

  void clearwpComment() {
    signatureattestationController.clear();
    savedAttestationSignature.value = null;
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

    // Clear API-related fields
    validationmsg = '';
    apiStatus = false;
    savedSignatureUrlfetch.value = '';
    // Clear lists and maps
    workPermitsMakerDetails.clear();
    subActivityWPMakerDetails.clear();
    selectedToolboxTrainingMaker.clear();
    checkerInformation.clear();
    makerInformation.clear();
    buildingListWPMakerList.clear();
    categoryListWPMakerList.clear();
  }
}
