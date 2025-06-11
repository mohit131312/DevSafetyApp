// lib/utils/image_helper.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<XFile?> pickAndCropImage({
    required ImageSource source,
    double maxHeight = 1080,
    double maxWidth = 1080,
    int maxSizeInMB = 2,
    BuildContext? context, // Optional: For showing messages
  }) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      );

      if (pickedFile == null) {
        debugPrint("No image selected");
        return null;
      }

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressQuality: 72,
        uiSettings: [
          AndroidUiSettings(
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.buttoncolor,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Crop Image'),
        ],
      );

      if (croppedFile == null) {
        debugPrint("Image cropping cancelled");
        return null;
      }

      final file = File(croppedFile.path);
      final fileSize = await file.length();

      final sizeInKB = fileSize / 1024;
      final sizeInMB = fileSize / (1024 * 1024);

      print("Image size: ${sizeInKB.toStringAsFixed(2)} KB");
      print("Image size: ${sizeInMB.toStringAsFixed(2)} MB");

      if (fileSize > maxSizeInMB * 1024 * 1024) {
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Image exceeds ${maxSizeInMB}MB. Please select a smaller image.')),
          );
        }
        return null;
      }

      return XFile(file.path);
    } catch (e) {
      debugPrint("Error picking or cropping image: $e");
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Something went wrong while selecting image.')),
        );
      }
      return null;
    }
  }

  /// ✅ New method: Crops a given file (used for multiple gallery selections)
  static Future<XFile?> cropImageFile({
    required XFile file,
    BuildContext? context,
    double maxHeight = 1080,
    double maxWidth = 1080,
    int maxSizeInMB = 2,
  }) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        compressQuality: 72,
        maxHeight: maxHeight.toInt(),
        maxWidth: maxWidth.toInt(),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.buttoncolor,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(title: 'Crop Image'),
        ],
      );

      if (croppedFile == null) {
        debugPrint("Image cropping cancelled");
        return null;
      }

      final cropped = File(croppedFile.path);
      final fileSize = await cropped.length();
      final sizeInMB = fileSize / (1024 * 1024);
      final sizeInKB = fileSize / 1024;

      print("Image size: ${sizeInKB.toStringAsFixed(2)} KB");
      print("Image size: ${sizeInMB.toStringAsFixed(2)} MB");
      if (sizeInMB > maxSizeInMB) {
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image exceeds ${maxSizeInMB}MB.')),
          );
        }
        return null;
      }

      return XFile(cropped.path);
    } catch (e) {
      debugPrint("Error cropping image: $e");
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Something went wrong during cropping.')),
        );
      }
      return null;
    }
  }
}
