import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_all/safety_violation_details_cotroller.dart';

import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SafetyViolationDetailsAll extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int safetyId;
  SafetyViolationDetailsAll({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
    required this.safetyId,
  });

  final SafetyViolationDetailsCotroller safetyViolationDetailsCotroller =
      Get.put(SafetyViolationDetailsCotroller());
  final LocationController locationController = Get.find();

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
              Obx(() => safetyViolationDetailsCotroller
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
                                      safetyViolationDetailsCotroller
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
                                                text: 'Violation Type',
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
                                              text: safetyViolationDetailsCotroller
                                                          .violationType[0]
                                                          .safetyDetails !=
                                                      null
                                                  ? safetyViolationDetailsCotroller
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.5,
                                            ),
                                            AppTextWidget(
                                                text: 'Category',
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
                                              text: safetyViolationDetailsCotroller
                                                          .category[0]
                                                          .safetyDetails !=
                                                      null
                                                  ? safetyViolationDetailsCotroller
                                                      .category[0].safetyDetails
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
                                                      1.5,
                                            ),
                                            AppTextWidget(
                                                text: 'Location of breach',
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
                                              text: safetyViolationDetailsCotroller
                                                          .violationDebitNote[0]
                                                          .locationOfBreach !=
                                                      null
                                                  ? safetyViolationDetailsCotroller
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.5,
                                            ),
                                            AppTextWidget(
                                                text: 'Risk Level',
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
                                                text: safetyViolationDetailsCotroller
                                                            .riskLevel[0]
                                                            .safetyDetails !=
                                                        null
                                                    ? safetyViolationDetailsCotroller
                                                        .riskLevel[0]
                                                        .safetyDetails
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
                                                text: 'Turn Around Time',
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
                                              text: safetyViolationDetailsCotroller
                                                          .violationDebitNote[0]
                                                          // ignore: unnecessary_null_comparison
                                                          .turnAroundTime !=
                                                      null
                                                  ? safetyViolationDetailsCotroller
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.2,
                                            ),
                                            AppTextWidget(
                                                text: 'Source of Observation',
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
                                              text: safetyViolationDetailsCotroller
                                                          .sourceOfObservation[
                                                              0]
                                                          .safetyDetails !=
                                                      null
                                                  ? safetyViolationDetailsCotroller
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
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1.5,
                                            ),
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
                                  AppTextWidget(
                                      text: 'Photos',
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.searchfeild),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 1.5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                      safetyViolationDetailsCotroller
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
                                                                if (safetyViolationDetailsCotroller
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
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            child:
                                                                                Image.network(
                                                                              "$baseUrl${safetyViolationDetailsCotroller.photos[index].photoPath.toString()}",
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
                                                                  child: (safetyViolationDetailsCotroller
                                                                          .photos[
                                                                              index]
                                                                          .photoPath!
                                                                          .isNotEmpty
                                                                      // ignore: unnecessary_null_comparison
                                                                      )
                                                                      ? Image
                                                                          .network(
                                                                          "$baseUrl${safetyViolationDetailsCotroller.photos[index].photoPath.toString()}",
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        )
                                                                      : Image
                                                                          .asset(
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
                                    safetyViolationDetailsCotroller
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
                () => safetyViolationDetailsCotroller.isinvolvepeople.value
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
                                        safetyViolationDetailsCotroller
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
                                decoration: (safetyViolationDetailsCotroller
                                            .involvedLaboursList.isNotEmpty ||
                                        safetyViolationDetailsCotroller
                                            .involvedStaffList.isNotEmpty ||
                                        safetyViolationDetailsCotroller
                                            .involvedContractorUserList
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
                                    safetyViolationDetailsCotroller
                                            .involvedLaboursList.isNotEmpty
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

                                    safetyViolationDetailsCotroller
                                            .involvedLaboursList.isNotEmpty
                                        ? SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          )
                                        : SizedBox(),

                                    safetyViolationDetailsCotroller
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
                                            height:
                                                safetyViolationDetailsCotroller
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
                                                    safetyViolationDetailsCotroller
                                                        .scrollLabourController,
                                                itemCount:
                                                    safetyViolationDetailsCotroller
                                                            .involvedLaboursList
                                                            .isNotEmpty
                                                        ? safetyViolationDetailsCotroller
                                                            .involvedLaboursList
                                                            .length
                                                        : 0,
                                                itemBuilder: (context, index) {
                                                  final labour =
                                                      safetyViolationDetailsCotroller
                                                              .involvedLaboursList[
                                                          index];

                                                  return ListTile(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 0, right: 20),
                                                    leading: CircleAvatar(
                                                      radius: 22,
                                                      backgroundImage: NetworkImage(
                                                          "$baseUrl${labour.userPhoto}"),
                                                    ),
                                                    title: AppTextWidget(
                                                      text: labour.labourName
                                                          .toString(),
                                                      fontSize: AppTextSize
                                                          .textSizeSmall,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColors.primaryText,
                                                    ),
                                                    subtitle: AppTextWidget(
                                                      text: labour.contactNumber
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

                                    safetyViolationDetailsCotroller
                                            .involvedLaboursList.isNotEmpty
                                        ? SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 4,
                                          )
                                        : SizedBox(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        AppTextWidget(
                                          text: 'Select Staff',
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryText,
                                        ),
                                      ],
                                    ),

                                    safetyViolationDetailsCotroller
                                            .involvedLaboursList.isNotEmpty
                                        ? SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          )
                                        : SizedBox(),

                                    safetyViolationDetailsCotroller
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
                                                safetyViolationDetailsCotroller
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
                                                    safetyViolationDetailsCotroller
                                                        .scrollStaffController,
                                                itemCount:
                                                    safetyViolationDetailsCotroller
                                                        .involvedStaffList
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  final entry =
                                                      safetyViolationDetailsCotroller
                                                          .involvedStaffList
                                                          .entries
                                                          .elementAt(index);
                                                  final staff = entry.value;

                                                  return ListTile(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 0, right: 20),
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
                                                      color:
                                                          AppColors.primaryText,
                                                    ),
                                                    subtitle: AppTextWidget(
                                                      text:
                                                          staff.contactNumber ??
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

                                    safetyViolationDetailsCotroller
                                                .involvedContractorUserList
                                                .isNotEmpty ||
                                            safetyViolationDetailsCotroller
                                                    // ignore: unnecessary_null_comparison
                                                    .involvedContractorUserList !=
                                                null
                                        ? SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
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
                                          text: 'Select Contractor',
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryText,
                                        ),
                                      ],
                                    ),

                                    safetyViolationDetailsCotroller
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
                                                    left: 8, right: 8, top: 8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.7,
                                                      color: AppColors
                                                          .searchfeildcolor),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                height: safetyViolationDetailsCotroller
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
                                                        safetyViolationDetailsCotroller
                                                            .scrollContractorController,
                                                    itemCount:
                                                        safetyViolationDetailsCotroller
                                                            .involvedContractorUserList
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final entry =
                                                          safetyViolationDetailsCotroller
                                                              .involvedContractorUserList
                                                              .entries
                                                              .elementAt(index);
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
                                                        subtitle: AppTextWidget(
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
                                      safetyViolationDetailsCotroller
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
                () => safetyViolationDetailsCotroller.isinformedpeople.value
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
                                        safetyViolationDetailsCotroller
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
                                decoration: safetyViolationDetailsCotroller
                                        .informedPersonsList.isNotEmpty
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
                                    safetyViolationDetailsCotroller
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
                                            height:
                                                safetyViolationDetailsCotroller
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
                                                    safetyViolationDetailsCotroller
                                                        .scrolldataController,
                                                itemCount:
                                                    safetyViolationDetailsCotroller
                                                            .informedPersonsList
                                                            .isNotEmpty
                                                        ? safetyViolationDetailsCotroller
                                                            .informedPersonsList
                                                            .length
                                                        : 0,
                                                itemBuilder: (context, index) {
                                                  final assgneeInformed =
                                                      safetyViolationDetailsCotroller
                                                              .informedPersonsList[
                                                          index];

                                                  return ListTile(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 0, right: 20),
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
                                                      color:
                                                          AppColors.primaryText,
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
                                      safetyViolationDetailsCotroller
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

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 3,
                ),
                width: SizeConfig.widthMultiplier * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                      Colors.grey.shade200, // Fallback color
                                  child: ClipOval(
                                    child: Image.network(
                                      "$baseUrl${safetyViolationDetailsCotroller.asgineeUserList[0].profilePhoto}",
                                      fit: BoxFit.cover,
                                      width: 56, // Diameter = radius * 2
                                      height: 56,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
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

                            //  Image.network(
                            //   "$baseUrl${safetyViolationDetailsCotroller.asgineeUserList[0].profilePhoto}",
                            //   fit: BoxFit.contain,
                            // ),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 3,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                  text:
                                      "${safetyViolationDetailsCotroller.asgineeUserList[0].firstName} "
                                      "${safetyViolationDetailsCotroller.asgineeUserList[0].lastName}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: safetyViolationDetailsCotroller
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
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Column(
                  children: [
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

                      controller: safetyViolationDetailsCotroller
                          .incidentAssigneeAllController,
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
                      height: SizeConfig.heightMultiplier * 2,
                    ),
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
                            "$baseUrl${safetyViolationDetailsCotroller.asginerUserList[0].profilePhoto}",
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
                                    "${safetyViolationDetailsCotroller.asginerUserList[0].firstName} "
                                    "${safetyViolationDetailsCotroller.asginerUserList[0].lastName}",
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText),
                            AppTextWidget(
                                text: safetyViolationDetailsCotroller
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
                      enabled: false,
                      controller: safetyViolationDetailsCotroller
                          .incidentAssigneeAssignorController,
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
                      text: safetyViolationDetailsCotroller
                                  .violationDebitNote
                                  // ignore: unnecessary_null_comparison
                                  [0]
                                  // ignore: unnecessary_null_comparison
                                  .createdAt !=
                              null
                          ? DateFormat('dd-MM-yyyy hh:mm a').format(
                              DateTime.parse(safetyViolationDetailsCotroller
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
              text: 'Close',
              onPressed: () async {
                Get.back();
              }),
        ),
      ),
    );
  }
}
