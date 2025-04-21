import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/assign_checker/assign_checker_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_date/work_Permit_date_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_precaution/work_permit_precaution_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_precaution/work_permit_precaution_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_undertaking/work_permit_under_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewWorkPermitScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  NewWorkPermitScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });
  final WorkPermitDateController dateController = Get.find();
  final WorkPermitPrecautionController workPermitPrecautionController =
      Get.find();
  final WorkPermitController workPermitController = Get.find();
  final NewWorkPermitController newWorkPermitController = Get.find();
  final WorkPermitUnderController workPermitUnderController = Get.find();
  final AssignCheckerController assignCheckerController = Get.find();
  final formKey = GlobalKey<FormState>();

  Future<void> showCustomBottomSheetDate(BuildContext context) async {
    final WorkPermitDateController dateController =
        Get.put(WorkPermitDateController());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow bottom sheet to resize based on content
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Avoid infinite height
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Start Date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Start Date',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              dateController.pickStartDate(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.44,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.5, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Obx(() => Text(
                                    // ignore: unnecessary_null_comparison
                                    dateController.selectedStartDate.value !=
                                            null
                                        ? "${dateController.selectedStartDate.value!.toLocal()}"
                                            .split(' ')[0]
                                        : 'Select Start Date',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  )),
                            ),
                          ),
                          Obx(() =>
                              dateController.startDateError.value.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.36,
                                        child: Text(
                                          dateController.startDateError.value,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink())
                        ],
                      ),
                      // End Date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('End Date',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              dateController.pickEndDate(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.44,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.5, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Obx(() => Text(
                                    // ignore: unnecessary_null_comparison
                                    dateController.selectedEndDate.value != null
                                        ? "${dateController.selectedEndDate.value!.toLocal()}"
                                            .split(' ')[0]
                                        : 'Select End Date',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  )),
                            ),
                          ),
                          Obx(() => dateController.endDateError.value.isNotEmpty
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.36,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      dateController.endDateError.value,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Start Time Section with AM/PM toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Start Time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Start Time',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              TimeOfDay? selectedTime = await showTimePicker(
                                context: context,
                                initialTime:
                                    dateController.selectedStartTime.value ??
                                        TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.dial,
                              );

                              if (selectedTime != null) {
                                dateController.updateStartTime(selectedTime);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.45,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.5, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Obx(() => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dateController.selectedStartTime.value
                                                ?.format(context) ??
                                            'Select Start Time',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      Text(
                                        dateController.selectedStartTime.value
                                                    ?.period ==
                                                DayPeriod.am
                                            ? 'AM'
                                            : 'PM',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      SizedBox(width: 20)
                                    ],
                                  )),
                            ),
                          ),
                          Obx(() =>
                              dateController.startTimeError.value.isNotEmpty
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.36,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          dateController.startTimeError.value,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink()),
                        ],
                      ),
                      // End Time with AM/PM toggle
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('End Time',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey)),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              TimeOfDay? selectedTime = await showTimePicker(
                                context: context,
                                initialTime:
                                    dateController.selectedEndTime.value ??
                                        TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode
                                    .dial, // Set to dial mode
                              );
                              if (selectedTime != null) {
                                dateController.updateEndTime(selectedTime);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.45,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.5, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Obx(() => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dateController.selectedEndTime.value
                                                ?.format(context) ??
                                            'Select End Time',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      Text(
                                        dateController.selectedEndTime.value
                                                    ?.period ==
                                                DayPeriod.am
                                            ? 'AM'
                                            : 'PM',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                      SizedBox(width: 20),
                                    ],
                                  )),
                            ),
                          ),
                          Obx(() => dateController.endTimeError.value.isNotEmpty
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.36,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      dateController.endTimeError.value,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 100,
                          // decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     border: Border.all(width: 1, color: Colors.white),
                          //     borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (dateController.validateDateTime()) {
                            String startDate =
                                dateController.selectedStartDate.value != null
                                    ? DateFormat('yyyy-MM-dd').format(
                                        dateController.selectedStartDate.value!)
                                    : '';

                            String startTime =
                                dateController.selectedStartTime.value != null
                                    ? DateFormat('HH:mm:ss').format(DateTime(
                                        0,
                                        1,
                                        1,
                                        dateController
                                            .selectedStartTime.value!.hour,
                                        dateController
                                            .selectedStartTime.value!.minute))
                                    : '';

                            String endDate =
                                dateController.selectedEndDate.value != null
                                    ? DateFormat('yyyy-MM-dd').format(
                                        dateController.selectedEndDate.value!)
                                    : '';

                            String endTime =
                                dateController.selectedEndTime.value != null
                                    ? DateFormat('HH:mm:ss').format(DateTime(
                                        0,
                                        1,
                                        1,
                                        dateController
                                            .selectedEndTime.value!.hour,
                                        dateController
                                            .selectedEndTime.value!.minute))
                                    : '';

                            newWorkPermitController.fromDateTime.value =
                                '$startDate $startTime';
                            newWorkPermitController.toDateTime.value =
                                '$endDate $endTime';

                            String workDuration =
                                '$startDate $startTime - $endDate $endTime';

                            newWorkPermitController.dateController.text =
                                workDuration; // Set the TextFormField value
                            print("Selected Start Date: $startDate");
                            print("Selected End Date: $endDate");
                            print("Selected Start Time: $startTime");
                            print("Selected End Time: $endTime");
                            print("Work Duration: $workDuration");
                            if (dateController.selectedStartDate.value != null &&
                                dateController.selectedStartTime.value !=
                                    null &&
                                dateController.selectedEndDate.value != null &&
                                dateController.selectedEndTime.value != null) {
                              newWorkPermitController.workDuration.value =
                                  '${dateController.selectedStartDate.value!.toLocal().toString().split(' ')[0]} '
                                  '${dateController.selectedStartTime.value!.format(context)} - '
                                  '${dateController.selectedEndDate.value!.toLocal().toString().split(' ')[0]} '
                                  '${dateController.selectedEndTime.value!.format(context)}';
                            }
                            Navigator.pop(context); // Close the bottom sheet
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: AppColors.buttoncolor,
                              border: Border.all(
                                width: 1,
                                color: AppColors.buttoncolor,
                              ),
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            'Set',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: SizeConfig.heightMultiplier * 6,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

//-----------------------------------------
  void showBuildingSelectionSheetBulding(
      BuildContext context, WorkPermitController controller) {
    final NewWorkPermitController newWorkPermitController =
        Get.find<NewWorkPermitController>();

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppTextWidget(
                      text: 'Select Building',
                      fontSize: AppTextSize.textSizeMedium,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Container(
                  height: 1.2,
                  width: SizeConfig.widthMultiplier * 100,
                  decoration: BoxDecoration(color: Colors.grey),
                ),

                SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5.5,
                    width: SizeConfig.widthMultiplier * 82,
                    child: AppTextFormfeild(
                      controller:
                          newWorkPermitController.searchControllerBuilding,
                      hintText: 'Search here..',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/Search.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      onChanged: (value) {
                        newWorkPermitController
                            .updateBuildingSearchQuery(value);
                      },
                    ),
                  ),
                ]),

                SizedBox(height: SizeConfig.heightMultiplier * 2),
                SizedBox(
                  height: 270,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(() {
                          final filteredbuidList =
                              newWorkPermitController.filteredbuildingList;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredbuidList.length,
                            itemBuilder: (context, index) {
                              final build = filteredbuidList[index];
                              return Column(
                                children: [
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 16, right: 16),
                                    leading: Transform.scale(
                                        scale: 1.1,
                                        child: Obx(
                                          () => Checkbox(
                                            side: BorderSide(
                                                color: AppColors.searchfeild,
                                                width: 1),
                                            value: newWorkPermitController
                                                .selectedBuildingIdList
                                                .contains(build.id),
                                            onChanged: (value) {
                                              newWorkPermitController
                                                  .toggleBuildingSelection(
                                                      build.id);
                                            },
                                            activeColor: AppColors.buttoncolor,
                                          ),
                                        )),
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //${index + 1}.

                                        AppTextWidget(
                                          text: filteredbuidList[index]
                                              .buildingName,
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        })
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      newWorkPermitController.addBuilding();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttoncolor, // Button color
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // ✅ Rounded Corners
                      ),
                    ),
                    child: Text(
                      "Add To List",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
              ],
            ));
      },
    );
  }
  //--------------------------------------------------------------------------

  void showBuildingSelectionSheetFloor(
      BuildContext context, WorkPermitController controller, buildingId) {
    final NewWorkPermitController newWorkPermitController =
        Get.find<NewWorkPermitController>();

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppTextWidget(
                      text: 'Select Floor',
                      fontSize: AppTextSize.textSizeMedium,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Container(
                  height: 1.2,
                  width: SizeConfig.widthMultiplier * 100,
                  decoration: BoxDecoration(color: Colors.grey),
                ),

                SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5.5,
                    width: SizeConfig.widthMultiplier * 82,
                    child: AppTextFormfeild(
                      controller: newWorkPermitController.searchControllerFloor,
                      hintText: 'Search here..',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/Search.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      onChanged: (value) {
                        newWorkPermitController.updateFloorSearchQuery(value);
                      },
                    ),
                  ),
                ]),

                SizedBox(height: SizeConfig.heightMultiplier * 2),
                SizedBox(
                  height: 270,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(() {
                          final filteredFloorList =
                              newWorkPermitController.filteredfloorList;

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredFloorList.length,
                            itemBuilder: (context, index) {
                              final floor = filteredFloorList[index];

                              return Column(
                                children: [
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    leading: Transform.scale(
                                      scale: 1.1,
                                      child: Obx(() {
                                        // Get the selected floors for this building
                                        final selectedFloors =
                                            newWorkPermitController
                                                        .selectedFloorIdsByBuilding[
                                                    buildingId] ??
                                                [];

                                        return Checkbox(
                                          side: BorderSide(
                                              color: AppColors.searchfeild,
                                              width: 1),
                                          value:
                                              selectedFloors.contains(floor.id),
                                          onChanged: (value) {
                                            newWorkPermitController
                                                .toggleFloorSelection(
                                                    floor.id, buildingId);
                                          },
                                          activeColor: AppColors.buttoncolor,
                                        );
                                      }),
                                    ),
                                    title: AppTextWidget(
                                      text: floor.floorName,
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryText,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      newWorkPermitController.addfloorbuildFinal(buildingId);

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttoncolor, // Button color
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // ✅ Rounded Corners
                      ),
                    ),
                    child: Text(
                      "Add To List",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.heightMultiplier * 10),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: AppBar(
              scrolledUnderElevation: 0.0,
              elevation: 0,
              backgroundColor: AppColors.buttoncolor,
              foregroundColor: AppColors.buttoncolor,
              centerTitle: true,
              toolbarHeight: SizeConfig.heightMultiplier * 10,
              title: Padding(
                padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
                child: AppTextWidget(
                  text: 'New Work Permit',
                  fontSize: AppTextSize.textSizeMedium,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: SizeConfig.heightMultiplier * 2.5,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 2,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.33,
                            backgroundColor: AppColors.searchfeildcolor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.defaultPrimary),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '01/03',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                    AppTextWidget(
                      text: 'Work Permit Details',
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.3,
                    ),
                    AppTextWidget(
                      text: 'Enter work permit details.',
                      fontSize: AppTextSize.textSizeSmalle,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: 'Select SubActivity',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        AppTextWidget(
                            text: AppTexts.star,
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.starcolor),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Obx(
                      () => AppSearchDropdown(
                        items: workPermitController.subActivityWorkList
                            .map(
                              (sub) => sub.subActivityName,
                            )
                            .whereType<String>()
                            .toList(),
                        selectedItem: newWorkPermitController
                                .selectedWorkActivity.value.isNotEmpty
                            ? newWorkPermitController.selectedWorkActivity.value
                            : null,
                        hintText: 'Select SubActivity',
                        onChanged: (value) async {
                          newWorkPermitController.selectedWorkActivity.value =
                              value ?? '';
                          var selectedcat = workPermitController
                              .subActivityWorkList
                              .firstWhereOrNull(
                                  (sub) => sub.subActivityName == value);
                          if (selectedcat != null) {
                            newWorkPermitController
                                .selectedWorkActivityId.value = selectedcat.id;
                            workPermitPrecautionController
                                .clearSelectedWorkPermitData();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomLoadingPopup());
                            await newWorkPermitController
                                .getDocumentRequiredData(newWorkPermitController
                                    .selectedWorkActivityId.value);
                            Get.back();
                            log('Selected newWorkPermitController.selectedWorkActivity: ${newWorkPermitController.selectedWorkActivity.value}');
                            log('Selected newWorkPermitController.selectedWorkActivityId: ${newWorkPermitController.selectedWorkActivityId.value}');
                          } else {
                            log('No matching reason found for: $value');
                          }
                        },
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'SubActivity cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: 'Description of Work ',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    AppTextFormfeild(
                      controller: newWorkPermitController.descWorkrController,
                      hintText: 'Description of Work here...',
                      focusNode: newWorkPermitController.dow,
                      onFieldSubmitted: (_) {
                        newWorkPermitController.dow.unfocus();
                      },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: 'Attach Toolbox Training',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Obx(
                      () => AppSearchDropdown(
                        items: workPermitController.safetyToolboxTraining
                            .map(
                              (t) => t.nameOfTbTraining,
                            )
                            .whereType<String>()
                            .toList(),
                        selectedItem: newWorkPermitController
                                .selectedtoolboxtrainig.value.isNotEmpty
                            ? newWorkPermitController
                                .selectedtoolboxtrainig.value
                            : null,
                        hintText: 'Select toolbox training',
                        onChanged: (value) async {
                          newWorkPermitController.selectedtoolboxtrainig.value =
                              value ?? '';
                          var selectedtool = workPermitController
                              .safetyToolboxTraining
                              .firstWhereOrNull(
                                  (t) => t.nameOfTbTraining == value);
                          if (selectedtool != null) {
                            newWorkPermitController.selectedtoolboxId.value =
                                selectedtool.id;

                            log('Selected newWorkPermitController.selectedtoolboxId: ${newWorkPermitController.selectedtoolboxId.value}');
                            log('Selected newWorkPermitController.selectedtoolboxtrainig: ${newWorkPermitController.selectedtoolboxtrainig.value}');
                          } else {
                            log('No matching reason found for: $value');
                          }
                        },
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'toolbox cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: 'Name of Work Permit',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        AppTextWidget(
                            text: AppTexts.star,
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.starcolor),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    AppTextFormfeild(
                      controller:
                          newWorkPermitController.nameworkpermitController,
                      hintText: 'Work permit name',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid work permit name';
                        }
                        return null;
                      },
                      focusNode: newWorkPermitController.nameofworkpermit,
                      onFieldSubmitted: (_) {
                        newWorkPermitController.nameofworkpermit.unfocus();
                      },
                      onChanged: (value) {},
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: AppTextWidget(
                            text: 'Select Building',
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText,
                          ),
                        ),
                        AppTextWidget(
                            text: AppTexts.star,
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.starcolor),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            showBuildingSelectionSheetBulding(
                                context, Get.find<WorkPermitController>());
                          },
                          child: AbsorbPointer(
                            child: DropdownButtonFormField<String>(
                              value: newWorkPermitController
                                      .selectedBuilding.value.isNotEmpty
                                  ? newWorkPermitController
                                      .selectedBuilding.value
                                  : null,
                              items: newWorkPermitController.buildings
                                  .map((building) => DropdownMenuItem(
                                        value: building,
                                        child: AppTextWidget(
                                          text: building,
                                          fontSize: AppTextSize.textSizeMedium,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryText,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                              hint: AppTextWidget(
                                text: 'Select Building',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w400,
                                color: AppColors.searchfeild,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.searchfeild,
                                size: 27,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.searchfeildcolor,
                                      width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.searchfeildcolor,
                                      width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(() => newWorkPermitController
                            .buildingfloorerror.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4, left: 12),
                            child: Text(
                              newWorkPermitController.buildingfloorerror.value,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 174, 75, 68),
                                fontSize: 12,
                              ),
                            ),
                          )
                        : SizedBox()),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: AppTextWidget(
                            text: 'Select Floor',
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText,
                          ),
                        ),
                        AppTextWidget(
                            text: AppTexts.star,
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.starcolor),
                      ],
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.6,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: AppTextWidget(
                            text: 'Note : Tap on Building to add Floor',
                            fontSize: AppTextSize.textSizeSmalle,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                        AppTextWidget(
                            text: AppTexts.star,
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.starcolor),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    // UI Code Update
                    Obx(() {
                      if (newWorkPermitController
                          .selectedBuildingIdListFinal.isEmpty) {
                        return SizedBox
                            .shrink(); // If list is empty, don't take up space
                      }
                      return SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: newWorkPermitController
                              .selectedBuildingIdListFinal.length,
                          itemBuilder: (context, index) {
                            final building = newWorkPermitController
                                .selectedBuildingIdListFinal[index];

                            // Ensure key names match the stored structure
                            int? id = building['building_id'] as int?;
                            List<int> floorIds = building['floor_ids'] ?? [];

                            if (id == null) {
                              log('Error: Building ID is null');
                              return SizedBox(); // Skip rendering for null entries
                            }

                            String buildingName =
                                newWorkPermitController.getBuildingNameById(id);
                            String getFloorNameById = newWorkPermitController
                                .getFloorNamesByIds(floorIds);

                            log('Selected ID: $id');

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.secondaryText.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomLoadingPopup(),
                                            );

                                            await newWorkPermitController
                                                .getSafetyfloorData(id);
                                            Get.back();

                                            log('Selected ID: $id');

                                            showBuildingSelectionSheetFloor(
                                              context,
                                              Get.find<WorkPermitController>(),
                                              id,
                                            );
                                          },
                                          child: SizedBox(
                                            width:
                                                SizeConfig.widthMultiplier * 73,
                                            child: AppTextWidget(
                                              text:
                                                  "Selected Building : $buildingName",
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryText,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            newWorkPermitController
                                                .deleteBuilding(index, id);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 20,
                                            color: AppColors.primaryText,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              SizeConfig.widthMultiplier * 75,
                                          child: AppTextWidget(
                                            text:
                                                "Selected Floor : ${getFloorNameById}",
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        showCustomBottomSheetDate(context);
                      },
                      child: Row(
                        children: [
                          AppTextWidget(
                            text: 'Duration of Work',
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText,
                          ),
                          AppTextWidget(
                              text: AppTexts.star,
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.starcolor),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showCustomBottomSheetDate(context);
                      },
                      child: Container(
                        height: 50,
                        width: SizeConfig.widthMultiplier * 91,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.searchfeildcolor, width: 1),
                        ),
                        child: Obx(() {
                          return Text(
                            newWorkPermitController.workDuration.value.isEmpty
                                ? 'Select Duration of Work'
                                : newWorkPermitController.workDuration.value,
                            style: GoogleFonts.inter(
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: newWorkPermitController
                                      .workDuration.value.isEmpty
                                  ? AppColors.searchfeild
                                  : AppColors.primaryText,
                            ),
                          );
                        }),
                      ),
                    ),
                    Obx(() => newWorkPermitController.workDuration.value.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4, left: 12),
                            child: Text(
                              newWorkPermitController.workDurationError.value,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 174, 75, 68),
                                fontSize: 12,
                              ),
                            ),
                          )
                        : SizedBox()),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    //--------------------------------------

                    SizedBox(height: SizeConfig.heightMultiplier * 5),
                    AppElevatedButton(
                        text: 'Next',
                        onPressed: () {
                          log(newWorkPermitController
                              .selectedBuildingIdListFinal
                              .toString());
                          if (newWorkPermitController
                              .validateBuildingSelection()) {}

                          newWorkPermitController
                              .validateWorkDuration(); // Call work duration validation

                          if (formKey.currentState!.validate() &&
                              newWorkPermitController
                                  .validateBuildingSelection() &&
                              newWorkPermitController
                                  .workDuration.value.isNotEmpty) {
                            Get.to(WorkPermitPrecautionScreen(
                                userId: userId,
                                userName: userName,
                                userImg: userImg,
                                userDesg: userDesg,
                                projectId: projectId));
                          }
                        }),
                    SizedBox(height: SizeConfig.heightMultiplier * 5),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
