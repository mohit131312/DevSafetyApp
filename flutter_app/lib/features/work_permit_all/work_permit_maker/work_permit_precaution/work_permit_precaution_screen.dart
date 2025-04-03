import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/assign_checker/assign_checker_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/assign_checker/assign_checker_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/new_work_permit/new_work_permit_model.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_precaution/work_permit_precaution_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_undertaking/work_permit_under_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WorkPermitPrecautionScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  WorkPermitPrecautionScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });
  final WorkPermitPrecautionController workPermitPrecautionController =
      Get.find();
  final AssignCheckerController assignCheckerController =
      Get.put(AssignCheckerController());
  final WorkPermitController workPermitController = Get.find();
  final NewWorkPermitController newWorkPermitController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //  resizeToAvoidBottomInset: false,
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
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
              child: AppTextWidget(
                text: 'New Work Permit',
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 4,
            vertical: SizeConfig.heightMultiplier * 2,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.66,
                    backgroundColor: AppColors.searchfeildcolor,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.defaultPrimary),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '02/03',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2.5,
            ),
            AppTextWidget(
              text: AppTexts.precaution,
              fontSize: AppTextSize.textSizeMediumm,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 0.3,
            ),
            AppTextWidget(
              text: 'Enter work permit details.',
              fontSize: AppTextSize.textSizeSmalle,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText,
            ),

            workPermitController.categoryWorkList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: workPermitController.categoryWorkList.length,
                    itemBuilder: (context, index) {
                      String categoryName = workPermitController
                          .categoryWorkList[index].categoryName;

                      // Filter the workPermitRequiredList to match the category
                      List<WorkPermitDetail> filteredList =
                          newWorkPermitController.workPermitRequiredList
                              .where(
                                  (item) => item.categoryName == categoryName)
                              .toList();
                      workPermitPrecautionController
                          .updateFilteredList(filteredList);

                      int categoryId =
                          workPermitController.categoryWorkList[index].id;

                      List<int> detailIds =
                          filteredList.map((e) => e.id).toList();
                      bool isAllSelected = workPermitPrecautionController
                              .selectedWorkPermitData[categoryId]?.length ==
                          detailIds.length;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2.5,
                          ),
                          Row(
                            children: [
                              AppTextWidget(
                                text:
                                    "${workPermitController.categoryWorkList[index].categoryName} Required",
                                fontSize: AppTextSize.textSizeMedium,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                              AppTextWidget(
                                  text: AppTexts.star,
                                  fontSize: AppTextSize.textSizeExtraSmall,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.starcolor),
                            ],
                          ),
                          Obx(() => workPermitPrecautionController
                                  .workPermitError.value.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                  ),
                                  child: Text(
                                    workPermitPrecautionController
                                        .workPermitError.value,
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 174, 75, 68),
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : SizedBox()),
                          if (filteredList.isNotEmpty)
                            Obx(() {
                              bool isAllSelected =
                                  workPermitPrecautionController
                                          .selectedWorkPermitData[categoryId]
                                          ?.length ==
                                      detailIds.length;

                              return Row(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 2.5,
                                  ),
                                  Checkbox(
                                    value: isAllSelected,
                                    activeColor: AppColors.buttoncolor,
                                    side: BorderSide(
                                      color: AppColors.secondaryText,
                                      width: 1.2,
                                    ),
                                    onChanged: (bool? value) {
                                      workPermitPrecautionController
                                          .toggleSelectAll(categoryId,
                                              detailIds, value ?? false);
                                    },
                                  ),
                                  AppTextWidget(
                                    text: AppTexts.selectall,
                                    fontSize: AppTextSize.textSizeSmallm,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryText,
                                  ),
                                ],
                              );
                            }),
                          SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                          filteredList.isNotEmpty
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 4,
                                    vertical: SizeConfig.heightMultiplier * 3,
                                  ),
                                  width: SizeConfig.widthMultiplier * 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.appgreycolor,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    5.5,
                                            width:
                                                SizeConfig.widthMultiplier * 82,
                                            child: TextField(
                                              // controller: workPermitPrecautionController
                                              //     .searchHazardsController,
                                              // readOnly: true,
                                              decoration: InputDecoration(
                                                hintText: 'Search here..',
                                                hintStyle: TextStyle(
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.searchfeild,
                                                ),
                                                prefixIcon: Container(
                                                  padding: EdgeInsets.all(
                                                      10.0), // Adjust padding as needed

                                                  child: Image.asset(
                                                    'assets/icons/Search.png',
                                                    fit: BoxFit
                                                        .contain, // Ensures it stays within the box
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .searchfeildcolor,
                                                      width: 0.5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .searchfeildcolor,
                                                      width: 0.5),
                                                ),
                                              ),
                                              onChanged: (value) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 2),
                                      SizedBox(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: filteredList.length,
                                                itemBuilder: (context, index) {
                                                  int detailId =
                                                      filteredList[index].id;

                                                  return Obx(() {
                                                    /// Get the checkbox status reactively

                                                    bool isChecked =
                                                        workPermitPrecautionController
                                                                .selectedWorkPermitData[
                                                                    categoryId]
                                                                ?.contains(
                                                                    detailId) ??
                                                            false;
                                                    return ListTile(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 0,
                                                              bottom: 0,
                                                              left: 16,
                                                              right: 16),
                                                      leading: SizedBox(
                                                        width: 24.0,
                                                        height: 24.0,
                                                        child: Checkbox(
                                                          value: isChecked,
                                                          activeColor: AppColors
                                                              .buttoncolor,
                                                          side: BorderSide(
                                                            color: AppColors
                                                                .secondaryText,
                                                            width: 1.2,
                                                          ),
                                                          onChanged:
                                                              (bool? value) {
                                                            workPermitPrecautionController
                                                                .toggleSelection(
                                                              categoryId,
                                                              detailId,
                                                              value ?? false,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      title: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          //${index + 1}.

                                                          Flexible(
                                                            child:
                                                                AppTextWidget(
                                                              text: filteredList[
                                                                      index]
                                                                  .permitDetails,
                                                              fontSize: AppTextSize
                                                                  .textSizeExtraSmall,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .secondaryText,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox()
                        ],
                      );
                    },
                  )
                : SizedBox(),

            //----------------------------------------------------------------

            //----------------------------------------------------------------

            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            Row(
              children: [
                AppTextWidget(
                  text: 'Assign Checkers',
                  fontSize: AppTextSize.textSizeSmall,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText,
                ),
                AppTextWidget(
                    text: AppTexts.star,
                    fontSize: AppTextSize.textSizeExtraSmall,
                    fontWeight: FontWeight.w400,
                    color: AppColors.starcolor),
              ],
            ),

            Obx(() {
              return assignCheckerController
                      .addInvolveassigneeDataPerson.isNotEmpty
                  ? SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    )
                  : SizedBox.shrink();
            }),

            Obx(
              () {
                final selectedList =
                    assignCheckerController.addInvolveassigneeDataPerson;

                return selectedList.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.7, color: AppColors.searchfeildcolor),
                            borderRadius: BorderRadius.circular(8)),
                        height: SizeConfig.heightMultiplier * 10,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: selectedList.length,
                          itemBuilder: (context, index) {
                            final assgneeData = selectedList[index];

                            return ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 0, right: 20),
                              leading: CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                    "$baseUrl${assgneeData.profilePhoto}"),
                              ),
                              title: AppTextWidget(
                                text: assgneeData.firstName.toString(),
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                              ),
                              subtitle: AppTextWidget(
                                text: assgneeData.designation.toString(),
                                fontSize: AppTextSize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryText,
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  assignCheckerController
                                      .removeassigneeData(index);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox();
              },
            ),

            Obx(() {
              return assignCheckerController
                      .addInvolveassigneeDataPerson.isNotEmpty
                  ? SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    )
                  : SizedBox
                      .shrink(); // Use `SizedBox.shrink()` to avoid unnecessary space
            }),

            Obx(() =>
                assignCheckerController.addInvolveassigneeDataPerson.isEmpty &&
                        assignCheckerController.assigneeError.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 5),
                        child: Text(
                          assignCheckerController.assigneeError.value,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 174, 75, 68),
                            fontSize: 12,
                          ),
                        ),
                      )
                    : SizedBox.shrink()),

            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: AppColors.thirdText,
                    width: 0.8,
                  ),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Get.to(AssignCheckerScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 28,
                    color: AppColors.thirdText,
                    weight: 0.2,
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 1,
                  ),
                  AppTextWidget(
                    text: "Add Checker",
                    fontSize: AppTextSize.textSizeSmallm,
                    fontWeight: FontWeight.w400,
                    color: AppColors.thirdText,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 1.5,
            ),
            AppTextWidget(
                text: 'Set the checkers in sequence?',
                fontSize: AppTextSize.textSizeSmall,
                fontWeight: FontWeight.w400,
                color: AppColors.searchfeild),
            SizedBox(
              height: SizeConfig.heightMultiplier * 6,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppMediumButton(
                      label: "Previous",
                      borderColor: AppColors.buttoncolor,
                      iconColor: AppColors.buttoncolor,
                      backgroundColor: Colors.white,
                      textColor: AppColors.buttoncolor,
                      imagePath: 'assets/icons/arrow-narrow-left.png',
                    ),
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier * 5),
                  GestureDetector(
                    onTap: () {
                      var postData = workPermitPrecautionController
                          .getSelectedDataForPost();
                      assignCheckerController.validateAssignee();
                      List<int> requiredCategories = workPermitController
                          .categoryWorkList
                          .map((e) => e.id)
                          .toList();
                      log('-------------$postData');
                      bool isValidSelection = workPermitPrecautionController
                          .validateWorkPermitSelection(requiredCategories);
                      log('Selection Valid: $isValidSelection');

                      bool isValidAssignee =
                          assignCheckerController.validateAssignee();
                      log('Assignee Valid: $isValidAssignee');

                      log('filteredListfinal List: ${workPermitPrecautionController.filteredListfinal}');

                      if (isValidAssignee &&
                          isValidSelection &&
                          workPermitPrecautionController
                              .filteredListfinal.isEmpty) {
                        workPermitPrecautionController.workPermitError.value =
                            '';
                        log('Error: 1.');
                        Get.to(WorkPermitUnderScreen(
                            userId: userId,
                            userName: userName,
                            userImg: userImg,
                            userDesg: userDesg,
                            projectId: projectId));
                      }

                      if (isValidSelection &&
                          isValidAssignee &&
                          workPermitPrecautionController
                              .filteredListfinal.isNotEmpty) {
                        log('Error: 2.');

                        Get.to(WorkPermitUnderScreen(
                            userId: userId,
                            userName: userName,
                            userImg: userImg,
                            userDesg: userDesg,
                            projectId: projectId));
                      }
                      if (!isValidAssignee && !isValidSelection) {
                        workPermitPrecautionController.workPermitError.value =
                            '';
                      }
                    },
                    child: AppMediumButton(
                      label: "Next",
                      borderColor: AppColors.backbuttoncolor,
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      backgroundColor: AppColors.buttoncolor,
                      imagePath2: 'assets/icons/arrow-narrow-right.png',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 6,
            ),
          ]),
        ),
      ),
    );
  }
}
