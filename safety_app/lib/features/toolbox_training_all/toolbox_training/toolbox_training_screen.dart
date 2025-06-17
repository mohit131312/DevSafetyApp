import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/permission/permission_model.dart';
import 'package:flutter_app/features/select_project/select_project_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/select_reviewer/select_reviewer_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/seletc_trainee/select_trainee_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_add_trainee/toolbox_add_trainee_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_attestation/toolbox_attestation_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_preview/toolbox_preview_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_t_details/toolbox_t_details_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_t_details/toolbox_t_details_screen.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_all_list_details/toolbox_training_all_listdet.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_all_list_details/toolbox_training_all_listdet_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_maker/toolbox_training_maker_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_maker/toolbox_training_maker_screen.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_reviewer/toolbox_training_reviewer.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_reviewer/toolbox_training_reviewer_controller.dart';
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

class ToolboxTrainingScreen extends StatefulWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  const ToolboxTrainingScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });

  @override
  State<ToolboxTrainingScreen> createState() => _ToolboxTrainingScreenState();
}

class _ToolboxTrainingScreenState extends State<ToolboxTrainingScreen>
    with SingleTickerProviderStateMixin {
  late ToolboxTrainingController toolboxTrainingController;
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

    toolboxTrainingController = Get.put(ToolboxTrainingController());

    final toolboxPermissions = Get.find<SelectProjectController>()
        .selectRoles
        .firstWhere(
          (entry) => entry.key == "5",
          orElse: () => MapEntry("5", The23()),
        )
        .value;

    final showAllTab = toolboxPermissions.moduleView ?? false;
    final showDoerTab = toolboxPermissions.moduleEdit ?? true;
    final showReviewerTab = toolboxPermissions.moduleDelete ?? false;
    showAddButton = toolboxPermissions.moduleCreate ?? false;

    if (showAllTab) {
      tabs.add(SizedBox(
          width: SizeConfig.widthMultiplier * 35,
          child: const Tab(text: AppTexts.all)));
      tabViews.add(_buildAllTab());
    }
    if (showDoerTab) {
      tabs.add(SizedBox(
          width: SizeConfig.widthMultiplier * 35,
          child: Tab(text: rolename.value)));
      tabViews.add(_buildMakerTab());
    }
    if (showReviewerTab) {
      tabs.add(SizedBox(
          width: SizeConfig.widthMultiplier * 35,
          child: Tab(text: rolename.value)));
      tabViews.add(_buildCheckerTab());
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

  final ToolboxTDetailsController toolboxTDetailsController =
      Get.put(ToolboxTDetailsController());
  final SelectReviewerController selectReviewerController =
      Get.put(SelectReviewerController());
  final ToolboxAddTraineeController toolboxAddTraineeController =
      Get.put(ToolboxAddTraineeController());
  final SelectTraineeController selectTraineeController =
      Get.put(SelectTraineeController());
  final ToolboxAttestationController toolboxAttestationController =
      Get.put(ToolboxAttestationController());
  final ToolboxPreviewController toolboxPreviewController =
      Get.put(ToolboxPreviewController());
  final ToolboxTrainingAllListdetController
      toolboxTrainingAllListdetController =
      Get.put(ToolboxTrainingAllListdetController());
  final ToolboxTrainingMakerController toolboxTrainingMakerController =
      Get.put(ToolboxTrainingMakerController());
  final ToolboxTrainingReviewerController toolboxTrainingReviewerController =
      Get.put(ToolboxTrainingReviewerController());
  final SelectProjectController selectProjectController =
      Get.find<SelectProjectController>();
  Widget _buildAllTab() {
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
                  controller: toolboxTrainingController.searchtoolAllController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: toolboxTrainingController.searchAllListFocusNode,
                  onFieldSubmitted: (p0) {
                    toolboxTrainingController.searchAllListFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    toolboxTrainingController.handleSearchAll(
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
                toolboxTrainingController.filteredtoolboxAllList;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No ToolBox Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final tool = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CustomLoadingPopup());
                      toolboxTrainingAllListdetController.resetData();
                      await toolboxTrainingAllListdetController
                          .gettoolBoxAllDetails(
                              widget.projectId, widget.userId, 1, tool.id);
                      Get.back();
                      toolboxTrainingController.searchAllListFocusNode
                          .unfocus();
                      Get.to(ToolboxTrainingAllListdet(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
                        toolBox: tool.id,
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
                              text: tool.tooluniqueId!,
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            AppTextWidget(
                              text: tool.nameOfTbTraining,
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
                              text: tool.details,
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            AppTextWidget(
                              text: (tool.createdAt != null)
                                  ? DateFormat('dd MMMM yyyy').format(tool
                                          .createdAt is String
                                      ? DateTime.parse(tool.createdAt as String)
                                      : tool.createdAt ?? DateTime.now())
                                  : '',
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                          ],
                        ),
                        trailing: AppTextWidget(
                          text: tool.status.toString() == "0"
                              ? "Open"
                              : tool.status.toString() == "1"
                                  ? "Accepted"
                                  : "Closed",
                          fontSize: AppTextSize.textSizeExtraSmall,
                          fontWeight: FontWeight.w500,
                          color: tool.status.toString() == "0"
                              ? AppColors.buttoncolor
                              : tool.status.toString() == "1"
                                  ? Colors.green
                                  : AppColors.secondaryText,
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

  Widget _buildMakerTab() {
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
                      toolboxTrainingController.searchtoolMakerController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: toolboxTrainingController.searchMakerFocusNode,
                  onFieldSubmitted: (p0) {
                    toolboxTrainingController.searchMakerFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    toolboxTrainingController.handleSearchDoer(
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
                toolboxTrainingController.filteredtoolboxListMaker;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No ToolBox Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final tool = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CustomLoadingPopup());
                      toolboxTrainingMakerController.cleartoolboxComment();
                      await toolboxTrainingMakerController
                          .gettoolBoxMakerDetails(
                              widget.projectId, widget.userId, 2, tool.id);
                      Get.back();
                      toolboxTrainingController.searchMakerFocusNode.unfocus();
                      Get.to(ToolboxTrainingMakerScreen(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
                        toolBox: tool.id,
                        uniqueId: tool.tooluniqueId!,
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
                              text: tool.tooluniqueId!,
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            AppTextWidget(
                              text: tool.nameOfTbTraining,
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
                              text: tool.details,
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            AppTextWidget(
                              text: (tool.createdAt != null)
                                  ? DateFormat('dd MMMM yyyy').format(tool
                                          .createdAt is String
                                      ? DateTime.parse(tool.createdAt as String)
                                      : tool.createdAt ?? DateTime.now())
                                  : '',
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                          ],
                        ),
                        trailing: AppTextWidget(
                          text: tool.status.toString() == "0"
                              ? "Open"
                              : tool.status.toString() == "1"
                                  ? "Accepted"
                                  : "Closed",
                          fontSize: AppTextSize.textSizeExtraSmall,
                          fontWeight: FontWeight.w500,
                          color: tool.status.toString() == "0"
                              ? AppColors.buttoncolor
                              : tool.status.toString() == "1"
                                  ? Colors.green
                                  : AppColors.secondaryText,
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

  Widget _buildCheckerTab() {
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
                      toolboxTrainingController.searchtoolReviwerController,
                  hintText: 'Search By Name..',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: toolboxTrainingController.searchReviewerFocusNode,
                  onFieldSubmitted: (p0) {
                    toolboxTrainingController.searchReviewerFocusNode.unfocus();
                  },
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/Search.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  onChanged: (value) {
                    toolboxTrainingController.handleSearchChecker(
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
                toolboxTrainingController.filteredtoolboxListReviewer;
            if (filteredList.isEmpty) {
              return Center(
                child: AppTextWidget(
                  text: 'No ToolBox Available',
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              );
            }
            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final tool = filteredList[index];

                return GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      toolboxTrainingReviewerController.cleartoolboxComment();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CustomLoadingPopup());
                      await toolboxTrainingReviewerController
                          .gettoolBoxreviewerDetails(
                              widget.projectId, widget.userId, 3, tool.id);
                      Get.back();
                      toolboxTrainingController.searchReviewerFocusNode
                          .unfocus();
                      Get.to(ToolboxTrainingReviewer(
                        userId: widget.userId,
                        userName: widget.userName,
                        userImg: widget.userImg,
                        userDesg: widget.userDesg,
                        projectId: widget.projectId,
                        toolBox: tool.id,
                        uniqueId: tool.tooluniqueId!,
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
                              text: tool.tooluniqueId!,
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            AppTextWidget(
                              text: tool.nameOfTbTraining,
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
                              text: tool.details,
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            AppTextWidget(
                              text: (tool.createdAt != null)
                                  ? DateFormat('dd MMMM yyyy').format(tool
                                          .createdAt is String
                                      ? DateTime.parse(tool.createdAt as String)
                                      : tool.createdAt ?? DateTime.now())
                                  : '',
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                          ],
                        ),
                        trailing: AppTextWidget(
                          text: tool.status.toString() == "0"
                              ? "Open"
                              : tool.status.toString() == "1"
                                  ? "Accepted"
                                  : "Closed",
                          fontSize: AppTextSize.textSizeExtraSmall,
                          fontWeight: FontWeight.w500,
                          color: tool.status.toString() == "0"
                              ? AppColors.buttoncolor
                              : tool.status.toString() == "1"
                                  ? Colors.green
                                  : AppColors.secondaryText,
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
                  text: AppTexts.toolboxtraining,
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
                          text: 'No permissions available for Toolbox Training',
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
                    width: SizeConfig.widthMultiplier * 36,
                    height: SizeConfig.heightMultiplier * 6.5,
                    child: FloatingActionButton(
                      onPressed: () async {
                        if (await CheckInternet.checkInternet()) {
                          toolboxPreviewController.resetAllData();
                          toolboxTDetailsController.resetTdetailsAllData();
                          toolboxAddTraineeController.clearAllData();
                          selectTraineeController.clearAllTrainneData();
                          toolboxAttestationController.clearAllData();
                          selectReviewerController.clearReviewerData();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomLoadingPopup());
                          toolboxTrainingController.searchReviewerFocusNode
                              .unfocus();
                          toolboxTrainingController.searchMakerFocusNode
                              .unfocus();
                          toolboxTrainingController.searchAllListFocusNode
                              .unfocus();
                          await toolboxTrainingController.getToolBoxData(
                              widget.projectId, widget.userId);

                          Get.back();
                          Get.to(ToolboxTDetailsScreen(
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
}
