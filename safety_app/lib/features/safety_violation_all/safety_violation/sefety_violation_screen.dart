import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/permission/permission_model.dart';
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
import 'package:flutter_app/features/select_project/select_project_controller.dart';
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

class SefetyViolationScreen extends StatefulWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  const SefetyViolationScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });

  @override
  State<SefetyViolationScreen> createState() => _SafetyViolationScreenState();
}

class _SafetyViolationScreenState extends State<SefetyViolationScreen>
    with SingleTickerProviderStateMixin {
  late SefetyViolationController safetyViolationController;
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

    safetyViolationController = Get.put(SefetyViolationController());

    final safetyPermissions = Get.find<SelectProjectController>()
        .selectRoles
        .firstWhere(
          (entry) => entry.key == "23",
          orElse: () => MapEntry("23", The23()),
        )
        .value;

    final showAllTab = safetyPermissions.moduleView ?? false;
    final showAssignorTab = safetyPermissions.moduleEdit ?? false;
    final showAssigneeTab = safetyPermissions.moduleDelete ?? false;
    showAddButton = safetyPermissions.moduleCreate ?? false;

    if (showAllTab) {
      tabs.add(SizedBox(
          width: SizeConfig.widthMultiplier * 35,
          child: const Tab(text: AppTexts.all)));
      tabViews.add(_buildAllTabView());
    }
    if (showAssignorTab) {
      tabs.add(SizedBox(
          width: SizeConfig.widthMultiplier * 35,
          child: Tab(text: rolename.value)));
      tabViews.add(_buildAssignorTabView());
    }
    if (showAssigneeTab) {
      tabs.add(SizedBox(
          width: SizeConfig.widthMultiplier * 35,
          child: Tab(text: rolename.value)));
      tabViews.add(_buildAssigneeTabView());
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
  final SelectProjectController selectProjectController =
      Get.find<SelectProjectController>();
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
            SizedBox(
              height: SizeConfig.heightMultiplier * 1.5,
            ),
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
                  tabs: tabs),
            ),
            Expanded(
              child: tabs.isNotEmpty
                  ? TabBarView(
                      controller: tabController,
                      children: tabViews,
                    )
                  : Center(
                      child: AppTextWidget(
                        text: 'No permissions available for Safety Violation',
                        color: AppColors.secondaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: showAddButton
            ? SizedBox(
                width: SizeConfig.widthMultiplier * 36,
                height: SizeConfig.heightMultiplier * 6.5,
                child: FloatingActionButton(
                  onPressed: () async {
                    if (await CheckInternet.checkInternet()) {
                      safetyViolationController.searchAllFocusNode.unfocus();
                      safetyViolationController.searchmakerFocusNode.unfocus();
                      safetyViolationController.searchcheckerFocusNode
                          .unfocus();
                      safetyViolationDetailsController.resetAllSafetyData();
                      safetyPreviewController.clearAllFields();
                      safetyViolationDetailsController.resetData();

                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CustomLoadingPopup());
                      await safetyViolationDetailsController
                          .getSafetyViolationData(widget.projectId);

                      Get.back();
                      Get.to(SafetyViolationDetails(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
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
            : SizedBox(),
      ),
    );
  }

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
                  controller:
                      safetyViolationController.searchSafetyAllController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: safetyViolationController.searchAllFocusNode,
                  onFieldSubmitted: (p0) {
                    safetyViolationController.searchAllFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    safetyViolationController.handlesearchAll(
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
            final filteredList =
                sefetyViolationController.filteredSafetyAllList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No Safety Violation Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final safety = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      safetyViolationDetailsCotroller.resetData();
                      await safetyViolationDetailsCotroller
                          .getSafetyViolationAllDetails(
                              widget.projectId, widget.userId, 1, safety.id);
                      safetyViolationController.searchAllFocusNode.unfocus();

                      Get.to(SafetyViolationDetailsAll(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
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
                                          ? DateTime.parse(
                                              safety.createdAt as String)
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
                                    text: safety.status.toString() == "0"
                                        ? 'Open'
                                        : safety.status.toString() == "1"
                                            ? 'Resolved'
                                            : safety.status.toString() == "2"
                                                ? 'Closed'
                                                : "",
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w500,
                                    color: safety.status.toString() == "0"
                                        ? AppColors.buttoncolor // Open → Orange
                                        : safety.status.toString() == "1"
                                            ? Colors.green // Accepted → Green
                                            : safety.status.toString() == "2"
                                                ? Colors.grey // Closed → Grey
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
        ),
      ],
    );
  }

  Widget _buildAssignorTabView() {
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
                  controller:
                      safetyViolationController.searchSafetyAssignorController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: safetyViolationController.searchmakerFocusNode,
                  onFieldSubmitted: (p0) {
                    safetyViolationController.searchmakerFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    safetyViolationController.handlesearchAssignor(
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
            final filteredList =
                sefetyViolationController.filteredSafetyAssignorList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No Safety Violation Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final safety = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      safetyViolationDetailsAssignorCont.clearAllData();

                      await safetyViolationDetailsAssignorCont
                          .getSafetyViolationAssginorDetails(
                              widget.projectId, widget.userId, 2, safety.id);
                      safetyViolationController.searchmakerFocusNode.unfocus();

                      Get.to(SafetyViolationDetailsAssignor(
                          userId: widget.userId,
                          userName: widget.userName,
                          userImg: widget.userImg,
                          userDesg: widget.userDesg,
                          projectId: widget.projectId,
                          safetyId: safety.id,
                          uniqueId: safety.violationUniqueId.toString()));
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
                                          ? DateTime.parse(
                                              safety.createdAt as String)
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
                                    text: safety.status.toString() == "0"
                                        ? 'Open'
                                        : safety.status.toString() == "1"
                                            ? 'Resolved'
                                            : safety.status.toString() == "2"
                                                ? 'Closed'
                                                : "",
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w500,
                                    color: safety.status.toString() == "0"
                                        ? AppColors.buttoncolor // Open → Orange
                                        : safety.status.toString() == "1"
                                            ? Colors.green // Accepted → Green
                                            : safety.status.toString() == "2"
                                                ? Colors.grey // Closed → Grey
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
        ),
      ],
    );
  }

  Widget _buildAssigneeTabView() {
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
                  controller:
                      safetyViolationController.searchSafetyAssigneeController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: safetyViolationController.searchcheckerFocusNode,
                  onFieldSubmitted: (p0) {
                    safetyViolationController.searchcheckerFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    safetyViolationController.handlesearchAssignee(
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
            final filteredList =
                sefetyViolationController.filteredSafetyAssigneeList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No Safety Violation Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final safety = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      safetyViolationDetailsAssigneeCont
                          .resetSafetyAssigneeData();
                      await safetyViolationDetailsAssigneeCont
                          .getSafetyViolationAssigneeDetails(
                              widget.projectId, widget.userId, 3, safety.id);
                      safetyViolationController.searchcheckerFocusNode
                          .unfocus();
                      Get.to(SafetyViolationDetailsAssignee(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
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
                                          ? DateTime.parse(
                                              safety.createdAt as String)
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
                                    text: safety.status.toString() == "0"
                                        ? 'Open'
                                        : safety.status.toString() == "1"
                                            ? 'Resolved'
                                            : safety.status.toString() == "2"
                                                ? 'Closed'
                                                : "",
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w500,
                                    color: safety.status.toString() == "0"
                                        ? AppColors.buttoncolor // Open → Orange
                                        : safety.status.toString() == "1"
                                            ? Colors.green // Accepted → Green
                                            : safety.status.toString() == "2"
                                                ? Colors.grey // Closed → Grey
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
        ),
      ],
    );
  }
}
