import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/staff/staff_add/add_staff_controller.dart';
import 'package:flutter_app/features/staff/staff_precaution/staff_precaution_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

import '../staff_undertaking/staff_undertaking_screen.dart';

// ignore: must_be_immutable
class StaffPrecaustionScreen extends StatelessWidget {
  final int categoryId;

  final int userId;
  final String userName;
  final int projectId;

  StaffPrecaustionScreen({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.projectId,
  });
  final AddStaffController addStaffController = Get.find();
  final StaffPrecautionController controller =
      Get.put(StaffPrecautionController());

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
                text: 'Add Staff',
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
                    value: 0.77,
                    backgroundColor: AppColors.searchfeildcolor,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.defaultPrimary),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '04/05',
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
              text: AppTexts.selectprecaustion,
              fontSize: AppTextSize.textSizeSmalle,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2.5,
            ),
            Row(
              children: [
                AppTextWidget(
                  text: AppTexts.safetyequipprovided,
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
            SizedBox(
              height: SizeConfig.heightMultiplier * 0.3,
            ),
            AppTextWidget(
              text: AppTexts.selectsafetyequip,
              fontSize: AppTextSize.textSizeSmall,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryText,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Checkbox(
                      activeColor: AppColors.buttoncolor,
                      side: BorderSide(
                        color: AppColors.secondaryText,
                        width: 1.2,
                      ),
                      onChanged: (bool? value) {
                        controller.toggleStaffSelectAll();
                      },
                      value: controller.isSelectAll.value,
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 2,
                ),
                AppTextWidget(
                  text: AppTexts.selectall,
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 5.5,
                  width: SizeConfig.widthMultiplier * 82,
                  child: AppTextFormfeild(
                    controller: controller.searchControllerEquipment,
                    hintText: 'Search here..',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/icons/Search.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    suffixIcon: Obx(
                        () => controller.searchQueryEquipment.value.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  controller.searchControllerEquipment.clear();
                                  controller.searchStaffDataEquipment('');
                                },
                                child: Icon(Icons.close,
                                    color: AppColors.searchfeild),
                              )
                            : SizedBox()),
                    enabled: true, // Set to false to disable the field
                    readOnly:
                        false, // Set to true if you don't want it editable
                    onChanged: (value) {
                      controller.searchStaffDataEquipment(value);
                    },
                  ),
                ),
              ],
            ),
            Obx(() => controller.selectionError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 22),
                    child: Text(
                      controller.selectionError.value,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 181, 32, 21),
                          fontSize: 13),
                    ),
                  )
                : SizedBox()),

            SizedBox(height: SizeConfig.heightMultiplier * 2),
            SizedBox(
              height: 270,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredDetailsEquipment.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                visualDensity: VisualDensity.compact,
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 16, right: 16),
                                leading: SizedBox(
                                    width: 24.0,
                                    height: 24.0,
                                    child: Obx(() => Checkbox(
                                          value: controller.selectedItemIds
                                              .contains(controller
                                                  .filteredDetailsEquipment[
                                                      index]
                                                  .id),
                                          activeColor: AppColors.buttoncolor,
                                          side: BorderSide(
                                            color: AppColors.secondaryText,
                                            width: 1.2,
                                          ),
                                          onChanged: (bool? value) {
                                            controller.toggleStaffSelection(
                                                controller
                                                    .filteredDetailsEquipment[
                                                        index]
                                                    .id);
                                          },
                                        ))),
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //${index + 1}.

                                    AppTextWidget(
                                      text: controller
                                          .filteredDetailsEquipment[index]
                                          .listDetails,
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryText,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),

            //----------------------------------------------------------------
            SizedBox(
              height: SizeConfig.heightMultiplier * 1,
            ),
            Row(
              children: [
                AppTextWidget(
                  text: AppTexts.instructiongivenn,
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
            SizedBox(
              height: SizeConfig.heightMultiplier * 2.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Checkbox(
                      value: controller.isSelectAllInstruction.value,
                      activeColor: AppColors.buttoncolor,
                      side: BorderSide(
                        color: AppColors.secondaryText,
                        width: 1.2,
                      ),
                      onChanged: (bool? value) {
                        controller.toggleStaffSelectAllInstruction();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 2,
                ),
                AppTextWidget(
                  text: AppTexts.selectall,
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 5.5,
                  width: SizeConfig.widthMultiplier * 82,
                  child: AppTextFormfeild(
                    controller: controller.searchControllerInstruction,
                    hintText: 'Search here..',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/icons/Search.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    suffixIcon: Obx(
                        () => controller.searchQueryEquipment.value.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  controller.searchControllerEquipment.clear();
                                  controller.searchStaffDataEquipment('');
                                },
                                child: Icon(Icons.close,
                                    color: AppColors.searchfeild),
                              )
                            : SizedBox()),
                    enabled: true, // Set to false to disable the field
                    readOnly:
                        false, // Set to true if you don't want it editable
                    onChanged: (value) {
                      controller.searchDataStaffInstruction(value);
                    },
                  ),
                ),
              ],
            ),
            Obx(() => controller.selectionInstructionError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 22),
                    child: Text(
                      controller.selectionInstructionError.value,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 181, 32, 21),
                          fontSize: 13),
                    ),
                  )
                : SizedBox()),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            SizedBox(
              height: 270,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredDetailsInstruction.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                visualDensity: VisualDensity.compact,
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 16, right: 16),
                                leading: SizedBox(
                                  width: 24.0,
                                  height: 24.0,
                                  child: Obx(
                                    () => Checkbox(
                                      value: controller.selectedItemInstruction
                                          .contains(
                                        controller
                                            .filteredDetailsInstruction[index]
                                            .id,
                                      ),
                                      activeColor: AppColors.buttoncolor,
                                      side: BorderSide(
                                        color: AppColors.secondaryText,
                                        width: 1.2,
                                      ),
                                      onChanged: (bool? value) {
                                        controller
                                            .toggleStaffSelectionInstruction(
                                                controller
                                                    .filteredDetailsInstruction[
                                                        index]
                                                    .id);
                                      },
                                    ),
                                  ),
                                ),
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //${index + 1}.

                                    AppTextWidget(
                                      text: controller
                                          .filteredDetailsInstruction[index]
                                          .inductionDetails,
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryText,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
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
                      if (controller.validateStaffSelection() &&
                          controller.validateStaffInstructionSelection()) {
                        Get.to(StaffUndertakingScreen(
                          categoryId: categoryId,
                          userId: userId,
                          userName: userName,
                          projectId: projectId,
                        ));
                        print("Navigating to Labour undertaking with:");
                        print("User ID: $userId");
                        print("User Name: $userName");
                        print("Project ID: $projectId");
                        print("categoryId: $categoryId");

                        log('-------------------------${controller.selectionInstructionError.value}');
                        log('-------------${addStaffController.profilePhoto.value}');
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
