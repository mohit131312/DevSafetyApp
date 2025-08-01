import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/contractor/add_contractor/add_contractor_controller.dart';
import 'package:flutter_app/features/contractor/contractor_details/contractor_details_screen.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AddContractor extends StatelessWidget {
  final int categoryId;

  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  AddContractor({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });

  final AddContractorController addContractorController = Get.find();
  final InductionTrainingController inductionTrainingController = Get.find();
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
                text: AppTexts.addContractor,
                fontSize: AppTextSize.textSizeMedium,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ),
            leading: Padding(
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
              child: IconButton(
                onPressed: () {
                  showConfirmationDialog(context);
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
                child: SizedBox(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: 0.25,
                                backgroundColor: AppColors.searchfeildcolor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.defaultPrimary),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '01/04',
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
                          text: AppTexts.contractordetails,
                          fontSize: AppTextSize.textSizeMediumm,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 0.3,
                        ),
                        AppTextWidget(
                          text: AppTexts.entercontractordetails,
                          fontSize: AppTextSize.textSizeSmalle,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryText,
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        AppTextWidget(
                          text: 'Search Contractor',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeConfig.widthMultiplier * 72,
                              child: TextFormField(
                                controller:
                                    addContractorController.searchController,
                                focusNode:
                                    addContractorController.searchFocusNodeAll,
                                onFieldSubmitted: (_) {
                                  addContractorController.searchFocusNodeAll
                                      .unfocus();
                                },
                                textInputAction: TextInputAction.next,
                                style: GoogleFonts.inter(
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryText,
                                ),
                                decoration: InputDecoration(
                                  hintText:
                                      'Search Contractor By Company name ',
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: AppTextSize.textSizeExtraSmall,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.searchfeild,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.searchfeildcolor,
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.searchfeildcolor,
                                        width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 126, 16, 9),
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                        topRight: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                    borderSide: BorderSide(
                                      color:
                                          const Color.fromARGB(255, 126, 16, 9),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 2,
                            ),

                            //-----------------------------------------

                            GestureDetector(
                              onTap: () async {
                                if (await CheckInternet.checkInternet()) {
                                  addContractorController
                                      .clearUserFieldsFinalContractor();
                                  String value = addContractorController
                                      .searchController.text;
                                  if (value.isNotEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CustomLoadingPopup());
                                    await addContractorController
                                        .getSafetyContractorMatchedDetails(
                                            value, context);
                                    Navigator.pop(context);
                                  }

                                  if (addContractorController
                                          .searchResults.isNotEmpty &&
                                      addContractorController
                                              .searchResults.length >
                                          1) {
                                    log('In the if getSafetyContractorMatchedDetails ');

                                    // } else {
                                    //   log('In the else getSafetyLabourDetails ');

                                    //   showDialog(
                                    //       context: context,
                                    //       builder: (BuildContext context) =>
                                    //           CustomLoadingPopup());

                                    //   await addContractorController
                                    //       .getSafetyLabourDetails(value, context, false);
                                    //   Navigator.pop(context);
                                  }
                                  addContractorController.searchFocusNodeAll
                                      .unfocus();
                                  addContractorController.searchController
                                      .clear();
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
                              child: Container(
                                  height: SizeConfig.heightMultiplier * 6.2,
                                  width: SizeConfig.widthMultiplier * 14,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.searchfeildcolor,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    color: AppColors.searchfeild,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        Row(
                          children: [
                            AppTextWidget(
                              text: AppTexts.contractorfirm,
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
                          () => AppTextFormfeild(
                            controller: addContractorController
                                .contractorfirmnameController,
                            hintText: 'Contractor Firm Name',
                            focusNode: addContractorController
                                .contractorfirmnameFocusNode,
                            onFieldSubmitted: (_) {
                              addContractorController
                                  .contractorfirmnameFocusNode
                                  .unfocus();
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            enabled: !addContractorController.userFound.value,
                            readOnly: addContractorController.userFound.value,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Contractor Firm Name cannot be empty';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]')),
                            ],
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Row(
                          children: [
                            AppTextWidget(
                              text: AppTexts.reasonforvisit,
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
                            popupMaxHeight: SizeConfig.heightMultiplier * 30,
                            items:
                                inductionTrainingController.reasonForVisitList
                                    .map(
                                      (reason) => reason.listDetails,
                                    )
                                    .toList(),
                            selectedItem: addContractorController
                                    .selectedreasons.value.isNotEmpty
                                ? addContractorController.selectedreasons.value
                                : null,
                            hintText: 'Select Reason',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              addContractorController.selectedreasons.value =
                                  value ?? '';

                              if (value != null) {
                                // Ensure we are matching with the correct field (ID or reason name)
                                var selectedReasonObj =
                                    inductionTrainingController
                                        .reasonForVisitList
                                        .firstWhereOrNull((state) =>
                                            state.listDetails == value);

                                if (selectedReasonObj != null) {
                                  addContractorController.selectedReasonId
                                      .value = selectedReasonObj.id;
                                  log('Selected Reason ID: ${addContractorController.selectedReasonId.value}');
                                  log('Selected Reason Name: ${addContractorController.selectedreasons.value}');
                                } else {
                                  log('No matching reason found for: $value');
                                }
                              }
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.toString().trim().isEmpty) {
                                return 'Please select a Reason ';
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
                              text: AppTexts.gstn,
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
                          () => AppTextFormfeild(
                            controller: addContractorController.gstnController,
                            hintText: 'Enter GSTN Number',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            enabled:
                                !addContractorController.userFound.value, //
                            readOnly:
                                addContractorController.userFound.value, //
                            focusNode: addContractorController.gstnFocusNode,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Gstn number cannot be empty';
                              }
                              // if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              //   return 'Enter a valid 10-digit number';
                              // }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onFieldSubmitted: (_) {
                              addContractorController.gstnFocusNode.unfocus();
                            },
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 20),
                      ],
                    ),
                  ),
                )),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.heightMultiplier * 1,
              horizontal: SizeConfig.widthMultiplier * 4,
            ),
            child: AppElevatedButton(
                text: 'Next',
                onPressed: () {
                  validateAndFocusFirstInvalidField();
                  if (formKey.currentState!.validate()) {
                    Get.to(ContractorDetailsScreen(
                      categoryId: categoryId,
                      userId: userId,
                      userName: userName,
                      userImg: userImg,
                      userDesg: userDesg,
                      projectId: projectId,
                    ));
                  }
                  print("Navigating to ContractorDetailsScreen with:");

                  print("User ID: $userId");
                  print("User Name: $userName");
                  print("Project ID: $projectId");
                  print("categoryId: $categoryId");
                }),
          ),
        ),
      ),
    );
  }

  void validateAndFocusFirstInvalidField() {
    if (addContractorController.contractorfirmnameController.text
        .trim()
        .isEmpty) {
      addContractorController.contractorfirmnameFocusNode.requestFocus();
      return;
    }
    if (addContractorController.gstnController.text.trim().isEmpty) {
      addContractorController.gstnFocusNode.requestFocus();
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
