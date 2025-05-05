import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_all_details/work_permit_all_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_all_details/work_permit_all_details.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_checker/work_permit_checker_details/work_permit_checker_details_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_checker/work_permit_checker_details/work_permit_checkers_details.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/assign_checker/assign_checker_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_date/work_Permit_date_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_details/work_permit_preview_maker_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_details/work_permit_preview_maker_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_precaution/work_permit_precaution_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_preview/work_permit_preview_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_undertaking/work_permit_under_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkPermitScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  WorkPermitScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });

  final TextEditingController searchController = TextEditingController();
  final WorkPermitController workPermitController =
      Get.put(WorkPermitController());
  final NewWorkPermitController newWorkPermitController =
      Get.put(NewWorkPermitController());
  final WorkPermitPreviewMakerController workPermitDetailsController =
      Get.put(WorkPermitPreviewMakerController());

  final WorkPermitDateController dateController =
      Get.put(WorkPermitDateController());
  final WorkPermitPrecautionController workPermitPrecautionController =
      Get.put(WorkPermitPrecautionController());

  final WorkPermitUnderController workPermitUnderController =
      Get.put(WorkPermitUnderController());
  final WorkPermitPreviewController workPermitPreviewController =
      Get.put(WorkPermitPreviewController());
  final AssignCheckerController assignCheckerController =
      Get.put(AssignCheckerController());
  final WorkPermitCheckerDetailsController workPermitCheckerDetailsController =
      Get.put(WorkPermitCheckerDetailsController());

  final WorkPermitAllController workPermitAllController =
      Get.put(WorkPermitAllController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
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
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 2,
                ),
                child: SizedBox(
                  height: SizeConfig.heightMultiplier * 6.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 6.4,
                        width: SizeConfig.widthMultiplier * 92,
                        child: Obx(() {
                          TextEditingController activeController;

                          switch (workPermitController.selectedOption.value) {
                            case 0:
                              activeController =
                                  workPermitController.searchWorkAllController;
                              break;
                            case 1:
                              activeController = workPermitController
                                  .searchWorkMakerController;
                              break;
                            case 2:
                              activeController = workPermitController
                                  .searchWorkCheckerController;
                              break;
                            default:
                              activeController =
                                  TextEditingController(); // fallback
                          }

                          return AppTextFormfeild(
                            controller: activeController,
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
                              workPermitController.handleSearchByTab(
                                workPermitController.selectedOption.value,
                                value,
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
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
                  controller: workPermitController.tabController,
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
                  tabAlignment: TabAlignment.start,
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
                        text: 'Maker',
                      ),
                    ),
                    SizedBox(
                      child: const Tab(
                        text: 'Checker',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: workPermitController.tabController,
                  children: [
                    Obx(() {
                      final filteredList =
                          workPermitController.filteredworkAllList;
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final work = filteredList[index];

                          return GestureDetector(
                            onTap: () async {
                              log('----------------------------${workPermitController.selectedOption.value}');

                              workPermitAllController.resetData();
                              await workPermitAllController
                                  .getWorkPermitAllDetails(
                                      projectId, userId, 1, work.id);
                              Get.to(WorkPermitAllDetails(
                                userId: userId,
                                userName: userName,
                                userImg: userImg,
                                userDesg: userDesg,
                                projectId: projectId,
                                wpId: work.id,
                              ));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: AppTextWidget(
                                    text: work.nameOfWorkpermit,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: work.description != null
                                            ? work.description!
                                            : '',
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                      AppTextWidget(
                                        text: (work.createdAt != null)
                                            ? DateFormat('dd MMMM yyyy').format(
                                                work.createdAt is String
                                                    ? DateTime.parse(work
                                                        .createdAt as String)
                                                    : work.createdAt ??
                                                        DateTime.now())
                                            : '',
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                    ],
                                  ),
                                  trailing: Padding(
                                    padding: EdgeInsets.only(
                                        left: 12, right: 12, top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppTextWidget(
                                          text: work.status == "0"
                                              ? 'Open'
                                              : work.status == "1"
                                                  ? 'Accepted'
                                                  : work.status == "2"
                                                      ? 'Rejected'
                                                      : work.status == "3"
                                                          ? 'Closed'
                                                          : 'Unknown',
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w500,
                                          color: work.status == "0"
                                              ? AppColors
                                                  .buttoncolor // Open → Orange
                                              : work.status == "1"
                                                  ? Colors
                                                      .green // Accepted → Green
                                                  : work.status == "2"
                                                      ? Colors
                                                          .red // Rejected → Red
                                                      : work.status == "3"
                                                          ? Colors
                                                              .grey // Closed → Grey
                                                          : Colors
                                                              .black, // Fallback for unknown statuses
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
                    GestureDetector(
                      onTap: () async {
                        // log('----------------------------${workPermitController.selectedOption.value}');

                        // if (workPermitController.selectedOption.value == 1) {
                        //   Get.to(WorkPermitPreviewMakerScreen());
                        // }
                      },
                      child: Obx(() {
                        final filteredList =
                            workPermitController.filteredwpMakerList;
                        return ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final work = filteredList[index];

                            return GestureDetector(
                              onTap: () async {
                                log('----------------------------${workPermitController.selectedOption.value}');

                                workPermitDetailsController.clearwpComment();
                                await workPermitDetailsController
                                    .getWorkPermitMakerDetails(
                                        projectId, userId, 2, work.id);
                                Get.to(WorkPermitPreviewMakerScreen(
                                  userId: userId,
                                  userName: userName,
                                  userImg: userImg,
                                  userDesg: userDesg,
                                  projectId: projectId,
                                  wpId: work.id,
                                ));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: AppTextWidget(
                                      text: work.nameOfWorkpermit,
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryText,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppTextWidget(
                                          text: work.description != null
                                              ? work.description!
                                              : '',
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryText,
                                        ),
                                        AppTextWidget(
                                          text: (work.createdAt != null)
                                              ? DateFormat('dd MMMM yyyy')
                                                  .format(work.createdAt
                                                          is String
                                                      ? DateTime.parse(work
                                                          .createdAt as String)
                                                      : work.createdAt ??
                                                          DateTime.now())
                                              : '',
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryText,
                                        ),
                                      ],
                                    ),
                                    trailing: Padding(
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          top: 8,
                                          bottom: 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppTextWidget(
                                            text: work.status == "0"
                                                ? 'Open'
                                                : work.status == "1"
                                                    ? 'Accepted'
                                                    : work.status == "2"
                                                        ? 'Rejected'
                                                        : work.status == "3"
                                                            ? 'Closed'
                                                            : 'Unknown',
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: work.status == "0"
                                                ? AppColors
                                                    .buttoncolor // Open → Orange
                                                : work.status == "1"
                                                    ? Colors
                                                        .green // Accepted → Green
                                                    : work.status == "2"
                                                        ? Colors
                                                            .red // Rejected → Red
                                                        : work.status == "3"
                                                            ? Colors
                                                                .grey // Closed → Grey
                                                            : Colors
                                                                .black, // Fallback for unknown statuses
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
                    ),
                    GestureDetector(
                      onTap: () {
                        log('----------------------------${workPermitController.selectedOption.value}');
                        // if (workPermitController.selectedOption.value == 0) {
                        //   Get.to(WorkPermitCheckersDetails());
                        // }
                      },
                      child: Obx(() {
                        final filteredList =
                            workPermitController.filteredwpCheckerList;
                        return ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final work = filteredList[index];

                            return GestureDetector(
                              onTap: () async {
                                workPermitCheckerDetailsController
                                    .clearwpCheckerComment();
                                await workPermitCheckerDetailsController
                                    .getWorkPermitCheckerDetails(
                                        projectId, userId, 3, work.id);

                                Get.to(WorkPermitCheckersDetails(
                                  userId: userId,
                                  userName: userName,
                                  userImg: userImg,
                                  userDesg: userDesg,
                                  projectId: projectId,
                                  wpId: work.id,
                                ));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: AppTextWidget(
                                      text: work.nameOfWorkpermit,
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryText,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppTextWidget(
                                          text: work.description != null
                                              ? work.description!
                                              : '',
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryText,
                                        ),
                                        AppTextWidget(
                                          text: (work.createdAt != null)
                                              ? DateFormat('dd MMMM yyyy')
                                                  .format(work.createdAt
                                                          is String
                                                      ? DateTime.parse(work
                                                          .createdAt as String)
                                                      : work.createdAt ??
                                                          DateTime.now())
                                              : '',
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryText,
                                        ),
                                      ],
                                    ),
                                    trailing: Padding(
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          top: 8,
                                          bottom: 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppTextWidget(
                                            text: work.status == "0"
                                                ? 'Open'
                                                : work.status == "1"
                                                    ? 'Accepted'
                                                    : work.status == "2"
                                                        ? 'Rejected'
                                                        : work.status == "3"
                                                            ? 'Closed'
                                                            : 'Unknown',
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: work.status == "0"
                                                ? AppColors
                                                    .buttoncolor // Open → Orange
                                                : work.status == "1"
                                                    ? Colors
                                                        .green // Accepted → Green
                                                    : work.status == "2"
                                                        ? Colors
                                                            .red // Rejected → Red
                                                        : work.status == "3"
                                                            ? Colors
                                                                .grey // Closed → Grey
                                                            : Colors
                                                                .black, // Fallback for unknown statuses
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
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Obx(() {
            int selectedIndex = workPermitController.selectedOption.value;

            return (selectedIndex == 0 || selectedIndex == 1)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.36,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: FloatingActionButton(
                      onPressed: () async {
                        final LocationController locationController =
                            Get.find();
                        locationController.fetchLocation();

                        workPermitController.clearWorkPermitData();

                        workPermitPreviewController.clearAllData();
                        assignCheckerController.clearAssigneeData();
                        newWorkPermitController.resetData();
                        workPermitPrecautionController.resetData();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomLoadingPopup());
                        await workPermitController.getWorkPermitData(projectId);
                        Get.back();

                        Get.to(NewWorkPermitScreen(
                            userId: userId,
                            userName: userName,
                            userImg: userImg,
                            userDesg: userDesg,
                            projectId: projectId));
                      },
                      backgroundColor: AppColors
                          .buttoncolor, // Replace with AppColors.buttoncolor
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 26,
                            color:
                                Colors.white, // Replace with AppColors.primary
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          AppTextWidget(
                            text: "Add",
                            fontSize: AppTextSize.textSizeMedium,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox
                    .shrink(); // Efficient way to hide the button when not needed
          }),
        ));
  }
}
