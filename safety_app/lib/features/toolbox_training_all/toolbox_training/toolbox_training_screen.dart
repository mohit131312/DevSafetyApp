import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
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
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ToolboxTrainingScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  ToolboxTrainingScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });
  ToolboxTrainingController toolboxTrainingController =
      Get.put(ToolboxTrainingController());
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
  final ToolboxPreviewController toolboxPreviewCotroller =
      Get.put(ToolboxPreviewController());

  final ToolboxTrainingAllListdetController
      toolboxTrainingAllListdetController =
      Get.put(ToolboxTrainingAllListdetController());
  final ToolboxTrainingMakerController toolboxTrainingMakerController =
      Get.put(ToolboxTrainingMakerController());
  final ToolboxTrainingReviewerController toolboxTrainingReviewerController =
      Get.put(ToolboxTrainingReviewerController());
  final TextEditingController searchController = TextEditingController();
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 2,
                ),
                child: SizedBox(
                  height: SizeConfig.heightMultiplier * 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 6,
                        width: SizeConfig.widthMultiplier * 92,
                        child: Obx(() {
                          switch (
                              toolboxTrainingController.selectedOption.value) {
                            case 0:
                              toolboxTrainingController.activeController =
                                  toolboxTrainingController
                                      .searchtoolAllController;
                              break;
                            case 1:
                              toolboxTrainingController.activeController =
                                  toolboxTrainingController
                                      .searchtoolMakerController;
                              break;
                            case 2:
                              toolboxTrainingController.activeController =
                                  toolboxTrainingController
                                      .searchtoolReviwerController;
                              break;
                            default:
                              toolboxTrainingController.activeController =
                                  TextEditingController(); // fallback
                          }

                          return AppTextFormfeild(
                            controller:
                                toolboxTrainingController.activeController,
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
                              toolboxTrainingController.handleSearchByTab(
                                toolboxTrainingController.selectedOption.value,
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
                  controller: toolboxTrainingController.tabController,
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
                        text: "Doer",
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 20,
                      child: const Tab(
                        text: AppTexts.reviewer,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.widthMultiplier * 3,
              ),
              Expanded(
                child: TabBarView(
                  controller: toolboxTrainingController.tabController,
                  children: [
                    Obx(() {
                      final filteredList =
                          toolboxTrainingController.filteredtoolboxAllList;
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
                                log('----------------------------${toolboxTrainingController.selectedOption.value}');
                                toolboxTrainingAllListdetController.resetData();
                                await toolboxTrainingAllListdetController
                                    .gettoolBoxAllDetails(
                                        projectId, userId, 1, tool.id);
                                Get.back();
                                Get.to(ToolboxTrainingAllListdet(
                                  userId: userId,
                                  userName: userName,
                                  userImg: userImg,
                                  userDesg: userDesg,
                                  projectId: projectId,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: tool.details,
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                      AppTextWidget(
                                        text: (tool.createdAt != null)
                                            ? DateFormat('dd MMMM yyyy').format(
                                                tool.createdAt is String
                                                    ? DateTime.parse(tool
                                                        .createdAt as String)
                                                    : tool.createdAt ??
                                                        DateTime.now())
                                            : '',
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
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
                    Obx(() {
                      final filteredList =
                          toolboxTrainingController.filteredtoolboxListMaker;
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final tool = filteredList[index];

                          return GestureDetector(
                            onTap: () async {
                              log('----------------------------${toolboxTrainingController.selectedOption.value}');
                              if (await CheckInternet.checkInternet()) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomLoadingPopup());
                                toolboxTrainingMakerController
                                    .cleartoolboxComment();
                                await toolboxTrainingMakerController
                                    .gettoolBoxMakerDetails(
                                        projectId, userId, 2, tool.id);
                                Get.back();
                                Get.to(ToolboxTrainingMakerScreen(
                                  userId: userId,
                                  userName: userName,
                                  userImg: userImg,
                                  userDesg: userDesg,
                                  projectId: projectId,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: tool.details,
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                      AppTextWidget(
                                        text: (tool.createdAt != null)
                                            ? DateFormat('dd MMMM yyyy').format(
                                                tool.createdAt is String
                                                    ? DateTime.parse(tool
                                                        .createdAt as String)
                                                    : tool.createdAt ??
                                                        DateTime.now())
                                            : '',
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
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
                    Obx(() {
                      final filteredList =
                          toolboxTrainingController.filteredtoolboxListReviewer;
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final tool = filteredList[index];

                          return GestureDetector(
                            onTap: () async {
                              if (await CheckInternet.checkInternet()) {
                                toolboxTrainingReviewerController
                                    .cleartoolboxComment();
                                log('----------------------------${toolboxTrainingController.selectedOption.value}');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomLoadingPopup());
                                await toolboxTrainingReviewerController
                                    .gettoolBoxreviewerDetails(
                                        projectId, userId, 3, tool.id);
                                Get.back();
                                Get.to(ToolboxTrainingReviewer(
                                  userId: userId,
                                  userName: userName,
                                  userImg: userImg,
                                  userDesg: userDesg,
                                  projectId: projectId,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: tool.details,
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                      AppTextWidget(
                                        text: (tool.createdAt != null)
                                            ? DateFormat('dd MMMM yyyy').format(
                                                tool.createdAt is String
                                                    ? DateTime.parse(tool
                                                        .createdAt as String)
                                                    : tool.createdAt ??
                                                        DateTime.now())
                                            : '',
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
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
                  ],
                ),
              ),
              // ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Obx(() {
            int selectedIndex = toolboxTrainingController.selectedOption.value;

            return (selectedIndex == 0 || selectedIndex == 1)
                ? SizedBox(
                    width: SizeConfig.widthMultiplier * 36,
                    height: SizeConfig.heightMultiplier * 6.5,
                    child: FloatingActionButton(
                      onPressed: () async {
                        if (await CheckInternet.checkInternet()) {
                          toolboxPreviewCotroller.resetAllData();
                          toolboxTDetailsController.resetTdetailsAllData();
                          toolboxAddTraineeController.clearAllData();
                          selectTraineeController.clearAllTrainneData();
                          toolboxAttestationController.clearAllData();
                          selectReviewerController.clearReviewerData();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomLoadingPopup());
                          await toolboxTrainingController.getToolBoxData(
                              projectId, userId);

                          // await toolboxTrainingController.getInstructionData(
                          //     projectId, userId, userId);
                          Get.back();
                          Get.to(ToolboxTDetailsScreen(
                              userId: userId,
                              userName: userName,
                              userImg: userImg,
                              userDesg: userDesg,
                              projectId: projectId));
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
        ));
  }
}
