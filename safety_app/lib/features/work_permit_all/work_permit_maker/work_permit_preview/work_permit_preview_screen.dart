import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/assign_checker/assign_checker_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_precaution/work_permit_precaution_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_preview/work_permit_preview_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_submit/work_submit_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkPermitPreviewScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  WorkPermitPreviewScreen({
    super.key,
    required this.userImg,
    required this.userDesg,
    required this.userId,
    required this.userName,
    required this.projectId,
  });
  final NewWorkPermitController newWorkPermitController =
      Get.put(NewWorkPermitController());

  final WorkPermitPreviewController workPermitPreviewController =
      Get.put(WorkPermitPreviewController());
  final WorkPermitController workPermitController = Get.find();

  final WorkPermitPrecautionController workPermitPrecautionController =
      Get.put(WorkPermitPrecautionController());
  final AssignCheckerController assignCheckerController =
      Get.put(AssignCheckerController());
  final LocationController locationController = Get.find();

  void showConfirmationDialogWorkPermit(BuildContext context) {
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
              text: 'Are you sure you want to submit work permit details?',
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
                    await workPermitPreviewController.safetySaveWorkPermit(
                        context, userName, userId, projectId);
                    if (workPermitPreviewController.apiStatus == true) {
                      Get.to(() => WorkSubmitScreen(
                            userId: userId,
                            userName: userName,
                            userImg: userImg,
                            userDesg: userDesg,
                            projectId: projectId,
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
                      text: 'Verify & Submit',
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.3,
                    ),
                    AppTextWidget(
                      text: 'Verify the details,',
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
                () => workPermitPreviewController.workpermitExpanded.value
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
                                    text: 'Work Permit Details',
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttoncolor,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        workPermitPreviewController
                                            .toggleExpansionWorkpermit();
                                      },
                                      child: Icon(Icons.keyboard_arrow_up)),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.widthMultiplier * 4,
                                  right: SizeConfig.widthMultiplier * 4,
                                  top: SizeConfig.heightMultiplier * 3,
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
                                      width: SizeConfig.widthMultiplier * 100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                              text: 'Name of Work Permit',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: newWorkPermitController
                                                      .nameworkpermitController
                                                      .text
                                                      .isNotEmpty
                                                  ? newWorkPermitController
                                                      .nameworkpermitController
                                                      .text
                                                  : '',
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
                                              text: 'SubActivity',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          Obx(() => AppTextWidget(
                                                text: newWorkPermitController
                                                        .selectedWorkActivity
                                                        .isNotEmpty
                                                    ? newWorkPermitController
                                                        .selectedWorkActivity
                                                        .value
                                                    : "",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              )),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text: 'Toolbox Training Number',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          Obx(() => AppTextWidget(
                                                text: newWorkPermitController
                                                        .selectedtoolboxtrainig
                                                        .isNotEmpty
                                                    ? newWorkPermitController
                                                        .selectedtoolboxtrainig
                                                        .value
                                                    : "Not available",
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              )),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text:
                                                  'Start Date & Time And End Date & Time',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: newWorkPermitController
                                                  .workDuration.value,
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
                                              text: 'Building & Floors',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          Obx(() {
                                            if (newWorkPermitController
                                                .selectedBuildingIdListFinal
                                                .isEmpty) {
                                              return SizedBox
                                                  .shrink(); // If list is empty, don't take up space
                                            }
                                            return SizedBox(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: newWorkPermitController
                                                    .selectedBuildingIdListFinal
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  final building =
                                                      newWorkPermitController
                                                              .selectedBuildingIdListFinal[
                                                          index];

                                                  // Ensure key names match the stored structure
                                                  int? id =
                                                      building['building_id']
                                                          as int?;
                                                  List<int> floorIds =
                                                      building['floor_ids'] ??
                                                          [];

                                                  if (id == null) {
                                                    log('Error: Building ID is null');
                                                    return SizedBox(); // Skip rendering for null entries
                                                  }

                                                  String buildingName =
                                                      newWorkPermitController
                                                          .getBuildingNameById(
                                                              id);
                                                  String getFloorNameById =
                                                      newWorkPermitController
                                                          .getFloorNamesByIds(
                                                              floorIds);

                                                  log('Selected ID: $id');

                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .widthMultiplier *
                                                                73,
                                                            child:
                                                                AppTextWidget(
                                                              text:
                                                                  "Selected Building : $buildingName",
                                                              fontSize: AppTextSize
                                                                  .textSizeSmall,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .widthMultiplier *
                                                                75,
                                                            child:
                                                                AppTextWidget(
                                                              text:
                                                                  "Selected Floor : ${getFloorNameById}",
                                                              fontSize: AppTextSize
                                                                  .textSizeSmall,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
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
                                  text: 'Work Permit Details',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      workPermitPreviewController
                                          .toggleExpansionWorkpermit();
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

              Obx(
                () => workPermitPreviewController
                        .isprecautionworkpermitExpanded.value
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
                                        workPermitPreviewController
                                            .toggleExpansionPrecaution();
                                      },
                                      child: Icon(Icons.keyboard_arrow_up)),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 3,
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 2),
                              Obx(() {
                                final workPermitPrecautionController =
                                    Get.find<WorkPermitPrecautionController>();

                                if (workPermitPrecautionController
                                    .selectedWorkPermitData.isEmpty) {
                                  return Center(
                                    child: AppTextWidget(
                                      text: "",
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryText,
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: workPermitPrecautionController
                                      .selectedWorkPermitData.length,
                                  itemBuilder: (context, categoryIndex) {
                                    int? categoryId =
                                        workPermitPrecautionController
                                            .selectedWorkPermitData.keys
                                            .elementAt(categoryIndex);
                                    // ignore: unnecessary_null_comparison
                                    if (categoryId == null) return SizedBox();

                                    String categoryName = workPermitController
                                            .categoryWorkList
                                            .firstWhereOrNull(
                                                (cat) => cat.id == categoryId)
                                            ?.categoryName ??
                                        "Unknown Category";

                                    List<int> detailIds =
                                        workPermitPrecautionController
                                                .selectedWorkPermitData[
                                                    categoryId]
                                                ?.toList() ??
                                            [];

                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 4,
                                        vertical:
                                            SizeConfig.heightMultiplier * 3,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 1,
                                        vertical:
                                            SizeConfig.heightMultiplier * 2,
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
                                                  text: categoryName,
                                                  fontSize: AppTextSize
                                                      .textSizeSmallm,
                                                  fontWeight: FontWeight.w500,
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
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: detailIds.length,
                                              itemBuilder:
                                                  (context, hazardIndex) {
                                                int? detailId =
                                                    detailIds[hazardIndex];
                                                // ignore: unnecessary_null_comparison
                                                if (detailId == null)
                                                  return SizedBox(); // Prevent crash

                                                String hazardName =
                                                    newWorkPermitController
                                                            .workPermitRequiredList
                                                            .firstWhereOrNull(
                                                                (det) =>
                                                                    det.id ==
                                                                    detailId)
                                                            ?.permitDetails ??
                                                        "Unknown Hazard";

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0,
                                                          top: 10),
                                                  child: AppTextWidget(
                                                    text:
                                                        "${hazardIndex + 1}. $hazardName",
                                                    fontSize: AppTextSize
                                                        .textSizeSmall,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.primaryText,
                                                  ),
                                                );
                                              }),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 3,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }),
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
                                      workPermitPreviewController
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

              //---------------------------------------------------------------------

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
                        text: 'Checker',
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryText),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Obx(
                      () {
                        // log("----------------obx: ${assignCheckerController.selectedassigneeDataIdsFinal}");
                        // log("----------------obx: ${assignCheckerController.addInvolveassigneeDataPerson}");

                        final selectedList = assignCheckerController
                            .addInvolveassigneeDataPerson;
                        log('${selectedList.length}');
                        return selectedList.isNotEmpty
                            ? Container(
                                padding: EdgeInsets.only(
                                  right: 8,
                                ),
                                height: SizeConfig.heightMultiplier * 10,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: selectedList.length,
                                  itemBuilder: (context, index) {
                                    final assgneeData = selectedList[index];

                                    return ListTile(
                                      contentPadding:
                                          EdgeInsets.only(left: 0, right: 20),
                                      // leading: CircleAvatar(
                                      //   radius: 30,
                                      //   backgroundImage: NetworkImage(
                                      //       "$baseUrl${assgneeData.profilePhoto}"),
                                      // ),
                                      leading: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 28,
                                            backgroundColor: Colors.grey
                                                .shade200, // Fallback color
                                            child: ClipOval(
                                              child: Image.network(
                                                "$baseUrl${assgneeData.profilePhoto}",
                                                fit: BoxFit.cover,
                                                width:
                                                    56, // Diameter = radius * 2
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
                                      title: AppTextWidget(
                                        text: assgneeData.firstName.toString(),
                                        fontSize: AppTextSize.textSizeSmallm,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryText,
                                      ),
                                      subtitle: AppTextWidget(
                                        text:
                                            assgneeData.designation.toString(),
                                        fontSize: AppTextSize.textSizeSmalle,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.secondaryText,
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
                    AppTextWidget(
                        text: 'Maker',
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
                            backgroundImage: userImg.isNotEmpty
                                ? NetworkImage("$baseUrl${userImg}")
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
                height: 20,
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 2.5,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.offUntil(
                    GetPageRoute(
                        page: () => NewWorkPermitScreen(
                              userId: userId,
                              userName: userName,
                              userImg: userImg,
                              userDesg: userDesg,
                              projectId: projectId,
                            )),
                    (route) {
                      if (route is GetPageRoute) {
                        return route.page!().runtimeType == WorkPermitScreen;
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
                  showConfirmationDialogWorkPermit(
                      context); // Call the function
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

  String getFormattedDateTime() {
    final now = DateTime.now();
    final formatter =
        DateFormat('dd MMM yyyy hh:mm a'); // Format: 06 Oct 2024 11:14 AM
    return formatter.format(now);
  }
}
