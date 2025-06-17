import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/permission/permission_model.dart';
import 'package:flutter_app/features/select_project/select_project_controller.dart';
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
import 'package:flutter_app/utils/api_client.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkPermitScreen extends StatefulWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  const WorkPermitScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });

  @override
  // ignore: library_private_types_in_public_api
  _WorkPermitScreenState createState() => _WorkPermitScreenState();
}

class _WorkPermitScreenState extends State<WorkPermitScreen>
    with SingleTickerProviderStateMixin {
  late WorkPermitController workPermitController;
  late TabController tabController;
  final List<Widget> tabs = [];
  final List<Widget> tabViews = [];
  late bool showAddButton;
  var rolename = ''.obs;
  var tablength = false;
  @override
  void initState() {
    super.initState();
    rolename.value = ApiClient.gs.read('role_name');

    workPermitController = Get.put(WorkPermitController());

    // Determine tabs based on permissions
    final workPermitPermissions = Get.find<SelectProjectController>()
        .selectRoles
        .firstWhere(
          (entry) => entry.key == "6",
          orElse: () => MapEntry("6", The23()),
        )
        .value;

    final showAllTab = workPermitPermissions.moduleView ?? false;
    final showDoerTab = workPermitPermissions.moduleEdit ?? false;
    final showCheckerTab = workPermitPermissions.moduleDelete ?? false;
    showAddButton = workPermitPermissions.moduleCreate ?? false;

    if (showAllTab) {
      tabs.add(SizedBox(
          width: SizeConfig.widthMultiplier * 35,
          child: const Tab(text: AppTexts.all)));
      tabViews.add(_buildAllTabView());
    }
    if (showDoerTab) {
      tabs.add(SizedBox(
          width: SizeConfig.widthMultiplier * 35,
          child: Tab(text: rolename.value)));
      tabViews.add(_buildMakerTabView());
    }
    if (showCheckerTab) {
      tabs.add(SizedBox(
          width: SizeConfig.widthMultiplier * 35,
          child: Tab(text: rolename.value)));
      tabViews.add(_buildCheckerTabView());
    }

    tabController = TabController(length: tabs.length, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        FocusScope.of(context).unfocus();
      }
    });
    if (tabs.length == 1) {
      tablength = true;
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
  final SelectProjectController selectProjectController =
      Get.find<SelectProjectController>();

  Widget _buildAllTabView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 4,
            vertical: SizeConfig.heightMultiplier * 1.5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 6,
                width: SizeConfig.widthMultiplier * 92,
                child: AppTextFormfeild(
                  controller: workPermitController.searchWorkAllController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: workPermitController.searchAllFocusNode,
                  onFieldSubmitted: (p0) {
                    workPermitController.searchAllFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    workPermitController.handleSearchAll(
                      value,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            final filteredList = workPermitController.filteredworkAllList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No Work Permit Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final work = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    log('----------------------------${tabController.index}');
                    if (await CheckInternet.checkInternet()) {
                      workPermitAllController.resetData();
                      await workPermitAllController.getWorkPermitAllDetails(
                          widget.projectId, widget.userId, 1, work.id);
                      workPermitController.searchAllFocusNode.unfocus();

                      Get.to(WorkPermitAllDetails(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
                        wpId: work.id,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: work.uniqueId!,
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            AppTextWidget(
                              text: work.nameOfWorkpermit,
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: work.description != null
                                  ? work.description!
                                  : '',
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            AppTextWidget(
                              text: (work.createdAt != null)
                                  ? DateFormat('dd MMMM yyyy').format(work
                                          .createdAt is String
                                      ? DateTime.parse(work.createdAt as String)
                                      : work.createdAt ?? DateTime.now())
                                  : '',
                              fontSize: AppTextSize.textSizeExtraSmall,
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
                                fontSize: AppTextSize.textSizeExtraSmall,
                                fontWeight: FontWeight.w500,
                                color: work.status == "0"
                                    ? AppColors.buttoncolor // Open → Orange
                                    : work.status == "1"
                                        ? Colors.green // Accepted → Green
                                        : work.status == "2"
                                            ? Colors.red // Rejected → Red
                                            : work.status == "3"
                                                ? Colors.grey // Closed → Grey
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
    );
  }

  Widget _buildMakerTabView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 4,
            vertical: SizeConfig.heightMultiplier * 1.5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 6,
                width: SizeConfig.widthMultiplier * 92,
                child: AppTextFormfeild(
                  controller: workPermitController.searchWorkMakerController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: workPermitController.searchmakerFocusNode,
                  onFieldSubmitted: (p0) {
                    workPermitController.searchmakerFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    workPermitController.handleSearchDoer(
                      value,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            final filteredList = workPermitController.filteredwpMakerList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No Work Permit Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final work = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    log('----------------------------${tabController.index}');
                    if (await CheckInternet.checkInternet()) {
                      workPermitDetailsController.clearwpComment();
                      await workPermitDetailsController
                          .getWorkPermitMakerDetails(
                              widget.projectId, widget.userId, 2, work.id);
                      workPermitController.searchmakerFocusNode.unfocus();

                      Get.to(WorkPermitPreviewMakerScreen(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
                        wpId: work.id,
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
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: work.uniqueId!,
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            AppTextWidget(
                              text: work.nameOfWorkpermit,
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: work.description != null
                                  ? work.description!
                                  : '',
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            AppTextWidget(
                              text: (work.createdAt != null)
                                  ? DateFormat('dd MMMM yyyy').format(work
                                          .createdAt is String
                                      ? DateTime.parse(work.createdAt as String)
                                      : work.createdAt ?? DateTime.now())
                                  : '',
                              fontSize: AppTextSize.textSizeExtraSmall,
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
                                fontSize: AppTextSize.textSizeExtraSmall,
                                fontWeight: FontWeight.w500,
                                color: work.status == "0"
                                    ? AppColors.buttoncolor // Open → Orange
                                    : work.status == "1"
                                        ? Colors.green // Accepted → Green
                                        : work.status == "2"
                                            ? Colors.red // Rejected → Red
                                            : work.status == "3"
                                                ? Colors.grey // Closed → Grey
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
    );
  }

  Widget _buildCheckerTabView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 4,
            vertical: SizeConfig.heightMultiplier * 1.5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 6,
                width: SizeConfig.widthMultiplier * 92,
                child: AppTextFormfeild(
                  controller: workPermitController.searchWorkCheckerController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: workPermitController.searchcheckerFocusNode,
                  onFieldSubmitted: (p0) {
                    workPermitController.searchcheckerFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    workPermitController.handleSearchChecker(
                      value,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            final filteredList = workPermitController.filteredwpCheckerList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No Work Permit Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final work = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      workPermitCheckerDetailsController
                          .clearwpCheckerComment();
                      await workPermitCheckerDetailsController
                          .getWorkPermitCheckerDetails(
                              widget.projectId, widget.userId, 3, work.id);
                      workPermitController.searchcheckerFocusNode.unfocus();

                      Get.to(WorkPermitCheckersDetails(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
                        wpId: work.id,
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
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: work.uniqueId!,
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            AppTextWidget(
                              text: work.nameOfWorkpermit,
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: work.description != null
                                  ? work.description!
                                  : '',
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            AppTextWidget(
                              text: (work.createdAt != null)
                                  ? DateFormat('dd MMMM yyyy').format(work
                                          .createdAt is String
                                      ? DateTime.parse(work.createdAt as String)
                                      : work.createdAt ?? DateTime.now())
                                  : '',
                              fontSize: AppTextSize.textSizeExtraSmall,
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
                                fontSize: AppTextSize.textSizeExtraSmall,
                                fontWeight: FontWeight.w500,
                                color: work.status == "0"
                                    ? AppColors.buttoncolor // Open → Orange
                                    : work.status == "1"
                                        ? Colors.green // Accepted → Green
                                        : work.status == "2"
                                            ? Colors.red // Rejected → Red
                                            : work.status == "3"
                                                ? Colors.grey // Closed → Grey
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
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
          body: Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 1.5,
              ),
              if (tabs.isNotEmpty)
                Container(
                  height: tablength
                      ? SizeConfig.heightMultiplier * 5
                      : SizeConfig.heightMultiplier * 6,
                  width: SizeConfig.widthMultiplier * 92,
                  padding: EdgeInsets.symmetric(
                    vertical: tablength
                        ? SizeConfig.heightMultiplier * 0
                        : SizeConfig.heightMultiplier * 0.8,
                    horizontal: SizeConfig.widthMultiplier * 1.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: tablength ? Colors.white : AppColors.textfeildcolor,
                  ),
                  child: TabBar(
                    controller: tabController,
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
                    tabs: tabs,
                  ),
                ),
              Expanded(
                child: tabs.isNotEmpty
                    ? TabBarView(
                        controller: tabController,
                        children: tabViews,
                      )
                    : Center(
                        child: AppTextWidget(
                        text: 'No permissions available',
                        color: AppColors.secondaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: showAddButton
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.36,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: FloatingActionButton(
                    onPressed: () async {
                      if (await CheckInternet.checkInternet()) {
                        workPermitController.clearWorkPermitData();

                        workPermitPreviewController.clearAllData();
                        workPermitUnderController.clearAllCheckboxes();
                        assignCheckerController.clearAssigneeData();
                        newWorkPermitController.resetData();
                        workPermitPrecautionController.resetData();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomLoadingPopup());
                        workPermitController.searchcheckerFocusNode.unfocus();
                        workPermitController.searchmakerFocusNode.unfocus();
                        workPermitController.searchAllFocusNode.unfocus();

                        await workPermitController
                            .getWorkPermitData(widget.projectId);
                        Get.back();

                        Get.to(NewWorkPermitScreen(
                            userId: widget.userId,
                            userName: widget.userName,
                            userImg: widget.userImg,
                            userDesg: widget.userDesg,
                            projectId: widget.projectId));
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
                    backgroundColor: AppColors
                        .buttoncolor, // Replace with AppColors.buttoncolor
                    elevation: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 26,
                          color: Colors.white, // Replace with AppColors.primary
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
              : SizedBox.shrink(),
        ));
  }
}
