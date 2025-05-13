import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_attestaion/safety_attestaion_screen.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_assignee/select_safety_assignee.dart';
import 'package:flutter_app/features/safety_violation_all/select_assignee/select_safety_assignee_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_informed_people/select_safety_informed_people.dart';
import 'package:flutter_app/features/safety_violation_all/select_informed_people/select_safety_informed_people_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_involved_person/select_involved_person.dart';
import 'package:flutter_app/features/safety_violation_all/select_involved_person/select_involved_person_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SafetyViolationDetails extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  SafetyViolationDetails({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final SelectInvolvedPersonController selectInvolvedPersonController =
      Get.find();
  final SelectSafetyInformedPeopleController
      selectSafetyInformedPeopleController = Get.find();
  final SafetyViolationDetailsController safetyViolationDetailsController =
      Get.find();

  final SelectSafetyAssigneeController selectSafetyAssigneeController =
      Get.find();
  final LocationController locationController = Get.find();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: AppColors.buttoncolor,
          centerTitle: true,
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: AppTextWidget(
              text: 'Safety Violation & Debit Note',
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
                            value: 0.50,
                            backgroundColor: AppColors.searchfeildcolor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.defaultPrimary),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '01/02',
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
                      text: 'Violation Details',
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.3,
                    ),
                    AppTextWidget(
                      text: 'Enter violation information in details.',
                      fontSize: AppTextSize.textSizeSmalle,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),

                    ////---------------
                    Column(
                      children: [
                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Photo',
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
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Obx(
                          () => safetyViolationDetailsController
                                      .violationImageCount <
                                  1
                              ? Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.widthMultiplier * 92,
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 24, bottom: 24),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.orange, width: 2),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.orange.shade50,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              safetyViolationDetailsController
                                                  .pickViolationImages(
                                                      source:
                                                          ImageSource.camera);
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.orange,
                                                  size: 30,
                                                ),
                                                SizedBox(height: 8),
                                                AppTextWidget(
                                                    text: 'Click Photo',
                                                    fontSize: AppTextSize
                                                        .textSizeExtraSmall,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .secondaryText),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  safetyViolationDetailsController
                                                      .pickViolationImages(
                                                          source: ImageSource
                                                              .gallery);
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.photo_library,
                                                      color: Colors.orange,
                                                      size: 30,
                                                    ),
                                                    SizedBox(height: 8),
                                                    AppTextWidget(
                                                        text: 'Open Galley',
                                                        fontSize: AppTextSize
                                                            .textSizeExtraSmall,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .secondaryText),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 14),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.buttoncolor),
                                        height: 1,
                                      ),
                                      SizedBox(height: 14),
                                      AppTextWidget(
                                          text: 'Maximum 10 photos',
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryText),
                                    ],
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Ensure items align properly

                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            child: GridView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    safetyViolationDetailsController
                                                        .violationimg.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      3, // Ensures one row (horizontal scroll)

                                                  childAspectRatio:
                                                      1, // Keeps items square
                                                  mainAxisSpacing: 10,
                                                  crossAxisSpacing:
                                                      10, // Spacing between images
                                                ),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Stack(
                                                    children: [
                                                      SizedBox(
                                                        height: SizeConfig
                                                                .imageSizeMultiplier *
                                                            18,
                                                        width: SizeConfig
                                                                .imageSizeMultiplier *
                                                            18,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12), // Clip image to match container

                                                          child: Image.file(
                                                            File(safetyViolationDetailsController
                                                                .violationimg[
                                                                    index]
                                                                .path),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 1,
                                                        right: 1,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            safetyViolationDetailsController
                                                                .removeViolationImage(
                                                                    index);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8),
                                                            ),
                                                            child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                                size: 15),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                }),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.imageSizeMultiplier *
                                                  5,
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                safetyViolationDetailsController
                                                    .pickViolationImages(
                                                        source:
                                                            ImageSource.camera);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.orange,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                safetyViolationDetailsController
                                                    .pickViolationImages(
                                                        source: ImageSource
                                                            .gallery);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.photo_library,
                                                  color: Colors.orange,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),

                        safetyViolationDetailsController.violationImageCount < 1
                            ? SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              )
                            : SizedBox(),
                        safetyViolationDetailsController.violationImageCount < 1
                            ? Row(
                                children: [
                                  AppTextWidget(
                                      text: 'Maximum 5 files (photos/1 video)',
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryText),
                                ],
                              )
                            : SizedBox(),

                        Obx(() => safetyViolationDetailsController
                                    .violationImageCount.value ==
                                0
                            ? Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 5),
                                    child: Text(
                                      safetyViolationDetailsController
                                          .photoError.value,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox()),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2.5,
                        ),

                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Violation Type',
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
                            // enabled: !addLabourController
                            //     .userFound.value, // ✅ Editable only if user NOT found

                            items: safetyViolationDetailsController
                                .violationTypeList
                                .map(
                                  (violation) => violation.safetyDetails,
                                )
                                .toList(),
                            selectedItem: safetyViolationDetailsController
                                    .selectViolation.value.isNotEmpty
                                ? safetyViolationDetailsController
                                    .selectViolation.value
                                : null,
                            hintText: 'Select Type',

                            onChanged: (value) {
                              safetyViolationDetailsController
                                  .selectViolation.value = value ?? '';
                              var selectedType =
                                  safetyViolationDetailsController
                                      .violationTypeList
                                      .firstWhereOrNull((violation) =>
                                          violation.safetyDetails == value);

                              if (selectedType != null) {
                                safetyViolationDetailsController
                                    .selectViolationId.value = selectedType.id;
                                log(' Selected Violation: ${safetyViolationDetailsController.selectViolation.value}');
                                log(' Selected Violation ID: ${safetyViolationDetailsController.selectViolationId.value}');
                              } else {}
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.toString().trim().isEmpty) {
                                return 'Please select a type';
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
                              text: 'Category',
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
                            items: safetyViolationDetailsController.categoryList
                                .map(
                                  (category) => category.safetyDetails,
                                )
                                .toList(),
                            selectedItem: safetyViolationDetailsController
                                    .selectCategory.value.isNotEmpty
                                ? safetyViolationDetailsController
                                    .selectCategory.value
                                : null,
                            hintText: 'Select Category',
                            onChanged: (value) {
                              safetyViolationDetailsController
                                  .selectCategory.value = value ?? '';
                              var selectedCategory =
                                  safetyViolationDetailsController.categoryList
                                      .firstWhereOrNull((category) =>
                                          category.safetyDetails == value);

                              if (selectedCategory != null) {
                                safetyViolationDetailsController
                                    .selectCategoryId
                                    .value = selectedCategory.id;
                                log(' Selected selectCategory: ${safetyViolationDetailsController.selectCategory.value}');
                                log(' Selected selectCategoryId ID: ${safetyViolationDetailsController.selectCategoryId.value}');
                              } else {}
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.toString().trim().isEmpty) {
                                return 'Please select a Category';
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
                              text: 'Enter Details',
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
                          controller: safetyViolationDetailsController
                              .detailsController,
                          hintText: 'Enter Details',
                          focusNode:
                              safetyViolationDetailsController.detailsFocusNode,
                          onFieldSubmitted: (_) {
                            safetyViolationDetailsController.detailsFocusNode
                                .unfocus();
                          },
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Details cannot be empty';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                        ),

                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        //---------------------------

                        //------------------------------------------------------
                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Location of Breach',
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
                          controller: safetyViolationDetailsController
                              .loactionofBreachController,
                          hintText: 'Enter Loaction of Breach',
                          focusNode: safetyViolationDetailsController
                              .loactionofBreachFocusNode,
                          onFieldSubmitted: (_) {
                            safetyViolationDetailsController
                                .loactionofBreachFocusNode
                                .unfocus();
                          },
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Loaction of Breach cannot be empty';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                        ),

                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),

                        //------------------------------
                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Risk Level',
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
                            items:
                                safetyViolationDetailsController.riskLevelList
                                    .map(
                                      (risk) => risk.safetyDetails,
                                    )
                                    .toList(),
                            selectedItem: safetyViolationDetailsController
                                    .selectRisklevel.value.isNotEmpty
                                ? safetyViolationDetailsController
                                    .selectRisklevel.value
                                : null,
                            hintText: 'Select Risk Level',
                            onChanged: (value) {
                              safetyViolationDetailsController
                                  .selectRisklevel.value = value ?? '';
                              var selectedrisk =
                                  safetyViolationDetailsController.riskLevelList
                                      .firstWhereOrNull((risk) =>
                                          risk.safetyDetails == value);

                              if (selectedrisk != null) {
                                safetyViolationDetailsController
                                    .selectRisklevelId.value = selectedrisk.id;
                                log(' Selected selectRisklevel: ${safetyViolationDetailsController.selectRisklevel.value}');
                                log(' Selected selectRisklevelId ID: ${safetyViolationDetailsController.selectRisklevelId.value}');
                              } else {}
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.toString().trim().isEmpty) {
                                return 'Please select a  Risk Level';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ), //------------------------------

                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Turn Around Time',
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

                        GestureDetector(
                          onTap: () async {
                            DateTime selectedDate = DateTime.now();

                            // Date Picker
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              selectedDate = pickedDate;
                            }

                            // Time Picker
                            TimeOfDay pickedTime =
                                TimeOfDay.fromDateTime(selectedDate);
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: pickedTime,
                            );

                            if (time != null) {
                              // Combine date and time into a single DateTime object
                              final DateTime combinedDateTime = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                time.hour,
                                time.minute,
                              );

                              String formattedDateTime =
                                  DateFormat('yyyy-MM-dd HH:mm')
                                      .format(combinedDateTime);

                              safetyViolationDetailsController
                                  .turnArounttimeController
                                  .text = formattedDateTime;
                            }
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              readOnly: true,
                              controller: safetyViolationDetailsController
                                  .turnArounttimeController,
                              focusNode: safetyViolationDetailsController
                                  .turnArounttimeFocusNode,
                              onFieldSubmitted: (_) {
                                safetyViolationDetailsController
                                    .turnArounttimeFocusNode
                                    .unfocus();
                              },
                              style: GoogleFonts.inter(
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryText,
                              ),
                              keyboardType: TextInputType.none,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Select turn Around time',
                                hintStyle: GoogleFonts.inter(
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.searchfeild,
                                ),
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
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color:
                                        const Color.fromARGB(255, 126, 16, 9),
                                    width: 1,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color:
                                        const Color.fromARGB(255, 126, 16, 9),
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Turn Around Time cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Source of Observation',
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
                            items:
                                safetyViolationDetailsController.souceofObsList
                                    .map(
                                      (souce) => souce.safetyDetails,
                                    )
                                    .toList(),
                            selectedItem: safetyViolationDetailsController
                                    .selectObservation.value.isNotEmpty
                                ? safetyViolationDetailsController
                                    .selectObservation.value
                                : null,
                            hintText: 'Select Source of Observation',
                            onChanged: (value) {
                              safetyViolationDetailsController
                                  .selectObservation.value = value ?? '';
                              var selectObs = safetyViolationDetailsController
                                  .souceofObsList
                                  .firstWhereOrNull(
                                      (souce) => souce.safetyDetails == value);

                              if (selectObs != null) {
                                safetyViolationDetailsController
                                    .selectObservationId.value = selectObs.id;
                                log(' Selected selectObservation: ${safetyViolationDetailsController.selectObservation.value}');
                                log(' Selected selectObservationId ID: ${safetyViolationDetailsController.selectObservationId.value}');
                              } else {}
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.toString().trim().isEmpty) {
                                return 'Please select a Source of Observation';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),

                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Select Involved Persons',
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
                          () => selectInvolvedPersonController
                                  .selectedLabourIdsFinal.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: 'Selected Labour',
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryText,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ),
                        Obx(() => selectInvolvedPersonController
                                .selectedLabourIdsFinal.isNotEmpty
                            ? SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              )
                            : SizedBox()),
                        Obx(
                          () {
                            final selectedList =
                                selectInvolvedPersonController.addInvolvePerson;

                            return selectInvolvedPersonController
                                    .selectedLabourIdsFinal.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.7,
                                            color: AppColors.searchfeildcolor),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: selectInvolvedPersonController
                                                .selectedLabourIdsFinal.length >
                                            1
                                        ? SizeConfig.heightMultiplier * 24
                                        : SizeConfig.heightMultiplier * 11,
                                    child: Scrollbar(
                                      radius: Radius.circular(10),
                                      thickness: 4,
                                      child: ListView.builder(
                                        primary: false,
                                        controller:
                                            safetyViolationDetailsController
                                                .scrollLabourController,
                                        itemCount: selectedList.length,
                                        itemBuilder: (context, index) {
                                          final labour = selectedList[index];

                                          return ListTile(
                                            contentPadding: EdgeInsets.only(
                                                left: 0, right: 20),
                                            leading: CircleAvatar(
                                              radius: 22,
                                              backgroundImage: NetworkImage(
                                                  "$baseUrl${labour.userPhoto}"),
                                            ),
                                            title: AppTextWidget(
                                              text:
                                                  labour.labourName.toString(),
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryText,
                                            ),
                                            subtitle: AppTextWidget(
                                              text: labour.contactNumber
                                                  .toString(),
                                              fontSize:
                                                  AppTextSize.textSizeSmalle,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryText,
                                            ),
                                            trailing: GestureDetector(
                                              onTap: () {
                                                selectInvolvedPersonController
                                                    .removeData(index);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          },
                        ),
                        Obx(() => selectInvolvedPersonController
                                .selectedStaffIdsFinal.isNotEmpty
                            ? SizedBox(
                                height: SizeConfig.heightMultiplier * 4,
                              )
                            : SizedBox()),
                        Obx(
                          () => selectInvolvedPersonController
                                  .selectedStaffIdsFinal.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: 'Selected Staff',
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryText,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ),

                        Obx(() => selectInvolvedPersonController
                                .selectedStaffIdsFinal.isNotEmpty
                            ? SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              )
                            : SizedBox()),
                        Obx(
                          () {
                            final selectedList = selectInvolvedPersonController
                                .addInvolveStaffPerson;

                            return selectInvolvedPersonController
                                    .selectedStaffIdsFinal.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.7,
                                            color: AppColors.searchfeildcolor),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: selectInvolvedPersonController
                                                .selectedStaffIdsFinal.length >
                                            1
                                        ? SizeConfig.heightMultiplier * 24
                                        : SizeConfig.heightMultiplier * 11,
                                    child: Scrollbar(
                                      child: ListView.builder(
                                        controller:
                                            safetyViolationDetailsController
                                                .scrollStaffController,
                                        itemCount: selectedList.length,
                                        itemBuilder: (context, index) {
                                          final staff = selectedList[index];

                                          return ListTile(
                                            contentPadding: EdgeInsets.only(
                                                left: 0, right: 20),
                                            leading: CircleAvatar(
                                              radius: 22,
                                              backgroundImage: NetworkImage(
                                                  "$baseUrl${staff.userPhoto}"),
                                            ),
                                            title: AppTextWidget(
                                              text: staff.staffName.toString(),
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryText,
                                            ),
                                            subtitle: AppTextWidget(
                                              text: staff.contactNumber
                                                  .toString(),
                                              fontSize:
                                                  AppTextSize.textSizeSmalle,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryText,
                                            ),
                                            trailing: GestureDetector(
                                              onTap: () {
                                                selectInvolvedPersonController
                                                    .removeStaffData(index);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          },
                        ),
                        Obx(() => selectInvolvedPersonController
                                .selectedContractorIdsFinal.isNotEmpty
                            ? SizedBox(
                                height: SizeConfig.heightMultiplier * 4,
                              )
                            : SizedBox()),

                        //---------------------------------------------------------

                        Obx(
                          () => selectInvolvedPersonController
                                  .selectedContractorIdsFinal.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: 'Selected Contractor',
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryText,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ),

                        Obx(() => selectInvolvedPersonController
                                .selectedContractorIdsFinal.isNotEmpty
                            ? SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              )
                            : SizedBox()),
                        Obx(
                          () {
                            final selectedList = selectInvolvedPersonController
                                .addInvolveContractorPerson;

                            return selectInvolvedPersonController
                                    .selectedContractorIdsFinal.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.7,
                                            color: AppColors.searchfeildcolor),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: selectInvolvedPersonController
                                                .selectedContractorIdsFinal
                                                .length >
                                            1
                                        ? SizeConfig.heightMultiplier * 24
                                        : SizeConfig.heightMultiplier * 11,
                                    child: Scrollbar(
                                      child: ListView.builder(
                                        controller:
                                            safetyViolationDetailsController
                                                .scrollContractorController,
                                        itemCount: selectedList.length,
                                        itemBuilder: (context, index) {
                                          final contractor =
                                              selectedList[index];

                                          return ListTile(
                                            contentPadding: EdgeInsets.only(
                                                left: 0, right: 20),
                                            leading: CircleAvatar(
                                              radius: 22,
                                              backgroundImage: NetworkImage(
                                                  "$baseUrl${contractor.documentPath}"),
                                            ),
                                            title: AppTextWidget(
                                              text: contractor.contractorName
                                                  .toString(),
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryText,
                                            ),
                                            subtitle: AppTextWidget(
                                              text: contractor.contractorPhoneNo
                                                  .toString(),
                                              fontSize:
                                                  AppTextSize.textSizeSmalle,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryText,
                                            ),
                                            trailing: GestureDetector(
                                              onTap: () {
                                                selectInvolvedPersonController
                                                    .removeContractorData(
                                                        index);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          },
                        ),

                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Obx(() => selectInvolvedPersonController
                                    .selectedStaffIdsFinal.isEmpty &&
                                selectInvolvedPersonController
                                    .selectedContractorIdsFinal.isEmpty &&
                                selectInvolvedPersonController
                                    .selectedLabourIdsFinal.isEmpty
                            ? Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 5),
                                    child: Text(
                                      safetyViolationDetailsController
                                          .involvedError.value,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox()),
                        safetyViolationDetailsController
                                    .involvedSafetyLaboursList.isEmpty &&
                                safetyViolationDetailsController
                                    .involvedSafetyStaffList.isEmpty &&
                                safetyViolationDetailsController
                                    .involvedSafetycontactor.isEmpty
                            ? Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 5),
                                    child: Text(
                                      "Please add Labour, Staff, Contractor People for Project",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: AppColors.thirdText,
                                width: 0.8,
                              ),
                            ),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            Get.to(SelectInvolvedPerson());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 28,
                                color: AppColors.thirdText,
                                weight: 0.2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 1,
                              ),
                              AppTextWidget(
                                text: "Add Involved Persons",
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w400,
                                color: AppColors.thirdText,
                              ),
                            ],
                          ),
                        ),
                        //-----------------------------------

                        //--------------------------------

                        SizedBox(height: SizeConfig.heightMultiplier * 3),
                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Select Informed People',
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
                          () {
                            final selectedList =
                                selectSafetyInformedPeopleController
                                    .addInvolveAssigneePerson;

                            return selectSafetyInformedPeopleController
                                    .selectedAssigneeIdsFinal.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.7,
                                            color: AppColors.searchfeildcolor),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: selectSafetyInformedPeopleController
                                                .selectedAssigneeIdsFinal
                                                .length >
                                            1
                                        ? SizeConfig.heightMultiplier * 24
                                        : SizeConfig.heightMultiplier * 11,
                                    child: Scrollbar(
                                      child: ListView.builder(
                                        controller:
                                            safetyViolationDetailsController
                                                .scrollAssigneeInformedController,
                                        itemCount: selectedList.length,
                                        itemBuilder: (context, index) {
                                          final assgneeInformed =
                                              selectedList[index];

                                          return ListTile(
                                            contentPadding: EdgeInsets.only(
                                                left: 0, right: 20),
                                            leading: CircleAvatar(
                                              radius: 22,
                                              backgroundImage: NetworkImage(
                                                  "$baseUrl${assgneeInformed.profilePhoto}"),
                                            ),
                                            title: AppTextWidget(
                                              text: assgneeInformed.firstName
                                                  .toString(),
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryText,
                                            ),
                                            subtitle: AppTextWidget(
                                              text: assgneeInformed.designation
                                                  .toString(),
                                              fontSize:
                                                  AppTextSize.textSizeSmalle,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.secondaryText,
                                            ),
                                            trailing: GestureDetector(
                                              onTap: () {
                                                selectSafetyInformedPeopleController
                                                    .removeAssigneeInformedData(
                                                        index);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          },
                        ),

                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Obx(() => selectSafetyInformedPeopleController
                                .selectedAssigneeIdsFinal.isEmpty
                            ? Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 5),
                                    child: Text(
                                      safetyViolationDetailsController
                                          .informedError.value,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox()),

                        safetyViolationDetailsController.assigneeList.isEmpty
                            ? Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 5),
                                    child: Text(
                                      "Please add Informed people for Project",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: AppColors.thirdText,
                                width: 0.8,
                              ),
                            ),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            Get.to(SelectSafetyInformedPeople());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 28,
                                color: AppColors.thirdText,
                                weight: 0.2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 1,
                              ),
                              AppTextWidget(
                                text: "Add Informed People",
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w400,
                                color: AppColors.thirdText,
                              ),
                            ],
                          ),
                        ),

                        //-----------------------------------------------------------------
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        // Row(
                        //   children: [
                        //     AppTextWidget(
                        //       text: 'Select Assignee',
                        //       fontSize: AppTextSize.textSizeSmall,
                        //       fontWeight: FontWeight.w500,
                        //       color: AppColors.primaryText,
                        //     ),
                        //     AppTextWidget(
                        //         text: AppTexts.star,
                        //         fontSize: AppTextSize.textSizeExtraSmall,
                        //         fontWeight: FontWeight.w400,
                        //         color: AppColors.starcolor),
                        //   ],
                        // ),

                        // SizedBox(
                        //   height: SizeConfig.heightMultiplier * 2.5,
                        // ),

                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Select Assignee',
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
                          () {
                            final selectedList = selectSafetyAssigneeController
                                .addInvolveassigneeDataPerson;

                            return selectSafetyAssigneeController
                                    .selectedassigneeDataIdsFinal.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.7,
                                            color: AppColors.searchfeildcolor),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: SizeConfig.heightMultiplier * 10,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: selectedList.length,
                                      itemBuilder: (context, index) {
                                        final assgneeData = selectedList[index];

                                        return ListTile(
                                          contentPadding: EdgeInsets.only(
                                              left: 0, right: 20),
                                          leading: CircleAvatar(
                                            radius: 22,
                                            backgroundImage: NetworkImage(
                                                "$baseUrl${assgneeData.profilePhoto}"),
                                          ),
                                          title: AppTextWidget(
                                            text: assgneeData.firstName
                                                .toString(),
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryText,
                                          ),
                                          subtitle: AppTextWidget(
                                            text: assgneeData.designation
                                                .toString(),
                                            fontSize:
                                                AppTextSize.textSizeSmalle,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.secondaryText,
                                          ),
                                          trailing: GestureDetector(
                                            onTap: () {
                                              selectSafetyAssigneeController
                                                  .removeassigneeData(index);
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox();
                          },
                        ),

                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Obx(() => selectSafetyAssigneeController
                                .selectedassigneeDataIdsFinal.isEmpty
                            ? Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 5),
                                    child: Text(
                                      safetyViolationDetailsController
                                          .assigneeError.value,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox()),
                        safetyViolationDetailsController.assigneeList.isEmpty
                            ? Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 5),
                                    child: Text(
                                      "Please add Assignee for Project",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: AppColors.thirdText,
                                width: 0.8,
                              ),
                            ),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            Get.to(SelectSafetyAssignee());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 28,
                                color: AppColors.thirdText,
                                weight: 0.2,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 1,
                              ),
                              AppTextWidget(
                                text: "Select Assignee",
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w400,
                                color: AppColors.thirdText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 5,
                    ),

                    SizedBox(height: SizeConfig.heightMultiplier * 5),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: AppElevatedButton(
              text: 'Next',
              onPressed: () {
                if (safetyViolationDetailsController.violationimg.isEmpty) {
                  safetyViolationDetailsController.photoError.value =
                      "Please insert Images.";
                }

                if (selectSafetyInformedPeopleController
                    .selectedAssigneeIdsFinal.isEmpty) {
                  safetyViolationDetailsController.informedError.value =
                      "Please Select Informed People.";
                }

                if (selectInvolvedPersonController
                        .selectedStaffIdsFinal.isEmpty &&
                    selectInvolvedPersonController
                        .selectedContractorIdsFinal.isEmpty &&
                    selectInvolvedPersonController
                        .selectedLabourIdsFinal.isEmpty) {
                  safetyViolationDetailsController.involvedError.value =
                      "Please Select Involved People.";
                }

                if (selectSafetyAssigneeController
                    .selectedassigneeDataIdsFinal.isEmpty) {
                  safetyViolationDetailsController.assigneeError.value =
                      "Please Select Assignee People.";
                }
                if (formKey.currentState!.validate() &&
                    safetyViolationDetailsController.violationimg.isNotEmpty &&
                    selectSafetyInformedPeopleController
                        .selectedAssigneeIdsFinal.isNotEmpty &&
                    selectSafetyAssigneeController
                        .selectedassigneeDataIdsFinal.isNotEmpty &&
                    (selectInvolvedPersonController
                            .selectedStaffIdsFinal.isNotEmpty ||
                        selectInvolvedPersonController
                            .selectedContractorIdsFinal.isNotEmpty ||
                        selectInvolvedPersonController
                            .selectedLabourIdsFinal.isNotEmpty)) {
                  locationController.fetchLocation();
                  Get.to(SafetyAttestaionScreen(
                    userId: userId,
                    userName: userName,
                    userImg: userImg,
                    userDesg: userDesg,
                    projectId: projectId,
                  ));
                  safetyViolationDetailsController.photoError.value = "";
                  safetyViolationDetailsController.informedError.value = "";
                  safetyViolationDetailsController.involvedError.value = "";
                  safetyViolationDetailsController.assigneeError.value = "";
                }
              }),
        ),
      ),
    );
  }
}
