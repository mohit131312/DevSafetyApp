import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/labourStaffConAll.dart/labour_staff_cont_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LabourStaffCont extends StatelessWidget {
  // final int categoryId;

  // final int userId;
  // final String userName;
  // final int projectId;

  LabourStaffCont({
    super.key,
    // required this.categoryId,
    // required this.userId,
    // required this.userName,
    // required this.projectId,
  });

  final LabourStaffContController labourStaffContController =
      Get.put(LabourStaffContController());
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
            Obx(
              () => labourStaffContController.isPersonalDetailsExpanded.value
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
                                      labourStaffContController
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
                                            width:
                                                SizeConfig.imageSizeMultiplier *
                                                    15,
                                            height:
                                                SizeConfig.imageSizeMultiplier *
                                                    15,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                "$baseUrl${labourStaffContController.labourDetailsList[0].userPhoto}",
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
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
                                              text: labourStaffContController
                                                      .labourDetailsList
                                                      .isNotEmpty
                                                  ? labourStaffContController
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 40,
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: (labourStaffContController
                                                            .labourDetailsList
                                                            .isNotEmpty &&
                                                        labourStaffContController
                                                                .labourDetailsList[
                                                                    0]
                                                                .birthDate !=
                                                            null)
                                                    ? DateFormat('dd MMMM yyyy')
                                                        .format(
                                                        labourStaffContController
                                                                    .labourDetailsList[
                                                                        0]
                                                                    .birthDate
                                                                is String
                                                            ? DateTime.parse(
                                                                labourStaffContController
                                                                        .labourDetailsList[
                                                                            0]
                                                                        .birthDate
                                                                    as String)
                                                            : labourStaffContController
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: AppTexts.gender,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                              text: labourStaffContController
                                                      .labourDetailsList[0]
                                                      .gender!
                                                      .isNotEmpty
                                                  ? labourStaffContController
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: AppTexts.contactno,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .labourDetailsList[0]
                                                        .contactNumber!
                                                        .isNotEmpty
                                                    ? labourStaffContController
                                                        .labourDetailsList[0]
                                                        .contactNumber
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: AppTexts.adharnum,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .labourDetailsList[0]
                                                        .adhaarCardNo!
                                                        .isNotEmpty
                                                    ? labourStaffContController
                                                        .labourDetailsList[0]
                                                        .adhaarCardNo
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: AppTexts.address,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                              text: labourStaffContController
                                                          .labourDetailsList[0]
                                                          .currentStreetName![0]
                                                          .isNotEmpty &&
                                                      labourStaffContController
                                                          .labourDetailsList[0]
                                                          .currentCity![0]
                                                          .isNotEmpty &&
                                                      labourStaffContController
                                                          .labourDetailsList[0]
                                                          .currentTaluka![0]
                                                          .isNotEmpty &&
                                                      labourStaffContController
                                                          .labourDetailsList[0]
                                                          .districtName![0]
                                                          .isNotEmpty &&
                                                      labourStaffContController
                                                          .labourDetailsList[0]
                                                          .stateName![0]
                                                          .isNotEmpty
                                                  ? "${labourStaffContController.labourDetailsList[0].currentStreetName ?? ''}, ${labourStaffContController.labourDetailsList[0].currentCity ?? ''}, ${labourStaffContController.labourDetailsList[0].currentTaluka ?? ''}, ${labourStaffContController.labourDetailsList[0].districtName ?? ''}, ${labourStaffContController.labourDetailsList[0].stateName ?? ''}"
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
                                        width: SizeConfig.widthMultiplier * 40,
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .labourDetailsList[0]
                                                        .bloodGroup!
                                                        .isNotEmpty
                                                    ? labourStaffContController
                                                        .labourDetailsList[0]
                                                        .bloodGroup
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: 'Literacy',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .labourDetailsList[0]
                                                        .literacy!
                                                        .isNotEmpty
                                                    ? labourStaffContController
                                                        .labourDetailsList[0]
                                                        .literacy
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: 'Marital Status',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                            .labourDetailsList[
                                                                0]
                                                            .maritalStatus !=
                                                        null
                                                    ? labourStaffContController
                                                        .labourDetailsList[0]
                                                        .maritalStatus
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: AppTexts.reasonforvisit,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .reasonOfVisitList[0]
                                                        .reasonOfVisit!
                                                        .isNotEmpty
                                                    ? labourStaffContController
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 40,
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .labourDetailsList[0]
                                                        .emergencyContactName
                                                        .isNotEmpty
                                                    ? labourStaffContController
                                                        .labourDetailsList[0]
                                                        .emergencyContactName
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text:
                                                    AppTexts.emergencyrelation,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .labourDetailsList[0]
                                                        .emergencyContactRelation
                                                        .isNotEmpty
                                                    ? labourStaffContController
                                                        .labourDetailsList[0]
                                                        .emergencyContactRelation
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 2,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 40,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                                text: AppTexts.emergencynumber,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .labourDetailsList[0]
                                                        .emergencyContactNumber
                                                        .isNotEmpty
                                                    ? labourStaffContController
                                                        .labourDetailsList[0]
                                                        .emergencyContactNumber
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
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
                                    labourStaffContController.toggleExpansion();
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
              () => labourStaffContController
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
                                    labourStaffContController
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 40,
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .tradeNameList
                                                        .isNotEmpty
                                                    ? labourStaffContController
                                                        .tradeNameList[0]
                                                        .inductionDetails
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: AppTexts.skill,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                              text: labourStaffContController
                                                      .skillLevelList.isNotEmpty
                                                  ? labourStaffContController
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 2,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 40,
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .labourDetailsList
                                                        .isNotEmpty
                                                    ? labourStaffContController
                                                        .labourDetailsList[0]
                                                        .experienceInYears
                                                        .toString()
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: 'Contractor Firm Name',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: labourStaffContController
                                                        .contractorCompanyDetailsList
                                                        .isNotEmpty
                                                    ? labourStaffContController
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
                                              height:
                                                  SizeConfig.heightMultiplier *
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
                                    labourStaffContController
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
            Obx(() => labourStaffContController.isidproofDetailsExpanded.value
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
                                    labourStaffContController
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
                                labourStaffContController
                                        .documentDetailsList.isEmpty
                                    ? SizedBox()
                                    : ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: labourStaffContController
                                            .documentDetailsList.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          if (index >=
                                              labourStaffContController
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
                                                                if (labourStaffContController
                                                                        .documentDetailsList
                                                                        .isNotEmpty &&
                                                                    labourStaffContController
                                                                            .documentDetailsList[
                                                                                index]
                                                                            // ignore: unnecessary_null_comparison
                                                                            .documentPath !=
                                                                        null &&
                                                                    labourStaffContController
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
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            child:
                                                                                Image.network(
                                                                              "$baseUrl${labourStaffContController.documentDetailsList[index].documentPath}",
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child: (labourStaffContController
                                                                              .documentDetailsList
                                                                              .isNotEmpty &&
                                                                          // ignore: unnecessary_null_comparison
                                                                          labourStaffContController.documentDetailsList[index].documentPath !=
                                                                              null &&
                                                                          labourStaffContController
                                                                              .documentDetailsList[
                                                                                  index]
                                                                              .documentPath
                                                                              .isNotEmpty)
                                                                      ? Image
                                                                          .network(
                                                                          "$baseUrl${labourStaffContController.documentDetailsList[index].documentPath}",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )
                                                                      : Image
                                                                          .asset(
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
                                                                text: labourStaffContController
                                                                        .documentDetailsList[
                                                                            index]
                                                                        .docmentType
                                                                        .isNotEmpty
                                                                    ? labourStaffContController
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
                                                                text: labourStaffContController
                                                                        .documentDetailsList[
                                                                            index]
                                                                        .idNumber
                                                                        .isNotEmpty
                                                                    ? labourStaffContController
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
                                                                text: (labourStaffContController
                                                                            .documentDetailsList
                                                                            .isNotEmpty &&
                                                                        // ignore: unnecessary_null_comparison
                                                                        labourStaffContController.documentDetailsList[index].validity !=
                                                                            null)
                                                                    ? DateFormat(
                                                                            'dd MMMM yyyy')
                                                                        .format(
                                                                        labourStaffContController.documentDetailsList[index].validity
                                                                                is String
                                                                            ? DateTime.parse(labourStaffContController.documentDetailsList[index].validity
                                                                                as String)
                                                                            // ignore: unnecessary_cast
                                                                            : labourStaffContController.documentDetailsList[index].validity
                                                                                as DateTime,
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
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Container(
                                              height: 1,
                                              color: AppColors.searchfeildcolor,
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
                                  labourStaffContController
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
              () => labourStaffContController.isprecautionDetailsExpanded.value
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
                                      labourStaffContController
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  labourStaffContController
                                          .equipmentDetailsList.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              labourStaffContController
                                                  .equipmentDetailsList
                                                  .length, (index) {
                                            var equipment =
                                                labourStaffContController
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
                                          text: "No safety equipment selected",
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
                                      vertical: SizeConfig.heightMultiplier * 3,
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
                                                text:
                                                    AppTexts.instructiongivenn,
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
                                          width:
                                              SizeConfig.widthMultiplier * 100,
                                          height: 1.5,
                                          color: AppColors.searchfeildcolor,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 3,
                                        ),
                                        labourStaffContController
                                                .instructionDetailsList
                                                .isNotEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                    labourStaffContController
                                                        .instructionDetailsList
                                                        .length, (index) {
                                                  var equipment =
                                                      labourStaffContController
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
                                                      color:
                                                          AppColors.searchfeild,
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
                                    labourStaffContController
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/icons/person_labour.png'),
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
                          // AppTextWidget(
                          //     text: userName,
                          //     fontSize: AppTextSize.textSizeSmallm,
                          //     fontWeight: FontWeight.w600,
                          //     color: AppColors.primaryText),
                          AppTextWidget(
                              text: 'SAFETY OFFICER',
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
                        // Get.offUntil(
                        //   GetPageRoute(
                        //       page: () => AddLabourScreen(
                        //           categoryId: categoryId,
                        //           userId: userId,
                        //           userName: userName,
                        //           projectId: projectId)),
                        //   (route) {
                        //     if (route is GetPageRoute) {
                        //       return route.page!().runtimeType ==
                        //           InductionTrainingScreen;
                        //     }
                        //     return false;
                        //   },
                        // );

                        // AddLabourScreen(
                        //     categoryId: categoryId,
                        //     userId: userId,
                        //     userName: userName,
                        //     projectId: projectId);
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
                        // showConfirmationDialog(
                        //     context, categoryId, userName, userId, projectId);
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
