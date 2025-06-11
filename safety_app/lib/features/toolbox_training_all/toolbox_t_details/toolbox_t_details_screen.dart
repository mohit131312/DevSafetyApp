import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/select_reviewer/select_reviewer.dart';
import 'package:flutter_app/features/toolbox_training_all/select_reviewer/select_reviewer_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/seletc_trainee/select_trainee_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_add_trainee/toolbox_add_trainee_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_add_trainee/toolbox_add_trainee_screen.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_t_details/toolbox_t_details_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';

class ToolboxTDetailsScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  ToolboxTDetailsScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });
  final ToolboxTDetailsController toolboxTDetailsController = Get.find();
  final ToolboxTrainingController toolboxTrainingController = Get.find();
  final SelectReviewerController selectReviewerController = Get.find();
  final ToolboxAddTraineeController toolboxAddTraineeController = Get.find();
  final SelectTraineeController selectTraineeController = Get.find();
  final LocationController locationController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void showConfirmationDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          title: AppTextWidget(
            text: 'Are You Sure?',
            fontSize: AppTextSize.textSizeMediumm,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          content: AppTextWidget(
              text:
                  'You will lose your data if you leave now. Are you sure you want to leave?',
              fontSize: AppTextSize.textSizeSmall,
              fontWeight: FontWeight.w500,
              color: AppColors.searchfeild),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppTextWidget(
                        text: 'Cancel',
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.buttoncolor,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppTextWidget(
                        text: 'Yes',
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: WillPopScope(
        onWillPop: () async {
          showConfirmationDialog(
            context,
          );
          return false; // Prevent back navigation until user confirms
        },
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
                  size: SizeConfig.heightMultiplier * 2.0,
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
                            value: 0.5,
                            backgroundColor: AppColors.searchfeildcolor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.defaultPrimary),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '01/03',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    AppTextWidget(
                      text: AppTexts.tbtdetails,
                      fontSize: AppTextSize.textSizeMedium,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),

                    //enterdetails
                    AppTextWidget(
                      text: AppTexts.enterdetails,
                      fontSize: AppTextSize.textSizeExtraSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                            text: 'Select Category',
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText),
                        AppTextWidget(
                          text: AppTexts.star,
                          fontSize: AppTextSize.textSizeExtraSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.starcolor,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 1),
                    Obx(
                      () => AppSearchDropdown(
                        key: toolboxTDetailsController.categoryKey,
                        items: toolboxTrainingController.toolboxCategoryList
                            .map(
                              (cat) => cat.categoryName,
                            )
                            .whereType<String>()
                            .toList(),
                        selectedItem: toolboxTDetailsController
                                .selectCategory.value.isNotEmpty
                            ? toolboxTDetailsController.selectCategory.value
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hintText: 'Select Category',
                        onChanged: (value) async {
                          toolboxTDetailsController.selectCategory.value =
                              value ?? '';
                          var selectedCat = toolboxTrainingController
                              .toolboxCategoryList
                              .firstWhereOrNull(
                                  (cat) => cat.categoryName == value);

                          if (selectedCat != null) {
                            toolboxTDetailsController.selectCategoryId.value =
                                selectedCat.id;
                            if (await CheckInternet.checkInternet()) {
                              toolboxTDetailsController.selectedInstructionIds
                                  .clear();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomLoadingPopup());
                              await toolboxTDetailsController
                                  .getInstructionData(
                                toolboxTDetailsController
                                    .selectCategoryId.value,
                                projectId,
                                userId,
                              );
                              Get.back();
                              log(' Selected toolboxTDetailsController.selectCategory.value: ${toolboxTDetailsController.selectCategory.value}');
                              log(' Selected toolboxTDetailsController.selectCategoryId.value: ${toolboxTDetailsController.selectCategoryId.value}');
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
                          } else {}
                        },
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'Please select a category type';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: SizeConfig.heightMultiplier * 2.0),
                    Row(
                      children: [
                        AppTextWidget(
                            text: AppTexts.attachworkpermit,
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 1),
                    Obx(
                      () => AppSearchDropdown(
                        items: toolboxTrainingController.workPermitList
                            .map(
                              (w) => w.nameOfWorkpermit,
                            )
                            .whereType<String>()
                            .toList(),
                        selectedItem: toolboxTDetailsController
                                .selectWorkPermit.value.isNotEmpty
                            ? toolboxTDetailsController.selectWorkPermit.value
                            : null,
                        hintText: 'Select Work Permit',
                        onChanged: (value) async {
                          toolboxTDetailsController.selectWorkPermit.value =
                              value ?? '';
                          var selectedWork = toolboxTrainingController
                              .workPermitList
                              .firstWhereOrNull(
                                  (w) => w.nameOfWorkpermit == value);

                          if (selectedWork != null) {
                            toolboxTDetailsController.selectWorkPermitId.value =
                                selectedWork.id!;
                            log(' SelectedselectWorkPermit.value: ${toolboxTDetailsController.selectWorkPermit.value}');
                            log(' Selected selectWorkPermitId: ${toolboxTDetailsController.selectWorkPermitId.value}');
                          } else {}
                        },
                        // validator: (value) {
                        //   if (value == null || value.toString().trim().isEmpty) {
                        //     return 'Please select a Work Permit';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2.0),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.nameoftoolboxtraining,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        AppTextWidget(
                          text: AppTexts.star,
                          fontSize: AppTextSize.textSizeExtraSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.starcolor,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 1),
                    AppTextFormfeild(
                      controller: toolboxTDetailsController.tbtController,
                      hintText: 'Enter Name of TBT',
                      focusNode: toolboxTDetailsController.tbtFocusNode,
                      onFieldSubmitted: (_) {
                        toolboxTDetailsController.tbtFocusNode.unfocus();
                      },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name of TBT cannot be empty';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      onChanged: (value) {},
                    ),

                    SizedBox(height: SizeConfig.heightMultiplier * 2.0),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.detailsoftraining,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        AppTextWidget(
                          text: AppTexts.star,
                          fontSize: AppTextSize.textSizeExtraSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.starcolor,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 1),
                    AppTextFormfeild(
                      controller: toolboxTDetailsController.detailsController,
                      hintText: 'Enter Details',
                      focusNode: toolboxTDetailsController.detailsFocusNode,
                      onFieldSubmitted: (_) {
                        toolboxTDetailsController.detailsFocusNode.unfocus();
                      },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Details cannot be empty';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      onChanged: (value) {},
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.reviewers,
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        AppTextWidget(
                          text: AppTexts.star,
                          fontSize: AppTextSize.textSizeExtraSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.starcolor,
                        ),
                      ],
                    ),

                    toolboxTrainingController.reviewerList.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                return selectReviewerController
                                        .addInvolveassigneeDataPerson.isNotEmpty
                                    ? SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 2.5,
                                      )
                                    : SizedBox.shrink();
                              }),
                              Obx(
                                () {
                                  final selectedList = selectReviewerController
                                      .addInvolveassigneeDataPerson;

                                  return selectedList.isNotEmpty
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: 8, right: 8, top: 8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.7,
                                                  color: AppColors
                                                      .searchfeildcolor),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          height:
                                              SizeConfig.heightMultiplier * 10,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: selectedList.length,
                                            itemBuilder: (context, index) {
                                              final assgneeData =
                                                  selectedList[index];

                                              return ListTile(
                                                contentPadding: EdgeInsets.only(
                                                    left: 0, right: 20),
                                                // leading: CircleAvatar(
                                                //   radius: 22,
                                                //   backgroundImage: NetworkImage(
                                                //       "$baseUrl${assgneeData.profilePhoto}"),
                                                // ),
                                                leading: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 28,
                                                      backgroundColor: Colors
                                                          .grey
                                                          .shade200, // Fallback color
                                                      child: ClipOval(
                                                        child: Image.network(
                                                          "$baseUrl${assgneeData.profilePhoto}",
                                                          fit: BoxFit.cover,
                                                          width:
                                                              56, // Diameter = radius * 2
                                                          height: 56,
                                                          loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) {
                                                            if (loadingProgress ==
                                                                null)
                                                              return child;
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 24,
                                                                height: 24,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                  color: AppColors
                                                                      .buttoncolor,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image.asset(
                                                              'assets/icons/image.png',
                                                              fit: BoxFit.cover,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                title: AppTextWidget(
                                                  text: assgneeData.firstName
                                                      .toString(),
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primaryText,
                                                ),
                                                subtitle: AppTextWidget(
                                                  text: assgneeData.designation
                                                      .toString(),
                                                  fontSize: AppTextSize
                                                      .textSizeSmalle,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColors.secondaryText,
                                                ),
                                                trailing: GestureDetector(
                                                  onTap: () {
                                                    selectReviewerController
                                                        .removeassigneeData(
                                                            index);
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
                                return selectReviewerController
                                        .addInvolveassigneeDataPerson.isNotEmpty
                                    ? SizedBox(
                                        height: SizeConfig.heightMultiplier * 2,
                                      )
                                    : SizedBox
                                        .shrink(); // Use `SizedBox.shrink()` to avoid unnecessary space
                              }),
                              Obx(() => selectReviewerController
                                          .addInvolveassigneeDataPerson
                                          .isEmpty &&
                                      selectReviewerController
                                          .assigneeError.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, left: 5),
                                      child: Text(
                                        selectReviewerController
                                            .assigneeError.value,
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink()),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              ElevatedButton(
                                key: toolboxTDetailsController.reviewerKey,
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
                                  Get.to(SelectReviewer());
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
                                      text: "Add Reviewer",
                                      fontSize: AppTextSize.textSizeSmallm,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.thirdText,
                                    ),
                                  ],
                                ),
                              ),
                              Obx(() {
                                return selectReviewerController
                                        .addInvolveassigneeDataPerson.isNotEmpty
                                    ? SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 2.5,
                                      )
                                    : SizedBox.shrink();
                              }),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4, left: 5),
                                child: Text(
                                  "Please Assign Project to users in web",
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 174, 75, 68),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                    SizedBox(
                        key: toolboxTDetailsController.instructionKey,
                        height: SizeConfig.heightMultiplier * 3),

                    Obx(() {
                      final filteredInstructionList =
                          toolboxTDetailsController.filteredInstruction;

                      if (filteredInstructionList.isEmpty &&
                          toolboxTDetailsController
                              .instructionController.text.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppTextWidget(
                                  text: AppTexts.instructiongiven,
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryText,
                                ),
                                AppTextWidget(
                                  text: AppTexts.star,
                                  fontSize: AppTextSize.textSizeExtraSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.starcolor,
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 5),
                          ],
                        );
                      }

                      // If data exists, show the full list
                      return Column(
                        children: [
                          Row(
                            children: [
                              AppTextWidget(
                                text: AppTexts.instructiongiven,
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                              AppTextWidget(
                                text: AppTexts.star,
                                fontSize: AppTextSize.textSizeExtraSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.starcolor,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Obx(() => toolboxTDetailsController
                                          .selectedInstructionIds.isEmpty &&
                                      toolboxTDetailsController
                                          .instructionError.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, left: 5),
                                      child: Text(
                                        toolboxTDetailsController
                                            .instructionError.value,
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 174, 75, 68),
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink()),
                            ],
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 2.8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: Obx(
                                  () => Checkbox(
                                    value: toolboxTDetailsController
                                        .isAllSelected.value,
                                    activeColor: AppColors.buttoncolor,
                                    side: BorderSide(
                                      color: AppColors.secondaryText,
                                      width: 1.2,
                                    ),
                                    onChanged: (bool? value) {
                                      toolboxTDetailsController
                                          .toggleSelectAll();
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
                          SizedBox(height: SizeConfig.heightMultiplier * 2.2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 5.3,
                                width: SizeConfig.widthMultiplier * 84,
                                child: AppTextFormfeild(
                                  controller: toolboxTDetailsController
                                      .instructionController,
                                  hintText: 'Search Instruction..',
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
                                    toolboxTDetailsController
                                        .updateInstructiontSearchQuery(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.8),
                          Obx(() => toolboxTDetailsController
                                  .filteredInstruction.isEmpty
                              ? AppTextWidget(
                                  text: "No data Found",
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryText,
                                )
                              : SizedBox()),
                          Obx(
                            () {
                              final filteredInstructionList =
                                  toolboxTDetailsController.filteredInstruction;

                              return SizedBox(
                                height: 220,
                                child: ScrollbarTheme(
                                  data: ScrollbarThemeData(
                                    thumbVisibility:
                                        WidgetStateProperty.all(true),
                                    thickness: WidgetStateProperty.all(3),
                                    radius: const Radius.circular(8),
                                    trackVisibility:
                                        WidgetStateProperty.all(true),
                                    thumbColor: WidgetStateProperty.all(
                                        AppColors.buttoncolor),
                                    trackColor: WidgetStateProperty.all(
                                        const Color.fromARGB(26, 101, 99, 99)),
                                    trackBorderColor: WidgetStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: Scrollbar(
                                    interactive: true,
                                    child: ListView.builder(
                                      itemCount: filteredInstructionList.length,
                                      itemBuilder: (context, index) {
                                        final inst =
                                            filteredInstructionList[index];

                                        return ListTile(
                                          dense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                          ),
                                          leading: SizedBox(
                                              child: Obx(
                                            () => Checkbox(
                                              side: BorderSide(
                                                  color: AppColors.searchfeild,
                                                  width: 1),
                                              value: toolboxTDetailsController
                                                  .selectedInstructionIds
                                                  .contains(inst.id),
                                              onChanged: (value) {
                                                toolboxTDetailsController
                                                    .toggleInstructionSelection(
                                                        inst.id);
                                              },
                                              activeColor:
                                                  AppColors.buttoncolor,
                                            ),
                                          )),
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //${index + 1}.
                                              AppTextWidget(
                                                text: "${index + 1}.  ",
                                                fontSize: AppTextSize
                                                    .textSizeExtraSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText,
                                              ),
                                              Expanded(
                                                child: AppTextWidget(
                                                  text: filteredInstructionList[
                                                          index]
                                                      .toolboxDetails
                                                      .toString(),
                                                  fontSize: AppTextSize
                                                      .textSizeExtraSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.primaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: SizeConfig.heightMultiplier * 6),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.heightMultiplier * 1,
              horizontal: SizeConfig.widthMultiplier * 4,
            ),
            child: AppElevatedButton(
              text: "Next",
              onPressed: () {
                bool isValidAssignee =
                    selectReviewerController.validateAssignee();
                bool isValidInstruction =
                    toolboxTDetailsController.validateInstructionSelection();
                validateAndFocusFirstInvalidField();
                if (formKey.currentState!.validate() &&
                    isValidAssignee &&
                    isValidInstruction) {
                  locationController.fetchLocation();
                  Get.to(ToolboxAddTraineeScreen(
                      userId: userId,
                      userName: userName,
                      userImg: userImg,
                      userDesg: userDesg,
                      projectId: projectId));
                  selectReviewerController.assigneeError.value = '';
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void validateAndFocusFirstInvalidField() {
    if (toolboxTDetailsController.selectCategory.value.isEmpty) {
      scrollToWidget(toolboxTDetailsController.categoryKey);
      return;
    }
    if (toolboxTDetailsController.tbtController.text.trim().isEmpty) {
      toolboxTDetailsController.tbtFocusNode.requestFocus();
      return;
    }
    if (toolboxTDetailsController.detailsController.text.trim().isEmpty) {
      toolboxTDetailsController.detailsFocusNode.requestFocus();
      return;
    }

    if (toolboxTDetailsController.selectCategory.value.isEmpty) {
      scrollToWidget(toolboxTDetailsController.categoryKey);
      return;
    }
    if (selectReviewerController.addInvolveassigneeDataPerson.isEmpty &&
        selectReviewerController.assigneeError.isNotEmpty) {
      scrollToWidget(toolboxTDetailsController.reviewerKey);
      return;
    }
    if (toolboxTDetailsController.selectedInstructionIds.isEmpty &&
        toolboxTDetailsController.instructionError.isNotEmpty) {
      scrollToWidget(toolboxTDetailsController.instructionKey);
      return;
    }
  }

  void scrollToWidget(GlobalKey key) {
    final context = key.currentContext;
    if (context != null && context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.2,
        );
      });
    }
  }
}
