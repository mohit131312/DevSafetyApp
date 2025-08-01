import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_all/safety_violation_details_all_model.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart' as http;

class SafetyViolationDetailsAssignorCont extends GetxController {
  var isincidentdetailsDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionIncedenet() {
    isincidentdetailsDetailsExpanded.value =
        !isincidentdetailsDetailsExpanded.value;
  }

  var isinvolvepeople = true.obs; // Observable to track expansion state

  void toggleExpansionpeople() {
    isinvolvepeople.value = !isinvolvepeople.value;
  }

  var isinformedpeople = true.obs; // Observable to track expansion state

  void toggleInformedExpansionpeople() {
    isinformedpeople.value = !isinformedpeople.value;
  }

  var isprecautionDetailsExpanded =
      true.obs; // Observable to track expansion state

  void toggleExpansionPrecaution() {
    isprecautionDetailsExpanded.value = !isprecautionDetailsExpanded.value;
  }

  @override
  void dispose() {
    scrollLabourController.dispose();
    scrollStaffController.dispose();
    scrollContractorController.dispose();
    scrolldataController.dispose();
    super.dispose();
  }

  ScrollController scrollLabourController = ScrollController();
  ScrollController scrollStaffController = ScrollController();
  ScrollController scrollContractorController = ScrollController();
  ScrollController scrolldataController = ScrollController();

  List<ViolationDebitNote> violationDebitNote = [];
  List<Category> violationType = [];
  List<Category> category = [];
  List<Category> riskLevel = [];
  List<Category> sourceOfObservation = [];
  List<InvolvedLaboursList> involvedLaboursList = [];
  List<InvolvedStaffList> involvedStaffList = [];
  List<InvolvedContractorUserList> involvedContractorUserList = [];
  List<InformedPersonsList> informedPersonsList = [];
  List<Photo> photos = [];
  List<AsgineUserList> asgineeUserList = [];
  List<AsgineUserList> asginerUserList = [];
  List<AsgineeAddPhoto> asgineeAddPhotos = [];
  var userFound = false.obs;
  var savedSignatureUrlfetch = ''.obs;
  Future getSafetyViolationAssginorDetails(
      projcetId, userId, userType, iRId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
        "violation_debit_note_id": iRId,
      };

      log("Request body: $map");

      var responseData = await globApiCall(
          'get_safety_violation_debit_note_selected_details', map);
      var data = await responseData['data'];
      log("Request body: $data");

      //-------------------------------------------------
      violationDebitNote = (await data['violation_debit_note'] as List<dynamic>)
          .map((e) => ViolationDebitNote.fromJson(e as Map<String, dynamic>))
          .toList();
      violationType = (data['violation_type'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList();

      category = (data['category'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList();

      riskLevel = (data['risk_level'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList();

      sourceOfObservation = (data['source_of_observation'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList();

      involvedLaboursList = (data['involved_labours_list'] as List<dynamic>)
          .map((e) => InvolvedLaboursList.fromJson(e))
          .toList();

      // involvedStaffList = {};
      // if (data['involved_staff_list'] is Map<String, dynamic>) {
      //   involvedStaffList = (data['involved_staff_list']
      //           as Map<String, dynamic>)
      //       .map((key, value) => MapEntry(key, InvolvedStaff.fromJson(value)));
      // }

      // // Safely parse involved_contractor_user_list (handles null)
      // involvedContractorUserList = {};
      // if (data['involved_contractor_user_list'] is Map<String, dynamic>) {
      //   involvedContractorUserList =
      //       (data['involved_contractor_user_list'] as Map<String, dynamic>).map(
      //           (key, value) =>
      //               MapEntry(key, InvolvedContractorUserList.fromJson(value)));
      // }
      involvedStaffList = (data['involved_staff_list'] as List<dynamic>)
          .map((e) => InvolvedStaffList.fromJson(e))
          .toList();

      involvedContractorUserList =
          (data['involved_contractor_user_list'] as List<dynamic>)
              .map((e) => InvolvedContractorUserList.fromJson(e))
              .toList();
      informedPersonsList = (data['informedPersonsList'] as List<dynamic>)
          .map((e) => InformedPersonsList.fromJson(e))
          .toList();

      photos = (data['photos'] as List<dynamic>)
          .map((e) => Photo.fromJson(e))
          .toList();

      asgineeUserList = (data['asginee_user_list'] as List<dynamic>)
          .map((e) => AsgineUserList.fromJson(e))
          .toList();

      asginerUserList = (data['asginer_user_list'] as List<dynamic>)
          .map((e) => AsgineUserList.fromJson(e))
          .toList();

      asgineeAddPhotos = (data['asginee_add_photos'] as List<dynamic>)
          .map((e) => AsgineeAddPhoto.fromJson(e))
          .toList();

      await violationDebitNote[0].status.toString() == "2"
          ? userFound.value = true
          : userFound.value = false;
      if (asgineeAddPhotos.isNotEmpty) {
        assigneecommentController.text =
            asgineeAddPhotos[0].assigneeComment.toString();
      } else {
        assigneecommentController.text = '';
      }

      log("userFound---------------------------------.value: ${userFound.value}");
      if (userFound.value) {
        assignorcommentController.text =
            violationDebitNote[0].assignerComment.toString();
        savedSignatureUrlfetch.value =
            violationDebitNote[0].assignerPhotoSignatureAfter.toString();
      } else {
        savedSignatureUrlfetch.value = '';
      }

      log('violation_debit_note count: ${violationDebitNote.length}');
      log('violationType count: ${violationType.length}');
      log('category count: ${category.length}');
      log('riskLevel count: ${riskLevel.length}');
      log('involvedLaboursList count: ${involvedLaboursList.length}');
      log('involvedStaffList keys count: ${involvedStaffList.length}');
      log('involvedContractorUserList keys count: ${involvedContractorUserList.length}');
      log('informedPersonsList count: ${informedPersonsList.length}');
      log('photos count: ${photos.length}');
      log('asgineeUserList count: ${asgineeUserList.length}');
      log('asginerUserList count: ${asginerUserList.length}');
      // log('asgineeAddPhotos count: ${asgineeAddPhotos.length}');
    } catch (e) {
      print("Error: $e");
    }
  }

  //-------------------------

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

  Future<void> saveIncidentAssigneeSignature() async {
    try {
      const int signatureWidth = 360;
      const int signatureHeight = 206;

      Uint8List? signatureBytes = await signatureCheckerController.toPngBytes(
        width: signatureWidth,
        height: signatureHeight,
      );
      // ignore: unnecessary_null_comparison
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

  TextEditingController assignorcommentController = TextEditingController();
  FocusNode assignorFocusNode = FocusNode();
  GlobalKey signKey = GlobalKey();
  TextEditingController assigneecommentController = TextEditingController();
  //----------------------------
  String validationmsg = '';
  bool apiStatus = false;

  Future<void> safetyViolationSaveAssignorComment(
      BuildContext c, safetyId, status) async {
    log("status: $status");
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());

      var request = await http.MultipartRequest(
          "POST",
          Uri.parse(
              '${RemoteServices.baseUrl}save_safety_violation_debit_note_assigner'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['safety_violation_debit_note_id'] = safetyId.toString();
      // request.fields['assignee_id'] = assigneeId.toString();
      request.fields['status'] = status.toString();
      request.fields['assigner_comment'] = assignorcommentController.text;

      request.files.add(await http.MultipartFile.fromPath(
        'assigner_photo_signature_after',
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

//---------------------------------------------------------

  void clearAllData() {
    // Reset expansion states
    isincidentdetailsDetailsExpanded.value = true;
    isinvolvepeople.value = true;
    isinformedpeople.value = true;
    isprecautionDetailsExpanded.value = true;

    // Clear the controllers
    assignorcommentController.clear();
    assigneecommentController.clear();

    // Clear signatures and related variables
    signatureCheckerController.clear();
    savedCheckerSignature.value = null;
    signatureattestationError.value = '';

    // Clear lists
    violationDebitNote.clear();
    violationType.clear();
    category.clear();
    riskLevel.clear();
    sourceOfObservation.clear();
    involvedLaboursList.clear();
    involvedStaffList.clear();
    involvedContractorUserList.clear();
    informedPersonsList.clear();
    photos.clear();
    asgineeUserList.clear();
    asginerUserList.clear();
    asgineeAddPhotos.clear();

    // Reset any flags or state variables
    userFound.value = false;
    savedSignatureUrlfetch.value = '';
    validationmsg = '';
    apiStatus = false;
  }
}
