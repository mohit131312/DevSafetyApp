import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_checker/work_permit_checker_details/work_permit_checkers_details.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/assign_checker/assign_checker_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_date/work_Permit_date_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_details/work_permit_details_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_precaution/work_permit_precaution_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_preview/work_permit_preview_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_undertaking/work_permit_under_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

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

  final WorkPermitDateController dateController =
      Get.put(WorkPermitDateController());
  final WorkPermitPrecautionController workPermitPrecautionController =
      Get.put(WorkPermitPrecautionController());
  final NewWorkPermitController newWorkPermitController =
      Get.put(NewWorkPermitController());
  final WorkPermitUnderController workPermitUnderController =
      Get.put(WorkPermitUnderController());
  final WorkPermitPreviewController workPermitPreviewController =
      Get.put(WorkPermitPreviewController());
  final AssignCheckerController assignCheckerController =
      Get.put(AssignCheckerController());
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
                    text: 'Work Permit',
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
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search here..',
                      hintStyle: TextStyle(
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.searchfeildcolor,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.searchfeildcolor,
                        size: 30,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: AppColors.searchfeildcolor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: AppColors.searchfeildcolor, width: 1),
                      ),
                    ),
                    onChanged: (value) {
                      workPermitController.searchLabor(value);
                    },
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
              Obx(
                () => Expanded(
                  child: TabBarView(
                    controller: workPermitController.tabController,
                    children: [
                      ListView.builder(
                        //    shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        itemCount: workPermitController.filteredDetails.length,
                        itemBuilder: (context, index) {
                          var item =
                              workPermitController.filteredDetails[index];
                          return Column(
                            children: [
                              ListTile(
                                title: AppTextWidget(
                                  text: item['title']!,
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: item['subtitle']!,
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                    AppTextWidget(
                                      text: item['date']!,
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
                                        text: item['text']!,
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.buttoncolor,
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
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          log('----------------------------${workPermitController.selectedOption.value}');

                          if (workPermitController.selectedOption.value == 0) {
                            Get.to(WorkPermitDetailsScreen());
                          }
                        },
                        child: ListView.builder(
                          //    shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              workPermitController.filteredDetails.length,
                          itemBuilder: (context, index) {
                            var item =
                                workPermitController.filteredDetails[index];
                            return Column(
                              children: [
                                ListTile(
                                  title: AppTextWidget(
                                    text: item['title']!,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: item['subtitle']!,
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                      AppTextWidget(
                                        text: item['date']!,
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
                                          text: item['text']!,
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.buttoncolor,
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
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          log('----------------------------${workPermitController.selectedOption.value}');
                          if (workPermitController.selectedOption.value == 0) {
                            Get.to(WorkPermitCheckersDetails());
                          }
                        },
                        child: ListView.builder(
                          //    shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              workPermitController.filteredDetails.length,
                          itemBuilder: (context, index) {
                            var item =
                                workPermitController.filteredDetails[index];
                            return Column(
                              children: [
                                ListTile(
                                  title: AppTextWidget(
                                    text: item['title']!,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: item['subtitle']!,
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryText,
                                      ),
                                      AppTextWidget(
                                        text: item['date']!,
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
                                          text: item['text']!,
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.buttoncolor,
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
                        workPermitPreviewController.clearAllData();
                        newWorkPermitController.resetData();
                        workPermitPrecautionController.resetData();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomLoadingPopup());
                        await workPermitController.getWorkPermitData(projectId);
                        Get.back();
                        // Get.to(SafetyViolationDetails(
                        //     userId: userId,
                        //     userName: userName,
                        //     userImg: userImg,
                        //     userDesg: userDesg));

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
