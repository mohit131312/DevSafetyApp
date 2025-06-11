import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:get/get.dart';

class WorkPermitDateController extends GetxController {
  var selectedStartDate = Rxn<DateTime>();
  var selectedEndDate = Rxn<DateTime>();
  var selectedStartTime = Rxn<TimeOfDay>();
  var selectedEndTime = Rxn<TimeOfDay>();

  var startDateError = ''.obs;
  var endDateError = ''.obs;
  var startTimeError = ''.obs;
  var endTimeError = ''.obs;

  /// Function to pick Start Date
  Future<void> pickStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.buttoncolor,
              onPrimary: Colors.white,
              onSurface: const Color.fromARGB(255, 28, 27, 27),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedStartDate.value = picked;
      startDateError.value = ""; // Clear error on valid selection

      // Ensure the end date is not before the start date
      if (selectedEndDate.value != null &&
          selectedEndDate.value!.isBefore(picked)) {
        selectedEndDate.value = picked;
      }

      validateDateTime();
    }
  }

  /// Function to pick End Date
  Future<void> pickEndDate(BuildContext context) async {
    if (selectedStartDate.value == null) {
      startDateError.value = "Please select a Start Date first";
      return;
    }

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate.value ?? selectedStartDate.value!,
      firstDate:
          selectedStartDate.value!, // Prevent selecting before start date
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.buttoncolor,
              onPrimary: Colors.white,
              onSurface: const Color.fromARGB(255, 28, 27, 27),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedEndDate.value = picked;
      endDateError.value = ""; // Clear error on valid selection
      validateDateTime();
    }
  }

  /// Function to update Start Time
  void updateStartTime(TimeOfDay newTime) {
    selectedStartTime.value = newTime;
    startTimeError.value = ""; // Clear error on valid selection
    validateDateTime();
  }

  /// Function to update End Time
  void updateEndTime(TimeOfDay newTime) {
    if (selectedStartTime.value == null) {
      startTimeError.value = "Please select a Start Time first";
      return;
    }

    if (selectedEndDate.value == selectedStartDate.value) {
      // Ensure End Time is after Start Time if the date is the same
      if (newTime.hour < selectedStartTime.value!.hour ||
          (newTime.hour == selectedStartTime.value!.hour &&
              newTime.minute <= selectedStartTime.value!.minute)) {
        endTimeError.value = "End Time must be after Start Time";
        return;
      }
    }

    selectedEndTime.value = newTime;
    endTimeError.value = ""; // Clear error on valid selection
    validateDateTime();
  }

  /// Function to Validate Start/End Date & Time
  bool validateDateTime() {
    bool isValid = true;

    if (selectedStartDate.value == null) {
      startDateError.value = "Start Date is required";
      isValid = false;
    }

    if (selectedEndDate.value == null) {
      endDateError.value = "End Date is required";
      isValid = false;
    } else if (selectedStartDate.value != null &&
        selectedEndDate.value!.isBefore(selectedStartDate.value!)) {
      endDateError.value = "End Date cannot be before Start Date";
      isValid = false;
    }

    if (selectedStartTime.value == null) {
      startTimeError.value = "Start Time is required";
      isValid = false;
    }

    if (selectedEndTime.value == null) {
      endTimeError.value = "End Time is required";
      isValid = false;
    } else if (selectedStartTime.value != null &&
        selectedEndTime.value != null &&
        selectedEndDate.value == selectedStartDate.value) {
      if (selectedEndTime.value!.hour < selectedStartTime.value!.hour ||
          (selectedEndTime.value!.hour == selectedStartTime.value!.hour &&
              selectedEndTime.value!.minute <=
                  selectedStartTime.value!.minute)) {
        endTimeError.value = "End Time must be after Start Time";
        isValid = false;
      }
    }

    return isValid;
  }

  void clearDuraion() {
    selectedStartDate.value = null;
    selectedEndDate.value = null;
    selectedStartTime.value = null;
    selectedEndTime.value = null;
    startDateError.value = '';
    endDateError.value = '';
    startTimeError.value = '';
    endTimeError.value = '';
  }
}
