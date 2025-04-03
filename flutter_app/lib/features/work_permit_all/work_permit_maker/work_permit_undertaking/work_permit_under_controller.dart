import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class WorkPermitUnderController extends GetxController {
  RxBool isCheckedUndertaking = false.obs;
  var searchQueryUndertaking = ''.obs;
  var filteredDetailsUndertaking = [].obs;
  final TextEditingController searchControllerUndertaking =
      TextEditingController();
  var isChecked = false.obs;
  var checkboxError = ''.obs; // ✅ Validation error message

  var isCheckedSin = false.obs;
  int checkboxValueBehalf = 0;
  void toggleCheckboxSign() {
    isCheckedSin.value = !isCheckedSin.value;
    print("isCheckedSin: ${isCheckedSin.value}");
    checkboxValueBehalf = isCheckedSin.value ? 1 : 0;

    print("isCheckedSin: $checkboxValueBehalf");
  }

  @override
  void onInit() {
    super.onInit();
    filteredDetailsUndertaking.assignAll(checklistUndertaking);
  }

  bool areAllChecked() =>
      filteredDetailsUndertaking.every((item) => item['isChecked'] == true);

  var checklistUndertaking = [
    {
      'title': 'I understood and will follow all the instructions given to me.',
      'isChecked': false
    },
    {
      'title':
          'I accept all the company regulations explained to me and I will comply to those. ',
      'isChecked': false
    },
    {
      'title':
          'I hereby declare that the information documents provided in above form is true & correct to the best of my knowledge and belief and nothing has been falsely stated. In case any of the above information is found to be false or untrue or misleading or misreprese-nting, I am aware that may be held liable for it.',
      'isChecked': false
    },
  ];

  void toggleCheckboxUndertaking(int index) {
    filteredDetailsUndertaking[index]['isChecked'] =
        !filteredDetailsUndertaking[index]['isChecked'];
    filteredDetailsUndertaking.refresh();

    isCheckedUndertaking.value = areAllChecked();
    print(
        "Checkbox at index $index is now: ${filteredDetailsUndertaking[index]['isChecked']}");
    int checkboxValue = filteredDetailsUndertaking[index]['isChecked'] ? 1 : 0;
    print("Checkbox at index $index is now: $checkboxValue");
    checkboxError.value = '';
  }

  void toggleSelectAllUndertaking() {
    bool newValue = !isCheckedUndertaking.value;
    isCheckedUndertaking.value = newValue;

    for (var item in filteredDetailsUndertaking) {
      item['isChecked'] = newValue;
    }
    filteredDetailsUndertaking.refresh();
    print(
        "All checkboxes set to: $newValue"); // Print all checkbox values in 1 or 0 format
    print("All checkboxes set to: ${newValue ? 1 : 0}");
    checkboxError.value = '';
  }

  void searchDataUndertaking(String query) {
    searchQueryUndertaking.value = query;
    if (query.isEmpty) {
      filteredDetailsUndertaking.assignAll(checklistUndertaking);
    } else {
      filteredDetailsUndertaking.assignAll(
        filteredDetailsUndertaking
            .where((item) => item['title']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void validateCheckboxes() {
    if (!areAllChecked()) {
      checkboxError.value = "Please check all the required checkboxes.";
    }
  }

  // List<Map<String, dynamic>> getCheckboxDataForAPI() {
  //   return filteredDetailsUndertaking.map((item) {
  //     return {
  //       'title': item['title'],
  //       'isChecked': item['isChecked'] ? 1 : 0, // Convert to 1 or 0
  //     };
  //   }).toList();
  // }
  var signatureError = ''.obs; // Observable for validation message
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  void clearSignature() {
    signatureController.clear();
    signatureError.value = "";
  }

  File signatureFile = File('');
  Future<void> saveSignature() async {
    try {
      Uint8List? signatureBytes = await signatureController.toPngBytes();

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
      signatureError.value = "";
    }
  }

  void clearAllCheckboxes() {
    for (var item in filteredDetailsUndertaking) {
      item['isChecked'] = false;
    }
    filteredDetailsUndertaking.refresh();
    isCheckedUndertaking.value = false;
    isChecked.value = false;
    isCheckedSin.value = false;
    clearSignature();
  }
}
