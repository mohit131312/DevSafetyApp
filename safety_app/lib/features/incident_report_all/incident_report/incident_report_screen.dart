import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/permission/permission_model.dart';
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

import '../incident_details/incident_details_controller.dart';
import 'incident_report_detailsAll/incident_report_details_all_controller.dart';

class IncidentReportScreen extends StatefulWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;

  const IncidentReportScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });

  @override
  State<IncidentReportScreen> createState() => _IncidentReportScreenState();
}

class _IncidentReportScreenState extends State<IncidentReportScreen>
    with SingleTickerProviderStateMixin {
  late IncidentReportController incidentReportController;
  late TabController tabController;
  final List<Widget> tabs = [];
  final List<Widget> tabViews = [];
  var tablength = false;

  late bool showAddButton;
  var rolename = ''.obs;
  @override
  void initState() {
    super.initState();
    rolename.value = ApiClient.gs.read('role_name');

    incidentReportController = Get.put(IncidentReportController());

    // Determine tabs based on permissions
    final incidentPermissions = Get.find<SelectProjectController>()
        .selectRoles
        .firstWhere(
          (entry) => entry.key == "25",
          orElse: () => MapEntry("25", The23()),
        )
        .value;

    final showAllTab = incidentPermissions.moduleView ?? false;
    final showDoerTab = incidentPermissions.moduleEdit ?? false;
    final showCheckerTab = incidentPermissions.moduleDelete ?? false;
    showAddButton = incidentPermissions.moduleCreate ?? false;

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
      tabViews.add(_buildAssignorTabview());
    }
    if (showCheckerTab) {
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
                  controller:
                      incidentReportController.searchIncidentAllController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: incidentReportController.searchAllFocusNode,
                  onFieldSubmitted: (p0) {
                    incidentReportController.searchAllFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    incidentReportController.handleSearchAll(
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
                incidentReportController.filteredIncidentAllList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No Incident Report Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final incident = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    incidentReportDetailsAllController.resetData();
                    if (await CheckInternet.checkInternet()) {
                      await incidentReportDetailsAllController
                          .getIncidentReportAllDetails(
                              widget.projectId, widget.userId, 1, incident.id);
                      incidentReportController.searchAllFocusNode.unfocus();

                      Get.to(IncidentReportDetailsAllScreen(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
                        incidentId: incident.id,
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
                          text: incident.incidentUiniqueId.toString(),
                          fontSize: AppTextSize.textSizeSmalle,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: incident.incidentDetails!,
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            AppTextWidget(
                              text: (incident.createdAt != null)
                                  ? DateFormat('dd MMMM yyyy').format(incident
                                          .createdAt is String
                                      ? DateTime.parse(
                                          incident.createdAt as String)
                                      : incident.createdAt ?? DateTime.now())
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
                                    text: incident.status.toString() == "0"
                                        ? 'Open'
                                        : incident.status.toString() == "1"
                                            ? 'Accepted'
                                            : incident.status.toString() == "2"
                                                ? 'Closed'
                                                : "",
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w500,
                                    color: incident.status.toString() == "0"
                                        ? AppColors.buttoncolor // Open → Orange
                                        : incident.status.toString() == "1"
                                            ? Colors.green // Accepted → Green
                                            : incident.status.toString() == "2"
                                                ? Colors.grey // Closed → Grey
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
                                          color: Color(parseColor(incident
                                              .severityColor
                                              .toString())),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: AppTextWidget(
                                        text: incident.colorName.toString(),
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
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
        ),
      ],
    );
  }

  Widget _buildAssignorTabview() {
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
                      incidentReportController.searchIncidentAssignorController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: incidentReportController.searchmakerFocusNode,
                  onFieldSubmitted: (p0) {
                    incidentReportController.searchmakerFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    incidentReportController.handleSearchAssignor(
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
                incidentReportController.filteredIncidentAssignorList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No Incident Report Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final incident = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      incidentReportDetailsAssignorCotroller.resetData();
                      incidentReportDetailsAssignorCotroller
                          .resetAssigneeForm();
                      await incidentReportDetailsAssignorCotroller
                          .getIncidentReportAssignorDetails(
                              widget.projectId, widget.userId, 2, incident.id);
                      incidentReportController.searchmakerFocusNode.unfocus();

                      Get.to(IncidentReportDetailsAssignor(
                          userId: widget.userId,
                          userName: widget.userName,
                          userImg: widget.userImg,
                          userDesg: widget.userDesg,
                          projectId: widget.projectId,
                          incidentId: incident.id,
                          uniqueId: incident.incidentUiniqueId.toString()));
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
                          text: incident.incidentUiniqueId.toString(),
                          fontSize: AppTextSize.textSizeSmalle,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: incident.incidentDetails!,
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            AppTextWidget(
                              text: (incident.createdAt != null)
                                  ? DateFormat('dd MMMM yyyy').format(incident
                                          .createdAt is String
                                      ? DateTime.parse(
                                          incident.createdAt as String)
                                      : incident.createdAt ?? DateTime.now())
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
                                    text: incident.status.toString() == "0"
                                        ? 'Open'
                                        : incident.status.toString() == "1"
                                            ? 'Accepted'
                                            : incident.status.toString() == "2"
                                                ? 'Closed'
                                                : 'Unknown',
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w500,
                                    color: incident.status.toString() == "0"
                                        ? AppColors.buttoncolor // Open → Orange
                                        : incident.status.toString() == "1"
                                            ? Colors.green // Accepted → Green
                                            : incident.status.toString() == "2"
                                                ? Colors.grey // Closed → Grey
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
                                          color: Color(parseColor(incident
                                              .severityColor
                                              .toString())),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: AppTextWidget(
                                        text: incident.colorName.toString(),
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
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
                      incidentReportController.searchIncidentAssigneeController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: incidentReportController.searchcheckerFocusNode,
                  onFieldSubmitted: (p0) {
                    incidentReportController.searchcheckerFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    incidentReportController.handleSearchAssignee(
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
                incidentReportController.filteredIncidentAssigneeList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No Incident Report Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final incident = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      incidentReportDetailsAssigneeController.resetData();
                      incidentReportDetailsAssigneeController
                          .resetAssigneeForm();
                      await incidentReportDetailsAssigneeController
                          .getIncidentReportAssigneeDetails(
                              widget.projectId, widget.userId, 3, incident.id);
                      incidentReportController.searchcheckerFocusNode.unfocus();

                      Get.to(IncidentReportDetailsAssignee(
                          userId: widget.userId,
                          userName: widget.userName,
                          userImg: widget.userImg,
                          userDesg: widget.userDesg,
                          projectId: widget.projectId,
                          incidentId: incident.id,
                          uniqueId: incident.incidentUiniqueId.toString()));
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
                          text: incident.incidentUiniqueId.toString(),
                          fontSize: AppTextSize.textSizeSmalle,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: incident.incidentDetails!,
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            AppTextWidget(
                              text: (incident.createdAt != null)
                                  ? DateFormat('dd MMMM yyyy').format(incident
                                          .createdAt is String
                                      ? DateTime.parse(
                                          incident.createdAt as String)
                                      : incident.createdAt ?? DateTime.now())
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
                                    text: incident.status.toString() == "0"
                                        ? 'Open'
                                        : incident.status.toString() == "1"
                                            ? 'Accepted'
                                            : incident.status.toString() == "2"
                                                ? 'Closed'
                                                : 'Unknown',
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w500,
                                    color: incident.status.toString() == "0"
                                        ? AppColors.buttoncolor // Open → Orange
                                        : incident.status.toString() == "1"
                                            ? Colors.green // Accepted → Green
                                            : incident.status.toString() == "2"
                                                ? Colors.grey // Closed → Grey
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
                                          color: Color(parseColor(incident
                                              .severityColor
                                              .toString())),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: AppTextWidget(
                                        text: incident.colorName.toString(),
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
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
                            text:
                                'No permissions available for Incident Report',
                            color: AppColors.secondaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: showAddButton
                ? SizedBox(
                    width: SizeConfig.widthMultiplier * 36,
                    height: SizeConfig.heightMultiplier * 6.5,
                    child: FloatingActionButton(
                      onPressed: () async {
                        incidentReportController.searchAllFocusNode.unfocus();
                        incidentReportController.searchmakerFocusNode.unfocus();
                        incidentReportController.searchcheckerFocusNode
                            .unfocus();

                        incidentDetailsController.resetData();
                        incidentReportController.resetAllLists();
                        incedentReportPreviewController.clearData();
                        incidentMoreDetailsController.resetData();
                        selectInjuredController.resetData();
                        selectAssigneController.clearSelectedData();
                        selectInformedIncidentController.clearSelectedData();
                        incidentAttestationController
                            .clearIncidentattestationSignature();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomLoadingPopup());

                        await incidentReportController
                            .getSafetyIncidentData(widget.projectId);
                        Get.back();
                        Get.to(IncidentDetailsScreen(
                            userId: widget.userId,
                            userName: widget.userName,
                            userImg: widget.userImg,
                            userDesg: widget.userDesg,
                            projectId: widget.projectId));
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
                : SizedBox()));
  }

  int parseColor(String colorString) {
    // Remove # if present
    colorString = colorString.replaceAll("#", "");

    // Add full opacity if only RGB is provided
    if (colorString.length == 6) {
      colorString = "FF$colorString";
    }

    return int.parse("0x$colorString");
  }
}
