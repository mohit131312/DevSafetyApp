import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/incident_report_all/incedent_report_submit/incident_report_resolved.dart';

import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_details_assignee/incident_report_details_assignee_controller.dart';

import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class IncidentReportDetailsAssignee extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int incidentId;
  final String uniqueId;
  IncidentReportDetailsAssignee({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
    required this.incidentId,
    required this.uniqueId,
  });

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final IncidentReportDetailsAssigneeController
      incidentReportDetailsAssigneeController =
      Get.put(IncidentReportDetailsAssigneeController());
  final LocationController locationController = Get.find();
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
              text: 'Are you sure you want to Resolve Incident Report?',
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
                    var assigneeId = incidentReportDetailsAssigneeController
                        .safetyIncidentReport[0].assigneeId;
                    await incidentReportDetailsAssigneeController
                        .safetySaveIncidentAssigneeComment(
                            context, incidentId, assigneeId, 1);
                    if (incidentReportDetailsAssigneeController.apiStatus ==
                        true) {
                      Get.to(IncidentReportResolved(
                        userId: userId,
                        projectId: projectId,
                        incidentId: incidentId,
                        uniqueId: uniqueId,
                      ));
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
        resizeToAvoidBottomInset: true,
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
              text: "Incident Report",
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
                Obx(() => incidentReportDetailsAssigneeController
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
                                        incidentReportDetailsAssigneeController
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
                                                        incidentReportDetailsAssigneeController
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
                                                      // return Stack(
                                                      //   children: [
                                                      //     SizedBox(
                                                      //       height: SizeConfig
                                                      //               .imageSizeMultiplier *
                                                      //           20,
                                                      //       width: SizeConfig
                                                      //               .imageSizeMultiplier *
                                                      //           20,
                                                      //       child: ClipRRect(
                                                      //         borderRadius:
                                                      //             BorderRadius
                                                      //                 .circular(
                                                      //                     12), // Clip image to match container

                                                      //         child:
                                                      //             Image.network(
                                                      //           "$baseUrl${incidentReportDetailsAssigneeController.photos[index].photoPath.toString()}",
                                                      //           fit: BoxFit
                                                      //               .contain,
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // );

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
                                                                  if (incidentReportDetailsAssigneeController
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
                                                                                "$baseUrl${incidentReportDetailsAssigneeController.photos[index].photoPath.toString()}",
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
                                                                    child: (incidentReportDetailsAssigneeController
                                                                            .photos[
                                                                                index]
                                                                            .photoPath!
                                                                            .isNotEmpty
                                                                        // ignore: unnecessary_null_comparison
                                                                        )
                                                                        ? Image
                                                                            .network(
                                                                            "$baseUrl${incidentReportDetailsAssigneeController.photos[index].photoPath.toString()}",
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
                                                  text: 'Building',
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
                                                text: incidentReportDetailsAssigneeController
                                                            .buildingList[0]
                                                            .buildingName !=
                                                        null
                                                    ? incidentReportDetailsAssigneeController
                                                        .buildingList[0]
                                                        .buildingName
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
                                                  text: 'Contractor Firm',
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
                                                text: incidentReportDetailsAssigneeController
                                                            .contractorCompany[
                                                                0]
                                                            .contractorCompanyName !=
                                                        null
                                                    ? incidentReportDetailsAssigneeController
                                                        .contractorCompany[0]
                                                        .contractorCompanyName
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
                                                  text: 'Root Cause',
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
                                                  text: incidentReportDetailsAssigneeController
                                                              .safetyIncidentReport[
                                                                  0]
                                                              .rootCause !=
                                                          null
                                                      ? incidentReportDetailsAssigneeController
                                                          .safetyIncidentReport[
                                                              0]
                                                          .rootCause
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
                                                  text: 'Area of Work',
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
                                                text:
                                                    incidentReportDetailsAssigneeController
                                                                .floorAreaOfWork[
                                                                    0]
                                                                // ignore: unnecessary_null_comparison
                                                                .floorName !=
                                                            null
                                                        ? incidentReportDetailsAssigneeController
                                                            .floorAreaOfWork[0]
                                                            .floorName
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
                                                  text: 'Severity',
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
                                                text: incidentReportDetailsAssigneeController
                                                            .severityLevel[0]
                                                            .incidentDetails !=
                                                        null
                                                    ? incidentReportDetailsAssigneeController
                                                        .severityLevel[0]
                                                        .incidentDetails
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
                                                  text: 'Incident Details',
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
                                                  text: incidentReportDetailsAssigneeController
                                                              .safetyIncidentReport[
                                                                  0]
                                                              .incidentDetails !=
                                                          null
                                                      ? incidentReportDetailsAssigneeController
                                                          .safetyIncidentReport[
                                                              0]
                                                          .incidentDetails
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
                                  text: 'Incident Details',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      incidentReportDetailsAssigneeController
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
                  () => incidentReportDetailsAssigneeController
                          .isinvolvepeople.value
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
                                          incidentReportDetailsAssigneeController
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
                                  decoration: (incidentReportDetailsAssigneeController
                                              .involvedLaboursList.isNotEmpty ||
                                          incidentReportDetailsAssigneeController
                                              .involvedStaffList.isNotEmpty ||
                                          incidentReportDetailsAssigneeController
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                            text: 'Labour',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                        ],
                                      ),
                                      incidentReportDetailsAssigneeController
                                              .involvedLaboursList.isEmpty
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      5,
                                            )
                                          : SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),

                                      incidentReportDetailsAssigneeController
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
                                              height: incidentReportDetailsAssigneeController
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
                                                      incidentReportDetailsAssigneeController
                                                          .scrollLabourController,
                                                  itemCount: incidentReportDetailsAssigneeController
                                                          .involvedLaboursList
                                                          .isNotEmpty
                                                      ? incidentReportDetailsAssigneeController
                                                          .involvedLaboursList
                                                          .length
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final labour =
                                                        incidentReportDetailsAssigneeController
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

                                      incidentReportDetailsAssigneeController
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

                                      incidentReportDetailsAssigneeController
                                              .involvedLaboursList.isNotEmpty
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            )
                                          : SizedBox(),

                                      incidentReportDetailsAssigneeController
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
                                                  incidentReportDetailsAssigneeController
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
                                                      incidentReportDetailsAssigneeController
                                                          .scrollStaffController,
                                                  itemCount:
                                                      incidentReportDetailsAssigneeController
                                                          .involvedStaffList
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    // incidentReportDetailsAssigneeController
                                                    //     .involvedStaffList
                                                    //     .entries
                                                    //     .elementAt(index);
                                                    final staff =
                                                        incidentReportDetailsAssigneeController
                                                                .involvedStaffList[
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

                                      incidentReportDetailsAssigneeController
                                                  .involvedContractorUserList
                                                  .isNotEmpty ||
                                              incidentReportDetailsAssigneeController
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

                                      incidentReportDetailsAssigneeController
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
                                                  height: incidentReportDetailsAssigneeController
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
                                                          incidentReportDetailsAssigneeController
                                                              .scrollContractorController,
                                                      itemCount:
                                                          incidentReportDetailsAssigneeController
                                                              .involvedContractorUserList
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        // final entry =
                                                        //     incidentReportDetailsAssigneeController
                                                        //         .involvedContractorUserList
                                                        //         .entries
                                                        //         .elementAt(
                                                        //             index);
                                                        final contractor =
                                                            incidentReportDetailsAssigneeController
                                                                    .involvedContractorUserList[
                                                                index];

                                                        return ListTile(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 0,
                                                                  right: 20),
                                                          leading: CircleAvatar(
                                                            radius: 22,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/icons/image.png'),
                                                            backgroundColor: Colors
                                                                .transparent, // Optional: helps if image has transparency
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
                                        incidentReportDetailsAssigneeController
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
                  () => incidentReportDetailsAssigneeController
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
                                          incidentReportDetailsAssigneeController
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
                                  decoration:
                                      incidentReportDetailsAssigneeController
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
                                      incidentReportDetailsAssigneeController
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
                                              height: incidentReportDetailsAssigneeController
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
                                                      incidentReportDetailsAssigneeController
                                                          .scrolldataController,
                                                  itemCount: incidentReportDetailsAssigneeController
                                                          .informedPersonsList
                                                          .isNotEmpty
                                                      ? incidentReportDetailsAssigneeController
                                                          .informedPersonsList
                                                          .length
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final assgneeInformed =
                                                        incidentReportDetailsAssigneeController
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
                                                        color: const Color
                                                            .fromARGB(
                                                            239, 2, 1, 1),
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
                                        incidentReportDetailsAssigneeController
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
                  () => incidentReportDetailsAssigneeController
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
                                          incidentReportDetailsAssigneeController
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppTextWidget(
                                              text: 'Preventive Measures',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
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
                                      incidentReportDetailsAssigneeController
                                              .preventionMeasures.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                incidentReportDetailsAssigneeController
                                                    .preventionMeasures.length,
                                                (index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: SizeConfig
                                                                .heightMultiplier *
                                                            1.5),
                                                    child: AppTextWidget(
                                                      text:
                                                          "${index + 1}. ${incidentReportDetailsAssigneeController.preventionMeasures[index].incidentDetails}", // Adjust the field you want to display from InformedPersonsList
                                                      fontSize: AppTextSize
                                                          .textSizeSmall,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.searchfeild,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : AppTextWidget(
                                              text: "No persons informed",
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red,
                                            )
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
                                        incidentReportDetailsAssigneeController
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                          text: 'Doer',
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
                              "$baseUrl${incidentReportDetailsAssigneeController.asginerUserList[0].profilePhoto}",
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
                                      "${incidentReportDetailsAssigneeController.asginerUserList[0].firstName ?? ''} "
                                      "${incidentReportDetailsAssigneeController.asginerUserList[0].lastName ?? ''}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: incidentReportDetailsAssigneeController
                                          .asginerUserList[0].designation ??
                                      "",
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
                  height: SizeConfig.heightMultiplier * 1,
                ),
                //////////-------------------------------

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      incidentReportDetailsAssigneeController.userFound.value
                          ? SizedBox()
                          : Row(
                              key: incidentReportDetailsAssigneeController
                                  .photoKey,
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
                      incidentReportDetailsAssigneeController.userFound.value
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
                                                  incidentReportDetailsAssigneeController
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
                                                            if (incidentReportDetailsAssigneeController
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
                                                                          "$baseUrl${incidentReportDetailsAssigneeController.asgineeAddPhotos[index].photoPath.toString()}",
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
                                                              child: (incidentReportDetailsAssigneeController
                                                                      .asgineeAddPhotos[
                                                                          index]
                                                                      .photoPath!
                                                                      .isNotEmpty
                                                                  // ignore: unnecessary_null_comparison
                                                                  )
                                                                  ? Image
                                                                      .network(
                                                                      "$baseUrl${incidentReportDetailsAssigneeController.asgineeAddPhotos[index].photoPath.toString()}",
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
                                  () => incidentReportDetailsAssigneeController
                                              .incidentAssigneeCount <
                                          1
                                      ? GestureDetector(
                                          onTap: () {
                                            incidentReportDetailsAssigneeController
                                                .pickIncidentAssigneeImages(
                                                    source:
                                                        ImageSource.gallery);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width:
                                                SizeConfig.widthMultiplier * 92,
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
                                                    text: 'Maximum 5 photos',
                                                    fontSize: AppTextSize
                                                        .textSizeExtraSmall,
                                                    fontWeight: FontWeight.w400,
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
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start, // Ensure items align properly

                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    child: GridView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            incidentReportDetailsAssigneeController
                                                                .incidentAssigneeimg
                                                                .length,
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
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Stack(
                                                            children: [
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .imageSizeMultiplier *
                                                                    18,
                                                                width: SizeConfig
                                                                        .imageSizeMultiplier *
                                                                    18,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12), // Clip image to match container

                                                                  child: Image
                                                                      .file(
                                                                    File(incidentReportDetailsAssigneeController
                                                                        .incidentAssigneeimg[
                                                                            index]
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
                                                                  onTap: () {
                                                                    incidentReportDetailsAssigneeController
                                                                        .removeAssigneeImage(
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(4),
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
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            15),
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
                                                    incidentReportDetailsAssigneeController
                                                        .pickIncidentAssigneeImages(
                                                            source: ImageSource
                                                                .gallery);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: SizeConfig
                                                            .imageSizeMultiplier *
                                                        18,
                                                    width: SizeConfig
                                                            .imageSizeMultiplier *
                                                        18,
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.orange,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Icon(
                                                      Icons.camera_alt_outlined,
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
                                incidentReportDetailsAssigneeController
                                            .incidentAssigneeCount >
                                        1
                                    ? SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 2.5,
                                      )
                                    : SizedBox(),
                                Obx(() =>
                                    incidentReportDetailsAssigneeController
                                                .incidentAssigneeCount.value ==
                                            0
                                        ? Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4, left: 5),
                                                child: Text(
                                                  incidentReportDetailsAssigneeController
                                                      .photoAssigneeError.value,
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 174, 75, 68),
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox()),
                              ],
                            ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2.5,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: 'Checker Comments',
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
                        enabled: !incidentReportDetailsAssigneeController
                            .userFound.value,
                        controller: incidentReportDetailsAssigneeController
                            .assigneecommentController,
                        hintText: 'Comments',
                        focusNode: incidentReportDetailsAssigneeController
                            .assigneeCommentFocus,
                        onFieldSubmitted: (_) {
                          incidentReportDetailsAssigneeController
                              .assigneeCommentFocus
                              .unfocus();
                        },
                        fillColor: incidentReportDetailsAssigneeController
                                .userFound.value
                            ? AppColors.textfeildcolor
                            : Colors.white,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a comment';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]'),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: "Checker Signature",
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
                                  left: 12, right: 12, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: AppColors.textfeildcolor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  incidentReportDetailsAssigneeController
                                          .userFound.value
                                      ? SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            incidentReportDetailsAssigneeController
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
                                    height: SizeConfig.heightMultiplier * 2,
                                  ),
                                  Obx(() {
                                    if (incidentReportDetailsAssigneeController
                                        .userFound.value) {
                                      // Show saved signature image
                                      return incidentReportDetailsAssigneeController
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
                                                "$baseUrl${incidentReportDetailsAssigneeController.savedSignatureUrlfetch.value}",
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          : const Text(
                                              "No signature available");
                                    } else {
                                      // Show signature pad
                                      return Listener(
                                        key:
                                            incidentReportDetailsAssigneeController
                                                .signkey,
                                        onPointerDown: (_) {
                                          Future.delayed(
                                              Duration(milliseconds: 50), () {
                                            if (incidentReportDetailsAssigneeController
                                                .signatureCheckerController
                                                .isNotEmpty) {
                                              incidentReportDetailsAssigneeController
                                                  .signatureattestationError
                                                  .value = '';
                                            }
                                          });
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Signature(
                                            height: 206,
                                            controller:
                                                incidentReportDetailsAssigneeController
                                                    .signatureCheckerController,
                                            backgroundColor: Colors.white,
                                          ),
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
                      Obx(() => incidentReportDetailsAssigneeController
                              .signatureattestationError.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4, left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    incidentReportDetailsAssigneeController
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
                        text: 'Checker',
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
                              "$baseUrl${incidentReportDetailsAssigneeController.asgineeUserList[0].profilePhoto}",
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
                                      "${incidentReportDetailsAssigneeController.asgineeUserList[0].firstName ?? ''} "
                                      "${incidentReportDetailsAssigneeController.asgineeUserList[0].lastName ?? ''}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: incidentReportDetailsAssigneeController
                                          .asgineeUserList[0].designation ??
                                      "",
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
                        text: incidentReportDetailsAssigneeController
                                    // ignore: unnecessary_null_comparison
                                    .safetyIncidentReport[0]
                                    // ignore: unnecessary_null_comparison
                                    .createdAt !=
                                null
                            ? DateFormat('dd-MM-yyyy hh:mm a').format(
                                DateTime.parse(
                                    incidentReportDetailsAssigneeController
                                        // ignore: unnecessary_null_comparison
                                        .safetyIncidentReport[0]
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
              text: incidentReportDetailsAssigneeController.userFound.value
                  ? "Close"
                  : 'Accepted',
              onPressed: () async {
                if (incidentReportDetailsAssigneeController.userFound.value ==
                    false) {
                  validateAndFocusFirstInvalidField();
                  if (incidentReportDetailsAssigneeController
                      .signatureCheckerController.isEmpty) {
                    incidentReportDetailsAssigneeController
                        .signatureattestationError
                        .value = "Please fill in the signature.";
                  }
                  if (incidentReportDetailsAssigneeController
                          .incidentAssigneeCount <
                      1) {
                    incidentReportDetailsAssigneeController
                        .photoAssigneeError.value = "Please Add Images";
                  }
                  if (formKey.currentState!.validate()) {
                    await incidentReportDetailsAssigneeController
                        .saveIncidentAssigneeSignature();

                    if (incidentReportDetailsAssigneeController
                        .signatureCheckerController.isEmpty) {
                      incidentReportDetailsAssigneeController
                          .signatureattestationError
                          .value = "Please fill in the signature.";
                      return;
                    }
                    if (incidentReportDetailsAssigneeController
                            .signatureCheckerController.isNotEmpty &&
                        incidentReportDetailsAssigneeController
                            .assigneecommentController.text.isNotEmpty) {
                      if (await CheckInternet.checkInternet()) {
                        showConfirmationDialogClosed(context);
                      } else {
                        await showDialog(
                          context: Get.context!,
                          builder: (BuildContext context) {
                            return CustomValidationPopup(
                                message:
                                    "Please check your internet connection.");
                          },
                        );
                      }
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

  void scrollToWidget(GlobalKey key) {
    final context = key.currentContext;
    if (context != null && context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.2,
        );
      });
    }
  }

  void validateAndFocusFirstInvalidField() {
    if (incidentReportDetailsAssigneeController.incidentAssigneeCount < 1) {
      scrollToWidget(incidentReportDetailsAssigneeController.photoKey);
      return;
    }
    if (incidentReportDetailsAssigneeController.assigneecommentController.text
        .trim()
        .isEmpty) {
      incidentReportDetailsAssigneeController.assigneeCommentFocus
          .requestFocus();
      return;
    }

    if (incidentReportDetailsAssigneeController
        .signatureCheckerController.isEmpty) {
      scrollToWidget(incidentReportDetailsAssigneeController.signkey);
      return;
    }
  }
}
