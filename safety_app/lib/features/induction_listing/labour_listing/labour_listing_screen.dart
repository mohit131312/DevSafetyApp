import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/induction_listing/labour_listing/labour_listing_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

class LabourListingScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  LabourListingScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });

  final LabourListingController labourListingController =
      Get.put(LabourListingController());
  final LocationController locationController = Get.find();
  @override
  Widget build(BuildContext context) {
    String imageUrl =
        "$baseUrl${labourListingController.labourDetailsList[0].userPhoto}";
    log("Image in list below URL: $imageUrl");

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
              Obx(
                () => labourListingController.isPersonalDetailsExpanded.value
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
                                    text: AppTexts.personaldetails,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttoncolor,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        labourListingController
                                            .toggleExpansion();
                                      },
                                      child: Icon(Icons.keyboard_arrow_up)),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              AppTextWidget(
                                text: AppTexts.personaldetails,
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryText,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
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
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // Profile Image
                                            Container(
                                              width: SizeConfig
                                                      .imageSizeMultiplier *
                                                  15,
                                              height: SizeConfig
                                                      .imageSizeMultiplier *
                                                  15,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: ClipOval(
                                                child: Image.network(
                                                  "$baseUrl${labourListingController.inductionTrainingsList[0].userPhoto}",
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress == null)
                                                      // ignore: curly_braces_in_flow_control_structures
                                                      return child;
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 24,
                                                        height: 24,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: AppColors
                                                              .buttoncolor,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      'assets/icons/image.png',
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier * 3,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                                text: AppTexts.fullname,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            AppTextWidget(
                                                text: labourListingController
                                                        .labourDetailsList
                                                        .isNotEmpty
                                                    ? labourListingController
                                                        .labourDetailsList[0]
                                                        .labourName
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 2,
                                    ),
                                    Container(
                                      width: SizeConfig.widthMultiplier * 100,
                                      height: 1.5,
                                      color: AppColors.searchfeildcolor,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 3,
                                    ),
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
                                                  text: AppTexts.dob,
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
                                                  text: (labourListingController
                                                              .labourDetailsList
                                                              .isNotEmpty &&
                                                          labourListingController
                                                                  .labourDetailsList[
                                                                      0]
                                                                  .birthDate !=
                                                              null)
                                                      ? DateFormat(
                                                              'dd MMMM yyyy')
                                                          .format(
                                                          labourListingController
                                                                      .labourDetailsList[
                                                                          0]
                                                                      .birthDate
                                                                  is String
                                                              ? DateTime.parse(
                                                                  labourListingController
                                                                          .labourDetailsList[
                                                                              0]
                                                                          .birthDate
                                                                      as String)
                                                              : labourListingController
                                                                      .labourDetailsList[
                                                                          0]
                                                                      .birthDate
                                                                  as DateTime,
                                                        )
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
                                              AppTextWidget(
                                                  text: AppTexts.gender,
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
                                                text: labourListingController
                                                        .labourDetailsList[0]
                                                        .gender!
                                                        .isNotEmpty
                                                    ? labourListingController
                                                        .labourDetailsList[0]
                                                        .gender
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
                                                    2.5,
                                              ),
                                              AppTextWidget(
                                                  text: AppTexts.contactno,
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
                                                  text: labourListingController
                                                          .labourDetailsList[0]
                                                          .contactNumber!
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .labourDetailsList[0]
                                                          .contactNumber
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
                                              AppTextWidget(
                                                  text: AppTexts.adharnum,
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
                                                  text: labourListingController
                                                          .labourDetailsList[0]
                                                          .adhaarCardNo!
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .labourDetailsList[0]
                                                          .adhaarCardNo
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
                                              AppTextWidget(
                                                  text: AppTexts.address,
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
                                                text: labourListingController
                                                            .labourDetailsList[
                                                                0]
                                                            .currentStreetName![
                                                                0]
                                                            .isNotEmpty &&
                                                        labourListingController
                                                            .labourDetailsList[
                                                                0]
                                                            .currentCity![0]
                                                            .isNotEmpty &&
                                                        labourListingController
                                                            .labourDetailsList[
                                                                0]
                                                            .currentTaluka![0]
                                                            .isNotEmpty &&
                                                        labourListingController
                                                            .labourDetailsList[
                                                                0]
                                                            .districtName![0]
                                                            .isNotEmpty &&
                                                        labourListingController
                                                            .labourDetailsList[
                                                                0]
                                                            .stateName![0]
                                                            .isNotEmpty
                                                    ? "${labourListingController.labourDetailsList[0].currentStreetName ?? ''}, ${labourListingController.labourDetailsList[0].currentCity ?? ''}, ${labourListingController.labourDetailsList[0].currentTaluka ?? ''}, ${labourListingController.labourDetailsList[0].districtName ?? ''}, ${labourListingController.labourDetailsList[0].stateName ?? ''}"
                                                        .trim()
                                                        .replaceAll(
                                                            RegExp(
                                                                r'(^, |, $|, ,)'),
                                                            '')
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
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
                                                  text: AppTexts.bloodgrp,
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
                                                  text: labourListingController
                                                          .labourDetailsList[0]
                                                          .bloodGroup!
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .labourDetailsList[0]
                                                          .bloodGroup
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
                                              AppTextWidget(
                                                  text: 'Literacy',
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
                                                  text: labourListingController
                                                          .labourDetailsList[0]
                                                          .literacy!
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .labourDetailsList[0]
                                                          .literacy
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
                                              AppTextWidget(
                                                  text: 'Marital Status',
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
                                                  text: labourListingController
                                                              .labourDetailsList[
                                                                  0]
                                                              .maritalStatus !=
                                                          null
                                                      ? labourListingController
                                                          .labourDetailsList[0]
                                                          .maritalStatus
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
                                              AppTextWidget(
                                                  text: AppTexts.reasonforvisit,
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
                                                  text: labourListingController
                                                          .reasonOfVisitList[0]
                                                          .reasonOfVisit!
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .reasonOfVisitList[0]
                                                          .reasonOfVisit
                                                          .toString()
                                                      : "",
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primaryText),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 4,
                              ),
                              AppTextWidget(
                                text: AppTexts.emergencydetails,
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryText,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
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
                                                  text: AppTexts.emergencyname,
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
                                                  text: labourListingController
                                                          .labourDetailsList[0]
                                                          .emergencyContactName
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .labourDetailsList[0]
                                                          .emergencyContactName
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
                                              AppTextWidget(
                                                  text: AppTexts
                                                      .emergencyrelation,
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
                                                  text: labourListingController
                                                          .labourDetailsList[0]
                                                          .emergencyContactRelation
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .labourDetailsList[0]
                                                          .emergencyContactRelation
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
                                                  text:
                                                      AppTexts.emergencynumber,
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
                                                  text: labourListingController
                                                          .labourDetailsList[0]
                                                          .emergencyContactNumber
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .labourDetailsList[0]
                                                          .emergencyContactNumber
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
                                  text: AppTexts.personaldetails,
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      labourListingController.toggleExpansion();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                          ],
                        ),
                      ),
              ),

              //---------------------------------------------------------------------

              Obx(
                () => labourListingController
                        .isProfessionalDetailsExpanded.value
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
                                          'assets/icons/briefcase.png')),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  AppTextWidget(
                                    text: AppTexts.professionaldetails,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttoncolor,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      labourListingController
                                          .toggleExpansionProfessional();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up),
                                  ),
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
                                                  text: AppTexts.trade,
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
                                                  text: labourListingController
                                                          .tradeNameList
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .tradeNameList[0]
                                                          .inductionDetails
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
                                              AppTextWidget(
                                                  text: AppTexts.skill,
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
                                                text: labourListingController
                                                        .skillLevelList
                                                        .isNotEmpty
                                                    ? labourListingController
                                                        .skillLevelList[0]
                                                        .skillLevel
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
                                                  text: AppTexts.yoexperience,
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
                                                  text: labourListingController
                                                          .labourDetailsList
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .labourDetailsList[0]
                                                          .experienceInYears
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
                                              AppTextWidget(
                                                  text: 'Contractor Firm Name',
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
                                                  text: labourListingController
                                                          .contractorCompanyDetailsList
                                                          .isNotEmpty
                                                      ? labourListingController
                                                          .contractorCompanyDetailsList[
                                                              0]
                                                          .contractorCompanyName
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
                                        'assets/icons/briefcase.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: AppTexts.professionaldetails,
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      labourListingController
                                          .toggleExpansionProfessional();
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

              //-----------------------------------------------------------------
              Obx(() => labourListingController.isidproofDetailsExpanded.value
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
                                    child:
                                        Image.asset('assets/icons/proof.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: AppTexts.idproof,
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      labourListingController
                                          .toggleExpansionidProof();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 1,
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
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 1.5,
                                  ),
                                  labourListingController
                                          .documentDetailsList.isEmpty
                                      ? SizedBox()
                                      : ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: labourListingController
                                              .documentDetailsList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            if (index >=
                                                labourListingController
                                                    .documentDetailsList[index]
                                                    .idNumber
                                                    .length) {
                                              return SizedBox
                                                  .shrink(); // Prevents the error
                                            }
                                            return Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .widthMultiplier *
                                                              40,
                                                          child: Column(
                                                            children: [
                                                              AppTextWidget(
                                                                  text: AppTexts
                                                                      .docphoto,
                                                                  fontSize:
                                                                      AppTextSize
                                                                          .textSizeSmall,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .searchfeild),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    1.5,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  if (labourListingController
                                                                          .documentDetailsList
                                                                          .isNotEmpty &&
                                                                      labourListingController
                                                                              .documentDetailsList[
                                                                                  index]
                                                                              // ignore: unnecessary_null_comparison
                                                                              .documentPath !=
                                                                          null &&
                                                                      labourListingController
                                                                          .documentDetailsList[
                                                                              index]
                                                                          .documentPath
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
                                                                                "$baseUrl${labourListingController.documentDetailsList[index].documentPath}",
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
                                                                    child: (labourListingController
                                                                                .documentDetailsList.isNotEmpty &&
                                                                            // ignore: unnecessary_null_comparison
                                                                            labourListingController.documentDetailsList[index].documentPath !=
                                                                                null &&
                                                                            labourListingController
                                                                                .documentDetailsList[
                                                                                    index]
                                                                                .documentPath
                                                                                .isNotEmpty)
                                                                        ? Image
                                                                            .network(
                                                                            "$baseUrl${labourListingController.documentDetailsList[index].documentPath}",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : Image.asset(
                                                                            ""),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    1.5,
                                                              ),
                                                              AppTextWidget(
                                                                  text: AppTexts
                                                                      .doctype,
                                                                  fontSize:
                                                                      AppTextSize
                                                                          .textSizeSmall,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .searchfeild),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    1,
                                                              ),
                                                              AppTextWidget(
                                                                  text: labourListingController
                                                                          .documentDetailsList[
                                                                              index]
                                                                          .docmentType
                                                                          .isNotEmpty
                                                                      ? labourListingController
                                                                          .documentDetailsList[
                                                                              index]
                                                                          .docmentType
                                                                      : "",
                                                                  fontSize:
                                                                      AppTextSize
                                                                          .textSizeSmall,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .primaryText),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    2.5,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeConfig
                                                                  .heightMultiplier *
                                                              2.5,
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .widthMultiplier *
                                                              2.5,
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .widthMultiplier *
                                                              40,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AppTextWidget(
                                                                  text: AppTexts
                                                                      .idno,
                                                                  fontSize:
                                                                      AppTextSize
                                                                          .textSizeSmall,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .searchfeild),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    1,
                                                              ),
                                                              AppTextWidget(
                                                                  text: labourListingController
                                                                          .documentDetailsList[
                                                                              index]
                                                                          .idNumber
                                                                          .isNotEmpty
                                                                      ? labourListingController
                                                                          .documentDetailsList[
                                                                              index]
                                                                          .idNumber
                                                                      : "",
                                                                  fontSize:
                                                                      AppTextSize
                                                                          .textSizeSmall,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .primaryText),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    5.5,
                                                              ),
                                                              AppTextWidget(
                                                                  text: AppTexts
                                                                      .validity,
                                                                  fontSize:
                                                                      AppTextSize
                                                                          .textSizeSmall,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .searchfeild),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    1,
                                                              ),
                                                              AppTextWidget(
                                                                  text: (labourListingController
                                                                              .documentDetailsList
                                                                              .isNotEmpty &&
                                                                          // ignore: unnecessary_null_comparison
                                                                          labourListingController.documentDetailsList[index].validity !=
                                                                              null)
                                                                      ? DateFormat(
                                                                              'dd MMMM yyyy')
                                                                          .format(
                                                                          labourListingController.documentDetailsList[index].validity is String
                                                                              ? DateTime.parse(labourListingController.documentDetailsList[index].validity as String)
                                                                              // ignore: unnecessary_cast
                                                                              : labourListingController.documentDetailsList[index].validity as DateTime,
                                                                        )
                                                                      : "",
                                                                  fontSize:
                                                                      AppTextSize
                                                                          .textSizeSmall,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .primaryText),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeConfig
                                                                  .heightMultiplier *
                                                              2.5,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Container(
                                                height: 1,
                                                color:
                                                    AppColors.searchfeildcolor,
                                              ),
                                            );
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
                                  child: Image.asset('assets/icons/proof.png')),
                              SizedBox(
                                width: 5,
                              ),
                              AppTextWidget(
                                text: AppTexts.idproof,
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttoncolor,
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    labourListingController
                                        .toggleExpansionidProof();
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
                () => labourListingController.isprecautionDetailsExpanded.value
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
                                    text: AppTexts.precautiondet,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttoncolor,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        labourListingController
                                            .toggleExpansionPrecaution();
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
                                          MainAxisAlignment.center,
                                      children: [
                                        AppTextWidget(
                                            text: AppTexts.safetyequipprovided,
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 2,
                                    ),
                                    Container(
                                      width: SizeConfig.widthMultiplier * 100,
                                      height: 1.5,
                                      color: AppColors.searchfeildcolor,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 3,
                                    ),
                                    labourListingController
                                            .equipmentDetailsList.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                labourListingController
                                                    .equipmentDetailsList
                                                    .length, (index) {
                                              var equipment =
                                                  labourListingController
                                                          .equipmentDetailsList[
                                                      index];

                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: SizeConfig
                                                            .heightMultiplier *
                                                        1.5),
                                                child: AppTextWidget(
                                                  text:
                                                      "${index + 1}. ${equipment.equipmentName}", // Access `title` safely
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.searchfeild,
                                                ),
                                              );
                                            }),
                                          )
                                        : AppTextWidget(
                                            text:
                                                "No safety equipment selected",
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red,
                                          ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 3,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 4,
                                        vertical:
                                            SizeConfig.heightMultiplier * 3,
                                      ),
                                      width: SizeConfig.widthMultiplier * 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.appgreycolor,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppTextWidget(
                                                  text: AppTexts
                                                      .instructiongivenn,
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primaryText),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 2,
                                          ),
                                          Container(
                                            width: SizeConfig.widthMultiplier *
                                                100,
                                            height: 1.5,
                                            color: AppColors.searchfeildcolor,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 3,
                                          ),
                                          labourListingController
                                                  .instructionDetailsList
                                                  .isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: List.generate(
                                                      labourListingController
                                                          .instructionDetailsList
                                                          .length, (index) {
                                                    var equipment =
                                                        labourListingController
                                                                .instructionDetailsList[
                                                            index];

                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: SizeConfig
                                                                  .heightMultiplier *
                                                              1.5),
                                                      child: AppTextWidget(
                                                        text:
                                                            "${index + 1}. ${equipment.instructionName}",
                                                        fontSize: AppTextSize
                                                            .textSizeSmall,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .searchfeild,
                                                      ),
                                                    );
                                                  }),
                                                )
                                              : AppTextWidget(
                                                  text:
                                                      "No safety equipment selected",
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red,
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 3,
                                    ),
                                  ],
                                ),
                              ),
                            ]))
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
                                  text: AppTexts.precautiondet,
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      labourListingController
                                          .toggleExpansionPrecaution();
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
                    AppTextWidget(
                        text: 'Inducted By',
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
                          child: Image.network(
                            "$baseUrl${userImg}",
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
                      height: SizeConfig.heightMultiplier * 2,
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
                      text: labourListingController
                                  // ignore: unnecessary_null_comparison
                                  .inductionTrainingsList[0]
                                  // ignore: unnecessary_null_comparison
                                  .createdAt !=
                              null
                          ? DateFormat('dd-MM-yyyy hh:mm a')
                              .format(DateTime.parse(labourListingController
                                  // ignore: unnecessary_null_comparison
                                  .inductionTrainingsList[0]
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
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: AppElevatedButton(
              text: 'Closed',
              onPressed: () {
                Get.back();
              }),
        ),
      ),
    );
  }
}
