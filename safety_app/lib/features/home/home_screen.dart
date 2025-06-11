import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bottom_navigation.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/workpermitlist_item.dart';
import 'package:flutter_app/features/home/home_screen_controller.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_screen.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/features/induction_training/induction_training_screen.dart';
import 'package:flutter_app/features/profile/profile_screen.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/sefety_violation_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/sefety_violation_screen.dart';
import 'package:flutter_app/features/select_project/select_project_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_screen.dart';

import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../components/quick_action_grid.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final int userId, roleId;
  final String selectedproject;
  final int projectId;
  String userName;
  String userImg;
  String userDesg;

  HomeScreen({
    super.key,
    required this.userId,
    required this.roleId,
    required this.selectedproject,
    required this.projectId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
  });

  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final LocationController locationController =
      Get.put(LocationController(), permanent: true);
  final WorkPermitController workPermitController =
      Get.put(WorkPermitController());
  ToolboxTrainingController toolboxTrainingController =
      Get.put(ToolboxTrainingController());
  final IncidentReportController incidentReportController =
      Get.put(IncidentReportController());
  final SefetyViolationController sefetyViolationController =
      Get.put(SefetyViolationController());
  final InductionTrainingController inductionTrainingController =
      Get.put(InductionTrainingController());
  final SelectProjectController selectProjectController = Get.find();
  String getTodayDayDate() {
    final now = DateTime.now();
    final formatter =
        DateFormat('EEEE, MMMM d, yyyy'); // Example: Tuesday, April 30, 2025
    return formatter.format(now);
  }

  Future<void> _refreshData() async {
    await selectProjectController.resetRolesData();
    await selectProjectController.getRolesDetails(userId, roleId, projectId);

    if (selectProjectController.roleStatus.value != 0) {
      await homeScreenController.getWorkPermitAllListing(projectId);
      await homeScreenController.getCardListing(projectId, userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    log('print $userId');

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: false,
          toolbarHeight: SizeConfig.heightMultiplier * 17.5,
          backgroundColor: AppColors.buttoncolor,
          title: SizedBox(
            width: SizeConfig.widthMultiplier * 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: 'Hello!  $userName',
                          fontSize: AppTextSize.textSizeMediumL,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 0.5,
                        ),
                        AppTextWidget(
                          text: getTodayDayDate(),
                          fontSize: AppTextSize.textSizeSmalle,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/icons/project_building.png'),
                      radius: 25,
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 3,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 40,
                          child: Text(
                            selectedproject,
                            style: TextStyle(
                              fontSize: AppTextSize.textSizeMedium,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Obx(() {
                      final location = locationController.currentLocation.value;
                      final city = locationController.cityName.value;

                      return GestureDetector(
                        onTap: () async {
                          await locationController.fetchLocation();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                              size: 26.0,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (location != null)
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 32,
                                child: Text(
                                  city.isNotEmpty
                                      ? '$city'
                                      : 'Fetching city...',
                                  style: TextStyle(
                                    fontSize: AppTextSize.textSizeSmalle,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          color: AppColors.buttoncolor,
          backgroundColor: Colors.white,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          displacement: 40.0, // Distance to pull before triggering refresh
          onRefresh: _refreshData,
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.heightMultiplier * 2.5),

                //------------------------
                SizedBox(
                  height: SizeConfig.heightMultiplier * 14.5,
                  child: Obx(() {
                    if (homeScreenController.workCard.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.buttoncolor),
                        ),
                      );
                    }
                    // Log entitlementIds and workCard for debugging
                    log('Entitlement IDs: ${selectProjectController.entitlementIds}');
                    log('Work Cards: ${homeScreenController.workCard}');

                    // Filter workCard based on entitlementIds
                    final filteredWorkCards =
                        homeScreenController.workCard.where((card) {
                      final title =
                          card['title']?.toString().toLowerCase().trim() ?? '';
                      log('Processing card title: $title'); // Debug title
                      // Map title to entitlement_id
                      int? entitlementId;
                      switch (title) {
                        case 'work permit':
                          entitlementId = 6;
                          break;
                        case 'toolbox training':
                          entitlementId = 5;
                          break;
                        case 'induction training':
                          entitlementId = 3;
                          break;
                        case 'safety violation':
                          entitlementId = 23;
                          break;
                        case 'incident report':
                          entitlementId = 25;
                          break;
                        case 'project labour':
                          entitlementId =
                              null; // No entitlementId, hide unless specified
                          break;
                        default:
                          log('Unknown title: $title, hiding card');
                          return false; // Hide unknown titles
                      }
                      if (entitlementId == null) {
                        log('No entitlementId for title: $title, hiding card');
                        return false; // Hide cards with null entitlementId (e.g., Project Labour)
                      }
                      final isIncluded = selectProjectController.entitlementIds
                          .contains(entitlementId);
                      log('Entitlement ID: $entitlementId, Included: $isIncluded');
                      return isIncluded;
                    }).toList();

                    // Log filtered results
                    log('Filtered Work Cards: $filteredWorkCards');

                    // Handle empty filtered list
                    if (filteredWorkCards.isEmpty) {
                      return const Center(
                          child: Text(
                        'No Cards available for this Role ..',
                        style: TextStyle(
                          fontSize: AppTextSize.textSizeSmalle,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryText,
                        ),
                        textAlign: TextAlign.center,
                      ));
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // itemCount: homeScreenController.workCard.length,
                      itemCount: filteredWorkCards.length,
                      itemBuilder: (context, index) {
                        // final card = homeScreenController.workCard[index];
                        final card = filteredWorkCards[index];
                        final title = card['title'] ?? 'Unknown';
                        final Map<String, dynamic> data = card['data'] ?? {};
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 14.0),
                            width: 300,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6E90B8), Color(0xFF004A94)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.25, 0.6],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: AppTextWidget(
                                            text: title,
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.appwhitecolor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            if (data.containsKey('open')) ...[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const AppTextWidget(
                                                    text: 'Open',
                                                    fontSize: AppTextSize
                                                        .textSizeExtraSmall,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    data['open'].toString(),
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            if (data.containsKey('closed')) ...[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const AppTextWidget(
                                                    text: 'Closed',
                                                    fontSize: AppTextSize
                                                        .textSizeExtraSmall,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    data['closed'].toString(),
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            if (data
                                                .containsKey('accepted')) ...[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const AppTextWidget(
                                                    text: 'Accepted',
                                                    fontSize: AppTextSize
                                                        .textSizeExtraSmall,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    data['accepted'].toString(),
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            if (data
                                                .containsKey('rejected')) ...[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const AppTextWidget(
                                                    text: 'Rejected',
                                                    fontSize: AppTextSize
                                                        .textSizeExtraSmall,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    data['rejected'].toString(),
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            if (data
                                                .containsKey('resolved')) ...[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const AppTextWidget(
                                                    text: 'Resolved',
                                                    fontSize: AppTextSize
                                                        .textSizeExtraSmall,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    data['resolved'].toString(),
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),

                SizedBox(height: SizeConfig.heightMultiplier * 2),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.5,
                      width: SizeConfig.widthMultiplier * 10,
                      child: LinearProgressIndicator(
                        value: 1,
                        backgroundColor: AppColors.searchfeildcolor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.buttoncolor),
                      ),
                    ),
                  ],
                ),
                //-------------------------------
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Selected Project: $projectId");
                        },
                        child: AppTextWidget(
                            text: AppTexts.quickaction,
                            fontSize: AppTextSize.textSizeSmallm,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      QuickActionsGrid(
                          userId: userId,
                          userName: userName,
                          projectId: projectId,
                          userImg: userImg,
                          userDesg: userDesg,
                          selectedproject: selectedproject),
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      Obx(() {
                        if (selectProjectController.entitlementIds
                            .contains(6)) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text: AppTexts.todaywork,
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                              WorkPermitListItem(
                                userId: userId,
                                userName: userName,
                                userImg: userImg,
                                userDesg: userDesg,
                                projectId: projectId,
                              ),
                            ],
                          );
                        } else {
                          // If entitlementIds does not contain 6 → return empty SizedBox (hide)
                          return SizedBox.shrink();
                        }
                      }),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.appwhitecolor,
          items: [
            BottomNavigationBarItem(
              icon: CustomBottomNavItem(
                iconPath: 'assets/icons/Labours.png',
                height: SizeConfig.heightMultiplier * 3.5,
                //    width: 24,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: CustomBottomNavItem(
                onTap: () {},
              ),
              label: "Add New",
            ),
            BottomNavigationBarItem(
              icon: CustomBottomNavItem(
                iconPath: "$baseUrl$userImg",
                isNetwork: true,
                height: SizeConfig.heightMultiplier * 3.5,
                onTap: () async {
                  log('print $userId');

                  Get.to(ProfileScreen(
                    selectedproject: selectedproject,
                    userId: userId,
                    roleId: roleId,
                    userName: userName,
                    userImg: userImg,
                    userDesg: userDesg,
                  ));
                },
                // width: 24,
              ),
              label: "Profile",
            ),
          ],
          selectedLabelStyle: TextStyle(
            fontSize: AppTextSize.textSizeExtraSmall,
            fontWeight: FontWeight.w400,
            color: AppColors.fourtText,
          ),
          selectedItemColor: AppColors.fourtText,
          unselectedItemColor: AppColors.fourtText,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Obx(() => buildFloatingActionButton(context)));
  }

  Widget buildFloatingActionButton(BuildContext context) {
    log('FAB Entitlement IDs: ${selectProjectController.entitlementIds}');
    log('FAB Items: $fabItems');

    // Filter fabItems based on entitlementIds
    final filteredFabItems = fabItems.where((item) {
      final entitlementId = item['entitlement_id'];
      if (entitlementId == null) {
        log('No entitlement_id for FAB item: ${item['title']}, hiding item');
        return false; // Hide items with null entitlement_id
      }
      final isIncluded =
          selectProjectController.entitlementIds.contains(entitlementId);
      log('FAB Item: ${item['title']}, Entitlement ID: $entitlementId, Included: $isIncluded');
      return isIncluded;
    }).toList();

    // Log filtered results
    log('Filtered FAB Items: $filteredFabItems');
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.buttoncolor,
          ),
          child: FloatingActionButton(
              backgroundColor: AppColors.buttoncolor,
              elevation: 0,
              shape: const CircleBorder(),
              child: Icon(
                Icons.add,
                size: 33,
                color: AppColors.primary,
              ),
              onPressed: () {
                if (filteredFabItems.isEmpty) {
                  // Optionally show a message if no items are available
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No actions available')),
                  );
                  return;
                }
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          }, // Tap outside to close
                          child: Container(
                            color: Colors.transparent,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 100, // Adjust above FAB
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              width: SizeConfig.widthMultiplier * 90,
                              padding:
                                  EdgeInsets.only(top: 15, left: 6, right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 3),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 4,
                                      childAspectRatio: 1,
                                    ),
                                    itemCount: filteredFabItems.length,
                                    itemBuilder: (context, index) {
                                      final item = filteredFabItems[index];
                                      final originalIndex =
                                          fabItems.indexOf(item);
                                      return GestureDetector(
                                        onTap: () async {
                                          switch (originalIndex) {
                                            // if (index == 0) {
                                            case 0:
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          CustomLoadingPopup());
                                              await workPermitController
                                                  .getWorkPermitAllListing(
                                                      projectId, userId, 1);
                                              await workPermitController
                                                  .getWorkPermitMakerListing(
                                                      projectId, userId, 2);
                                              await workPermitController
                                                  .getWorkPermitCheckerListing(
                                                      projectId, userId, 3);

                                              Navigator.pop(context);
                                              if (logStatus == true) {
                                                Get.to(() => WorkPermitScreen(
                                                    userId: userId,
                                                    userName: userName,
                                                    userImg: userImg,
                                                    userDesg: userDesg,
                                                    projectId: projectId));
                                                print(
                                                    "Navigating to WorkPermitScreen with:");
                                                print("User ID: $userId");
                                                print("User Name: $userName");
                                                print("Project ID: $projectId");
                                              } else {
                                                logout();
                                              }
                                              break;

                                            case 1:
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          CustomLoadingPopup());
                                              await toolboxTrainingController
                                                  .getToolBoxListingAll(
                                                      projectId, userId, 1);
                                              await toolboxTrainingController
                                                  .getToolBoxListingMaker(
                                                      projectId, userId, 2);
                                              await toolboxTrainingController
                                                  .getToolBoxListingReviewer(
                                                      projectId, userId, 3);

                                              Navigator.pop(context);
                                              if (logStatus == true) {
                                                Get.to(() =>
                                                    ToolboxTrainingScreen(
                                                        userId: userId,
                                                        userName: userName,
                                                        userImg: userImg,
                                                        userDesg: userDesg,
                                                        projectId: projectId));
                                                print(
                                                    "Navigating to ToolboxTrainingScreen with:");
                                                print("User ID: $userId");
                                                print("User Name: $userName");
                                                print("Project ID: $projectId");
                                              } else {
                                                logout();
                                              }
                                              break;
                                            case 2:
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          CustomLoadingPopup());
                                              await inductionTrainingController
                                                  .getProjectDetails();
                                              await inductionTrainingController
                                                  .getInductionListing(
                                                      projectId, userId);

                                              Navigator.pop(context);
                                              if (logStatus == true) {
                                                Get.to(() =>
                                                    InductionTrainingScreen(
                                                      userId: userId,
                                                      userName: userName,
                                                      userImg: userImg,
                                                      userDesg: userDesg,
                                                      projectId: projectId,
                                                    ));
                                                print(
                                                    "Navigating to InductionTrainingScreen with:");
                                                print("User ID: $userId");
                                                print("User Name: $userName");
                                                print("Project ID: $projectId");
                                              } else {
                                                logout();
                                              }
                                              break;
                                            case 3:
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          CustomLoadingPopup());
                                              await sefetyViolationController
                                                  .getSafetyViolationAllListing(
                                                      projectId, userId, 1);
                                              await sefetyViolationController
                                                  .getSafetyViolationAssignorListing(
                                                      projectId, userId, 2);
                                              await sefetyViolationController
                                                  .getSafetyViolationAssigneeListing(
                                                      projectId, userId, 3);

                                              Navigator.pop(context);
                                              if (logStatus == true) {
                                                Get.to(
                                                    () => SefetyViolationScreen(
                                                          userId: userId,
                                                          userName: userName,
                                                          userImg: userImg,
                                                          userDesg: userDesg,
                                                          projectId: projectId,
                                                        ));
                                                print(
                                                    "Navigating to SefetyViolationScreen with:");
                                                print("User ID: $userId");
                                                print("User Name: $userName");
                                              } else {
                                                logout();
                                              }
                                              break;
                                            case 4:
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          CustomLoadingPopup());
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          CustomLoadingPopup());
                                              await incidentReportController
                                                  .getIncidentReportAllListing(
                                                      projectId, userId, 1);
                                              await incidentReportController
                                                  .getIncidentReportAssignorListing(
                                                      projectId, userId, 2);
                                              await incidentReportController
                                                  .getIncidentReportAssigneeListing(
                                                      projectId, userId, 3);

                                              Navigator.pop(context);
                                              if (logStatus == true) {
                                                Get.to(() =>
                                                    IncidentReportScreen(
                                                        userId: userId,
                                                        userName: userName,
                                                        userImg: userImg,
                                                        userDesg: userDesg,
                                                        projectId: projectId));
                                                print(
                                                    "Navigating to IncidentReportScreen with:");
                                                print("User ID: $userId");
                                                print("User Name: $userName");
                                              } else {
                                                logout();
                                              }
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(item['icon'],
                                                height: 30, width: 30),
                                            SizedBox(height: 6),
                                            Flexible(
                                              child: Text(
                                                item['title'],
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: AppTextSize
                                                      .textSizeSmalle,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  final List<Map<String, dynamic>> fabItems = [
    {
      'title': 'Create Work Permit',
      'icon': 'assets/icons/Create_WP.png',
      'entitlement_id': 6
    },
    {
      'title': 'Create TBT',
      'icon': 'assets/icons/Create_TBT.png',
      'entitlement_id': 5
    },
    {
      'title': 'Add Labour',
      'icon': 'assets/icons/Add_Labour.png',
      'entitlement_id': 3
    }, // Or 100 if assigned
    {
      'title': 'Create Safety Violation',
      'icon': 'assets/icons/Create_SA.png',
      'entitlement_id': 23
    },
    {
      'title': 'Create Incident Report',
      'icon': 'assets/icons/Create_IR.png',
      'entitlement_id': 25
    },
  ];
}
