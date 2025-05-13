import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_submit/safety_submit_closed_screen.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_assignor/safety_violation_details_assignor_cont.dart';

import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class SafetyViolationDetailsAssignor extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int safetyId;
  final String uniqueId;
  SafetyViolationDetailsAssignor({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
    required this.safetyId,
    required this.uniqueId,
  });

  final SafetyViolationDetailsAssignorCont safetyViolationDetailsAssignorCont =
      Get.put(SafetyViolationDetailsAssignorCont());
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
              text: 'Are you sure you want to close Safety violation?',
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
                    await safetyViolationDetailsAssignorCont
                        .safetyViolationSaveAssignorComment(
                            context, safetyId, 2);
                    if (safetyViolationDetailsAssignorCont.apiStatus == true) {
                      Get.to(SafetySubmitClosedScreen(
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
                Obx(() => safetyViolationDetailsAssignorCont
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
                                        safetyViolationDetailsAssignorCont
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
                                                text: safetyViolationDetailsAssignorCont
                                                            .violationType[0]
                                                            .safetyDetails !=
                                                        null
                                                    ? safetyViolationDetailsAssignorCont
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
                                                text: safetyViolationDetailsAssignorCont
                                                            .category[0]
                                                            .safetyDetails !=
                                                        null
                                                    ? safetyViolationDetailsAssignorCont
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
                                                text: safetyViolationDetailsAssignorCont
                                                            .violationDebitNote[
                                                                0]
                                                            .locationOfBreach !=
                                                        null
                                                    ? safetyViolationDetailsAssignorCont
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
                                                  text: safetyViolationDetailsAssignorCont
                                                              .riskLevel[0]
                                                              .safetyDetails !=
                                                          null
                                                      ? safetyViolationDetailsAssignorCont
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
                                                text: safetyViolationDetailsAssignorCont
                                                            .violationDebitNote[0]
                                                            // ignore: unnecessary_null_comparison
                                                            .turnAroundTime !=
                                                        null
                                                    ? safetyViolationDetailsAssignorCont
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
                                                text: safetyViolationDetailsAssignorCont
                                                            .sourceOfObservation[
                                                                0]
                                                            .safetyDetails !=
                                                        null
                                                    ? safetyViolationDetailsAssignorCont
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
                                                        safetyViolationDetailsAssignorCont
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
                                                                  if (safetyViolationDetailsAssignorCont
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
                                                                                "$baseUrl${safetyViolationDetailsAssignorCont.photos[index].photoPath.toString()}",
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
                                                                    child: (safetyViolationDetailsAssignorCont
                                                                            .photos[
                                                                                index]
                                                                            .photoPath!
                                                                            .isNotEmpty
                                                                        // ignore: unnecessary_null_comparison
                                                                        )
                                                                        ? Image
                                                                            .network(
                                                                            "$baseUrl${safetyViolationDetailsAssignorCont.photos[index].photoPath.toString()}",
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
                                      safetyViolationDetailsAssignorCont
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
                  () => safetyViolationDetailsAssignorCont.isinvolvepeople.value
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
                                          safetyViolationDetailsAssignorCont
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
                                      (safetyViolationDetailsAssignorCont
                                                  .involvedLaboursList
                                                  .isNotEmpty ||
                                              safetyViolationDetailsAssignorCont
                                                  .involvedStaffList
                                                  .isNotEmpty ||
                                              safetyViolationDetailsAssignorCont
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
                                      safetyViolationDetailsAssignorCont
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

                                      safetyViolationDetailsAssignorCont
                                              .involvedLaboursList.isNotEmpty
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            )
                                          : SizedBox(),

                                      safetyViolationDetailsAssignorCont
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
                                              height: safetyViolationDetailsAssignorCont
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
                                                      safetyViolationDetailsAssignorCont
                                                          .scrollLabourController,
                                                  itemCount: safetyViolationDetailsAssignorCont
                                                          .involvedLaboursList
                                                          .isNotEmpty
                                                      ? safetyViolationDetailsAssignorCont
                                                          .involvedLaboursList
                                                          .length
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final labour =
                                                        safetyViolationDetailsAssignorCont
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

                                      safetyViolationDetailsAssignorCont
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

                                      safetyViolationDetailsAssignorCont
                                              .involvedLaboursList.isNotEmpty
                                          ? SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            )
                                          : SizedBox(),

                                      safetyViolationDetailsAssignorCont
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
                                                  safetyViolationDetailsAssignorCont
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
                                                      safetyViolationDetailsAssignorCont
                                                          .scrollStaffController,
                                                  itemCount:
                                                      safetyViolationDetailsAssignorCont
                                                          .involvedStaffList
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final entry =
                                                        safetyViolationDetailsAssignorCont
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
                                                          "$baseUrl${staff.userPhoto}",
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

                                      safetyViolationDetailsAssignorCont
                                                  .involvedContractorUserList
                                                  .isNotEmpty ||
                                              safetyViolationDetailsAssignorCont
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

                                      safetyViolationDetailsAssignorCont
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
                                                  height: safetyViolationDetailsAssignorCont
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
                                                          safetyViolationDetailsAssignorCont
                                                              .scrollContractorController,
                                                      itemCount:
                                                          safetyViolationDetailsAssignorCont
                                                              .involvedContractorUserList
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final entry =
                                                            safetyViolationDetailsAssignorCont
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
                                        safetyViolationDetailsAssignorCont
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
                  () => safetyViolationDetailsAssignorCont
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
                                          safetyViolationDetailsAssignorCont
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
                                  decoration: safetyViolationDetailsAssignorCont
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
                                      safetyViolationDetailsAssignorCont
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
                                              height: safetyViolationDetailsAssignorCont
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
                                                      safetyViolationDetailsAssignorCont
                                                          .scrolldataController,
                                                  itemCount: safetyViolationDetailsAssignorCont
                                                          .informedPersonsList
                                                          .isNotEmpty
                                                      ? safetyViolationDetailsAssignorCont
                                                          .informedPersonsList
                                                          .length
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final assgneeInformed =
                                                        safetyViolationDetailsAssignorCont
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
                                        safetyViolationDetailsAssignorCont
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
                              "$baseUrl${safetyViolationDetailsAssignorCont.asgineeUserList[0].profilePhoto}",
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
                                      "${safetyViolationDetailsAssignorCont.asgineeUserList[0].firstName} "
                                      "${safetyViolationDetailsAssignorCont.asgineeUserList[0].lastName}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: safetyViolationDetailsAssignorCont
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
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2.5,
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
                        enabled: false,
                        controller: safetyViolationDetailsAssignorCont
                            .assigneecommentController,
                        hintText: 'Comments',
                        // focusNode: newWorkPermitController.dow,
                        // onFieldSubmitted: (_) {
                        //   newWorkPermitController.dow.unfocus();
                        // },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter a comment';
                        //   }
                        //   return null;
                        // },
                        onChanged: (value) {},
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
                                            safetyViolationDetailsAssignorCont
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
                                                      if (safetyViolationDetailsAssignorCont
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
                                                                    "$baseUrl${safetyViolationDetailsAssignorCont.asgineeAddPhotos[index].photoPath.toString()}",
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
                                                        child: (safetyViolationDetailsAssignorCont
                                                                .asgineeAddPhotos[
                                                                    index]
                                                                .photoPath!
                                                                .isNotEmpty
                                                            // ignore: unnecessary_null_comparison
                                                            )
                                                            ? Image.network(
                                                                "$baseUrl${safetyViolationDetailsAssignorCont.asgineeAddPhotos[index].photoPath.toString()}",
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
                              "$baseUrl${safetyViolationDetailsAssignorCont.asginerUserList[0].profilePhoto}",
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
                                      "${safetyViolationDetailsAssignorCont.asginerUserList[0].firstName} "
                                      "${safetyViolationDetailsAssignorCont.asginerUserList[0].lastName}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: safetyViolationDetailsAssignorCont
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
                        enabled:
                            !safetyViolationDetailsAssignorCont.userFound.value,
                        controller: safetyViolationDetailsAssignorCont
                            .assignorcommentController,
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
                                  left: 12, right: 12, top: 20, bottom: 20),
                              height: 305,
                              decoration: BoxDecoration(
                                color: AppColors.textfeildcolor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  safetyViolationDetailsAssignorCont
                                          .userFound.value
                                      ? SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            safetyViolationDetailsAssignorCont
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
                                    if (safetyViolationDetailsAssignorCont
                                        .userFound.value) {
                                      // Show saved signature image
                                      return safetyViolationDetailsAssignorCont
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
                                                "$baseUrl${safetyViolationDetailsAssignorCont.savedSignatureUrlfetch.value}",
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
                                              safetyViolationDetailsAssignorCont
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
                      Obx(() => safetyViolationDetailsAssignorCont
                              .signatureattestationError.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4, left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    safetyViolationDetailsAssignorCont
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

                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Container(
                  width: SizeConfig.widthMultiplier * 100,
                  height: 1.5,
                  color: AppColors.searchfeildcolor,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
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
                              "$baseUrl${safetyViolationDetailsAssignorCont.asginerUserList[0].profilePhoto}",
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
                                      "${safetyViolationDetailsAssignorCont.asginerUserList[0].firstName} "
                                      "${safetyViolationDetailsAssignorCont.asginerUserList[0].lastName}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: safetyViolationDetailsAssignorCont
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
                        text: safetyViolationDetailsAssignorCont
                                    .violationDebitNote
                                    // ignore: unnecessary_null_comparison
                                    [0]
                                    // ignore: unnecessary_null_comparison
                                    .createdAt !=
                                null
                            ? DateFormat('dd-MM-yyyy hh:mm a').format(
                                DateTime.parse(
                                    safetyViolationDetailsAssignorCont
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
                text: safetyViolationDetailsAssignorCont.userFound.value
                    ? "Closed"
                    : 'Submit',
                onPressed: () async {
                  if (safetyViolationDetailsAssignorCont.userFound.value ==
                      false) {
                    if (formKey.currentState!.validate()) {
                      await safetyViolationDetailsAssignorCont
                          .saveIncidentAssigneeSignature();

                      if (safetyViolationDetailsAssignorCont
                          .signatureCheckerController.isEmpty) {
                        safetyViolationDetailsAssignorCont
                            .signatureattestationError
                            .value = "Please fill in the signature.";
                        return;
                      }
                      if (safetyViolationDetailsAssignorCont
                              .signatureCheckerController.isNotEmpty &&
                          safetyViolationDetailsAssignorCont
                              .assignorcommentController.text.isNotEmpty) {
                        showConfirmationDialogClosed(context);
                      }
                    }
                    //   Get.to(WorkPermitPrecautionScreen());
                  } else {
                    Get.back();
                  }
                })),
      ),
    );
  }
}
