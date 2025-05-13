import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/home_screen.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/incident_report_all/incedent_report_preview/incedent_report_preview_controller.dart';
import 'package:flutter_app/features/incident_report_all/incedent_report_submit/incident_report_submit.dart';
import 'package:flutter_app/features/incident_report_all/incident_details/incident_details_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_details/incident_details_screen.dart';
import 'package:flutter_app/features/incident_report_all/incident_more_details/incident_more_details_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_assigne/select_assigne_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_informed_people/select_informed_people_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_injured/select_injured_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IncedentReportPreviewScreen extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;

  IncedentReportPreviewScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final IncidentReportController incidentReportController = Get.find();
  final IncidentDetailsController incidentDetailsController = Get.find();
  final IncidentMoreDetailsController incidentMoreDetailsController =
      Get.find();
  final SelectInformedIncidentController selectInformedIncidentController =
      Get.find();

  final SelectInjuredController selectInjuredController = Get.find();

  final SelectAssigneController selectAssigneController = Get.find();

  final IncedentReportPreviewController incedentReportPreviewController =
      Get.put(IncedentReportPreviewController());
  final LocationController locationController = Get.find();
  String getFormattedDateTime() {
    final now = DateTime.now();
    final formatter =
        DateFormat('dd MMM yyyy hh:mm a'); // Format: 06 Oct 2024 11:14 AM
    return formatter.format(now);
  }

  void showConfirmationDialogMeasures(
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
              text: 'Are you sure you want to Create Incident Report?',
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
                        text: 'Cancel',
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await incedentReportPreviewController
                        .safetySaveIncidentReport(
                            context, userName, userId, projectId);
                    //  if (safetyPreviewController.validationmsg ==
                    //  'Data saved successfully.') {
                    //   Get.to(() => SafetySubmitScreeen(
                    //       userId: userId,
                    //       userName: userName,
                    //       userImg: userImg,
                    //       userDesg: userDesg));
                    // }
                    if (incedentReportPreviewController.validationmsg ==
                        'Incident report saved successfully.') {
                      Get.to(IncidentReportSubmit(
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
                        text: 'Submit',
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
              Obx(() => incedentReportPreviewController
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
                                  text: 'Incident Details',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      incedentReportPreviewController
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
                                        incidentDetailsController
                                                    .incidentImageCount <
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
                                                          child:
                                                              GridView.builder(
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemCount:
                                                                      incidentDetailsController
                                                                          .incidentimg
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
                                                                            borderRadius:
                                                                                BorderRadius.circular(12), // Clip image to match container

                                                                            child:
                                                                                Image.file(
                                                                              File(incidentDetailsController.incidentimg[index].path),
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
                                                text: 'Building',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            Obx(() {
                                              return AppTextWidget(
                                                text: incidentDetailsController
                                                        .selectBuilding
                                                        .value
                                                        .isNotEmpty
                                                    ? incidentDetailsController
                                                        .selectBuilding.value
                                                    : '',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              );
                                            }),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.5,
                                            ),
                                            AppTextWidget(
                                                text: 'Contractor Firm',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            Obx(() {
                                              return AppTextWidget(
                                                text: incidentDetailsController
                                                        .selectCompany
                                                        .value
                                                        .isNotEmpty
                                                    ? incidentDetailsController
                                                        .selectCompany.value
                                                    : '',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              );
                                            }),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.5,
                                            ),
                                            AppTextWidget(
                                                text: 'Root Cause',
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
                                                text:
                                                    incidentMoreDetailsController
                                                        .rootcauseController
                                                        .text,
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
                                                text: 'Area of Work',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            Obx(() {
                                              return AppTextWidget(
                                                text: incidentDetailsController
                                                        .selectFloor
                                                        .value
                                                        .isNotEmpty
                                                    ? incidentDetailsController
                                                        .selectFloor.value
                                                    : '',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              );
                                            }),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.2,
                                            ),
                                            AppTextWidget(
                                                text: 'Severity',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            Obx(() {
                                              return AppTextWidget(
                                                text: incidentDetailsController
                                                        .selectSeverity
                                                        .value
                                                        .isNotEmpty
                                                    ? incidentDetailsController
                                                        .selectSeverity.value
                                                    : '',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              );
                                            }),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.5,
                                            ),
                                            AppTextWidget(
                                                text: 'Incident Details',
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
                                                text: incidentDetailsController
                                                    .incidentController.text,
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
                                text: 'Incident Details',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttoncolor,
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    incedentReportPreviewController
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
                () => incedentReportPreviewController.isinvolvepeople.value
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
                                        incedentReportPreviewController
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
                                decoration: (selectInjuredController
                                            .selectedIncidentLabourIdsFinal
                                            .isNotEmpty ||
                                        selectInjuredController
                                            .selectedIncidentStaffIdsFinal
                                            .isNotEmpty ||
                                        selectInjuredController
                                            .selectedIncidentContractorIdsFinal
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
                                      () => selectInjuredController
                                              .selectedIncidentLabourIdsFinal
                                              .isNotEmpty
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
                                    ),
                                    Obx(() => selectInjuredController
                                            .selectedIncidentLabourIdsFinal
                                            .isNotEmpty
                                        ? SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          )
                                        : SizedBox()),
                                    Obx(
                                      () {
                                        final selectedList =
                                            selectInjuredController
                                                .addIncidentInvolvePerson;

                                        return selectInjuredController
                                                .selectedIncidentLabourIdsFinal
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
                                                        BorderRadius.circular(
                                                            8)),
                                                height: selectInjuredController
                                                            .selectedIncidentLabourIdsFinal
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
                                                        incedentReportPreviewController
                                                            .scrollLabourController,
                                                    itemCount: selectedList
                                                            .isNotEmpty
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
                                                          text: labour
                                                              .labourName
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
                                    Obx(() => selectInjuredController
                                            .selectedIncidentStaffIdsFinal
                                            .isNotEmpty
                                        ? SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 4,
                                          )
                                        : SizedBox()),
                                    Obx(
                                      () => selectInjuredController
                                              .selectedIncidentStaffIdsFinal
                                              .isNotEmpty
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                AppTextWidget(
                                                  text: 'Staff',
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.primaryText,
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ),

                                    Obx(() => selectInjuredController
                                            .selectedIncidentStaffIdsFinal
                                            .isNotEmpty
                                        ? SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          )
                                        : SizedBox()),
                                    Obx(
                                      () {
                                        final selectedList =
                                            selectInjuredController
                                                .addInvolveIncidentStaffPerson;

                                        return selectInjuredController
                                                .selectedIncidentStaffIdsFinal
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
                                                        BorderRadius.circular(
                                                            8)),
                                                height: selectInjuredController
                                                            .selectedIncidentStaffIdsFinal
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
                                                        incedentReportPreviewController
                                                            .scrollStaffController,
                                                    itemCount: selectedList
                                                            .isNotEmpty
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
                                    Obx(() => selectInjuredController
                                            .selectedIncidentContractorIdsFinal
                                            .isNotEmpty
                                        ? SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 4,
                                          )
                                        : SizedBox()),

                                    //---------------------------------------------------------

                                    Obx(
                                      () => selectInjuredController
                                              .selectedIncidentContractorIdsFinal
                                              .isNotEmpty
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                AppTextWidget(
                                                  text: 'Contractor',
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.primaryText,
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ),

                                    Obx(() => selectInjuredController
                                            .selectedIncidentContractorIdsFinal
                                            .isNotEmpty
                                        ? SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          )
                                        : SizedBox()),
                                    Obx(
                                      () {
                                        final selectedList = selectInjuredController
                                            .addInvolveIncidentContractorPerson;

                                        return selectInjuredController
                                                .selectedIncidentContractorIdsFinal
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
                                                        BorderRadius.circular(
                                                            8)),
                                                height: selectInjuredController
                                                            .selectedIncidentContractorIdsFinal
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
                                                        incedentReportPreviewController
                                                            .scrollContractorController,
                                                    itemCount: selectedList
                                                            .isNotEmpty
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
                                                                  .contractorPhoneNo
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
                                      incedentReportPreviewController
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
                () => incedentReportPreviewController.isinformedpeople.value
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
                                        incedentReportPreviewController
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
                                decoration: selectInformedIncidentController
                                        .selectedAssIncidentIdsFinal.isNotEmpty
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
                                            selectInformedIncidentController
                                                .addInvolveIncidentPerson;

                                        return selectInformedIncidentController
                                                .selectedAssIncidentIdsFinal
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
                                                        BorderRadius.circular(
                                                            8)),
                                                height: selectInformedIncidentController
                                                            .selectedAssIncidentIdsFinal
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
                                                        incedentReportPreviewController
                                                            .scrollAssigneeInformedController,
                                                    itemCount: selectedList
                                                            .isNotEmpty
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
                                                        // leading: CircleAvatar(
                                                        //   radius: 22,
                                                        //   backgroundImage: assgneeInformed
                                                        //                   .profilePhoto !=
                                                        //               null &&
                                                        //           assgneeInformed
                                                        //               .profilePhoto!
                                                        //               .isNotEmpty
                                                        //       ? NetworkImage(
                                                        //           "$baseUrl${assgneeInformed.profilePhoto}")
                                                        //       : AssetImage("")
                                                        //           as ImageProvider,
                                                        // ),
                                                        leading: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 28,
                                                              backgroundColor:
                                                                  Colors.grey
                                                                      .shade200, // Fallback color
                                                              child: ClipOval(
                                                                child: Image
                                                                    .network(
                                                                  assgneeInformed.profilePhoto !=
                                                                              null &&
                                                                          assgneeInformed
                                                                              .profilePhoto!
                                                                              .isNotEmpty
                                                                      ? "$baseUrl${assgneeInformed.profilePhoto}"
                                                                      : "",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width:
                                                                      56, // Diameter = radius * 2
                                                                  height: 56,
                                                                  loadingBuilder:
                                                                      (context,
                                                                          child,
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null)
                                                                      return child;
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            24,
                                                                        height:
                                                                            24,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              2,
                                                                          color:
                                                                              AppColors.buttoncolor,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  errorBuilder:
                                                                      (context,
                                                                          error,
                                                                          stackTrace) {
                                                                    return Image
                                                                        .asset(
                                                                      'assets/icons/image.png',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
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
                                      incedentReportPreviewController
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

              Obx(
                () => incedentReportPreviewController
                        .isprecautionDetailsExpanded.value
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
                                        incedentReportPreviewController
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
                                            text: 'Preventive Measures',
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
                                    Obx(() {
                                      final selectedMeasures =
                                          incidentReportController
                                              .preventionMeasuresList
                                              .where((measure) =>
                                                  incidentMoreDetailsController
                                                      .selectedMoreIncidentIds
                                                      .contains(measure.id))
                                              .toList();

                                      return selectedMeasures.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  selectedMeasures.length,
                                                  (index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: SizeConfig
                                                              .heightMultiplier *
                                                          1.5),
                                                  child: AppTextWidget(
                                                    text:
                                                        "${index + 1}. ${selectedMeasures[index].incidentDetails}",
                                                    fontSize: AppTextSize
                                                        .textSizeSmall,
                                                    fontWeight: FontWeight.w400,
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
                                            );
                                    }),
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
                                  text: AppTexts.precautiondet,
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      incedentReportPreviewController
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
                        selectAssigneController
                                .addInvolveassigneeDataPerson.isNotEmpty
                            ? Container(
                                width: SizeConfig.imageSizeMultiplier * 15,
                                height: SizeConfig.imageSizeMultiplier * 15,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Colors
                                          .grey.shade200, // Fallback color
                                      child: ClipOval(
                                        child: Image.network(
                                          selectAssigneController
                                                          // ignore: unnecessary_null_comparison
                                                          .addInvolveassigneeDataPerson !=
                                                      null &&
                                                  selectAssigneController
                                                      .addInvolveassigneeDataPerson
                                                      .isNotEmpty
                                              ? "$baseUrl${selectAssigneController.addInvolveassigneeDataPerson[0].profilePhoto}"
                                              : "",
                                          fit: BoxFit.cover,
                                          width: 56, // Diameter = radius * 2
                                          height: 56,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: AppColors.buttoncolor,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                                //  CircleAvatar(
                                //   radius: 22,
                                //   backgroundImage: selectAssigneController
                                //           .addInvolveassigneeDataPerson
                                //           .isNotEmpty
                                //       ? NetworkImage(
                                //           "$baseUrl${selectAssigneController.addInvolveassigneeDataPerson[0].profilePhoto}")
                                //       : AssetImage(
                                //               "assets/images/default_avatar.png")
                                //           as ImageProvider,
                                // ),
                              )
                            : Text('Not Selected'),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                                text: selectAssigneController
                                        .addInvolveassigneeDataPerson.isNotEmpty
                                    ? selectAssigneController
                                        .addInvolveassigneeDataPerson[0]
                                        .firstName!
                                    : "",
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText),
                            AppTextWidget(
                                text: selectAssigneController
                                        .addInvolveassigneeDataPerson.isNotEmpty
                                    ? selectAssigneController
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
                                  : AssetImage(
                                          "assets/images/default_avatar.png")
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
                      text: getFormattedDateTime(),
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
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.offUntil(
                    GetPageRoute(
                        page: () => IncidentDetailsScreen(
                              userId: userId,
                              userName: userName,
                              userImg: userImg,
                              userDesg: userDesg,
                              projectId: projectId,
                            )),
                    (route) {
                      if (route is GetPageRoute) {
                        return route.page!().runtimeType == HomeScreen;
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
                  showConfirmationDialogMeasures(context); // Call the function
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
    );
  }
}
