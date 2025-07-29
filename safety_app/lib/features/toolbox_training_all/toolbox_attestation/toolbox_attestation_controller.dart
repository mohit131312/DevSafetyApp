import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class ToolboxAttestationController extends GetxController {
  var signatureattestationError = ''.obs;

  final SignatureController signatureattestationController =
      SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  var savedAttestationSignature = Rxn<Uint8List>();

  void clearIncidentattestationSignature() {
    signatureattestationController.clear();
    savedAttestationSignature.value = null;
    signatureattestationError.value = "";
  }

  File signatureFile = File('');

  Future<void> saveSafetyIncidentSignature() async {
    try {
      const int signatureWidth = 360;
      const int signatureHeight = 206;

      Uint8List? signatureBytes =
          await signatureattestationController.toPngBytes(
        width: signatureWidth,
        height: signatureHeight,
      );
      // Uint8List? signatureBytes =
      //     await signatureattestationController.toPngBytes();

      if (signatureBytes != null) {
        // Save as a file
        Directory tempDir = await getTemporaryDirectory();
        signatureFile = File('${tempDir.path}/signature.png');
        await signatureFile.writeAsBytes(signatureBytes);
        savedAttestationSignature.value = signatureBytes;

        print("SignatureIncident saved at: ${signatureFile.path}");
      } else {
        print("Signature is null");
      }
    } catch (e) {
      print("Error saving signature: $e");
      signatureattestationError.value = "";
    }
  }

  void clearAllData() {
    clearIncidentattestationSignature(); // Clears the signature and error message
    signatureFile = File(''); // Resets the file reference
    print("All attestation data cleared!");
  }
}
