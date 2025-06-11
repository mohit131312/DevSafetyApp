import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/image_helper.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_detailsAll/incide_report_details_all_model.dart';
import 'package:flutter_app/remote_services.dart';
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart' as http;

class IncidentReportDetailsAssigneeController extends GetxController {
  var isincidentdetailsDetailsExpanded =
      true.obs; // Observable to track expansion state
  TextEditingController assigneecommentController = TextEditingController();
  FocusNode assigneeCommentFocus = FocusNode();
  GlobalKey photoKey = GlobalKey();
  GlobalKey signkey = GlobalKey();
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
  List<SafetyIncidentReport> safetyIncidentReport = [];
  List<SeverityLevel> severityLevel = [];
  List<FloorAreaOfWork> floorAreaOfWork = [];
  List<ContractorCompany> contractorCompany = [];
  List<BuildingList> buildingList = [];
  List<InvolvedList> involvedLaboursList = [];
  Map<String, Staff> involvedStaffList = {};
  Map<String, InvolvedContractorUserList> involvedContractorUserList = {};
  List<InformedPersonsList> informedPersonsList = [];
  List<PreventionMeasure> preventionMeasures = [];
  List<Photo> photos = [];
  List<AsgineUserList> asgineeUserList = [];
  List<AsgineUserList> asginerUserList = [];
  List<AsgineeAddPhoto> asgineeAddPhotos = [];
  var userFound = false.obs;
  var savedSignatureUrlfetch = ''.obs;

  Future getIncidentReportAssigneeDetails(
      projcetId, userId, userType, iRId) async {
    try {
      Map<String, dynamic> map = {
        "project_id": projcetId,
        "user_id": userId,
        "user_type": userType,
        "incident_report_id": iRId,
      };

      log("Request body: $map");

      var responseData =
          await globApiCall('get_safety_incident_report_selected_details', map);
      var data = await responseData['data'];
      log("Request body: $data");

      //-------------------------------------------------
      safetyIncidentReport = (await data['safety_incident_report']
              as List<dynamic>)
          .map((e) => SafetyIncidentReport.fromJson(e as Map<String, dynamic>))
          .toList();
      severityLevel = (data['severity_level'] as List<dynamic>)
          .map((e) => SeverityLevel.fromJson(e))
          .toList();

      floorAreaOfWork = (data['floor_area_of_work'] as List<dynamic>)
          .map((e) => FloorAreaOfWork.fromJson(e))
          .toList();

      contractorCompany = (data['contractor_company'] as List<dynamic>)
          .map((e) => ContractorCompany.fromJson(e))
          .toList();

      buildingList = (data['building_list'] as List<dynamic>)
          .map((e) => BuildingList.fromJson(e))
          .toList();

      involvedLaboursList = (data['involved_labours_list'] as List<dynamic>)
          .map((e) => InvolvedList.fromJson(e))
          .toList();

      involvedStaffList = {};
      if (data['involved_staff_list'] is Map<String, dynamic>) {
        involvedStaffList =
            (data['involved_staff_list'] as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, Staff.fromJson(value)));
      }

      // Safely parse involved_contractor_user_list (handles null)
      involvedContractorUserList = {};
      if (data['involved_contractor_user_list'] is Map<String, dynamic>) {
        involvedContractorUserList =
            (data['involved_contractor_user_list'] as Map<String, dynamic>).map(
                (key, value) =>
                    MapEntry(key, InvolvedContractorUserList.fromJson(value)));
      }

      preventionMeasures = (data['prevention_measures'] as List<dynamic>)
          .map((e) => PreventionMeasure.fromJson(e))
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

      // ignore: unnecessary_null_comparison
      asgineeAddPhotos.isNotEmpty && asgineeAddPhotos != null
          ? userFound.value = true
          : userFound.value = false;
      if (userFound.value) {
        assigneecommentController.text =
            asgineeAddPhotos[0].assigneeComment.toString();
        savedSignatureUrlfetch.value =
            asgineeAddPhotos[0].assigneePhotoSignatureAfter.toString();
      } else {
        savedSignatureUrlfetch.value = '';
      }
      log('safetyIncidentReport count: ${safetyIncidentReport.length}');
      log('severityLevel count: ${severityLevel.length}');
      log('floorAreaOfWork count: ${floorAreaOfWork.length}');
      log('contractorCompany count: ${contractorCompany.length}');
      log('buildingList count: ${buildingList.length}');
      log('involvedLaboursList count: ${involvedLaboursList.length}');
      log('involvedStaffList keys count: ${involvedStaffList.length}');
      log('involvedContractorUserList keys count: ${involvedContractorUserList.length}');
      log('informedPersonsList count: ${informedPersonsList.length}');
      log('preventionMeasures count: ${preventionMeasures.length}');
      log('photos count: ${photos.length}');
      log('asgineeUserList count: ${asgineeUserList.length}');
      log('asginerUserList count: ${asginerUserList.length}');
      log('asgineeAddPhotos count: ${asgineeAddPhotos.length}');
    } catch (e) {
      print("Error: $e");
    }
  }

  void resetData() {
    safetyIncidentReport.clear();
    severityLevel.clear();
    floorAreaOfWork.clear();
    contractorCompany.clear();
    buildingList.clear();
    involvedLaboursList.clear();
    involvedStaffList.clear(); // Clears the map
    involvedContractorUserList.clear(); // Clears the map
    informedPersonsList.clear();
    preventionMeasures.clear();
    photos.clear();
    asgineeUserList.clear();
    asginerUserList.clear();
    asgineeAddPhotos.clear();
  }

  TextEditingController incidentReportController = TextEditingController();

  //--------------------------
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

  Future<void> saveIncidentAssigneeSignature() async {
    try {
      Uint8List? signatureBytes = await signatureCheckerController.toPngBytes();

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

  //----------------------------
  String validationmsg = '';
  bool apiStatus = false;

  Future<void> safetySaveIncidentAssigneeComment(
      BuildContext c, incidentId, assigneeId, status) async {
    log("status: $status");
    try {
      showDialog(
          context: c,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomLoadingPopup());

      var request = await http.MultipartRequest(
          "POST",
          Uri.parse(
              '${RemoteServices.baseUrl}save_safety_incident_assignee_comment'));

      request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = '${ApiClient.gs.read('token')}';

      request.fields['safety_incident_report_id'] = incidentId.toString();
      request.fields['assignee_id'] = assigneeId.toString();
      request.fields['status'] = status.toString();
      request.fields['assignee_comment'] = assigneecommentController.text;
      for (var image in incidentAssigneeimg) {
        if (image.path.isNotEmpty && File(image.path).existsSync()) {
          log("File phhottt0------ exists, attaching: ${image.path}");

          request.files.add(await http.MultipartFile.fromPath(
            'photo_path[]',
            image.path,
          ));
        } else {
          log(" File not found: ${image.path}");
        }
      }
      request.files.add(await http.MultipartFile.fromPath(
        'assignee_photo_signature_after',
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

  var incidentAssigneeimg = <XFile>[];
  var photoAssigneeError = ''.obs;

  var incidentAssigneeCount = 0.obs;

  final maxPhotos = 5;

  // Future<void> pickIncidentAssigneeImages() async {
  //   final ImagePicker picker = ImagePicker();

  //   if (incidentAssigneeimg.length < maxPhotos) {
  //     int remainingSlots = maxPhotos - incidentAssigneeimg.length;

  //     final List<XFile> pickedFiles = await picker.pickMultiImage();

  //     final List<XFile> limitedFiles =
  //         pickedFiles.take(remainingSlots).toList();

  //     incidentAssigneeimg.addAll(limitedFiles);
  //     incidentAssigneeCount.value =
  //         incidentAssigneeimg.length; // ✅ Correct update

  //     log('-----------incidentImageCount------------$incidentAssigneeCount');
  //     log('-----------incidentimg-------------${incidentAssigneeimg.length}');
  //   }
  // }
  Future<void> pickIncidentAssigneeImages({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();

    if (incidentAssigneeimg.length < maxPhotos) {
      int remainingSlots = maxPhotos - incidentAssigneeimg.length;

      if (source == ImageSource.gallery) {
        final List<XFile> pickedFiles = await picker.pickMultiImage();
        final List<XFile> limitedFiles =
            pickedFiles.take(remainingSlots).toList();

        for (var file in limitedFiles) {
          final croppedFile = await ImageHelper.cropImageFile(
            file: file,
            context: Get.context,
          );
          if (croppedFile != null) {
            incidentAssigneeimg.add(croppedFile);
          }
        }

        log('Picked & Cropped from Gallery: ${incidentAssigneeimg.length} images');
      } else if (source == ImageSource.camera) {
        final XFile? capturedFile =
            await picker.pickImage(source: ImageSource.camera);

        if (capturedFile != null) {
          final croppedFile = await ImageHelper.cropImageFile(
            file: capturedFile,
            context: Get.context,
          );
          if (croppedFile != null) {
            incidentAssigneeimg.add(croppedFile);
            log('Captured & Cropped from Camera: 1 image');
          }
        }
      }

      incidentAssigneeCount.value = incidentAssigneeimg.length;
      if (incidentAssigneeCount.value > 0) {
        photoAssigneeError.value = "";
      }

      log('incidentAssigneeCount: ${incidentAssigneeCount.value}');
    }
  }

  void removeAssigneeImage(int index) {
    if (index >= 0 && index < incidentAssigneeimg.length) {
      incidentAssigneeimg.removeAt(index);
      incidentAssigneeCount.value = incidentAssigneeimg.length;

      log('Removed image at index $index from incidentimg. Remaining: ${incidentAssigneeCount.value}');
    }
  }

  void resetAssigneeForm() {
    // Clear comment
    assigneecommentController.clear();
    incidentReportController.clear();

    // Clear signature
    signatureCheckerController.clear();
    savedCheckerSignature.value = null;
    signatureattestationError.value = "";
    savedSignatureUrlfetch.value = '';
    signatureFile = File('');
    validationmsg = '';
    apiStatus = false;
    // Clear images
    incidentAssigneeimg.clear();
    incidentAssigneeCount.value = 0;

    // Clear saved signature URL (from API)
    savedSignatureUrlfetch.value = '';

    // Reset photo error message
    photoAssigneeError.value = '';

    // Reset user check
    userFound.value = false;
// Reset UI toggles
    isincidentdetailsDetailsExpanded.value = true;
    isinvolvepeople.value = true;
    isinformedpeople.value = true;
    isprecautionDetailsExpanded.value = true;

    log("Form reset completed.");
  }

  void resetIncidentAssigneeData() {
    // Clear form fields
    resetAssigneeForm();

    // Clear fetched model data
    resetData();

    // Reset UI expansion toggles
    isincidentdetailsDetailsExpanded.value = true;
    isinvolvepeople.value = true;
    isinformedpeople.value = true;
    isprecautionDetailsExpanded.value = true;

    // Reset controllers and scrolls if needed
    incidentReportController.clear();

    log("All assignee incident data fully reset.");
  }
}
