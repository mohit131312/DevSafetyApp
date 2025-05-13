import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_submit/safety_resolved_screen.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_assignee/safety_violation_details_assignee_cont.dart';

import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class SafetyViolationDetailsAssignee extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int safetyId;
  final String uniqueId;
  SafetyViolationDetailsAssignee(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userImg,
      required this.userDesg,
      required this.projectId,
      required this.safetyId,
      required this.uniqueId});

  final SafetyViolationDetailsAssigneeCont safetyViolationDetailsAssigneeCont =
      Get.put(SafetyViolationDetailsAssigneeCont());
  final LocationController locationController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void showConfirmationDialogClosed(BuildContext context) {
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
              text: 'Are you sure you want to Resolve Safety violation?',
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
                    var assigneeId = safetyViolationDetailsAssigneeCont
                        .violationDebitNote[0].assigneeId;
                    await safetyViolationDetailsAssigneeCont
                        .safetyViolationSaveAssigneeComment(
                            context, safetyId, assigneeId, 1);
                    if (safetyViolationDetailsAssigneeCont.apiStatus == true) {
                      Get.to(SafetyResolvedScreen(
                          userId: userId,
                          projectId: projectId,
                          safetyId: safetyId,
                          uniqueId: uniqueId));
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
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        //  resizeToAvoidBottomInset: false,
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
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                Obx(() => safetyViolationDetailsAssigneeCont
                        .isincidentdetailsDetailsExpanded.value
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
                                        safetyViolationDetailsAssigneeCont
                                            .toggleExpansionIncedenet();
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              SizeConfig.widthMultiplier * 40,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              AppTextWidget(
                                                  text: 'Violation Type',
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.searchfeild),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1,
                                              ),
                                              AppTextWidget(
                                                text: safetyViolationDetailsAssigneeCont
                                                            .violationType[0]
                                                            .safetyDetails !=
                                                        null
                                                    ? safetyViolationDetailsAssigneeCont
                                                        .violationType[0]
                                                        .safetyDetails
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1.5,
                                              ),
                                              AppTextWidget(
                                                  text: 'Category',
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.searchfeild),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1,
                                              ),
                                              AppTextWidget(
                                                text: safetyViolationDetailsAssigneeCont
                                                            .category[0]
                                                            .safetyDetails !=
                                                        null
                                                    ? safetyViolationDetailsAssigneeCont
                                                        .category[0]
                                                        .safetyDetails
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1.5,
                                              ),
                                              AppTextWidget(
                                                  text: 'Location of breach',
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.searchfeild),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1,
                                              ),
                                              AppTextWidget(
                                                text: safetyViolationDetailsAssigneeCont
                                                            .violationDebitNote[
                                                                0]
                                                            .locationOfBreach !=
                                                        null
                                                    ? safetyViolationDetailsAssigneeCont
                                                        .violationDebitNote[0]
                                                        .locationOfBreach
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1.5,
                                              ),
                                              AppTextWidget(
                                                  text: 'Risk Level',
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.searchfeild),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1,
                                              ),
                                              AppTextWidget(
                                                  text: safetyViolationDetailsAssigneeCont
                                                              .riskLevel[0]
                                                              .safetyDetails !=
                                                          null
                                                      ? safetyViolationDetailsAssigneeCont
                                                          .riskLevel[0]
                                                          .safetyDetails
                                                          .toString()
                                                      : "",
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primaryText),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    2.5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier * 2,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.widthMultiplier * 40,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              AppTextWidget(
                                                  text: 'Turn Around Time',
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.searchfeild),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1,
                                              ),
                                              AppTextWidget(
                                                text: safetyViolationDetailsAssigneeCont
                                                            .violationDebitNote[0]
                                                            // ignore: unnecessary_null_comparison
                                                            .turnAroundTime !=
                                                        null
                                                    ? safetyViolationDetailsAssigneeCont
                                                        .violationDebitNote[0]
                                                        // ignore: unnecessary_null_comparison
                                                        .turnAroundTime
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1.2,
                                              ),
                                              AppTextWidget(
                                                  text: 'Source of Observation',
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.searchfeild),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1,
                                              ),
                                              AppTextWidget(
                                                text: safetyViolationDetailsAssigneeCont
                                                            .sourceOfObservation[
                                                                0]
                                                            .safetyDetails !=
                                                        null
                                                    ? safetyViolationDetailsAssigneeCont
                                                        .sourceOfObservation[0]
                                                        .safetyDetails
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    1.5,
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    2.5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    AppTextWidget(
                                        text: 'Photos',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.searchfeild),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1.5,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                        safetyViolationDetailsAssigneeCont
                                                            .photos.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          4, // Ensures one row (horizontal scroll)

                                                      childAspectRatio:
                                                          1, // Keeps items square
                                                      mainAxisSpacing: 12,
                                                      crossAxisSpacing:
                                                          12, // Spacing between images
                                                    ),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Stack(
                                                        children: [
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .imageSizeMultiplier *
                                                                20,
                                                            width: SizeConfig
                                                                    .imageSizeMultiplier *
                                                                20,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12), // Clip image to match container

                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  if (safetyViolationDetailsAssigneeCont
                                                                      .photos
                                                                      .isNotEmpty) {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Dialog(
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          child:
                                                                              InteractiveViewer(
                                                                            panEnabled:
                                                                                true,
                                                                            minScale:
                                                                                0.5,
                                                                            maxScale:
                                                                                3.0,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              child: Image.network(
                                                                                "$baseUrl${safetyViolationDetailsAssigneeCont.photos[index].photoPath.toString()}",
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                },
                                                                child: SizedBox(
                                                                  height: SizeConfig
                                                                          .imageSizeMultiplier *
                                                                      16,
                                                                  width: SizeConfig
                                                                          .imageSizeMultiplier *
                                                                      16,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child: (safetyViolationDetailsAssigneeCont
                                                                            .photos[
                                                                                index]
                                                                            .photoPath!
                                                                            .isNotEmpty
                                                                        // ignore: unnecessary_null_comparison
                                                                        )
                                                                        ? Image
                                                                            .network(
                                                                            "$baseUrl${safetyViolationDetailsAssigneeCont.photos[index].photoPath.toString()}",
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          )
                                                                        : Image.asset(
                                                                            ""),
                                                                  ),
                                                                ),
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
                                      safetyViolationDetailsAssigneeCont
                                          .toggleExpansionIncedenet();
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
                  () => safetyViolationDetailsAssigneeCont.isinvolvepeople.value
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
                                          safetyViolationDetailsAssigneeCont
                                              .toggleExpansionpeople();
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
                                  decoration:
                                      (safetyViolationDetailsAssigneeCont
                                                  .involvedLaboursList
                                                  .isNotEmpty ||
                                              safetyViolationDetailsAssigneeCont
                                                  .involvedStaffList
                                                  .isNotEmpty ||
                                              safetyViolationDetailsAssigneeCont
                                                  .involvedContractorUserList
                                                  .isNotEmpty)
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: AppColors.appgreycolor,
                                            )
                                          : BoxDecoration(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier * 1,
                                      ),
                                      safetyViolationDetailsAssigneeCont
                                              .involvedLaboursList.isNotEmpty
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                AppTextWidget(
                                                  text: 'Labour',
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.primaryText,
                                                ),
                                              ],
                                            )
                                          : SizedBox(),

                                      safetyViolationDetailsAssigneeCont
                                              .involvedLaboursList.isNotEmpty
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            )
                                          : SizedBox(),

                                      safetyViolationDetailsAssigneeCont
                                              .involvedLaboursList.isNotEmpty
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
                                              height: safetyViolationDetailsAssigneeCont
                                                          .involvedLaboursList
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
                                                      safetyViolationDetailsAssigneeCont
                                                          .scrollLabourController,
                                                  itemCount: safetyViolationDetailsAssigneeCont
                                                          .involvedLaboursList
                                                          .isNotEmpty
                                                      ? safetyViolationDetailsAssigneeCont
                                                          .involvedLaboursList
                                                          .length
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final labour =
                                                        safetyViolationDetailsAssigneeCont
                                                                .involvedLaboursList[
                                                            index];

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
                                          : SizedBox(),

                                      safetyViolationDetailsAssigneeCont
                                              .involvedLaboursList.isNotEmpty
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      4,
                                            )
                                          : SizedBox(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                            text: 'Staff',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                        ],
                                      ),

                                      safetyViolationDetailsAssigneeCont
                                              .involvedLaboursList.isNotEmpty
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            )
                                          : SizedBox(),

                                      safetyViolationDetailsAssigneeCont
                                              .involvedStaffList.isNotEmpty
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8, top: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.7,
                                                    color: AppColors
                                                        .searchfeildcolor),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              height:
                                                  safetyViolationDetailsAssigneeCont
                                                              .involvedStaffList
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
                                                      safetyViolationDetailsAssigneeCont
                                                          .scrollStaffController,
                                                  itemCount:
                                                      safetyViolationDetailsAssigneeCont
                                                          .involvedStaffList
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final entry =
                                                        safetyViolationDetailsAssigneeCont
                                                            .involvedStaffList
                                                            .entries
                                                            .elementAt(index);
                                                    final staff = entry.value;

                                                    return ListTile(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 0,
                                                              right: 20),
                                                      leading: CircleAvatar(
                                                        radius: 22,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "$baseUrl${staff.userPhoto ?? ''}",
                                                        ),
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
                                                                .contactNumber ??
                                                            'No Contact',
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
                                          : SizedBox(),

                                      safetyViolationDetailsAssigneeCont
                                                  .involvedContractorUserList
                                                  .isNotEmpty ||
                                              safetyViolationDetailsAssigneeCont
                                                      // ignore: unnecessary_null_comparison
                                                      .involvedContractorUserList !=
                                                  null
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            )
                                          : SizedBox(),

                                      //---------------------------------------------------------
                                      SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                            text: 'Contractor',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                        ],
                                      ),

                                      safetyViolationDetailsAssigneeCont
                                              .involvedContractorUserList
                                              .isNotEmpty
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        1),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 8,
                                                      right: 8,
                                                      top: 8),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 0.7,
                                                        color: AppColors
                                                            .searchfeildcolor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  height: safetyViolationDetailsAssigneeCont
                                                              .involvedContractorUserList
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
                                                          safetyViolationDetailsAssigneeCont
                                                              .scrollContractorController,
                                                      itemCount:
                                                          safetyViolationDetailsAssigneeCont
                                                              .involvedContractorUserList
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final entry =
                                                            safetyViolationDetailsAssigneeCont
                                                                .involvedContractorUserList
                                                                .entries
                                                                .elementAt(
                                                                    index);
                                                        final contractor =
                                                            entry.value;

                                                        return ListTile(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 0,
                                                                  right: 20),
                                                          leading: CircleAvatar(
                                                            radius: 22,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              "$baseUrl${contractor.documentPath}",
                                                            ),
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
                                                          subtitle:
                                                              AppTextWidget(
                                                            text: contractor
                                                                        .contractorPhoneNo
                                                                        ?.isNotEmpty ??
                                                                    false
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
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
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
                                        safetyViolationDetailsAssigneeCont
                                            .toggleExpansionpeople();
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
                  () => safetyViolationDetailsAssigneeCont
                          .isinformedpeople.value
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
                                          safetyViolationDetailsAssigneeCont
                                              .toggleInformedExpansionpeople();
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
                                  decoration: safetyViolationDetailsAssigneeCont
                                          .informedPersonsList.isNotEmpty
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: AppColors.appgreycolor,
                                        )
                                      : BoxDecoration(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier * 1,
                                      ),
                                      safetyViolationDetailsAssigneeCont
                                              .informedPersonsList.isNotEmpty
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
                                              height: safetyViolationDetailsAssigneeCont
                                                          .informedPersonsList
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
                                                      safetyViolationDetailsAssigneeCont
                                                          .scrolldataController,
                                                  itemCount: safetyViolationDetailsAssigneeCont
                                                          .informedPersonsList
                                                          .isNotEmpty
                                                      ? safetyViolationDetailsAssigneeCont
                                                          .informedPersonsList
                                                          .length
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final assgneeInformed =
                                                        safetyViolationDetailsAssigneeCont
                                                                .informedPersonsList[
                                                            index];

                                                    return ListTile(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 0,
                                                              right: 20),
                                                      leading: CircleAvatar(
                                                        radius: 22,
                                                        backgroundImage: assgneeInformed
                                                                        .photo !=
                                                                    null &&
                                                                assgneeInformed
                                                                    .photo!
                                                                    .isNotEmpty
                                                            ? NetworkImage(
                                                                "$baseUrl${assgneeInformed.photo}")
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
                                          : SizedBox(),
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
                                        safetyViolationDetailsAssigneeCont
                                            .toggleInformedExpansionpeople();
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

                //----------------------------------------
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                          text: 'Assignor',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      Row(
                        children: [
                          Container(
                            width: SizeConfig.imageSizeMultiplier * 15,
                            height: SizeConfig.imageSizeMultiplier * 15,
                            child: Image.network(
                              "$baseUrl${safetyViolationDetailsAssigneeCont.asginerUserList[0].profilePhoto}",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 3,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                  text:
                                      "${safetyViolationDetailsAssigneeCont.asginerUserList[0].firstName} "
                                      "${safetyViolationDetailsAssigneeCont.asginerUserList[0].lastName}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: safetyViolationDetailsAssigneeCont
                                      .asginerUserList[0].designation!,
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
                    ],
                  ),
                ),

                Container(
                  width: SizeConfig.widthMultiplier * 100,
                  height: 1.5,
                  color: AppColors.searchfeildcolor,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                //////////-------------------------------

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      safetyViolationDetailsAssigneeCont.userFound.value
                          ? SizedBox()
                          : Row(
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
                      safetyViolationDetailsAssigneeCont.userFound.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  AppTextWidget(
                                      text: 'Photos',
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryText),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 1.5,
                                  ),
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
                                                  safetyViolationDetailsAssigneeCont
                                                      .asgineeAddPhotos.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    4, // Ensures one row (horizontal scroll)

                                                childAspectRatio:
                                                    1, // Keeps items square
                                                mainAxisSpacing: 12,
                                                crossAxisSpacing:
                                                    12, // Spacing between images
                                              ),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .imageSizeMultiplier *
                                                          20,
                                                      width: SizeConfig
                                                              .imageSizeMultiplier *
                                                          20,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12), // Clip image to match container

                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if (safetyViolationDetailsAssigneeCont
                                                                .asgineeAddPhotos
                                                                .isNotEmpty) {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    child:
                                                                        InteractiveViewer(
                                                                      panEnabled:
                                                                          true,
                                                                      minScale:
                                                                          0.5,
                                                                      maxScale:
                                                                          3.0,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        child: Image
                                                                            .network(
                                                                          "$baseUrl${safetyViolationDetailsAssigneeCont.asgineeAddPhotos[index].photoPath.toString()}",
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          },
                                                          child: SizedBox(
                                                            height: SizeConfig
                                                                    .imageSizeMultiplier *
                                                                16,
                                                            width: SizeConfig
                                                                    .imageSizeMultiplier *
                                                                16,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: (safetyViolationDetailsAssigneeCont
                                                                      .asgineeAddPhotos[
                                                                          index]
                                                                      .photoPath!
                                                                      .isNotEmpty
                                                                  // ignore: unnecessary_null_comparison
                                                                  )
                                                                  ? Image
                                                                      .network(
                                                                      "$baseUrl${safetyViolationDetailsAssigneeCont.asgineeAddPhotos[index].photoPath.toString()}",
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    )
                                                                  : Image.asset(
                                                                      ""),
                                                            ),
                                                          ),
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
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 3.5,
                                  ),
                                ])
                          : Column(
                              children: [
                                Obx(
                                  () =>
                                      safetyViolationDetailsAssigneeCont
                                                  .incidentAssigneeCount <
                                              1
                                          ? GestureDetector(
                                              onTap: () {
                                                safetyViolationDetailsAssigneeCont
                                                    .pickIncidentAssigneeImages();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        92,
                                                padding: EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 24,
                                                    bottom: 24),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.orange.shade50,
                                                ),
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
                                                        text:
                                                            'Maximum 10 photos',
                                                        fontSize: AppTextSize
                                                            .textSizeExtraSmall,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .secondaryText),
                                                  ],
                                                ),
                                              ),
                                            )
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
                                                        child: GridView.builder(
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                safetyViolationDetailsAssigneeCont
                                                                    .incidentAssigneeimg
                                                                    .length,
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount:
                                                                  3, // Ensures one row (horizontal scroll)

                                                              childAspectRatio:
                                                                  1, // Keeps items square
                                                              mainAxisSpacing:
                                                                  10,
                                                              crossAxisSpacing:
                                                                  10, // Spacing between images
                                                            ),
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Stack(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.imageSizeMultiplier *
                                                                            18,
                                                                    width: SizeConfig
                                                                            .imageSizeMultiplier *
                                                                        18,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12), // Clip image to match container

                                                                      child: Image
                                                                          .file(
                                                                        File(safetyViolationDetailsAssigneeCont
                                                                            .incidentAssigneeimg[index]
                                                                            .path),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 1,
                                                                    right: 1,
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        safetyViolationDetailsAssigneeCont
                                                                            .removeAssigneeImage(index);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(4),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.8),
                                                                        ),
                                                                        child: Icon(
                                                                            Icons
                                                                                .close,
                                                                            color:
                                                                                Colors.white,
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
                                                      width: SizeConfig
                                                              .imageSizeMultiplier *
                                                          5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        safetyViolationDetailsAssigneeCont
                                                            .pickIncidentAssigneeImages();
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: SizeConfig
                                                                .imageSizeMultiplier *
                                                            18,
                                                        width: SizeConfig
                                                                .imageSizeMultiplier *
                                                            18,
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.orange,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: Colors.orange,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                ),
                                safetyViolationDetailsAssigneeCont
                                            .incidentAssigneeCount <
                                        1
                                    ? SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 2.5,
                                      )
                                    : SizedBox(),
                                Obx(() => safetyViolationDetailsAssigneeCont
                                            .incidentAssigneeCount.value ==
                                        0
                                    ? Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4, left: 5),
                                            child: Text(
                                              safetyViolationDetailsAssigneeCont
                                                  .photoAssigneeError.value,
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 174, 75, 68),
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox()),
                              ],
                            ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: 'Assignee Comments',
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
                        enabled:
                            !safetyViolationDetailsAssigneeCont.userFound.value,
                        controller: safetyViolationDetailsAssigneeCont
                            .assigneecommentController,
                        hintText: 'Comments',
                        // focusNode: newWorkPermitController.dow,
                        // onFieldSubmitted: (_) {
                        //   newWorkPermitController.dow.unfocus();
                        // },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a comment';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: "Assignee Signature",
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 20, bottom: 20),
                              height: 305,
                              decoration: BoxDecoration(
                                color: AppColors.textfeildcolor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  safetyViolationDetailsAssigneeCont
                                          .userFound.value
                                      ? SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            safetyViolationDetailsAssigneeCont
                                                .clearSafetyattestationSignature();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: Image.asset(
                                                  'assets/icons/reload.png',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              AppTextWidget(
                                                text: 'Clear',
                                                fontSize:
                                                    AppTextSize.textSizeSmallm,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.primaryText,
                                              ),
                                            ],
                                          ),
                                        ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 4,
                                  ),
                                  Obx(() {
                                    if (safetyViolationDetailsAssigneeCont
                                        .userFound.value) {
                                      // Show saved signature image
                                      return safetyViolationDetailsAssigneeCont
                                              .savedSignatureUrlfetch
                                              .value
                                              .isNotEmpty
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      25,
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      80,
                                              child: Image.network(
                                                "$baseUrl${safetyViolationDetailsAssigneeCont.savedSignatureUrlfetch.value}",
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          : const Text(
                                              "No signature available");
                                    } else {
                                      // Show signature pad
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Signature(
                                          height: 206,
                                          controller:
                                              safetyViolationDetailsAssigneeCont
                                                  .signatureCheckerController,
                                          backgroundColor: Colors.white,
                                        ),
                                      );
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(() => safetyViolationDetailsAssigneeCont
                              .signatureattestationError.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4, left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    safetyViolationDetailsAssigneeCont
                                        .signatureattestationError.value,
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 174, 75, 68),
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox()),
                    ],
                  ),
                ),
                //---------------------------------
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: 'Assignee',
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      Row(
                        children: [
                          Container(
                            width: SizeConfig.imageSizeMultiplier * 15,
                            height: SizeConfig.imageSizeMultiplier * 15,
                            child: Image.network(
                              "$baseUrl${safetyViolationDetailsAssigneeCont.asgineeUserList[0].profilePhoto}",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 3,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                  text:
                                      "${safetyViolationDetailsAssigneeCont.asgineeUserList[0].firstName} "
                                      "${safetyViolationDetailsAssigneeCont.asgineeUserList[0].lastName}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: safetyViolationDetailsAssigneeCont
                                      .asgineeUserList[0].designation!,
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
                    ],
                  ),
                ),
                //------------------------------------------------------------------------

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
                        text: safetyViolationDetailsAssigneeCont
                                    .violationDebitNote
                                    // ignore: unnecessary_null_comparison
                                    [0]
                                    // ignore: unnecessary_null_comparison
                                    .createdAt !=
                                null
                            ? DateFormat('dd-MM-yyyy hh:mm a').format(
                                DateTime.parse(
                                    safetyViolationDetailsAssigneeCont
                                        .violationDebitNote
                                        // ignore: unnecessary_null_comparison
                                        [0]
                                        // ignore: unnecessary_null_comparison
                                        .createdAt
                                        .toString()))
                            : "",
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText,
                      ),
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
                      Obx(() {
                        final city = locationController.cityName.value;

                        return AppTextWidget(
                          text: city.isNotEmpty
                              ? 'City: $city'
                              : 'Fetching city...',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryText,
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),

                SizedBox(
                  height: SizeConfig.heightMultiplier * 6,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: AppElevatedButton(
              text: safetyViolationDetailsAssigneeCont.userFound.value
                  ? "Closed"
                  : 'Submit',
              onPressed: () async {
                if (safetyViolationDetailsAssigneeCont.userFound.value ==
                    false) {
                  if (formKey.currentState!.validate()) {
                    await safetyViolationDetailsAssigneeCont
                        .saveIncidentAssigneeSignature();

                    if (safetyViolationDetailsAssigneeCont
                        .signatureCheckerController.isEmpty) {
                      safetyViolationDetailsAssigneeCont
                          .signatureattestationError
                          .value = "Please fill in the signature.";
                      return;
                    }
                    if (safetyViolationDetailsAssigneeCont
                            .signatureCheckerController.isNotEmpty &&
                        safetyViolationDetailsAssigneeCont
                            .assigneecommentController.text.isNotEmpty) {
                      showConfirmationDialogClosed(context);
                    }
                  }
                  //   Get.to(WorkPermitPrecautionScreen());
                } else {
                  Get.back();
                }
              }),
        ),
      ),
    );
  }
}
