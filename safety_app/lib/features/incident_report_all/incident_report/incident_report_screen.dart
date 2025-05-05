import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/incident_report_all/incedent_report_preview/incedent_report_preview_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_attestation/incident_attestation_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_details/incident_details_screen.dart';
import 'package:flutter_app/features/incident_report_all/incident_more_details/incident_more_details_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_detailsAll/incident_report_details_all_screen.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_details_assignee/incident_report_details_assignee.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_details_assignee/incident_report_details_assignee_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_details_assignor/incident_report_details_assignor.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_details_assignor/incident_report_details_assignor_cotroller.dart';
import 'package:flutter_app/features/incident_report_all/select_assigne/select_assigne_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_informed_people/select_informed_people_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_injured/select_injured_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../incident_details/incident_details_controller.dart';
import 'incident_report_detailsAll/incident_report_details_all_controller.dart';

// ignore: must_be_immutable
class IncidentReportScreen extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;

  IncidentReportScreen(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userImg,
      required this.userDesg,
      required this.projectId});
  final TextEditingController searchController = TextEditingController();
  final IncidentReportController incidentReportController =
      Get.put(IncidentReportController());
  final IncidentDetailsController incidentDetailsController =
      Get.put(IncidentDetailsController());
  final IncidentMoreDetailsController incidentMoreDetailsController =
      Get.put(IncidentMoreDetailsController());
  final SelectInjuredController selectInjuredController = Get.put(
    SelectInjuredController(),
  );

  final SelectInformedIncidentController selectInformedIncidentController =
      Get.put(SelectInformedIncidentController());

  final SelectAssigneController selectAssigneController =
      Get.put(SelectAssigneController());
  final IncidentAttestationController incidentAttestationController =
      Get.put(IncidentAttestationController());
  final IncedentReportPreviewController incedentReportPreviewController =
      Get.put(IncedentReportPreviewController());
  final IncidentReportDetailsAllController incidentReportDetailsAllController =
      Get.put(IncidentReportDetailsAllController());
  final IncidentReportDetailsAssigneeController
      incidentReportDetailsAssigneeController =
      Get.put(IncidentReportDetailsAssigneeController());
  final IncidentReportDetailsAssignorCotroller
      incidentReportDetailsAssignorCotroller =
      Get.put(IncidentReportDetailsAssignorCotroller());
  final LocationController locationController = Get.find();
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
                text: 'Incident Report',
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

                          switch (
                              incidentReportController.selectedOption.value) {
                            case 0:
                              activeController = incidentReportController
                                  .searchIncidentAllController;
                              break;
                            case 1:
                              activeController = incidentReportController
                                  .searchIncidentAssignorController;
                              break;
                            case 2:
                              activeController = incidentReportController
                                  .searchIncidentAssigneeController;
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
                              incidentReportController.handleSearchByTab(
                                incidentReportController.selectedOption.value,
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
                  controller: incidentReportController.tabController,
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
                        text: 'Assignor',
                      ),
                    ),
                    SizedBox(
                      child: const Tab(
                        text: 'Assignee',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: incidentReportController.tabController,
                  children: [
                    Obx(() {
                      final filteredList =
                          incidentReportController.filteredIncidentAllList;
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final incident = filteredList[index];

                          return GestureDetector(
                            onTap: () async {
                              log('----------------------------${incidentReportController.selectedOption.value}');
                              incidentReportDetailsAllController.resetData();
                              await incidentReportDetailsAllController
                                  .getIncidentReportAllDetails(
                                      projectId, userId, 1, incident.id);

                              Get.to(IncidentReportDetailsAllScreen(
                                userId: userId,
                                userName: userName,
                                userImg: userImg,
                                userDesg: userDesg,
                                projectId: projectId,
                                incidentId: incident.id,
                              ));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: AppTextWidget(
                                    text: incident.id.toString(),
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: incident.incidentDetails!,
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                      AppTextWidget(
                                        text: (incident.createdAt != null)
                                            ? DateFormat('dd MMMM yyyy').format(
                                                incident.createdAt is String
                                                    ? DateTime.parse(incident
                                                        .createdAt as String)
                                                    : incident.createdAt ??
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
                                        left: 12, right: 12, top: 8, bottom: 3),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [
                                            AppTextWidget(
                                              text: incident.status
                                                          .toString() ==
                                                      "0"
                                                  ? 'Open'
                                                  : incident.status
                                                              .toString() ==
                                                          "1"
                                                      ? 'Accepted'
                                                      : incident.status
                                                                  .toString() ==
                                                              "2"
                                                          ? 'Closed'
                                                          : "",
                                              fontSize: AppTextSize
                                                  .textSizeExtraSmall,
                                              fontWeight: FontWeight.w500,
                                              color: incident.status
                                                          .toString() ==
                                                      "0"
                                                  ? AppColors
                                                      .buttoncolor // Open → Orange
                                                  : incident.status
                                                              .toString() ==
                                                          "1"
                                                      ? Colors
                                                          .green // Accepted → Green
                                                      : incident.status
                                                                  .toString() ==
                                                              "2"
                                                          ? Colors
                                                              .grey // Closed → Grey
                                                          : Colors.black,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                width: 80,
                                                height: 23,
                                                decoration: BoxDecoration(
                                                    color: Color(_parseColor(
                                                        incident.severityColor
                                                            .toString())),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: AppTextWidget(
                                                  text: incident.colorName
                                                      .toString(),
                                                  fontSize: AppTextSize
                                                      .textSizeExtraSmall,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                )),
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
                          incidentReportController.filteredIncidentAssignorList;
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final incident = filteredList[index];

                          return GestureDetector(
                            onTap: () async {
                              log('----------------------------${incidentReportController.selectedOption.value}');
                              log('----------------------------${incidentReportController.selectedOption.value}');
                              incidentReportDetailsAssignorCotroller
                                  .resetData();
                              incidentReportDetailsAssignorCotroller
                                  .resetAssigneeForm();
                              await incidentReportDetailsAssignorCotroller
                                  .getIncidentReportAssignorDetails(
                                      projectId, userId, 2, incident.id);

                              Get.to(IncidentReportDetailsAssignor(
                                userId: userId,
                                userName: userName,
                                userImg: userImg,
                                userDesg: userDesg,
                                projectId: projectId,
                                incidentId: incident.id,
                              ));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: AppTextWidget(
                                    text: incident.id.toString(),
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: incident.incidentDetails!,
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                      AppTextWidget(
                                        text: (incident.createdAt != null)
                                            ? DateFormat('dd MMMM yyyy').format(
                                                incident.createdAt is String
                                                    ? DateTime.parse(incident
                                                        .createdAt as String)
                                                    : incident.createdAt ??
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
                                        left: 12, right: 12, top: 8, bottom: 3),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [
                                            AppTextWidget(
                                              text: incident.status
                                                          .toString() ==
                                                      "0"
                                                  ? 'Open'
                                                  : incident.status
                                                              .toString() ==
                                                          "1"
                                                      ? 'Accepted'
                                                      : incident.status
                                                                  .toString() ==
                                                              "2"
                                                          ? 'Closed'
                                                          : 'Unknown',
                                              fontSize: AppTextSize
                                                  .textSizeExtraSmall,
                                              fontWeight: FontWeight.w500,
                                              color: incident.status
                                                          .toString() ==
                                                      "0"
                                                  ? AppColors
                                                      .buttoncolor // Open → Orange
                                                  : incident.status
                                                              .toString() ==
                                                          "1"
                                                      ? Colors
                                                          .green // Accepted → Green
                                                      : incident.status
                                                                  .toString() ==
                                                              "2"
                                                          ? Colors
                                                              .grey // Closed → Grey
                                                          : Colors.black,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                width: 80,
                                                height: 23,
                                                decoration: BoxDecoration(
                                                    color: Color(_parseColor(
                                                        incident.severityColor
                                                            .toString())),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: AppTextWidget(
                                                  text: incident.colorName
                                                      .toString(),
                                                  fontSize: AppTextSize
                                                      .textSizeExtraSmall,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                )),
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
                          incidentReportController.filteredIncidentAssigneeList;
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final incident = filteredList[index];

                          return GestureDetector(
                            onTap: () async {
                              log('----------------------------${incidentReportController.selectedOption.value}');
                              incidentReportDetailsAssigneeController
                                  .resetData();
                              incidentReportDetailsAssigneeController
                                  .resetAssigneeForm();
                              await incidentReportDetailsAssigneeController
                                  .getIncidentReportAssigneeDetails(
                                      projectId, userId, 3, incident.id);

                              Get.to(IncidentReportDetailsAssignee(
                                userId: userId,
                                userName: userName,
                                userImg: userImg,
                                userDesg: userDesg,
                                projectId: projectId,
                                incidentId: incident.id,
                              ));
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: AppTextWidget(
                                    text: incident.id.toString(),
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: incident.incidentDetails!,
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                      AppTextWidget(
                                        text: (incident.createdAt != null)
                                            ? DateFormat('dd MMMM yyyy').format(
                                                incident.createdAt is String
                                                    ? DateTime.parse(incident
                                                        .createdAt as String)
                                                    : incident.createdAt ??
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
                                        left: 12, right: 12, top: 8, bottom: 3),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [
                                            AppTextWidget(
                                              text: incident.status
                                                          .toString() ==
                                                      "0"
                                                  ? 'Open'
                                                  : incident.status
                                                              .toString() ==
                                                          "1"
                                                      ? 'Accepted'
                                                      : incident.status
                                                                  .toString() ==
                                                              "2"
                                                          ? 'Closed'
                                                          : 'Unknown',
                                              fontSize: AppTextSize
                                                  .textSizeExtraSmall,
                                              fontWeight: FontWeight.w500,
                                              color: incident.status
                                                          .toString() ==
                                                      "0"
                                                  ? AppColors
                                                      .buttoncolor // Open → Orange
                                                  : incident.status
                                                              .toString() ==
                                                          "1"
                                                      ? Colors
                                                          .green // Accepted → Green
                                                      : incident.status
                                                                  .toString() ==
                                                              "2"
                                                          ? Colors
                                                              .grey // Closed → Grey
                                                          : Colors.black,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                width: 80,
                                                height: 23,
                                                decoration: BoxDecoration(
                                                    color: Color(_parseColor(
                                                        incident.severityColor
                                                            .toString())),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: AppTextWidget(
                                                  text: incident.colorName
                                                      .toString(),
                                                  fontSize: AppTextSize
                                                      .textSizeExtraSmall,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                )),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Obx(() {
            int selectedIndex = incidentReportController.selectedOption.value;

            return (selectedIndex == 0 || selectedIndex == 1)
                ? SizedBox(
                    width: SizeConfig.widthMultiplier * 36,
                    height: SizeConfig.heightMultiplier * 6.5,
                    child: FloatingActionButton(
                      onPressed: () async {
                        locationController.fetchLocation();

                        incidentDetailsController.resetData();
                        incidentReportController.resetAllLists();
                        incedentReportPreviewController.clearData();
                        incidentMoreDetailsController.resetData();
                        selectInjuredController.resetData();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomLoadingPopup());

                        await incidentReportController
                            .getSafetyIncidentData(projectId);
                        Get.back();
                        Get.to(IncidentDetailsScreen(
                            userId: userId,
                            userName: userName,
                            userImg: userImg,
                            userDesg: userDesg,
                            projectId: projectId));
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
        ));
  }

  int _parseColor(String colorString) {
    // Remove # if present
    colorString = colorString.replaceAll("#", "");

    // Add full opacity if only RGB is provided
    if (colorString.length == 6) {
      colorString = "FF$colorString";
    }

    return int.parse("0x$colorString");
  }
}
