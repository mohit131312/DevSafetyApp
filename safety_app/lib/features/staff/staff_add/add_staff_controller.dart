import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/features/staff/staff_add/add_staff_model.dart';
import 'package:flutter_app/features/staff/staff_documentation/staff_documentation_controller.dart';
import 'package:flutter_app/features/staff/staff_precaution/staff_precaution_controller.dart';
import 'package:flutter_app/features/staff/staff_undertaking/staff_undertaking_controller.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddStaffController extends GetxController {
  final StaffDocumentationController staffDocumentationController =
      Get.put(StaffDocumentationController());
  final InductionTrainingController inductionTrainingController = Get.find();
  final StaffPrecautionController staffPrecautionController =
      Get.put(StaffPrecautionController());
  final StaffUndertakingController staffUndertakingController =
      Get.put(StaffUndertakingController());

  //-------------------------------------
  var fullnameFocusNode = FocusNode();

  var searchFocusNodeAll = FocusNode();
  TextEditingController searchController = TextEditingController();

  var contactFocusNode = FocusNode();
  final List<Map<String, dynamic>> gendersStaff = [
    {'label': 'Male', 'icon': 'assets/icons/male.png'},
    {'label': 'Female', 'icon': 'assets/icons/female.png'},
    {'label': 'Other', 'icon': 'assets/icons/star.png'}
  ];

  //--------------------------------------------------------------

  var selectedStaffGender = 0.obs;

  void selectGender(int index) {
    selectedStaffGender.value = index;
  }

  String get selectedGenderLabel =>
      gendersStaff[selectedStaffGender.value]['label']!;

  //--------------------------------------------------------------

  var profilePhoto = ''.obs;
  var profilePhotoEroor = ''.obs;
  XFile? selectedImage;

  Future<void> pickStaffImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage = pickedFile;

      profilePhoto.value = pickedFile.path;
    } else {
      print("No image selected");
    }
  }
  //--------------------------------------------------------------

  var isSameAsCurrent = false.obs; // Checkbox state

  var selectedBloodGroup = ''.obs;
  var selectedreasons = ''.obs;
  var selectedLiteratre = ''.obs;
  var selectedmarried = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedState = ''.obs;
  var selectedPermanantDistrict = ''.obs;
  var selectedPermanantState = ''.obs;

  var selectedDate = Rxn<DateTime>();
  final TextEditingController dateController = TextEditingController();

  void updateStaffDate(DateTime newDate) {
    selectedDate.value = newDate;
    dateController.text = DateFormat("yyyy-MM-dd").format(newDate);
  }

  var isExpanded = false.obs;
  var isExpanded2 = false.obs;

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  void toggleExpansion2() {
    isExpanded2.value = !isExpanded2.value;
  }

  List<TextEditingController> addressControllers =
      List.generate(4, (index) => TextEditingController());
  List<TextEditingController> permanantAddressController =
      List.generate(4, (index) => TextEditingController());

  int age = 18;
  int calculateStaffAge(DateTime birthDate) {
    DateTime today = DateTime.now();

    // Calculate the age
    int age = today.year - birthDate.year;

    if (today.isBefore(DateTime(today.year, birthDate.month, birthDate.day))) {
      age--;
    }

    return age;
  }

  List<String> literacyStatus = ["Literate", "Illiterate"];
  List<String> maritalStatus = ["Married", "Unmarried"];

  List<String> addressLabels = ["Street Name", "City", "Taluka", "Pincode"];
  List<String> addresspermanantLabels = [
    "Street Name",
    "City",
    "Taluka",
    "Pincode"
  ];

  var formattedAddress = "".obs;

  void updateStaffFormattedAddress() {
    formattedAddress.value = "${addressControllers[0].text}, " // Street
        "${addressControllers[1].text}, " // City
        "${addressControllers[2].text}, " // Taluka
        "${addressControllers[3].text}, " // Pincode
        "${selectedDistrict.value}, " // District
        "${selectedState.value}"; // State
  }

  // Function to return formatted address
  var formattedpermanantaddAddress = "".obs;
  void updateStaffpermanantFormattedAddress() {
    formattedpermanantaddAddress.value =
        "${permanantAddressController[0].text}, " // Street
        "${permanantAddressController[1].text}, " // City
        "${permanantAddressController[2].text}, " // Taluka
        "${permanantAddressController[3].text}, " // Pincode
        "${selectedPermanantDistrict.value}, " // District
        "${selectedPermanantState.value}"; // State
  }

  TextEditingController staffnameController = TextEditingController();
  TextEditingController contactnumberController = TextEditingController();
  TextEditingController econtactnumberController = TextEditingController();
  TextEditingController econtactnameController = TextEditingController();
  TextEditingController econtactrelationController = TextEditingController();
  var econtactnumberFocusNode = FocusNode();
  var econtactnameFocusNode = FocusNode();
  var econtactrelationFocusNode = FocusNode();
  var streetFocusNode = FocusNode();
  var cityFocusNode = FocusNode();
  var talukaFocusNode = FocusNode();
  var pincodeFocusNode = FocusNode();
  var streetPermanatFocusNode = FocusNode();
  var cityPermanatFocusNode = FocusNode();
  var talukaPermanatFocusNode = FocusNode();
  var pincodePermanatFocusNode = FocusNode();
  var searchFocusNode = FocusNode();

  void toggleSameAsCurrent(bool value) {
    isSameAsCurrent.value = value;
    if (value) {
      for (int i = 0; i < 4; i++) {
        permanantAddressController[i].text = addressControllers[i].text;
        addressControllers[i].addListener(() {
          if (isSameAsCurrent.value) {
            permanantAddressController[i].text = addressControllers[i].text;
          }
        });
      }
      selectedPermanantState.value = selectedState.value;
      selectedPermanantDistrict.value = selectedDistrict.value;
      selectedPermanantStateId.value = selectedStateId.value; //

      selectedPermanantDistrictId.value = selectedDistrictId.value; //
    } else {
      for (int i = 0; i < 4; i++) {
        permanantAddressController[i].clear();
        addressControllers[i].removeListener(() {});
      }
      selectedPermanantState.value = '';
      selectedPermanantStateId.value = 0; //

      selectedPermanantDistrict.value = '';
      selectedPermanantDistrictId.value = 0; //
      isSameAsCurrent.refresh();
    }
  }

  //----------------------
  var searchType = 'ID'.obs;
  var userFound = false.obs;
  var selectedStaffData = ''.obs;
  int staffID = 0;
  List<AssignLabourProject> assignedLabourProjects = [];

  var selectedStateId = 0.obs; // Store the ID separately
  var selectedDistrictId = 0.obs;
  var selectedPermanantStateId = 0.obs;
  var selectedPermanantDistrictId = 0.obs;
  var selectedReasonId = 0.obs; // Store the ID separately
  Map<String, dynamic> map = {};
  Future getSafetyStaffDetails(String id, BuildContext context,
      bool validationStatus, bool searchId) async {
    clearStaffUserFields();
    try {
      if (searchId) {
        map = {"staff_id": id, "staff_name": '', "project_id": 1};
        print("Request body: $map");
      } else {
        map = searchType.value == 'ID'
            ? {"staff_id": id, "staff_name": "", "project_id": 1}
            : {"staff_id": '', "staff_name": id, "project_id": 1};
        print("Request body: $map");
      }

      var responseData = await globApiCall('get_safety_staff_details', map);
      log('API Response: ${responseData}');

      var data = await responseData['data'][0];
      log('Data Response: ${data}');

      if (validationStatus == true) {
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
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomValidationPopup(message: validationmsg);
            },
          );
        }
      } else {}

      selectedStaffData.value = data['staff_name'] ?? "";
      staffID = data['id'];

      staffnameController.text = data['staff_name'] ?? "";
      contactnumberController.text = data['contact_number'] ?? "";
      selectedBloodGroup.value = data['blood_group'] ?? "";

      /// selectedLiteratre.value = data['literacy'] ?? "";
      // selectedmarried.value = data['marital_status'] ?? "";
      econtactnameController.text = data['emergency_contact_name'] ?? "";
      econtactnumberController.text = data['emergency_contact_number'] ?? "";
      dateController.text = data['birth_date'] ?? "";
      econtactrelationController.text =
          data['emergency_contact_relation'] ?? "";

      // profilePhoto.value = labour['user_photo'];
      print(profilePhoto.value);

      // Populate current address
      addressControllers[0].text = data['current_street_name'] ?? "";
      addressControllers[1].text = data['current_city'] ?? "";
      addressControllers[2].text = data['current_taluka'] ?? "";
      addressControllers[3].text = data['current_pincode'] ?? "";

      selectedState.value = inductionTrainingController.stateList
              .firstWhereOrNull(
                  (element) => element.id == data['current_state'])
              ?.stateName ??
          "";

      selectedStateId.value = data['current_state'];

      selectedDistrict.value = inductionTrainingController.districtList
              .firstWhereOrNull(
                  (element) => element.id == data['current_district'])
              ?.districtName ??
          "";

      selectedDistrictId.value = data['current_district'];

      permanantAddressController[0].text = data['permanent_street_name'] ?? "";
      permanantAddressController[1].text = data['permanent_city'] ?? "";
      permanantAddressController[2].text = data['permanent_taluka'] ?? "";
      permanantAddressController[3].text = data['permanent_pincode'] ?? "";

      selectedPermanantState.value = inductionTrainingController.stateList
              .firstWhereOrNull(
                  (element) => element.id == data['permanent_state'])
              ?.stateName ??
          "";
      selectedPermanantStateId.value = data['permanent_state'];

      selectedPermanantDistrict.value = inductionTrainingController.districtList
              .firstWhereOrNull(
                  (element) => element.id == data['permanent_district'])
              ?.districtName ??
          "";
      selectedPermanantDistrictId.value =
          data['permanent_district']; // Store the ID for API requests

      // **Handle Gender Selection Based on API Response**
      String genderFromApi = data['gender'] ?? "";
      int genderIndex =
          gendersStaff.indexWhere((gender) => gender['label'] == genderFromApi);
      if (genderIndex != -1) {
        selectedStaffGender.value = genderIndex;
      } else {
        selectedStaffGender.value = 0;
      }

      ///professioal details

      ///documnetation
      staffDocumentationController.adharnoController.text =
          data['adhaar_no'] ?? "";

      userFound.value = true;

      print('--- Labour Data ---');
      print('Full Name: ${staffnameController.text}');
      print('Contact Number: ${contactnumberController.text}');
      print('Date Number: ${dateController.text}');

      print('Blood Group: ${selectedBloodGroup.value}');
      print('Emergency Contact Name: ${econtactnameController.text}');
      print('Emergency Contact Number: ${econtactnumberController.text}');
      print('Emergency Contact Relation: ${econtactrelationController.text}');
    } catch (e) {
      log("Error: $e");
      userFound.value = false;
      clearStaffUserFields();
    }
  }

  String validationmsg = '';
  var searchResults = <Map<String, dynamic>>[].obs;

  Future getSafetyStaffMatchedDetails(String id, BuildContext context) async {
    try {
      Map<String, dynamic> map = {"staff_id": '', "staff_name": id};
      print("Request body: $map");

      var responseData = await globApiCall('get_safety_staff_name_list', map);
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
      clearStaffUserFields();
    }
  }

  void clearStaffUserFields() {
    staffnameController.clear();
    contactnumberController.clear();
    econtactnameController.clear();
    econtactrelationController.clear();
    dateController.clear();
    selectedStaffGender.value = 0;
    selectedreasons.value = '';
    econtactnumberController.clear();
    selectedBloodGroup.value = "";
    selectedState.value = "";
    selectedDistrict.value = "";
    selectedLiteratre.value = '';
    selectedmarried.value = '';
    selectedPermanantState.value = "";
    selectedPermanantDistrict.value = "";
    profilePhoto.value = '';

    for (var controller in addressControllers) {
      controller.clear();
    }
    for (var controller in permanantAddressController) {
      controller.clear();
    }
    // Clearing labourPrecautionController fields
    staffPrecautionController.selectedItemIds.clear();
    staffPrecautionController.selectedItemInstruction.clear();
    staffPrecautionController.isSelectAll.value = false;
    staffPrecautionController.isSelectAllInstruction.value = false;

    //dovumentation
    staffDocumentationController.staffotherimg.clear();
    staffDocumentationController.adharnoController.clear();
    staffDocumentationController.otherImageCount.value = 0;
    staffDocumentationController.staffimg.clear();
    staffDocumentationController.documentType.clear();
    staffDocumentationController.documentTypeName.clear();
    staffDocumentationController.idNumber.clear();
    staffDocumentationController.validity.clear();

    staffDocumentationController.idnoController.clear();
    staffDocumentationController.validityController.clear();
    staffDocumentationController.validityText.value = '';
    staffDocumentationController.idnoText.value = '';

    staffDocumentationController.selectedDoctType.value = '';
    staffDocumentationController.selectedIdProofId.value = 0;
    staffDocumentationController.selectedDateValidity.value = null;
    staffDocumentationController.dateController.clear();

    log(' Cleared all labour documentation data.');
    staffUndertakingController.clearSignature();
    staffUndertakingController.checkboxValueBehalf = 0;
    for (var undertaking
        in staffUndertakingController.filteredDetailsUndertaking) {
      undertaking['isChecked'] = false;
    }
    staffUndertakingController.isCheckedUndertaking.value = false;

    assignedLabourProjects.clear();
  }

  String validationmsgnew = '';
  var districtListMatched = <DistrictList>[].obs;
  Future getAssociatedDistrictsList(
      Map<String, dynamic> updatedData, context) async {
    try {
      log('api ---------------$updatedData');

      var responseData =
          await globApiCall('get_associated_districts_list', updatedData);
      var data = responseData['data'];

      if (data != null && data.containsKey('district_list')) {
        districtListMatched.assignAll(
          // ✅ Fix: Use assignAll() instead of direct assignment
          (data['district_list'] as List<dynamic>)
              .map((e) => DistrictList.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }
      log('District List: ${jsonEncode(districtListMatched)}'); // ✅ Correct logging

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
            return CustomValidationPopup(message: validationmsgnew);
          },
        );
      } else {
        // validationmsg = responseData['message'];

        // print('successmsg-------------$validationmsgnew');
        // // Show success message popup
        // await showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return CustomValidationPopup(message: validationmsgnew);
        //   },
        // );
      }
    } catch (e) {
      log("Error: $e");

      // Show error popup
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomValidationPopup(
              message: "Something went wrong. Please try again.");
        },
      );
    }
  }

  void clearStaffUserFieldsFinal() {
    userFound.value = false;

    staffnameController.clear();
    contactnumberController.clear();
    econtactnameController.clear();
    econtactrelationController.clear();
    dateController.clear();
    searchController.clear();
    isSameAsCurrent.value = false;
    econtactnumberController.clear();
    selectedLiteratre.value = '';
    selectedmarried.value = '';
    selectedStaffGender.value = 0;

    selectedBloodGroup.value = "";
    selectedState.value = "";
    selectedDistrict.value = "";
    selectedLiteratre.value = '';
    selectedmarried.value = '';
    selectedPermanantState.value = "";
    selectedPermanantDistrict.value = "";
    profilePhoto.value = '';
    searchType.value = 'ID';

    assignedLabourProjects.clear();

    for (var controller in addressControllers) {
      controller.clear();
    }
    for (var controller in permanantAddressController) {
      controller.clear();
    }

    //dovumentation
    staffDocumentationController.adharnoController.clear();
    staffDocumentationController.selectedDoctType.value = '';
    staffDocumentationController.idnoController.clear();
    staffDocumentationController.validityController.clear();
    staffDocumentationController.staffAdharcard.clear();
    staffDocumentationController.staffotherimg.clear();
    staffDocumentationController.allstaffimgData.clear();

    staffDocumentationController.adharImageCount.value = 0;
    staffDocumentationController.otherImageCount.value = 0;
    staffDocumentationController.allstaffimgDataCount.value = 0;
    staffDocumentationController.staffimg.clear();

    staffPrecautionController.selectedItemIds.clear();
    staffPrecautionController.selectedItemInstruction.clear();
    staffPrecautionController.isSelectAll.value = false;
    staffPrecautionController.isSelectAllInstruction.value = false;

    staffPrecautionController.searchControllerEquipment.clear();
    staffPrecautionController.searchControllerInstruction.clear();

    staffUndertakingController.clearAllCheckboxes();
    printStaffClearedData();
  }

  void printStaffClearedData() {
    print("All user fields and selections have been cleared:");
    print("User Found: ${userFound.value}");
    print("Full Name: ${staffnameController.text}");
    print("Contact Number: ${contactnumberController.text}");
    print("Emergency Contact Name: ${econtactnameController.text}");
    print("Emergency Contact Relation: ${econtactrelationController.text}");
    print("Date: ${dateController.text}");
    print("Search Query: ${searchController.text}");
    print("Emergency Contact Number: ${econtactnumberController.text}");
    print("Literacy: ${selectedLiteratre.value}");
    print("Marital Status: ${selectedmarried.value}");
    print("Gender: ${selectedStaffGender.value}");
    print("Blood Group: ${selectedBloodGroup.value}");
    print("State: ${selectedState.value}");
    print("District: ${selectedDistrict.value}");
    print("Permanent State: ${selectedPermanantState.value}");
    print("Permanent District: ${selectedPermanantDistrict.value}");
    print("Selected Image Path: ${profilePhoto.value}");
    print("Search Type: ${searchType.value}");

    print("Assigned Labour Projects: ${assignedLabourProjects}");

    print("Undertaking checkboxes cleared:");
    for (var item in staffUndertakingController.filteredDetailsUndertaking) {
      print("${item['title']}: ${item['isChecked']}");
    }

    print(
        "Signature cleared: ${staffUndertakingController.signatureController.isEmpty}");

    print("Documentation fields cleared:");
    print("Adhar No: ${staffDocumentationController.adharnoController.text}");
    print(
        "Selected Doc Type: ${staffDocumentationController.selectedDoctType.value}");
    print("ID No: ${staffDocumentationController.idnoController.text}");
    print("Validity: ${staffDocumentationController.validityController.text}");
    print(
        "Adhar Image Count: ${staffDocumentationController.adharImageCount.value}");
    print(
        "Other Image Count: ${staffDocumentationController.otherImageCount.value}");
    print(
        "All Labour Image Data Count: ${staffDocumentationController.allstaffimgDataCount.value}");

    print("Precautions cleared:");
    print("Selected Item IDs: ${staffPrecautionController.selectedItemIds}");
    print(
        "Selected Item Instructions: ${staffPrecautionController.selectedItemInstruction}");
    print("Select All: ${staffPrecautionController.isSelectAll.value}");
    print(
        "Select All Instruction: ${staffPrecautionController.isSelectAllInstruction.value}");
  }
}
