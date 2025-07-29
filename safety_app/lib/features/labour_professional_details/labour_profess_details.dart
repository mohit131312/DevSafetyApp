import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/Labour_add/add_labour_controller.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/features/labour_documentation/labour_documentation.dart';
import 'package:flutter_app/features/labour_professional_details/labour_profess_details_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LabourProfessDetails extends StatelessWidget {
  final int categoryId;

  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  LabourProfessDetails({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final InductionTrainingController inductionTrainingController = Get.find();
  final AddLabourController addLabourController = Get.find();

  final LabourProfessDetailsController labourProfessDetailsController =
      Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
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
              text: AppTexts.addlabour,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 4,
              vertical: SizeConfig.heightMultiplier * 2,
            ),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.4,
                            backgroundColor: AppColors.searchfeildcolor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.defaultPrimary),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '02/05',
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
                      text: AppTexts.labourprofessinaldetails,
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.3,
                    ),
                    AppTextWidget(
                      text: AppTexts.enterlabourprofessionaldetails,
                      fontSize: AppTextSize.textSizeSmalle,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                            text: AppTexts.trade,
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText),
                        AppTextWidget(
                            text: AppTexts.star,
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.starcolor),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Obx(
                      () => AppSearchDropdown(
                        items: !addLabourController.userFound.value
                            ? inductionTrainingController.tradeList
                                .map(
                                  (trade) => trade.inductionDetails,
                                )
                                .toList()
                            : addLabourController.assignedLabourProjects
                                .map((e) => e.tradeName)
                                .toList(),
                        selectedItem: labourProfessDetailsController
                                .selectedtrade.value.isNotEmpty
                            ? labourProfessDetailsController.selectedtrade.value
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hintText: 'Select Trade',
                        onChanged: (value) {
                          labourProfessDetailsController.selectedtrade.value =
                              value ?? '';

                          if (labourProfessDetailsController
                              .selectedtrade.value.isNotEmpty) {
                            var selectedTrade = inductionTrainingController
                                .tradeList
                                .firstWhereOrNull(
                              (trade) => trade.inductionDetails == value,
                            );
                            labourProfessDetailsController.selectedTradeId
                                .value = selectedTrade?.id.toString() ?? '';
                          }

                          var assignedProject = addLabourController
                              .assignedLabourProjects
                              .firstWhereOrNull(
                                  (proj) => proj.tradeName == value);
                          if (assignedProject != null) {
                            labourProfessDetailsController.contractorCompanyName
                                .value = assignedProject.contractorName;
                            labourProfessDetailsController
                                    .selectedSkillLevel.value =
                                (assignedProject.skillType.isNotEmpty)
                                    ? assignedProject.skillType
                                    : 'Unskilled';
                          }

                          if (labourProfessDetailsController
                              .contractorCompanyName.value.isNotEmpty) {
                            var selectedContractor = inductionTrainingController
                                .contractorLists
                                .firstWhereOrNull(
                              (contractor) =>
                                  contractor.contractorCompanyName ==
                                  labourProfessDetailsController
                                      .contractorCompanyName.value,
                            );
                            labourProfessDetailsController
                                    .selectedContractorId.value =
                                selectedContractor?.id.toString() ?? '';
                          }

                          print(
                              "Selected Trade ID: ${labourProfessDetailsController.selectedTradeId.value}");
                          print(
                              "Selected Contractor ID: ${labourProfessDetailsController.selectedContractorId.value}");
                        },
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'Please select a trade';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.yoexperience,
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
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Obx(
                      () => AppSearchDropdown(
                        popupMaxHeight: SizeConfig.heightMultiplier * 28,
                        enabled: !addLabourController.userFound.value,
                        items: labourProfessDetailsController.yoenumbers
                            .map(
                              (yoe) => yoe.toString(),
                            )
                            .toList(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        selectedItem: addLabourController.userFound.value
                            ? labourProfessDetailsController.selectedyoe.value
                                .toString()
                            : labourProfessDetailsController.selectedyoe.value
                                .toString(),
                        hintText: 'Select Year of Experience',
                        onChanged: (value) {
                          final parsed = int.tryParse(value ?? '');
                          if (parsed != null) {
                            labourProfessDetailsController.selectedyoe.value =
                                parsed;
                          }
                        },
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'Please select a year of experience';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.firmname,
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
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),

                    //------------------------------
                    Obx(
                      () => AppSearchDropdown(
                        popupMaxHeight: SizeConfig.heightMultiplier * 28,
                        enabled: !addLabourController.userFound
                            .value, // ✅ Editable only if user NOT found
                        items: !addLabourController.userFound.value
                            ? inductionTrainingController.contractorLists
                                .map(
                                  (contractor) =>
                                      contractor.contractorCompanyName,
                                )
                                .toList()
                            : addLabourController.assignedLabourProjects
                                .map((e) => e.contractorName)
                                .toList(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        selectedItem: labourProfessDetailsController
                                .contractorCompanyName.value.isNotEmpty
                            ? labourProfessDetailsController
                                .contractorCompanyName.value
                            : null,
                        hintText: 'Select Name',
                        onChanged: (value) {
                          labourProfessDetailsController
                              .contractorCompanyName.value = value ?? '';
                          if (labourProfessDetailsController
                              .contractorCompanyName.value.isNotEmpty) {
                            var selectedContractor = inductionTrainingController
                                .contractorLists
                                .firstWhereOrNull(
                              (contractor) =>
                                  contractor.contractorCompanyName ==
                                  labourProfessDetailsController
                                      .contractorCompanyName.value,
                            );
                            labourProfessDetailsController
                                    .selectedContractorId.value =
                                selectedContractor?.id.toString() ?? '';
                          }

                          print(
                              "Selected Trade ID: ${labourProfessDetailsController.selectedTradeId.value}");
                          print(
                              "Selected Contractor ID: ${labourProfessDetailsController.selectedContractorId.value}");
                        },
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'Please select a Firm name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.skill,
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
                    Obx(() => Row(
                          children: [
                            Radio(
                              value: 'Skilled',
                              groupValue: labourProfessDetailsController
                                  .selectedSkillLevel.value,
                              activeColor: Colors.orange,
                              onChanged: addLabourController.userFound.value
                                  ? null
                                  : (value) {
                                      labourProfessDetailsController
                                          .updateSkillLevel(value as String);
                                    },
                            ),
                            AppTextWidget(
                              text: 'Skilled',
                              fontSize: AppTextSize.textSizeSmallm,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryText,
                            ),
                            SizedBox(width: 16), // Space between options
                            Radio(
                              value: 'Unskilled',
                              groupValue: labourProfessDetailsController
                                  .selectedSkillLevel.value,
                              activeColor: Colors.orange,
                              onChanged: addLabourController.userFound.value
                                  ? null //
                                  : (value) {
                                      labourProfessDetailsController
                                          .updateSkillLevel(value as String);
                                    },
                            ),
                            AppTextWidget(
                              text: 'Unskilled',
                              fontSize: AppTextSize.textSizeSmallm,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryText,
                            ),
                          ],
                        )),
                    Obx(() => labourProfessDetailsController
                                .selectedSkillLevel.value.isEmpty &&
                            labourProfessDetailsController
                                .skillerror.value.isNotEmpty
                        ? Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4, left: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      labourProfessDetailsController
                                          .skillerror.value,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink()),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 22,
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
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
                  imagePath: 'assets/images/leftarrow.png',
                ),
              ),
              SizedBox(width: SizeConfig.widthMultiplier * 5),
              GestureDetector(
                onTap: () {
                  if (labourProfessDetailsController
                      .selectedSkillLevel.value.isEmpty) {
                    labourProfessDetailsController.skillerror.value =
                        "Please select skill level";
                  }
                  if (formKey.currentState!.validate()) {
                    log('-------------${addLabourController.profilePhoto.value}');
                    log('-------------${addLabourController.profilePhoto.value}');
                    log('-----------------------$categoryId');
                    if (labourProfessDetailsController
                        .selectedSkillLevel.value.isNotEmpty) {
                      Get.to(LabourDocumentation(
                        categoryId: categoryId,
                        userId: userId,
                        userName: userName,
                        userImg: userImg,
                        userDesg: userDesg,
                        projectId: projectId,
                      ));
                      print("Navigating to Documentaion with:");
                      print("User ID: $userId");
                      print("User Name: $userName");
                      print("Project ID: $projectId");
                      print("categoryId: $categoryId");
                    }
                  }
                },
                child: AppMediumButton(
                  label: "Next",
                  borderColor: AppColors.backbuttoncolor,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  backgroundColor: AppColors.buttoncolor,
                  imagePath2: 'assets/images/rightarrow.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
