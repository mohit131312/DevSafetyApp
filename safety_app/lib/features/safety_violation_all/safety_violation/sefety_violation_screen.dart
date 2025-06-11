import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/safety_violation_all/safety_attestaion/safety_attestaion_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_preview/safety_preview_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_all/safety_violation_details_all.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_all/safety_violation_details_cotroller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_assignee/safety_violation_details_assignee.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_assignee/safety_violation_details_assignee_cont.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_assignor/safety_violation_details_assignor.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/safety_violation_details/safety_violation_details_assignor/safety_violation_details_assignor_cont.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/sefety_violation_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_assignee/select_safety_assignee_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_informed_people/select_safety_informed_people_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_involved_person/select_involved_person_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SefetyViolationScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  SefetyViolationScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final TextEditingController searchController = TextEditingController();
  final SefetyViolationController sefetyViolationController =
      Get.put(SefetyViolationController());
  final SafetyViolationDetailsController safetyViolationDetailsController =
      Get.put(SafetyViolationDetailsController());
  final SelectInvolvedPersonController selectInvolvedPersonController = Get.put(
    SelectInvolvedPersonController(),
  );
  final SelectSafetyInformedPeopleController
      selectSafetyInformedPeopleController =
      Get.put(SelectSafetyInformedPeopleController());

  final SelectSafetyAssigneeController selectSafetyAssigneeController =
      Get.put(SelectSafetyAssigneeController());
  final SafetyAttestaionController safetyAttestaionController =
      Get.put(SafetyAttestaionController());
  final SafetyPreviewController safetyPreviewController =
      Get.put(SafetyPreviewController());

  final SafetyViolationDetailsCotroller safetyViolationDetailsCotroller =
      Get.put(SafetyViolationDetailsCotroller());
  final SafetyViolationDetailsAssigneeCont safetyViolationDetailsAssigneeCont =
      Get.put(SafetyViolationDetailsAssigneeCont());
  final SafetyViolationDetailsAssignorCont safetyViolationDetailsAssignorCont =
      Get.put(SafetyViolationDetailsAssignorCont());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              text: 'Safety Violation & Debit Note',
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 6,
                    width: SizeConfig.widthMultiplier * 92,
                    child: Obx(() {
                      switch (sefetyViolationController.selectedOption.value) {
                        case 0:
                          sefetyViolationController.activeController =
                              sefetyViolationController
                                  .searchSafetyAllController;
                          break;
                        case 1:
                          sefetyViolationController.activeController =
                              sefetyViolationController
                                  .searchSafetyAssignorController;
                          break;
                        case 2:
                          sefetyViolationController.activeController =
                              sefetyViolationController
                                  .searchSafetyAssigneeController;
                          break;
                        default:
                          sefetyViolationController.activeController =
                              TextEditingController(); // fallback
                      }

                      return AppTextFormfeild(
                        controller: sefetyViolationController.activeController,
                        hintText: 'Search By Name..',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/Search.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        onChanged: (value) {
                          sefetyViolationController.handleSearchByTab(
                            sefetyViolationController.selectedOption.value,
                            value,
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            Container(
              height: SizeConfig.heightMultiplier * 6,
              width: SizeConfig.widthMultiplier * 92,
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 0.8,
                horizontal: SizeConfig.widthMultiplier * 1.5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.textfeildcolor,
              ),
              child: TabBar(
                controller: sefetyViolationController.tabController,
                isScrollable: true,
                indicatorColor: AppColors.textfeildcolor,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.searchfeild,
                indicator: BoxDecoration(
                  color: AppColors.thirdText,
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,
                tabAlignment: TabAlignment.center,
                tabs: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 20,
                    child: const Tab(
                      text: AppTexts.all,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 20,
                    child: const Tab(
                      text: 'Assignor',
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 20,
                    child: const Tab(
                      text: 'Assignee',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: sefetyViolationController.tabController,
                children: [
                  Obx(() {
                    final filteredList =
                        sefetyViolationController.filteredSafetyAllList;
                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final safety = filteredList[index];

                        return GestureDetector(
                          onTap: () async {
                            log('----------------------------${sefetyViolationController.selectedOption.value}');
                            if (await CheckInternet.checkInternet()) {
                              safetyViolationDetailsCotroller.resetData();
                              await safetyViolationDetailsCotroller
                                  .getSafetyViolationAllDetails(
                                      projectId, userId, 1, safety.id);

                              Get.to(SafetyViolationDetailsAll(
                                userId: userId,
                                userName: userName,
                                userImg: userImg,
                                userDesg: userDesg,
                                projectId: projectId,
                                safetyId: safety.id,
                              ));
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
                          },
                          child: Column(
                            children: [
                              ListTile(
                                title: AppTextWidget(
                                  text: safety.violationUniqueId.toString(),
                                  fontSize: AppTextSize.textSizeSmalle,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: safety.details,
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                    AppTextWidget(
                                      // ignore: unnecessary_null_comparison
                                      text: (safety.createdAt != null)
                                          ? DateFormat('dd MMMM yyyy').format(
                                              safety.createdAt is String
                                                  ? DateTime.parse(safety
                                                      .createdAt as String)
                                                  : safety.createdAt)
                                          : '',
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 8, bottom: 3),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        children: [
                                          AppTextWidget(
                                            text: safety.status.toString() ==
                                                    "0"
                                                ? 'Open'
                                                : safety.status.toString() ==
                                                        "1"
                                                    ? 'Resolved'
                                                    : safety.status
                                                                .toString() ==
                                                            "2"
                                                        ? 'Closed'
                                                        : "",
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: safety.status.toString() ==
                                                    "0"
                                                ? AppColors
                                                    .buttoncolor // Open → Orange
                                                : safety.status.toString() ==
                                                        "1"
                                                    ? Colors
                                                        .green // Accepted → Green
                                                    : safety.status
                                                                .toString() ==
                                                            "2"
                                                        ? Colors
                                                            .grey // Closed → Grey
                                                        : Colors.black,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: AppColors.textfeildcolor,
                                thickness: 1.5,
                                height: 2,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                  Obx(() {
                    final filteredList =
                        sefetyViolationController.filteredSafetyAssignorList;
                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final safety = filteredList[index];

                        return GestureDetector(
                          onTap: () async {
                            log('----------------------------${sefetyViolationController.selectedOption.value}');
                            if (await CheckInternet.checkInternet()) {
                              safetyViolationDetailsAssignorCont.clearAllData();

                              await safetyViolationDetailsAssignorCont
                                  .getSafetyViolationAssginorDetails(
                                      projectId, userId, 2, safety.id);

                              Get.to(SafetyViolationDetailsAssignor(
                                  userId: userId,
                                  userName: userName,
                                  userImg: userImg,
                                  userDesg: userDesg,
                                  projectId: projectId,
                                  safetyId: safety.id,
                                  uniqueId:
                                      safety.violationUniqueId.toString()));
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
                          },
                          child: Column(
                            children: [
                              ListTile(
                                title: AppTextWidget(
                                  text: safety.violationUniqueId.toString(),
                                  fontSize: AppTextSize.textSizeSmalle,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: safety.details,
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                    AppTextWidget(
                                      // ignore: unnecessary_null_comparison
                                      text: (safety.createdAt != null)
                                          ? DateFormat('dd MMMM yyyy').format(
                                              safety.createdAt is String
                                                  ? DateTime.parse(safety
                                                      .createdAt as String)
                                                  : safety.createdAt)
                                          : '',
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 8, bottom: 3),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        children: [
                                          AppTextWidget(
                                            text: safety.status.toString() ==
                                                    "0"
                                                ? 'Open'
                                                : safety.status.toString() ==
                                                        "1"
                                                    ? 'Resolved'
                                                    : safety.status
                                                                .toString() ==
                                                            "2"
                                                        ? 'Closed'
                                                        : "",
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: safety.status.toString() ==
                                                    "0"
                                                ? AppColors
                                                    .buttoncolor // Open → Orange
                                                : safety.status.toString() ==
                                                        "1"
                                                    ? Colors
                                                        .green // Accepted → Green
                                                    : safety.status
                                                                .toString() ==
                                                            "2"
                                                        ? Colors
                                                            .grey // Closed → Grey
                                                        : Colors.black,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: AppColors.textfeildcolor,
                                thickness: 1.5,
                                height: 2,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                  Obx(() {
                    final filteredList =
                        sefetyViolationController.filteredSafetyAssigneeList;
                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final safety = filteredList[index];

                        return GestureDetector(
                          onTap: () async {
                            log('----------------------------${sefetyViolationController.selectedOption.value}');
                            if (await CheckInternet.checkInternet()) {
                              safetyViolationDetailsAssigneeCont
                                  .resetSafetyAssigneeData();
                              await safetyViolationDetailsAssigneeCont
                                  .getSafetyViolationAssigneeDetails(
                                      projectId, userId, 3, safety.id);

                              Get.to(SafetyViolationDetailsAssignee(
                                userId: userId,
                                userName: userName,
                                userImg: userImg,
                                userDesg: userDesg,
                                projectId: projectId,
                                safetyId: safety.id,
                                uniqueId: safety.violationUniqueId.toString(),
                              ));
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
                          },
                          child: Column(
                            children: [
                              ListTile(
                                title: AppTextWidget(
                                  text: safety.violationUniqueId.toString(),
                                  fontSize: AppTextSize.textSizeSmalle,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: safety.details,
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                    AppTextWidget(
                                      // ignore: unnecessary_null_comparison
                                      text: (safety.createdAt != null)
                                          ? DateFormat('dd MMMM yyyy').format(
                                              safety.createdAt is String
                                                  ? DateTime.parse(safety
                                                      .createdAt as String)
                                                  : safety.createdAt)
                                          : '',
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 8, bottom: 3),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        children: [
                                          AppTextWidget(
                                            text: safety.status.toString() ==
                                                    "0"
                                                ? 'Open'
                                                : safety.status.toString() ==
                                                        "1"
                                                    ? 'Resolved'
                                                    : safety.status
                                                                .toString() ==
                                                            "2"
                                                        ? 'Closed'
                                                        : "",
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: safety.status.toString() ==
                                                    "0"
                                                ? AppColors
                                                    .buttoncolor // Open → Orange
                                                : safety.status.toString() ==
                                                        "1"
                                                    ? Colors
                                                        .green // Accepted → Green
                                                    : safety.status
                                                                .toString() ==
                                                            "2"
                                                        ? Colors
                                                            .grey // Closed → Grey
                                                        : Colors.black,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: AppColors.textfeildcolor,
                                thickness: 1.5,
                                height: 2,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() {
          int selectedIndex = sefetyViolationController.selectedOption.value;

          return (selectedIndex == 0 || selectedIndex == 1)
              ? SizedBox(
                  width: SizeConfig.widthMultiplier * 36,
                  height: SizeConfig.heightMultiplier * 6.5,
                  child: FloatingActionButton(
                    onPressed: () async {
                      if (await CheckInternet.checkInternet()) {
                        safetyViolationDetailsController.resetAllSafetyData();
                        safetyPreviewController.clearAllFields();
                        safetyViolationDetailsController.resetData();

                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomLoadingPopup());
                        await safetyViolationDetailsController
                            .getSafetyViolationData(projectId);
                        Get.back();
                        Get.to(SafetyViolationDetails(
                          userId: userId,
                          userName: userName,
                          userImg: userImg,
                          userDesg: userDesg,
                          projectId: projectId,
                        ));
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
                    },
                    backgroundColor: AppColors.buttoncolor,
                    elevation: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 26,
                          color: AppColors.primary,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1,
                        ),
                        AppTextWidget(
                          text: "Add",
                          fontSize: AppTextSize.textSizeMedium,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox();
        }),
      ),
    );
  }
}
