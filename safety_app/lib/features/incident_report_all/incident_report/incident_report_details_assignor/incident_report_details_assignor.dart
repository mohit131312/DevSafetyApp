import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/incident_report_all/incedent_report_submit_closed/incident_report_submit_closed.dart';

import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_details_assignor/incident_report_details_assignor_cotroller.dart';

import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class IncidentReportDetailsAssignor extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int incidentId;
  final String uniqueId;
  IncidentReportDetailsAssignor({
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

  final IncidentReportDetailsAssignorCotroller
      incidentReportDetailsAssignorCotroller =
      Get.put(IncidentReportDetailsAssignorCotroller());
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
              text: 'Are you sure you want to close Incident Report?',
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
                    await incidentReportDetailsAssignorCotroller
                        .safetySaveIncidentAssignorComment(
                            context, incidentId, 2);
                    if (incidentReportDetailsAssignorCotroller.apiStatus ==
                        true) {
                      Get.to(IncidentReportSubmitClosed(
                          userId: userId,
                          projectId: projectId,
                          incidentId: incidentId,
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
                        height: SizeConfig.heightMultiplier * 0.8,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: "Incident Report Unique ID :  ",
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                          AppTextWidget(
                            text: incidentReportDetailsAssignorCotroller
                                .safetyIncidentReport[0].uniqueId
                                .toString(),
                            fontSize: AppTextSize.textSizeSmalle,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText,
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //---------------------------------------------------------------------

                //-----------------------------------------------------------------
                Obx(() => incidentReportDetailsAssignorCotroller
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
                                        incidentReportDetailsAssignorCotroller
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
                                                        incidentReportDetailsAssignorCotroller
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
                                                      //           "$baseUrl${incidentReportDetailsAssignorCotroller.photos[index].photoPath.toString()}",
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
                                                                  if (incidentReportDetailsAssignorCotroller
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
                                                                                "$baseUrl${incidentReportDetailsAssignorCotroller.photos[index].photoPath.toString()}",
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
                                                                    child: (incidentReportDetailsAssignorCotroller
                                                                            .photos[
                                                                                index]
                                                                            .photoPath!
                                                                            .isNotEmpty
                                                                        // ignore: unnecessary_null_comparison
                                                                        )
                                                                        ? Image
                                                                            .network(
                                                                            "$baseUrl${incidentReportDetailsAssignorCotroller.photos[index].photoPath.toString()}",
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
                                                text: incidentReportDetailsAssignorCotroller
                                                            .buildingList[0]
                                                            .buildingName !=
                                                        null
                                                    ? incidentReportDetailsAssignorCotroller
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
                                                text: incidentReportDetailsAssignorCotroller
                                                            .contractorCompany[
                                                                0]
                                                            .contractorCompanyName !=
                                                        null
                                                    ? incidentReportDetailsAssignorCotroller
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
                                                  text: incidentReportDetailsAssignorCotroller
                                                              .safetyIncidentReport[
                                                                  0]
                                                              .rootCause !=
                                                          null
                                                      ? incidentReportDetailsAssignorCotroller
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
                                                    incidentReportDetailsAssignorCotroller
                                                                .floorAreaOfWork[
                                                                    0]
                                                                // ignore: unnecessary_null_comparison
                                                                .floorName !=
                                                            null
                                                        ? incidentReportDetailsAssignorCotroller
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
                                                text: incidentReportDetailsAssignorCotroller
                                                            .severityLevel[0]
                                                            .incidentDetails !=
                                                        null
                                                    ? incidentReportDetailsAssignorCotroller
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
                                                  text: incidentReportDetailsAssignorCotroller
                                                              .safetyIncidentReport[
                                                                  0]
                                                              .incidentDetails !=
                                                          null
                                                      ? incidentReportDetailsAssignorCotroller
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
                                      incidentReportDetailsAssignorCotroller
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
                  () => incidentReportDetailsAssignorCotroller
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
                                          incidentReportDetailsAssignorCotroller
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
                                  decoration: (incidentReportDetailsAssignorCotroller
                                              .involvedLaboursList.isNotEmpty ||
                                          incidentReportDetailsAssignorCotroller
                                              .involvedStaffList.isNotEmpty ||
                                          incidentReportDetailsAssignorCotroller
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

                                      incidentReportDetailsAssignorCotroller
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

                                      incidentReportDetailsAssignorCotroller
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
                                              height: incidentReportDetailsAssignorCotroller
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
                                                      incidentReportDetailsAssignorCotroller
                                                          .scrollLabourController,
                                                  itemCount: incidentReportDetailsAssignorCotroller
                                                          .involvedLaboursList
                                                          .isNotEmpty
                                                      ? incidentReportDetailsAssignorCotroller
                                                          .involvedLaboursList
                                                          .length
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final labour =
                                                        incidentReportDetailsAssignorCotroller
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

                                      incidentReportDetailsAssignorCotroller
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

                                      incidentReportDetailsAssignorCotroller
                                              .involvedLaboursList.isNotEmpty
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            )
                                          : SizedBox(),

                                      incidentReportDetailsAssignorCotroller
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
                                                  incidentReportDetailsAssignorCotroller
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
                                                      incidentReportDetailsAssignorCotroller
                                                          .scrollStaffController,
                                                  itemCount:
                                                      incidentReportDetailsAssignorCotroller
                                                          .involvedStaffList
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    // final entry =
                                                    //     incidentReportDetailsAssignorCotroller
                                                    //         .involvedStaffList
                                                    //         .entries
                                                    //         .elementAt(index);
                                                    final staff =
                                                        incidentReportDetailsAssignorCotroller
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

                                      incidentReportDetailsAssignorCotroller
                                                  .involvedContractorUserList
                                                  .isNotEmpty ||
                                              incidentReportDetailsAssignorCotroller
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

                                      incidentReportDetailsAssignorCotroller
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
                                                  height: incidentReportDetailsAssignorCotroller
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
                                                          incidentReportDetailsAssignorCotroller
                                                              .scrollContractorController,
                                                      itemCount:
                                                          incidentReportDetailsAssignorCotroller
                                                              .involvedContractorUserList
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        // final entry =
                                                        //     incidentReportDetailsAssignorCotroller
                                                        //         .involvedContractorUserList
                                                        //         .entries
                                                        //         .elementAt(
                                                        //             index);
                                                        final contractor =
                                                            incidentReportDetailsAssignorCotroller
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
                                        incidentReportDetailsAssignorCotroller
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
                  () => incidentReportDetailsAssignorCotroller
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
                                          incidentReportDetailsAssignorCotroller
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
                                      incidentReportDetailsAssignorCotroller
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
                                      incidentReportDetailsAssignorCotroller
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
                                              height: incidentReportDetailsAssignorCotroller
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
                                                      incidentReportDetailsAssignorCotroller
                                                          .scrolldataController,
                                                  itemCount: incidentReportDetailsAssignorCotroller
                                                          .informedPersonsList
                                                          .isNotEmpty
                                                      ? incidentReportDetailsAssignorCotroller
                                                          .informedPersonsList
                                                          .length
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final assgneeInformed =
                                                        incidentReportDetailsAssignorCotroller
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
                                        incidentReportDetailsAssignorCotroller
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
                  () => incidentReportDetailsAssignorCotroller
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
                                          incidentReportDetailsAssignorCotroller
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
                                      incidentReportDetailsAssignorCotroller
                                              .preventionMeasures.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                incidentReportDetailsAssignorCotroller
                                                    .preventionMeasures.length,
                                                (index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: SizeConfig
                                                                .heightMultiplier *
                                                            1.5),
                                                    child: AppTextWidget(
                                                      text:
                                                          "${index + 1}. ${incidentReportDetailsAssignorCotroller.preventionMeasures[index].incidentDetails}", // Adjust the field you want to display from InformedPersonsList
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
                                        incidentReportDetailsAssignorCotroller
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
                              "$baseUrl${incidentReportDetailsAssignorCotroller.asgineeUserList[0].profilePhoto}",
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
                                      "${incidentReportDetailsAssignorCotroller.asgineeUserList[0].firstName ?? ''} "
                                      "${incidentReportDetailsAssignorCotroller.asgineeUserList[0].lastName ?? ''}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: incidentReportDetailsAssignorCotroller
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
                        enabled: false,
                        controller: incidentReportDetailsAssignorCotroller
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
                        fillColor: AppColors.textfeildcolor,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2.5,
                      ),
                      AppTextWidget(
                          text: 'Photos',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1.5,
                      ),
                      Column(
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
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            incidentReportDetailsAssignorCotroller
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
                                                      if (incidentReportDetailsAssignorCotroller
                                                          .asgineeAddPhotos
                                                          .isNotEmpty) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Dialog(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child:
                                                                  InteractiveViewer(
                                                                panEnabled:
                                                                    true,
                                                                minScale: 0.5,
                                                                maxScale: 3.0,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child: Image
                                                                      .network(
                                                                    "$baseUrl${incidentReportDetailsAssignorCotroller.asgineeAddPhotos[index].photoPath.toString()}",
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
                                                                .circular(10),
                                                        child: (incidentReportDetailsAssignorCotroller
                                                                .asgineeAddPhotos[
                                                                    index]
                                                                .photoPath!
                                                                .isNotEmpty
                                                            // ignore: unnecessary_null_comparison
                                                            )
                                                            ? Image.network(
                                                                "$baseUrl${incidentReportDetailsAssignorCotroller.asgineeAddPhotos[index].photoPath.toString()}",
                                                                fit: BoxFit
                                                                    .contain,
                                                              )
                                                            : Image.asset(""),
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
                          ]),
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

                //---------------------------------
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
                              "$baseUrl${incidentReportDetailsAssignorCotroller.asginerUserList[0].profilePhoto}",
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
                                      "${incidentReportDetailsAssignorCotroller.asginerUserList[0].firstName ?? ''} "
                                      "${incidentReportDetailsAssignorCotroller.asginerUserList[0].lastName ?? ''}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: incidentReportDetailsAssignorCotroller
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
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2.5,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: 'Assignor Comments',
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
                        enabled: !incidentReportDetailsAssignorCotroller
                            .userFound.value,
                        controller: incidentReportDetailsAssignorCotroller
                            .assignorcommentController,
                        hintText: 'Comments',
                        focusNode: incidentReportDetailsAssignorCotroller
                            .assignorcommentFocusnode,
                        onFieldSubmitted: (_) {
                          incidentReportDetailsAssignorCotroller
                              .assignorcommentFocusnode
                              .unfocus();
                        },
                        fillColor: incidentReportDetailsAssignorCotroller
                                .userFound.value
                            ? AppColors.textfeildcolor
                            : Colors.white,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]'),
                          ),
                        ],
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
                        height: SizeConfig.heightMultiplier * 2.5,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: "Assignor Signature",
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
                                  incidentReportDetailsAssignorCotroller
                                          .userFound.value
                                      ? SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            incidentReportDetailsAssignorCotroller
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
                                    if (incidentReportDetailsAssignorCotroller
                                        .userFound.value) {
                                      // Show saved signature image
                                      return incidentReportDetailsAssignorCotroller
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
                                                "$baseUrl${incidentReportDetailsAssignorCotroller.savedSignatureUrlfetch.value}",
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          : const Text(
                                              "No signature available");
                                    } else {
                                      // Show signature pad
                                      return Listener(
                                        key:
                                            incidentReportDetailsAssignorCotroller
                                                .signkey,
                                        onPointerDown: (_) {
                                          Future.delayed(
                                              Duration(milliseconds: 50), () {
                                            if (incidentReportDetailsAssignorCotroller
                                                .signatureCheckerController
                                                .isNotEmpty) {
                                              incidentReportDetailsAssignorCotroller
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
                                                incidentReportDetailsAssignorCotroller
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
                      Obx(() => incidentReportDetailsAssignorCotroller
                              .signatureattestationError.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4, left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    incidentReportDetailsAssignorCotroller
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
                        text: incidentReportDetailsAssignorCotroller
                                    // ignore: unnecessary_null_comparison
                                    .safetyIncidentReport[0]
                                    // ignore: unnecessary_null_comparison
                                    .createdAt !=
                                null
                            ? DateFormat('dd-MM-yyyy hh:mm a').format(
                                DateTime.parse(
                                    incidentReportDetailsAssignorCotroller
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
              text: incidentReportDetailsAssignorCotroller.userFound.value
                  ? "Close"
                  : 'Close the Incident Report',
              onPressed: () async {
                if (incidentReportDetailsAssignorCotroller.userFound.value ==
                    false) {
                  validateAndFocusFirstInvalidField();
                  if (incidentReportDetailsAssignorCotroller
                      .signatureCheckerController.isEmpty) {
                    incidentReportDetailsAssignorCotroller
                        .signatureattestationError
                        .value = "Please fill in the signature.";
                  }
                  if (formKey.currentState!.validate()) {
                    await incidentReportDetailsAssignorCotroller
                        .saveIncidentAssigneeSignature();

                    if (incidentReportDetailsAssignorCotroller
                        .signatureCheckerController.isEmpty) {
                      incidentReportDetailsAssignorCotroller
                          .signatureattestationError
                          .value = "Please fill in the signature.";
                      return;
                    }
                    if (incidentReportDetailsAssignorCotroller
                            .signatureCheckerController.isNotEmpty &&
                        incidentReportDetailsAssignorCotroller
                            .assignorcommentController.text.isNotEmpty) {
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
    if (incidentReportDetailsAssignorCotroller.assignorcommentController.text
        .trim()
        .isEmpty) {
      incidentReportDetailsAssignorCotroller.assignorcommentFocusnode
          .requestFocus();
      return;
    }
    if (incidentReportDetailsAssignorCotroller
        .signatureCheckerController.isEmpty) {
      scrollToWidget(incidentReportDetailsAssignorCotroller.signkey);
      return;
    }
  }
}
