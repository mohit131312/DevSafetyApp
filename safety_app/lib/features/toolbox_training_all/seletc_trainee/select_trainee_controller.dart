import 'package:flutter/material.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectTraineeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //------------------------------------------------------------------------------------------------------
  var selectedOption = 0.obs;
  // final IncidentReportController incidentReportController =
  //     Get.put(IncidentReportController());
  final ToolboxTrainingController toolboxTrainingController = Get.find();

  final TextEditingController searchController = TextEditingController();
  final TextEditingController searchStaffController = TextEditingController();
  final TextEditingController searchContractorController =
      TextEditingController();

  late TabController tabController;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      selectedOption.value = tabController.index;
      print("Selected Tab Index: ${selectedOption.value}");
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  var selectedIncidentLabourIds = <int>[].obs;
  var selectedIncidentLabourIdsFinal = <Map<String, dynamic>>[].obs;

  void toggleIncidentSelection(int id) {
    if (selectedIncidentLabourIds.contains(id)) {
      selectedIncidentLabourIds.remove(id);
    } else {
      selectedIncidentLabourIds.add(id);
    }
    print(
        "Selected IncidentLabourIds IDs: ${selectedIncidentLabourIds.toList()}");
  }

  var searchQuery = ''.obs;

  void updateIncidentSearchQuery(String query) {
    searchQuery.value = query;
  }

  // List<InvolvedList> get filteredIncidentLabours {
  //   final query = searchQuery.value.toLowerCase();
  //   return incidentReportController.involvedIncidentLaboursList
  //       .where((labour) =>
  //           labour.labourName.toLowerCase().contains(query) ||
  //           labour.id.toString().contains(query))
  //       .toList();
  // }

  List<TraineesList> get filteredIncidentLabours {
    final query = searchQuery.value.toLowerCase();
    return toolboxTrainingController.traineesLaboursList
        .where((t) =>
            t.labourName!.toLowerCase().contains(query) ||
            t.id.toString().contains(query))
        .toList();
  }

  void addIncidentData() {
    selectedIncidentLabourIdsFinal.clear();
    selectedIncidentLabourIdsFinal.addAll(
        selectedIncidentLabourIds.map((id) => {"user_type": "1", "id": id}));

    print(
        "SelectedLabour Data for API: ${selectedIncidentLabourIdsFinal.toList()}");
  }

  void removeIncidentData(int index) {
    if (index >= 0 && index < selectedIncidentLabourIdsFinal.length) {
      Map<String, dynamic> itemToRemove = selectedIncidentLabourIdsFinal[index];
      int idToRemove = itemToRemove["id"];

      selectedIncidentLabourIdsFinal.removeAt(index);
      selectedIncidentLabourIds.remove(idToRemove);
      // toolboxAddTraineeController.signatureVisibility.remove(index);
      // toolboxAddTraineeController.signatureControllers.remove(index);

      // // Refresh to update UI
      // toolboxAddTraineeController.signatureVisibility.refresh();
      // toolboxAddTraineeController.signatureControllers.refresh();

      print("Removed Labour ID: $idToRemove");
      print(
          "Updated selectedIncidentLabourIdsFinal: ${selectedIncidentLabourIdsFinal.toList()}");
      print(
          "Updated selectedIncidentLabourIds: ${selectedIncidentLabourIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<TraineesList> get addIncidentInvolvePerson {
    return toolboxTrainingController.traineesLaboursList
        .where((labour) => selectedIncidentLabourIdsFinal
            .any((item) => item["id"] == labour.id))
        .toList();
  }

  ///------------------------------------------------------------------
  ///

  var selectedIncidentStaffIds = <int>[].obs;

  var selectedIncidentStaffIdsFinal = <Map<String, dynamic>>[].obs;

  void toggleIncidentStaffSelection(int id) {
    if (selectedIncidentStaffIds.contains(id)) {
      selectedIncidentStaffIds.remove(id);
    } else {
      selectedIncidentStaffIds.add(id);
    }
    print(
        "Selected selectedIncidentStaffIds IDs: ${selectedIncidentStaffIds.toList()}");
  }

  var searchStaffQuery = ''.obs;

  void updateSearchIncidentStaffQuery(String query) {
    searchStaffQuery.value = query;
  }

  // List<InvolvedStaffList> get filteredIncidentStaff {
  //   final query = searchStaffQuery.value.toLowerCase();
  //   return incidentReportController.involvedIncidentStaffList
  //       .where((staff) =>
  //           staff.staffName!.toLowerCase().contains(query) ||
  //           staff.id.toString().contains(query))
  //       .toList();
  // }
  List<TraineesListStaff> get filteredIncidentStaff {
    final query = searchStaffQuery.value.toLowerCase();
    return toolboxTrainingController.traineesstaffList
        .where((staff) =>
            staff.staffName!.toLowerCase().contains(query) ||
            staff.staffid.toString().contains(query))
        .toList();
  }

  void addIncidentStaffData() {
    selectedIncidentStaffIdsFinal.clear(); // Clear previous selections
    selectedIncidentStaffIdsFinal.addAll(
        selectedIncidentStaffIds.map((id) => {"user_type": "3", "id": id}));

    print(
        "Selected Staff Data for API: ${selectedIncidentStaffIdsFinal.toList()}");
  }

  void removeIncidentStaffData(int index) {
    if (index >= 0 && index < selectedIncidentStaffIdsFinal.length) {
      Map<String, dynamic> itemToRemove = selectedIncidentStaffIdsFinal[index];

      int idToRemove = itemToRemove["id"];

      selectedIncidentStaffIdsFinal.removeAt(index);
      selectedIncidentStaffIds.remove(idToRemove);

      print("Removed Staff ID: $idToRemove");
      print(
          "Updated selectedIncidentStaffIdsFinal: ${selectedIncidentStaffIdsFinal.toList()}");
      print(
          "Updated selectedIncidentStaffIds: ${selectedIncidentStaffIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<TraineesListStaff> get addInvolveIncidentStaffPerson {
    return toolboxTrainingController.traineesstaffList
        .where((staff) => selectedIncidentStaffIdsFinal
            .any((item) => item["id"] == staff.staffid))
        .toList();
  }
  //-------------------------------------------------------------

  var selectedIncidentContractorIds = <int>[].obs;
  var selectedIncidentContractorIdsFinal = <Map<String, dynamic>>[].obs;

  void toggleIncidentContractorSelection(int id) {
    if (selectedIncidentContractorIds.contains(id)) {
      selectedIncidentContractorIds.remove(id);
    } else {
      selectedIncidentContractorIds.add(id);
    }
    print(
        "Selected selectedIncidentContractorIds IDs: ${selectedIncidentContractorIds.toList()}");
  }

  var searchContractorQuery = ''.obs;

  void updateSearchIncidentContractorQuery(String query) {
    searchContractorQuery.value = query;
  }

  // List<InvolvedContractorUserList> get filteredIncidentContractor {
  //   final query = searchContractorQuery.value.toLowerCase();
  //   return incidentReportController.involvedIncidentContractorList
  //       .where((contractor) =>
  //           contractor.contractorName.toLowerCase().contains(query) ||
  //           contractor.id.toString().contains(query))
  //       .toList();
  // }
  List<TraineesContractorUserList> get filteredIncidentContractor {
    final query = searchContractorQuery.value.toLowerCase();
    return toolboxTrainingController.traineesContractorList
        .where((contractor) =>
            contractor.contractorName!.toLowerCase().contains(query) ||
            contractor.id.toString().contains(query))
        .toList();
  }

  void addIncidentContractorData() {
    selectedIncidentContractorIdsFinal.clear();
    selectedIncidentContractorIdsFinal.addAll(selectedIncidentContractorIds
        .map((id) => {"user_type": "2", "id": id}));

    print(
        "Selected selectedIncidentContractorIdsFinal Data for API: ${selectedIncidentContractorIdsFinal.toList()}");
  }

  void removeIncidentContractorData(int index) {
    if (index >= 0 && index < selectedIncidentContractorIdsFinal.length) {
      Map<String, dynamic> itemToRemove =
          selectedIncidentContractorIdsFinal[index];
      int idToRemove = itemToRemove["id"];

      selectedIncidentContractorIdsFinal.removeAt(index);
      selectedIncidentContractorIds.remove(idToRemove);

      print("Removed Contractor ID: $idToRemove");
      print(
          "Updated Contractor: ${selectedIncidentContractorIdsFinal.toList()}");
      print(
          "Updated Contractor IDS: ${selectedIncidentContractorIds.toList()}");
    } else {
      print("Invalid index: $index");
    }
  }

  List<TraineesContractorUserList> get addInvolveIncidentContractorPerson {
    return toolboxTrainingController.traineesContractorList
        .where((contractor) => selectedIncidentContractorIdsFinal
            .any((item) => item["id"] == contractor.id))
        .toList();
  }

  ///-----------------------------------------
  ///

  Future<void> makeCall(String phoneNumber) async {
    // Ensure the phone number is valid for the 'tel' scheme
    final Uri callUri = Uri.parse('tel:$phoneNumber');
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(callUri.toString())) {
        // ignore: deprecated_member_use
        await launch(callUri.toString());
      } else {
        Get.snackbar(
          'Error',
          'Unable to launch dialer. Please check your number or phone settings.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while trying to make a call.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void clearAllTrainneData() {
    selectedIncidentLabourIds.clear();
    selectedIncidentLabourIdsFinal.clear();

    selectedIncidentStaffIds.clear();
    selectedIncidentStaffIdsFinal.clear();

    selectedIncidentContractorIds.clear();
    selectedIncidentContractorIdsFinal.clear();

    searchQuery.value = '';
    searchStaffQuery.value = '';
    searchContractorQuery.value = '';

    searchController.clear();
    searchStaffController.clear();
    searchContractorController.clear();

    print("All data cleared!");
  }
}
