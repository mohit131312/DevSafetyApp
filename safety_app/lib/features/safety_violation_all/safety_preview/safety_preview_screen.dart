import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/safety_violation_all/safety_preview/safety_preview_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_submit/safety_submit_screeen.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/sefety_violation_screen.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_assignee/select_safety_assignee_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_informed_people/select_safety_informed_people_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_involved_person/select_involved_person_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class SafetyPreviewScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  SafetyPreviewScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final SelectSafetyAssigneeController selectSafetyAssigneeController =
      Get.find();

  final SafetyViolationDetailsController safetyViolationDetailsController =
      Get.find();

  final SelectInvolvedPersonController selectInvolvedPersonController =
      Get.find();
  final SelectSafetyInformedPeopleController
      selectSafetyInformedPeopleController = Get.find();

  final SafetyPreviewController safetyPreviewController =
      Get.put(SafetyPreviewController());

  void showConfirmationDialogViolation(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          title: AppTextWidget(
            text: 'Are You Sure?',
            fontSize: AppTextSize.textSizeMediumm,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          content: AppTextWidget(
              text: 'Are you sure you want to submit labour\'s details?',
              fontSize: AppTextSize.textSizeSmall,
              fontWeight: FontWeight.w500,
              color: AppColors.searchfeild),
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppTextWidget(
                        text: 'No',
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await safetyPreviewController.safetySaveSafetyViolation(
                        context, userName, userId, projectId);
                    if (safetyPreviewController.validationmsg ==
                        'Data saved successfully.') {
                      Get.to(() => SafetySubmitScreeen(
                          userId: userId,
                          userName: userName,
                          userImg: userImg,
                          userDesg: userDesg,
                          projectId: projectId));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.buttoncolor,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppTextWidget(
                        text: 'Yes',
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //  resizeToAvoidBottomInset: false,
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
                text: AppTexts.preview,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: AppTexts.previewsubmit,
                    fontSize: AppTextSize.textSizeMediumm,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.3,
                  ),
                  AppTextWidget(
                    text: AppTexts.checkdetailssubmit,
                    fontSize: AppTextSize.textSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.5,
                  ),
                ],
              ),
            ),

            //---------------------------------------------------------------------

            //-----------------------------------------------------------------
            Obx(() => safetyPreviewController.issafetyDetailsExpanded.value
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4,
                      vertical: SizeConfig.heightMultiplier * 2,
                    ),
                    width: SizeConfig.widthMultiplier * 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFFEFEFE),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x10000000),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                      'assets/icons/User_orange.png')),
                              SizedBox(
                                width: 5,
                              ),
                              AppTextWidget(
                                text: 'General Details',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttoncolor,
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    safetyPreviewController
                                        .toggleExpansionSafety();
                                  },
                                  child: Icon(Icons.keyboard_arrow_up)),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 4,
                              vertical: SizeConfig.heightMultiplier * 3,
                            ),
                            width: SizeConfig.widthMultiplier * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.appgreycolor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                        text: 'Violation Type',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.searchfeild),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1,
                                    ),
                                    Obx(() {
                                      return safetyViolationDetailsController
                                              .selectViolation.isNotEmpty
                                          ? AppTextWidget(
                                              text:
                                                  safetyViolationDetailsController
                                                      .selectViolation.value,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText)
                                          : AppTextWidget(
                                              text: "",
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red,
                                            );
                                    }),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1.5,
                                    ),
                                    AppTextWidget(
                                        text: 'Category',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.searchfeild),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1,
                                    ),
                                    Obx(() {
                                      return safetyViolationDetailsController
                                              .selectCategory.isNotEmpty
                                          ? AppTextWidget(
                                              text:
                                                  safetyViolationDetailsController
                                                      .selectCategory.value,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText)
                                          : AppTextWidget(
                                              text: "",
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red,
                                            );
                                    }),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1.5,
                                    ),
                                    AppTextWidget(
                                        text: 'Location of Breach',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.searchfeild),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1,
                                    ),
                                    safetyViolationDetailsController
                                            .loactionofBreachController
                                            .text
                                            .isNotEmpty
                                        ? AppTextWidget(
                                            text:
                                                safetyViolationDetailsController
                                                    .loactionofBreachController
                                                    .text,
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText)
                                        : AppTextWidget(
                                            text: "",
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red,
                                          ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1.5,
                                    ),
                                    AppTextWidget(
                                        text: 'Risk Level',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.searchfeild),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1,
                                    ),
                                    Obx(() {
                                      return safetyViolationDetailsController
                                              .selectRisklevel.isNotEmpty
                                          ? AppTextWidget(
                                              text:
                                                  safetyViolationDetailsController
                                                      .selectRisklevel.value,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText)
                                          : AppTextWidget(
                                              text: "",
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red,
                                            );
                                    }),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1.5,
                                    ),
                                    AppTextWidget(
                                        text: 'Turn Around Time',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.searchfeild),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1,
                                    ),
                                    safetyViolationDetailsController
                                            .turnArounttimeController
                                            .text
                                            .isNotEmpty
                                        ? AppTextWidget(
                                            text:
                                                safetyViolationDetailsController
                                                    .turnArounttimeController
                                                    .text,
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText)
                                        : AppTextWidget(
                                            text: "",
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red,
                                          ),
                                    AppTextWidget(
                                        text: 'Source of Observation',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.searchfeild),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1,
                                    ),
                                    Obx(() {
                                      return safetyViolationDetailsController
                                              .selectObservation.isNotEmpty
                                          ? AppTextWidget(
                                              text:
                                                  safetyViolationDetailsController
                                                      .selectObservation.value,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText)
                                          : AppTextWidget(
                                              text: "",
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red,
                                            );
                                    }),
                                    AppTextWidget(
                                        text: 'Photos',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.searchfeild),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1.5,
                                    ),
                                    Obx(
                                      () =>
                                          safetyViolationDetailsController
                                                      .violationImageCount <
                                                  1
                                              ? SizedBox()
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start, // Ensure items align properly

                                                      children: [
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: GridView
                                                                .builder(
                                                                    physics:
                                                                        NeverScrollableScrollPhysics(),
                                                                    itemCount: safetyViolationDetailsController
                                                                        .violationimg
                                                                        .length,
                                                                    gridDelegate:
                                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          4, // Ensures one row (horizontal scroll)

                                                                      childAspectRatio:
                                                                          1, // Keeps items square
                                                                      mainAxisSpacing:
                                                                          12,
                                                                      crossAxisSpacing:
                                                                          12, // Spacing between images
                                                                    ),
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Stack(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                SizeConfig.imageSizeMultiplier * 20,
                                                                            width:
                                                                                SizeConfig.imageSizeMultiplier * 20,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(12), // Clip image to match container

                                                                              child: Image.file(
                                                                                File(safetyViolationDetailsController.violationimg[index].path),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4,
                      vertical: SizeConfig.heightMultiplier * 2,
                    ),
                    width: SizeConfig.widthMultiplier * 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFFEFEFE),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x10000000),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                    'assets/icons/User_orange.png')),
                            SizedBox(
                              width: 5,
                            ),
                            AppTextWidget(
                              text: 'General Details',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.buttoncolor,
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  safetyPreviewController
                                      .toggleExpansionSafety();
                                },
                                child: Icon(Icons.keyboard_arrow_up)),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                      ],
                    ),
                  )),
            //------------------------------------------------------------------
            Obx(
              () => safetyPreviewController.isinvolvepeople.value
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 2,
                      ),
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFEFEFE),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(
                                        'assets/icons/precaution.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: 'Involved People',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      safetyPreviewController
                                          .toggleInvolvedExpansionpeople();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4,
                                vertical: SizeConfig.heightMultiplier * 3,
                              ),
                              width: SizeConfig.widthMultiplier * 100,
                              decoration: (selectInvolvedPersonController
                                          .selectedLabourIdsFinal.isNotEmpty ||
                                      selectInvolvedPersonController
                                          .selectedStaffIdsFinal.isNotEmpty ||
                                      selectInvolvedPersonController
                                          .selectedContractorIdsFinal
                                          .isNotEmpty)
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.appgreycolor,
                                    )
                                  : BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 1,
                                  ),
                                  Obx(
                                    () => selectInvolvedPersonController
                                            .selectedLabourIdsFinal.isNotEmpty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              AppTextWidget(
                                                text: 'Select Labour',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
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
                                          height:
                                              SizeConfig.heightMultiplier * 1,
                                        )
                                      : SizedBox()),
                                  Obx(
                                    () {
                                      final selectedList =
                                          selectInvolvedPersonController
                                              .addInvolvePerson;

                                      return selectInvolvedPersonController
                                              .selectedLabourIdsFinal.isNotEmpty
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8, top: 8),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.7,
                                                      color: AppColors
                                                          .searchfeildcolor),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              height: selectInvolvedPersonController
                                                          .selectedLabourIdsFinal
                                                          .length >
                                                      1
                                                  ? SizeConfig
                                                          .heightMultiplier *
                                                      24
                                                  : SizeConfig
                                                          .heightMultiplier *
                                                      11,
                                              child: Scrollbar(
                                                radius: Radius.circular(10),
                                                thickness: 4,
                                                child: ListView.builder(
                                                  primary: false,
                                                  controller:
                                                      safetyViolationDetailsController
                                                          .scrollLabourController,
                                                  itemCount:
                                                      selectedList.isNotEmpty
                                                          ? selectedList.length
                                                          : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final labour =
                                                        selectedList[index];

                                                    return ListTile(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 0,
                                                              right: 20),
                                                      leading: CircleAvatar(
                                                        radius: 22,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "$baseUrl${labour.userPhoto}"),
                                                      ),
                                                      title: AppTextWidget(
                                                        text: labour.labourName
                                                            .toString(),
                                                        fontSize: AppTextSize
                                                            .textSizeSmall,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .primaryText,
                                                      ),
                                                      subtitle: AppTextWidget(
                                                        text: labour
                                                            .contactNumber
                                                            .toString(),
                                                        fontSize: AppTextSize
                                                            .textSizeSmalle,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .secondaryText,
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
                                          height:
                                              SizeConfig.heightMultiplier * 4,
                                        )
                                      : SizedBox()),
                                  Obx(
                                    () => selectInvolvedPersonController
                                            .selectedStaffIdsFinal.isNotEmpty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              AppTextWidget(
                                                text: 'Select Staff',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
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
                                          height:
                                              SizeConfig.heightMultiplier * 1,
                                        )
                                      : SizedBox()),
                                  Obx(
                                    () {
                                      final selectedList =
                                          selectInvolvedPersonController
                                              .addInvolveStaffPerson;

                                      return selectInvolvedPersonController
                                              .selectedStaffIdsFinal.isNotEmpty
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8, top: 8),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.7,
                                                      color: AppColors
                                                          .searchfeildcolor),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              height: selectInvolvedPersonController
                                                          .selectedStaffIdsFinal
                                                          .length >
                                                      1
                                                  ? SizeConfig
                                                          .heightMultiplier *
                                                      24
                                                  : SizeConfig
                                                          .heightMultiplier *
                                                      11,
                                              child: Scrollbar(
                                                child: ListView.builder(
                                                  controller:
                                                      safetyViolationDetailsController
                                                          .scrollStaffController,
                                                  itemCount:
                                                      selectedList.isNotEmpty
                                                          ? selectedList.length
                                                          : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final staff =
                                                        selectedList[index];

                                                    return ListTile(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 0,
                                                              right: 20),
                                                      leading: CircleAvatar(
                                                        radius: 22,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "$baseUrl${staff.userPhoto}"),
                                                      ),
                                                      title: AppTextWidget(
                                                        text: staff.staffName
                                                            .toString(),
                                                        fontSize: AppTextSize
                                                            .textSizeSmall,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .primaryText,
                                                      ),
                                                      subtitle: AppTextWidget(
                                                        text: staff
                                                            .contactNumber
                                                            .toString(),
                                                        fontSize: AppTextSize
                                                            .textSizeSmalle,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .secondaryText,
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
                                          height:
                                              SizeConfig.heightMultiplier * 4,
                                        )
                                      : SizedBox()),

                                  //---------------------------------------------------------

                                  Obx(
                                    () => selectInvolvedPersonController
                                            .selectedContractorIdsFinal
                                            .isNotEmpty
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              AppTextWidget(
                                                text: 'Select Contractor',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
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
                                          height:
                                              SizeConfig.heightMultiplier * 1,
                                        )
                                      : SizedBox()),
                                  Obx(
                                    () {
                                      final selectedList =
                                          selectInvolvedPersonController
                                              .addInvolveContractorPerson;

                                      return selectInvolvedPersonController
                                              .selectedContractorIdsFinal
                                              .isNotEmpty
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8, top: 8),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.7,
                                                      color: AppColors
                                                          .searchfeildcolor),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              height: selectInvolvedPersonController
                                                          .selectedContractorIdsFinal
                                                          .length >
                                                      1
                                                  ? SizeConfig
                                                          .heightMultiplier *
                                                      24
                                                  : SizeConfig
                                                          .heightMultiplier *
                                                      11,
                                              child: Scrollbar(
                                                child: ListView.builder(
                                                  controller:
                                                      safetyViolationDetailsController
                                                          .scrollContractorController,
                                                  itemCount:
                                                      selectedList.isNotEmpty
                                                          ? selectedList.length
                                                          : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final contractor =
                                                        selectedList[index];

                                                    return ListTile(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 0,
                                                              right: 20),
                                                      leading: CircleAvatar(
                                                        radius: 22,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "$baseUrl${contractor.documentPath}"),
                                                      ),
                                                      title: AppTextWidget(
                                                        text: contractor
                                                            .contractorName
                                                            .toString(),
                                                        fontSize: AppTextSize
                                                            .textSizeSmall,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .primaryText,
                                                      ),
                                                      subtitle: AppTextWidget(
                                                        text: contractor
                                                                .contractorPhoneNo!
                                                                .isNotEmpty
                                                            ? contractor
                                                                .contractorPhoneNo
                                                                .toString()
                                                            : '',
                                                        fontSize: AppTextSize
                                                            .textSizeSmalle,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .secondaryText,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          : SizedBox();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 2,
                      ),
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFEFEFE),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                      'assets/icons/precaution.png')),
                              SizedBox(
                                width: 5,
                              ),
                              AppTextWidget(
                                text: 'Involved People',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttoncolor,
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    safetyPreviewController
                                        .toggleInvolvedExpansionpeople();
                                  },
                                  child: Icon(Icons.keyboard_arrow_up)),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                        ],
                      ),
                    ),
            ),
//--------------------------------------------select informed people

            Obx(
              () => safetyPreviewController.isinformedpeople.value
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 2,
                      ),
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFEFEFE),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(
                                        'assets/icons/precaution.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: 'Informed People',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      safetyPreviewController
                                          .toggleExpansionisinformedpeople();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4,
                                vertical: SizeConfig.heightMultiplier * 3,
                              ),
                              width: SizeConfig.widthMultiplier * 100,
                              decoration: selectSafetyInformedPeopleController
                                      .selectedAssigneeIdsFinal.isNotEmpty
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.appgreycolor,
                                    )
                                  : BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 1,
                                  ),
                                  Obx(
                                    () {
                                      final selectedList =
                                          selectSafetyInformedPeopleController
                                              .addInvolveAssigneePerson;

                                      return selectSafetyInformedPeopleController
                                              .selectedAssigneeIdsFinal
                                              .isNotEmpty
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8, top: 8),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.7,
                                                      color: AppColors
                                                          .searchfeildcolor),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              height: selectSafetyInformedPeopleController
                                                          .selectedAssigneeIdsFinal
                                                          .length >
                                                      1
                                                  ? SizeConfig
                                                          .heightMultiplier *
                                                      24
                                                  : SizeConfig
                                                          .heightMultiplier *
                                                      11,
                                              child: Scrollbar(
                                                child: ListView.builder(
                                                  controller:
                                                      safetyViolationDetailsController
                                                          .scrollAssigneeInformedController,
                                                  itemCount:
                                                      selectedList.isNotEmpty
                                                          ? selectedList.length
                                                          : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final assgneeInformed =
                                                        selectedList[index];

                                                    return ListTile(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 0,
                                                              right: 20),
                                                      leading: CircleAvatar(
                                                        radius: 22,
                                                        backgroundImage: assgneeInformed
                                                                        .profilePhoto !=
                                                                    null &&
                                                                assgneeInformed
                                                                    .profilePhoto!
                                                                    .isNotEmpty
                                                            ? NetworkImage(
                                                                "$baseUrl${assgneeInformed.profilePhoto}")
                                                            : AssetImage("")
                                                                as ImageProvider,
                                                      ),
                                                      title: AppTextWidget(
                                                        text: assgneeInformed
                                                            .firstName
                                                            .toString(),
                                                        fontSize: AppTextSize
                                                            .textSizeSmall,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .primaryText,
                                                      ),
                                                      subtitle: AppTextWidget(
                                                        text: assgneeInformed
                                                            .designation
                                                            .toString(),
                                                        fontSize: AppTextSize
                                                            .textSizeSmalle,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .secondaryText,
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
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                          ]),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 2,
                      ),
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFEFEFE),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                      'assets/icons/precaution.png')),
                              SizedBox(
                                width: 5,
                              ),
                              AppTextWidget(
                                text: 'Informed People',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttoncolor,
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    safetyPreviewController
                                        .toggleExpansionisinformedpeople();
                                  },
                                  child: Icon(Icons.keyboard_arrow_up)),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                        ],
                      ),
                    ),
            ),

//---------------------------------
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 3,
              ),
              width: SizeConfig.widthMultiplier * 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                      text: 'Assignee',
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Row(
                    children: [
                      Container(
                        width: SizeConfig.imageSizeMultiplier * 15,
                        height: SizeConfig.imageSizeMultiplier * 15,
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage: selectSafetyAssigneeController
                                  .addInvolveassigneeDataPerson.isNotEmpty
                              ? NetworkImage(
                                  "$baseUrl${selectSafetyAssigneeController.addInvolveassigneeDataPerson[0].profilePhoto}")
                              : AssetImage("assets/images/default_avatar.png")
                                  as ImageProvider,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                              text: selectSafetyAssigneeController
                                      .addInvolveassigneeDataPerson.isNotEmpty
                                  ? selectSafetyAssigneeController
                                      .addInvolveassigneeDataPerson[0].firstName
                                  : "",
                              fontSize: AppTextSize.textSizeSmallm,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText),
                          AppTextWidget(
                              text: selectSafetyAssigneeController
                                      .addInvolveassigneeDataPerson.isNotEmpty
                                  ? selectSafetyAssigneeController
                                      .addInvolveassigneeDataPerson[0]
                                      .designation
                                      .toString()
                                  : "",
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.searchfeild),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  AppTextWidget(
                      text: 'Assignor',
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Row(
                    children: [
                      Container(
                        width: SizeConfig.imageSizeMultiplier * 15,
                        height: SizeConfig.imageSizeMultiplier * 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: userImg.isNotEmpty
                                ? NetworkImage("$baseUrl${userImg}")
                                : AssetImage("assets/images/default_avatar.png")
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                              text: userName,
                              fontSize: AppTextSize.textSizeSmallm,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText),
                          AppTextWidget(
                              text: userDesg,
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.searchfeild),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  AppTextWidget(
                      text: 'Created On',
                      fontSize: AppTextSize.textSizeSmalle,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  AppTextWidget(
                      text: '06 Oct 2024 11:14 AM',
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  AppTextWidget(
                      text: 'Geolocation',
                      fontSize: AppTextSize.textSizeSmalle,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  AppTextWidget(
                      text:
                          'Sade Satra Nali, Pune, Hadapsar, 411028, Maharashtra, Pune',
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offUntil(
                          GetPageRoute(
                              page: () => SafetyViolationDetails(
                                    userImg: userImg,
                                    userId: userId,
                                    userName: userName,
                                    userDesg: userDesg,
                                    projectId: projectId,
                                  )),
                          (route) {
                            if (route is GetPageRoute) {
                              return route.page!().runtimeType ==
                                  SefetyViolationScreen;
                            }
                            return false;
                          },
                        );
                      },
                      child: AppMediumButton(
                        label: "Edit",
                        borderColor: AppColors.buttoncolor,
                        iconColor: AppColors.buttoncolor,
                        backgroundColor: Colors.white,
                        textColor: AppColors.buttoncolor,
                        imagePath: 'assets/icons/edit.png',
                      ),
                    ),
                    SizedBox(width: SizeConfig.widthMultiplier * 5),
                    GestureDetector(
                      onTap: () {
                        showConfirmationDialogViolation(
                          context,
                        );
                      },
                      child: AppMediumButton(
                        label: "Submit",
                        borderColor: AppColors.backbuttoncolor,
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        backgroundColor: AppColors.buttoncolor,
                        imagePath2: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 6,
            ),
          ],
        ),
      ),
    );
  }
}
