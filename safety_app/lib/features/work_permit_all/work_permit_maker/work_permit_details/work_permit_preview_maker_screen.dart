import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_details/work_permit_preview_maker_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_submit_closed/work_submit_closed_screen.dart';
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

class WorkPermitPreviewMakerScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;
  final int wpId;

  WorkPermitPreviewMakerScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
    required this.wpId,
  });
  final WorkPermitPreviewMakerController workPermitPreviewMakerController =
      Get.put(WorkPermitPreviewMakerController());
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
              text: 'Are you sure you want to close work permit?',
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
                    await workPermitPreviewMakerController
                        .safetySaveWorkPermitComment(context, wpId);
                    if (workPermitPreviewMakerController.apiStatus == true) {
                      Get.to(() => WorkSubmitClosedScreen(
                            userId: userId,
                            projectId: projectId,
                            wpId: wpId,
                            uniqueId: workPermitPreviewMakerController
                                    .workPermitsMakerDetails[0].uniqueId
                                    ?.toString() ??
                                '0',
                          ));
                    }

                    //      Get.to(WorkSubmitClosedScreen());
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              text: 'Work Permit',
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
                        text: 'Work Permit Details',
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
                        height: SizeConfig.heightMultiplier * 0.8,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: "Work Permit Unique ID :  ",
                            fontSize: AppTextSize.textSizeSmallm,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                          AppTextWidget(
                            text: workPermitPreviewMakerController
                                .workPermitsMakerDetails[0].uniqueId
                                .toString(),
                            fontSize: AppTextSize.textSizeSmall,
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
                Obx(
                  () => workPermitPreviewMakerController
                          .workpermitExpanded.value
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
                                          workPermitPreviewMakerController
                                              .toggleExpansionWorkpermit();
                                        },
                                        child: Icon(Icons.keyboard_arrow_up)),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 2,
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
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: workPermitPreviewMakerController
                                                        .workPermitsMakerDetails[
                                                            0]
                                                        .nameOfWorkpermit
                                                        .isNotEmpty
                                                    ? workPermitPreviewMakerController
                                                        .workPermitsMakerDetails[
                                                            0]
                                                        .nameOfWorkpermit
                                                    : '-',
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
                                                    'SubActivity of Work Permit',
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
                                              text: workPermitPreviewMakerController
                                                      .subActivityWPMakerDetails[
                                                          0]
                                                      .subActivityName
                                                      .isNotEmpty
                                                  ? workPermitPreviewMakerController
                                                      .subActivityWPMakerDetails[
                                                          0]
                                                      .subActivityName
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
                                                text:
                                                    'Toolbox Training Id/Name',
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
                                              text: workPermitPreviewMakerController
                                                          .selectedToolboxTrainingMaker
                                                          .isNotEmpty &&
                                                      workPermitPreviewMakerController
                                                              .selectedToolboxTrainingMaker[
                                                                  0]
                                                              // ignore: unnecessary_null_comparison
                                                              .id !=
                                                          null
                                                  ? '${workPermitPreviewMakerController.selectedToolboxTrainingMaker[0].id.toString()} / ${workPermitPreviewMakerController.selectedToolboxTrainingMaker[0].nameOfTbTraining}'
                                                  : "NA",
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
                                                text: 'Start Date & Time',
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
                                                text: workPermitPreviewMakerController
                                                            .workPermitsMakerDetails[
                                                                0]
                                                            .fromDateTime !=
                                                        null
                                                    ? DateFormat(
                                                            'dd MMMM yyyy – hh:mm a')
                                                        .format(
                                                        workPermitPreviewMakerController
                                                                    .workPermitsMakerDetails[
                                                                        0]
                                                                    .fromDateTime
                                                                is String
                                                            ? DateTime.parse(
                                                                workPermitPreviewMakerController
                                                                        .workPermitsMakerDetails[
                                                                            0]
                                                                        .fromDateTime
                                                                    as String)
                                                            : workPermitPreviewMakerController
                                                                    .workPermitsMakerDetails[
                                                                        0]
                                                                    .fromDateTime ??
                                                                DateTime.now(),
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
                                                text: 'End Date & Time',
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
                                                text: workPermitPreviewMakerController
                                                            .workPermitsMakerDetails[
                                                                0]
                                                            .toDateTime !=
                                                        null
                                                    ? DateFormat(
                                                            'dd MMMM yyyy – hh:mm a')
                                                        .format(
                                                        workPermitPreviewMakerController
                                                                    .workPermitsMakerDetails[
                                                                        0]
                                                                    .toDateTime
                                                                is String
                                                            ? DateTime.parse(
                                                                workPermitPreviewMakerController
                                                                        .workPermitsMakerDetails[
                                                                            0]
                                                                        .toDateTime
                                                                    as String)
                                                            : workPermitPreviewMakerController
                                                                    .workPermitsMakerDetails[
                                                                        0]
                                                                    .toDateTime ??
                                                                DateTime.now(),
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
                                                text: 'Building & floors',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  workPermitPreviewMakerController
                                                      .buildingListWPMakerList
                                                      .entries
                                                      .map<Widget>((entry) {
                                                final buildingName = entry.key;
                                                final floors = entry.value
                                                    as List<dynamic>;

                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Building: $buildingName",
                                                      style: TextStyle(
                                                          fontSize: AppTextSize
                                                              .textSizeSmall,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors
                                                              .primaryText),
                                                    ),
                                                    ...floors
                                                        .map<Widget>((floor) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 2.0),
                                                        child: floor['floor_name'] !=
                                                                    null &&
                                                                floor['floor_name']
                                                                    .toString()
                                                                    .trim()
                                                                    .isNotEmpty
                                                            ? Text(
                                                                "Floor: ${floor['floor_name']}")
                                                            : SizedBox
                                                                .shrink(), // returns nothing (empty widget)
                                                      );
                                                    }).toList(),
                                                    SizedBox(height: 12),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                            // SizedBox(
                                            //   height:
                                            //       SizeConfig.heightMultiplier * 1.5,
                                            // ),
                                            // AppTextWidget(
                                            //     text: 'Floor',
                                            //     fontSize: AppTextSize.textSizeSmall,
                                            //     fontWeight: FontWeight.w400,
                                            //     color: AppColors.searchfeild),
                                            // SizedBox(
                                            //   height:
                                            //       SizeConfig.heightMultiplier * 1,
                                            // ),
                                            // Obx(() {
                                            //   var selectedFloor =
                                            //       newWorkPermitController
                                            //           .getSelectedFloor();
                                            //   return selectedFloor.isNotEmpty
                                            //       ? Column(
                                            //           crossAxisAlignment:
                                            //               CrossAxisAlignment.start,
                                            //           children: List.generate(
                                            //               selectedFloor.length,
                                            //               (index) {
                                            //             return Padding(
                                            //               padding: EdgeInsets.only(
                                            //                   bottom: SizeConfig
                                            //                           .heightMultiplier *
                                            //                       1.5),
                                            //               child: AppTextWidget(
                                            //                   text:
                                            //                       "${selectedFloor[index]['title']}",
                                            //                   fontSize: AppTextSize
                                            //                       .textSizeSmall,
                                            //                   fontWeight:
                                            //                       FontWeight.w400,
                                            //                   color: AppColors
                                            //                       .primaryText),
                                            //             );
                                            //           }),
                                            //         )
                                            //       : AppTextWidget(
                                            //           text:
                                            //               "No safety equipment selected",
                                            //           fontSize:
                                            //               AppTextSize.textSizeSmall,
                                            //           fontWeight: FontWeight.w400,
                                            //           color: Colors.red,
                                            //         );
                                            // }),
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
                                        workPermitPreviewMakerController
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
                  () => workPermitPreviewMakerController
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
                                          workPermitPreviewMakerController
                                              .toggleExpansionPrecaution();
                                        },
                                        child: Icon(Icons.keyboard_arrow_up)),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 3,
                                ),
                                Container(
                                  // padding: EdgeInsets.symmetric(
                                  //   horizontal: SizeConfig.widthMultiplier * 4,
                                  //   vertical: SizeConfig.heightMultiplier * 3,
                                  // ),
                                  width: SizeConfig.widthMultiplier * 100,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(12),
                                  //   color: AppColors.appgreycolor,
                                  // ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildCategoryWidgetContainer(),
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
                                    text: AppTexts.precautiondet,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttoncolor,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        workPermitPreviewMakerController
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                          text: 'Checker',
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
                              "$baseUrl${workPermitPreviewMakerController.checkerInformation[0].photo}",
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
                                      "${workPermitPreviewMakerController.checkerInformation[0].firstName ?? ''} "
                                      "${workPermitPreviewMakerController.checkerInformation[0].lastName ?? ''}",
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: workPermitPreviewMakerController
                                          .checkerInformation[0].designation ??
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
                          controller: workPermitPreviewMakerController
                              .workPermitRemarksControllerenable,
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
                          fillColor: AppColors.textfeildcolor),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                    ],
                  ),
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
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AppTextWidget(
                            text: 'Doer Comments',
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
                            !workPermitPreviewMakerController.userFound.value,
                        controller: workPermitPreviewMakerController
                            .workPermitRemarksController,
                        hintText: 'Comments',
                        focusNode: workPermitPreviewMakerController
                            .workPermitmakerFocusNode,
                        onFieldSubmitted: (_) {
                          workPermitPreviewMakerController
                              .workPermitmakerFocusNode
                              .unfocus();
                        },
                        fillColor:
                            workPermitPreviewMakerController.userFound.value
                                ? AppColors.textfeildcolor
                                : Colors.white,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]')),
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
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: "Doer Signature",
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
                                  workPermitPreviewMakerController
                                          .userFound.value
                                      ? SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            workPermitPreviewMakerController
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
                                    if (workPermitPreviewMakerController
                                        .userFound.value) {
                                      // Show saved signature image
                                      return workPermitPreviewMakerController
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
                                                "$baseUrl${workPermitPreviewMakerController.savedSignatureUrlfetch.value}",
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          : const Text(
                                              "No signature available");
                                    } else {
                                      // Show signature pad
                                      return Listener(
                                        key: workPermitPreviewMakerController
                                            .signatureSectionKey,
                                        onPointerDown: (_) {
                                          Future.delayed(
                                              Duration(milliseconds: 50), () {
                                            if (workPermitPreviewMakerController
                                                .signatureattestationController
                                                .isNotEmpty) {
                                              workPermitPreviewMakerController
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
                                                workPermitPreviewMakerController
                                                    .signatureattestationController,
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
                      Obx(() => workPermitPreviewMakerController
                              .signatureattestationError.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4, left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    workPermitPreviewMakerController
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
                        text: "Doer",
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: SizeConfig.imageSizeMultiplier * 15,
                            height: SizeConfig.imageSizeMultiplier * 15,
                            child: Image.network(
                              "$baseUrl${workPermitPreviewMakerController.makerInformation[0].photo}",
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
                                  text: workPermitPreviewMakerController
                                          .makerInformation.isNotEmpty
                                      ? '${workPermitPreviewMakerController.makerInformation[0].firstName} ${workPermitPreviewMakerController.makerInformation[0].lastName}'
                                      : 'No Name',
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText),
                              AppTextWidget(
                                  text: workPermitPreviewMakerController
                                          .makerInformation.isNotEmpty
                                      ? '${workPermitPreviewMakerController.makerInformation[0].designation}'
                                      : 'No Name',
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
                        text: workPermitPreviewMakerController
                                    // ignore: unnecessary_null_comparison
                                    .workPermitsMakerDetails[0]
                                    // ignore: unnecessary_null_comparison
                                    .createdAt !=
                                null
                            ? DateFormat('dd-MM-yyyy hh:mm a').format(
                                DateTime.parse(workPermitPreviewMakerController
                                    .workPermitsMakerDetails[0].createdAt
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: Obx(
            () => AppElevatedButton(
                text: workPermitPreviewMakerController.userFound.value
                    ? 'Close'
                    : 'Close the Work Permit',
                onPressed: () async {
                  if (workPermitPreviewMakerController.userFound.value) {
                    Get.back();
                  } else {
                    validateAndFocusFirstInvalidField();
                    if (workPermitPreviewMakerController
                        .signatureattestationController.isEmpty) {
                      workPermitPreviewMakerController.signatureattestationError
                          .value = "Please fill in the signature.";
                    }
                    if (formKey.currentState!.validate()) {
                      await workPermitPreviewMakerController
                          .saveSafetyattestationSignature();

                      if (workPermitPreviewMakerController
                          .signatureattestationController.isEmpty) {
                        workPermitPreviewMakerController
                            .signatureattestationError
                            .value = "Please fill in the signature.";
                        return;
                      }
                      if (workPermitPreviewMakerController
                              .signatureattestationController.isNotEmpty &&
                          workPermitPreviewMakerController
                              .workPermitRemarksController.text.isNotEmpty) {
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
                      //   Get.to(WorkPermitPrecautionScreen());
                    }
                  }
                }),
          ),
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
    if (workPermitPreviewMakerController.workPermitRemarksController.text
        .trim()
        .isEmpty) {
      workPermitPreviewMakerController.workPermitmakerFocusNode.requestFocus();
      return;
    }
    if (workPermitPreviewMakerController
        .signatureattestationController.isEmpty) {
      scrollToWidget(workPermitPreviewMakerController.signatureSectionKey);
      return;
    }
  }

  Widget buildCategoryWidgetContainer() {
    final categoryMap =
        workPermitPreviewMakerController.categoryListWPMakerList;

    if (categoryMap.isEmpty) return SizedBox(); // Or a placeholder

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categoryMap.entries.map<Widget>((entry) {
        final categoryName = entry.key;
        final permitDetailsList = entry.value as List<dynamic>;

        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 2,
              ),
              width: SizeConfig.widthMultiplier * 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.appgreycolor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: AppTextWidget(
                      text: categoryName,
                      fontSize: AppTextSize.textSizeSmallm,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  Container(
                    width: SizeConfig.widthMultiplier * 100,
                    height: 1.5,
                    color: AppColors.searchfeildcolor,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: permitDetailsList.length,
                    itemBuilder: (context, index) {
                      final detail = permitDetailsList[index];
                      final permitText =
                          detail['permit_details']?.toString().trim() ??
                              "Unknown";

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppTextWidget(
                          text: "${index + 1}. $permitText",
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryText,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            )
          ],
        );
      }).toList(),
    );
  }
}
