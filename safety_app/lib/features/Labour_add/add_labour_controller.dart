import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/Labour_add/add_labour_model.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/features/labour_documentation/labour_documentation_controller.dart';
import 'package:flutter_app/features/labour_precaution/labour_precaution_controller.dart';
import 'package:flutter_app/features/labour_professional_details/labour_profess_details_controller.dart';
import 'package:flutter_app/features/labour_undertaking/labour_undertaking_controller.dart';
import 'package:flutter_app/utils/global_api_call.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddLabourController extends GetxController {
  var selectedGender = 0.obs;
  final LabourProfessDetailsController labourProfessDetailsController =
      Get.put(LabourProfessDetailsController());
  final LabourDocumentationController labourDocumentationController =
      Get.put(LabourDocumentationController());
  final InductionTrainingController inductionTrainingController =
      Get.put(InductionTrainingController());
  final LabourPrecautionController labourPrecautionController =
      Get.put(LabourPrecautionController());
  final LabourUndertakingController labourUndertakingController =
      Get.put(LabourUndertakingController());
  var fullnameFocusNode = FocusNode();
  var searchFocusNodeAll = FocusNode();
  TextEditingController searchController = TextEditingController();

  var contactFocusNode = FocusNode();
  final List<Map<String, dynamic>> genders = [
    {'label': 'Male', 'icon': 'assets/icons/male.png'},
    {'label': 'Female', 'icon': 'assets/icons/female.png'},
    {'label': 'Other', 'icon': 'assets/icons/star.png'}
  ];

  void selectGender(int index) {
    selectedGender.value = index;
  }

  String get selectedGenderLabel => genders[selectedGender.value]['label']!;
  var profilePhoto = ''.obs;
  var profilePhotoEroor = ''.obs;
  XFile? selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage = pickedFile;

      profilePhoto.value = pickedFile.path;
    } else {
      print("No image selected");
    }
  }

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

  void updateDate(DateTime newDate) {
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

  @override
  void onClose() {
    fullnameFocusNode.dispose();
    searchFocusNodeAll.dispose();
    contactFocusNode.dispose();
    searchController.dispose();
    dateController.dispose();
    super.onClose();
  }

  List<TextEditingController> addressControllers =
      List.generate(4, (index) => TextEditingController());
  List<TextEditingController> permanantAddressController =
      List.generate(4, (index) => TextEditingController());

  int age = 18;
  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();

    // Calculate the age
    int age = today.year - birthDate.year;

    // Check if the birthday has occurred this year
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

  void updateFormattedAddress() {
    formattedAddress.value = "${addressControllers[0].text}, " // Street
        "${addressControllers[1].text}, " // City
        "${addressControllers[2].text}, " // Taluka
        "${addressControllers[3].text}, " // Pincode
        "${selectedDistrict.value}, " // District
        "${selectedState.value}"; // State
  }

  // Function to return formatted address
  var formattedpermanantaddAddress = "".obs;
  void updatepermanantFormattedAddress() {
    formattedpermanantaddAddress.value =
        "${permanantAddressController[0].text}, " // Street
        "${permanantAddressController[1].text}, " // City
        "${permanantAddressController[2].text}, " // Taluka
        "${permanantAddressController[3].text}, " // Pincode
        "${selectedPermanantDistrict.value}, " // District
        "${selectedPermanantState.value}"; // State
  }

  TextEditingController labournameController = TextEditingController();
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
      selectedPermanantStateId.value = selectedStateId.value;
      selectedPermanantDistrictId.value = selectedDistrictId.value;
    } else {
      for (int i = 0; i < 4; i++) {
        permanantAddressController[i].clear();

        addressControllers[i].removeListener(() {});
      }
      selectedPermanantState.value = '';
      selectedPermanantStateId.value = 0;
      selectedPermanantDistrict.value = '';
      selectedPermanantDistrictId.value = 0;
    }

    isSameAsCurrent.refresh();
  }

  //----------------------
  var searchType = 'ID'.obs;
  var userFound = false.obs;
  var selectedLabourData = ''.obs;
  int labourId = 1;
  List<AssignLabourProject> assignedLabourProjects = [];

  var selectedStateId = 0.obs; // Store the ID separately
  var selectedDistrictId = 0.obs;
  var selectedPermanantStateId = 0.obs;
  var selectedPermanantDistrictId = 0.obs;
  var selectedReasonId = 0.obs; // Store the ID separately
  Map<String, dynamic> map = {};
  Future getSafetyLabourDetails(String id, BuildContext context,
      bool validationStatus, bool searchId, projectId) async {
    clearUserFields();
    try {
      if (searchId) {
        map = {"labour_id": id, "labour_name": "", "project_id": projectId};
      } else {
        map = searchType.value == 'ID'
            ? {"labour_id": id, "labour_name": "", "project_id": projectId}
            : {"labour_id": '', "labour_name": id, "project_id": projectId};
        print("Request body: $map");
      }

      var responseData = await globApiCall('get_safety_labour_details', map);
      //log('API Response: ${responseData}');

      var data = await responseData['data'];
      log('API Response: ${data}');

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

      var labour = await data['labour'][0];
      selectedLabourData.value = labour['labour_name'] ?? "";
      labourId = labour['id'];

      labournameController.text = labour['labour_name'] ?? "";
      contactnumberController.text = labour['contact_number'] ?? "";
      selectedBloodGroup.value = labour['blood_group'] ?? "";
      selectedLiteratre.value = labour['literacy'] ?? "";
      selectedmarried.value = labour['marital_status'] ?? "";
      econtactnameController.text = labour['emergency_contact_name'] ?? "";
      econtactnumberController.text = labour['emergency_contact_number'] ?? "";
      dateController.text = labour['birth_date'] ?? "";
      econtactrelationController.text =
          labour['emergency_contact_relation'] ?? "";

      // profilePhoto.value = labour['user_photo'];
      print(profilePhoto.value);
      labourProfessDetailsController.selectedyoe.value =
          labour['experience_in_years'] ?? '';

      // Populate current address
      addressControllers[0].text = labour['current_street_name'] ?? "";
      addressControllers[1].text = labour['current_city'] ?? "";
      addressControllers[2].text = labour['current_taluka'] ?? "";
      addressControllers[3].text = labour['current_pincode'] ?? "";

      selectedState.value = inductionTrainingController.stateList
              .firstWhereOrNull(
                  (element) => element.id == labour['current_state'])
              ?.stateName ??
          "";

      selectedStateId.value = labour['current_state'];

      selectedDistrict.value = inductionTrainingController.districtList
              .firstWhereOrNull(
                  (element) => element.id == labour['current_district'])
              ?.districtName ??
          "";

      selectedDistrictId.value = labour['current_district'];

      // Populate permanent address
      permanantAddressController[0].text =
          labour['permanent_street_name'] ?? "";
      permanantAddressController[1].text = labour['permanent_city'] ?? "";
      permanantAddressController[2].text = labour['permanent_taluka'] ?? "";
      permanantAddressController[3].text = labour['permanent_pincode'] ?? "";

      selectedPermanantState.value = inductionTrainingController.stateList
              .firstWhereOrNull(
                  (element) => element.id == labour['permanent_state'])
              ?.stateName ??
          "";
      selectedPermanantStateId.value =
          labour['permanent_state']; // Store the ID for API requests

      selectedPermanantDistrict.value = inductionTrainingController.districtList
              .firstWhereOrNull(
                  (element) => element.id == labour['permanent_district'])
              ?.districtName ??
          "";
      selectedPermanantDistrictId.value =
          labour['permanent_district']; // Store the ID for API requests

      // **Handle Gender Selection Based on API Response**
      String genderFromApi = labour['gender'] ?? "";
      int genderIndex =
          genders.indexWhere((gender) => gender['label'] == genderFromApi);
      if (genderIndex != -1) {
        selectedGender.value = genderIndex;
      } else {
        selectedGender.value = 0; // Default to Male if no match found
      }

      ///professioal details
// Store assigned projects
      var assignedProjects = labour['assign_labour_projects'] as List<dynamic>;

      assignedLabourProjects = assignedProjects.map((proj) {
        int tradeId = proj['trade_id'] ?? 0;
        int contractorId = proj['contractor_id'] ?? 0;

        String tradeName = inductionTrainingController.tradeList
                .firstWhereOrNull((trade) => trade.id == tradeId)
                ?.inductionDetails ??
            "";

        String contractorName = inductionTrainingController.contractorLists
                .firstWhereOrNull((contract) => contract.id == contractorId)
                ?.contractorCompanyName ??
            "";

        return AssignLabourProject.fromJson(proj, tradeName, contractorName);
      }).toList();

      // List<dynamic> assignedProjects = [];

      // if (labour['assign_labour_projects'] != null &&
      //     labour['assign_labour_projects'] is List) {
      //   assignedProjects = labour['assign_labour_projects'];
      // }

      // assignedLabourProjects = assignedProjects.map((proj) {
      //   int tradeId = proj['trade_id'] ?? 0;
      //   int contractorId = proj['contractor_id'] ?? 0;

      //   String tradeName = inductionTrainingController.tradeList
      //           .firstWhereOrNull((trade) => trade.id == tradeId)
      //           ?.inductionDetails ??
      //       "";

      //   String contractorName = inductionTrainingController.contractorLists
      //           .firstWhereOrNull((contract) => contract.id == contractorId)
      //           ?.contractorCompanyName ??
      //       "";

      //   return AssignLabourProject.fromJson(proj, tradeName, contractorName);
      // }).toList();

// Debugging Output
      print("Assigned Projects: ${assignedLabourProjects.length}");
      for (var project in assignedLabourProjects) {
        print("Trade ID: ${project.tradeId}, Trade Name: ${project.tradeName}");
        print(
            "Contractor ID: ${project.contractorId}, Contractor Name: ${project.contractorName},slilled Name: ${project.skillType}");
      }

      ///documnetation
      labourDocumentationController.adharnoController.text =
          labour['adhaar_card_no'];

      userFound.value = true;

      print('--- Labour Data ---');
      print('Full Name: ${labournameController.text}');
      print('Contact Number: ${contactnumberController.text}');
      print('Date Number: ${dateController.text}');

      print('Blood Group: ${selectedBloodGroup.value}');
      print('Emergency Contact Name: ${econtactnameController.text}');
      print('Emergency Contact Number: ${econtactnumberController.text}');
      print('Emergency Contact Relation: ${econtactrelationController.text}');
    } catch (e) {
      log("Error: $e");
      userFound.value = false;
      clearUserFields();
    }
  }

  String validationmsg = '';
  var searchResults = <Map<String, dynamic>>[].obs;

  Future getSafetyLabourMatchedDetails(
      String id, BuildContext context, projectId) async {
    try {
      Map<String, dynamic> map = {
        "labour_id": '',
        "labour_name": id,
        "project_id": projectId
      };
      print("Request body: $map");

      var responseData = await globApiCall('get_safety_labour_name_list', map);
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
      clearUserFields();
    }
  }

  void clearUserFields() {
    labournameController.clear();
    contactnumberController.clear();
    econtactnameController.clear();
    econtactrelationController.clear();
    dateController.clear();
    selectedGender.value = 0;
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
    labourProfessDetailsController.selectedtrade.value = '';
    labourProfessDetailsController.selectedyoe.value = 0;
    labourProfessDetailsController.selectedSkillLevel.value = '';
    labourProfessDetailsController.contractorCompanyName.value = '';
    for (var controller in addressControllers) {
      controller.clear();
    }
    for (var controller in permanantAddressController) {
      controller.clear();
    }
    // Clearing LabourPrecautionController fields
    labourPrecautionController.selectedItemIds.clear();
    labourPrecautionController.selectedItemInstruction.clear();
    labourPrecautionController.isSelectAll.value = false;
    labourPrecautionController.isSelectAllInstruction.value = false;

    //dovumentation
    labourDocumentationController.labourotherimg.clear();
    labourDocumentationController.adharnoController.clear();
    labourDocumentationController.otherImageCount.value = 0;
    labourDocumentationController.labourimg.clear();
    labourDocumentationController.documentType.clear();
    labourDocumentationController.documentTypeName.clear();
    labourDocumentationController.idNumber.clear();
    labourDocumentationController.validity.clear();

    labourDocumentationController.idnoController.clear();
    labourDocumentationController.validityController.clear();
    labourDocumentationController.validityText.value = '';
    labourDocumentationController.idnoText.value = '';

    labourDocumentationController.selectedDoctType.value = '';
    labourDocumentationController.selectedIdProofId.value = 0;
    labourDocumentationController.selectedDateValidity.value = null;
    labourDocumentationController.dateController.clear();

    log(' Cleared all labour documentation data.');
    labourUndertakingController.clearSignature();
    labourUndertakingController.checkboxValueBehalf = 0;
    for (var undertaking
        in labourUndertakingController.filteredDetailsUndertaking) {
      undertaking['isChecked'] = false;
    }
    labourUndertakingController.isCheckedUndertaking.value = false;

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

  void clearUserFieldsFinal() {
    userFound.value = false;

    labournameController.clear();
    contactnumberController.clear();
    econtactnameController.clear();
    econtactrelationController.clear();
    dateController.clear();
    searchController.clear();
    isSameAsCurrent.value = false;
    econtactnumberController.clear();
    selectedLiteratre.value = '';
    selectedmarried.value = '';
    selectedGender.value = 0;

    selectedBloodGroup.value = "";
    selectedState.value = "";
    selectedDistrict.value = "";
    selectedLiteratre.value = '';
    selectedmarried.value = '';
    selectedPermanantState.value = "";
    selectedPermanantDistrict.value = "";
    profilePhoto.value = '';
    searchType.value = 'ID';
    labourProfessDetailsController.selectedtrade.value = '';
    labourProfessDetailsController.selectedyoe.value = 0;
    labourProfessDetailsController.selectedSkillLevel.value = '';
    labourProfessDetailsController.contractorCompanyName.value = '';
    assignedLabourProjects.clear();

    for (var controller in addressControllers) {
      controller.clear();
    }
    for (var controller in permanantAddressController) {
      controller.clear();
    }

    //dovumentation
    labourDocumentationController.adharnoController.clear();
    labourDocumentationController.selectedDoctType.value = '';
    labourDocumentationController.idnoController.clear();
    labourDocumentationController.validityController.clear();
    labourDocumentationController.labourAdharcard.clear();
    labourDocumentationController.labourotherimg.clear();
    labourDocumentationController.alllabourImgData.clear();

    labourDocumentationController.adharImageCount.value = 0;
    labourDocumentationController.otherImageCount.value = 0;
    labourDocumentationController.alllabourImgDataCount.value = 0;
    labourDocumentationController.labourimg.clear();

    labourPrecautionController.selectedItemIds.clear();
    labourPrecautionController.selectedItemInstruction.clear();
    labourPrecautionController.isSelectAll.value = false;
    labourPrecautionController.isSelectAllInstruction.value = false;

    labourPrecautionController.searchControllerEquipment.clear();
    labourPrecautionController.searchControllerInstruction.clear();

    labourUndertakingController.clearAllCheckboxes();
    printClearedData();
  }

  void printClearedData() {
    print("All user fields and selections have been cleared:");
    print("User Found: ${userFound.value}");
    print("Full Name: ${labournameController.text}");
    print("Contact Number: ${contactnumberController.text}");
    print("Emergency Contact Name: ${econtactnameController.text}");
    print("Emergency Contact Relation: ${econtactrelationController.text}");
    print("Date: ${dateController.text}");
    print("Search Query: ${searchController.text}");
    print("Emergency Contact Number: ${econtactnumberController.text}");
    print("Literacy: ${selectedLiteratre.value}");
    print("Marital Status: ${selectedmarried.value}");
    print("Gender: ${selectedGender.value}");
    print("Blood Group: ${selectedBloodGroup.value}");
    print("State: ${selectedState.value}");
    print("District: ${selectedDistrict.value}");
    print("Permanent State: ${selectedPermanantState.value}");
    print("Permanent District: ${selectedPermanantDistrict.value}");
    print("Selected Image Path: ${profilePhoto.value}");
    print("Search Type: ${searchType.value}");
    print("Trade: ${labourProfessDetailsController.selectedtrade.value}");
    print(
        "Years of Experience: ${labourProfessDetailsController.selectedyoe.value}");
    print(
        "Skill Level: ${labourProfessDetailsController.selectedSkillLevel.value}");
    print(
        "Contractor Company Name: ${labourProfessDetailsController.contractorCompanyName.value}");
    print("Assigned Labour Projects: ${assignedLabourProjects}");

    print("Undertaking checkboxes cleared:");
    for (var item in labourUndertakingController.filteredDetailsUndertaking) {
      print("${item['title']}: ${item['isChecked']}");
    }

    print(
        "Signature cleared: ${labourUndertakingController.signatureController.isEmpty}");

    print("Documentation fields cleared:");
    print("Adhar No: ${labourDocumentationController.adharnoController.text}");
    print(
        "Selected Doc Type: ${labourDocumentationController.selectedDoctType.value}");
    print("ID No: ${labourDocumentationController.idnoController.text}");
    print("Validity: ${labourDocumentationController.validityController.text}");
    print(
        "Adhar Image Count: ${labourDocumentationController.adharImageCount.value}");
    print(
        "Other Image Count: ${labourDocumentationController.otherImageCount.value}");
    print(
        "All Labour Image Data Count: ${labourDocumentationController.alllabourImgDataCount.value}");

    print("Precautions cleared:");
    print("Selected Item IDs: ${labourPrecautionController.selectedItemIds}");
    print(
        "Selected Item Instructions: ${labourPrecautionController.selectedItemInstruction}");
    print("Select All: ${labourPrecautionController.isSelectAll.value}");
    print(
        "Select All Instruction: ${labourPrecautionController.isSelectAllInstruction.value}");
  }
}
