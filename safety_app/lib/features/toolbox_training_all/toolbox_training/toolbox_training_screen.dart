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
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
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

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(SizeConfig.heightMultiplier * 10),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: AppBar(
                scrolledUnderElevation: 0.0,
                elevation: 0,
                backgroundColor: AppColors.buttoncolor,
                foregroundColor: AppColors.buttoncolor,
                centerTitle: true,
                toolbarHeight: SizeConfig.heightMultiplier * 10,
                title: Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
                  child: AppTextWidget(
                    text: AppTexts.toolboxtraining,
                    fontSize: AppTextSize.textSizeMedium,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                ),
                leading: Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
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
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 2,
                      right: SizeConfig.widthMultiplier * 5,
                    ),
                    child: Image.asset(
                      "assets/icons/frame_icon.png",
                      height: SizeConfig.imageSizeMultiplier * 6,
                      width: SizeConfig.imageSizeMultiplier * 6,
                    ),
                  )
                ],
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
                              toolboxTrainingController.selectedOption.value) {
                            case 0:
                              activeController = toolboxTrainingController
                                  .searchtoolAllController;
                              break;
                            case 1:
                              activeController = toolboxTrainingController
                                  .searchtoolMakerController;
                              break;
                            case 2:
                              activeController = toolboxTrainingController
                                  .searchtoolReviwerController;
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
                        text: AppTexts.maker,
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
                          final work = filteredList[index];

                          return GestureDetector(
                            onTap: () async {
                              // log('----------------------------${workPermitController.selectedOption.value}');
                              // await workPermitAllController
                              //     .getWorkPermitAllDetails(
                              //         projectId, userId, 1, work.id);
                              // Get.to(WorkPermitAllDetails(
                              //   userId: userId,
                              //   userName: userName,
                              //   userImg: userImg,
                              //   userDesg: userDesg,
                              //   projectId: projectId,
                              //   wpId: work.id,
                              // ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: AppTextWidget(
                                    text: work.nameOfTbTraining,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: work.details,
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
                                  trailing: AppTextWidget(
                                    text: work.status.toString() == "0"
                                        ? "Open"
                                        : "Closed",
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w500,
                                    color: work.status.toString() == "0"
                                        ? AppColors.buttoncolor
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
                          final work = filteredList[index];

                          return GestureDetector(
                            onTap: () async {
                              // log('----------------------------${workPermitController.selectedOption.value}');
                              // await workPermitAllController
                              //     .getWorkPermitAllDetails(
                              //         projectId, userId, 1, work.id);
                              // Get.to(WorkPermitAllDetails(
                              //   userId: userId,
                              //   userName: userName,
                              //   userImg: userImg,
                              //   userDesg: userDesg,
                              //   projectId: projectId,
                              //   wpId: work.id,
                              // ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: AppTextWidget(
                                    text: work.nameOfTbTraining,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: work.details,
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
                                  trailing: AppTextWidget(
                                    text: work.status.toString() == "0"
                                        ? "Open"
                                        : "Closed",
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w500,
                                    color: work.status.toString() == "0"
                                        ? AppColors.buttoncolor
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
                          final work = filteredList[index];

                          return GestureDetector(
                            onTap: () async {
                              // log('----------------------------${workPermitController.selectedOption.value}');
                              // await workPermitAllController
                              //     .getWorkPermitAllDetails(
                              //         projectId, userId, 1, work.id);
                              // Get.to(WorkPermitAllDetails(
                              //   userId: userId,
                              //   userName: userName,
                              //   userImg: userImg,
                              //   userDesg: userDesg,
                              //   projectId: projectId,
                              //   wpId: work.id,
                              // ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: AppTextWidget(
                                    text: work.nameOfTbTraining,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: work.details,
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
                                  trailing: AppTextWidget(
                                    text: work.status.toString() == "0"
                                        ? "Open"
                                        : "Closed",
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w500,
                                    color: work.status.toString() == "0"
                                        ? AppColors.buttoncolor
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
                        toolboxPreviewCotroller.resetAllData();
                        toolboxTDetailsController.resetTdetailsAllData();
                        toolboxAddTraineeController.clearAllData();
                        selectTraineeController.clearAllTrainneData();
                        toolboxAttestationController.clearAllData();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomLoadingPopup());

                        await toolboxTrainingController.getSafetyIncidentData(
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
