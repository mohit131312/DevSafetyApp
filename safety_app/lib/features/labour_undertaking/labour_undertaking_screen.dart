import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/Labour_add/add_labour_controller.dart';
import 'package:flutter_app/features/labour_preview/labour_preview_screen.dart';
import 'package:flutter_app/features/labour_undertaking/labour_undertaking_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

// ignore: must_be_immutable
class LabourUndertakingScreen extends StatelessWidget {
  final int categoryId;

  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  LabourUndertakingScreen({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });

  final LabourUndertakingController labourUndertakingController =
      Get.put(LabourUndertakingController());
  final AddLabourController addLabourController = Get.find();
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 1,
                      backgroundColor: AppColors.searchfeildcolor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.defaultPrimary),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '05/05',
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
                text: AppTexts.undertaking,
                fontSize: AppTextSize.textSizeMediumm,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 0.3,
              ),
              AppTextWidget(
                text: AppTexts.fillundertaking,
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
                    text: AppTexts.undertaking,
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
                text: AppTexts.ihereby,
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
                  SizedBox(
                    width: 4,
                  ),
                  Obx(
                    () => SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: Checkbox(
                        value: labourUndertakingController
                            .isCheckedUndertaking.value,
                        activeColor: AppColors.buttoncolor,
                        side: BorderSide(
                          color: AppColors.secondaryText,
                          width: 1.2,
                        ),
                        onChanged: (bool? value) {
                          labourUndertakingController
                              .toggleSelectAllUndertaking();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 2,
                  ),
                  Row(
                    children: [
                      AppTextWidget(
                        text: AppTexts.selectall,
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText,
                      ),
                    ],
                  ),
                ],
              ),
              Obx(() =>
                  labourUndertakingController.checkboxError.value.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4, left: 12),
                          child: Text(
                            labourUndertakingController.checkboxError.value,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 174, 75, 68),
                                fontSize: 12),
                          ),
                        )
                      : SizedBox()),
              SizedBox(height: SizeConfig.heightMultiplier * 2.5),

              SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: labourUndertakingController
                              .filteredDetailsUndertaking.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListTile(
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.only(
                                      top: 0, bottom: 0, left: 4, right: 3),
                                  leading: SizedBox(
                                    width: 24.0,
                                    height: 24.0,
                                    child: Checkbox(
                                      value: labourUndertakingController
                                              .filteredDetailsUndertaking[index]
                                          ['isChecked'] as bool,
                                      activeColor: AppColors.buttoncolor,
                                      side: BorderSide(
                                        color: AppColors.secondaryText,
                                        width: 1.2,
                                      ),
                                      onChanged: (bool? value) {
                                        labourUndertakingController
                                            .toggleCheckboxUndertaking(index);
                                      },
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      //${index + 1}.

                                      Flexible(
                                        child: AppTextWidget(
                                          text: labourUndertakingController
                                              .filteredDetailsUndertaking[index]
                                                  ['title']
                                              .toString(),
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryText,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }), // Display Undertaking Validation Message
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                children: [
                  AppTextWidget(
                    text: AppTexts.signature,
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
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.textfeildcolor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              labourUndertakingController.clearSignature();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                    'assets/icons/reload.png',
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                AppTextWidget(
                                  text: 'Clear',
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryText,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          Listener(
                            onPointerDown: (_) {
                              Future.delayed(Duration(milliseconds: 50), () {
                                if (labourUndertakingController
                                    .signatureController.isNotEmpty) {
                                  labourUndertakingController
                                      .signatureError.value = '';
                                }
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Signature(
                                height: 200,
                                controller: labourUndertakingController
                                    .signatureController,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ), // Validation message (Reactive)
              Obx(() =>
                  labourUndertakingController.signatureError.value.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4, left: 12),
                          child: Text(
                            labourUndertakingController.signatureError.value,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 174, 75, 68),
                                fontSize: 12),
                          ),
                        )
                      : SizedBox()),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Obx(() => Checkbox(
                          value: labourUndertakingController.isCheckedSin.value,
                          activeColor: AppColors.buttoncolor,
                          side: BorderSide(
                            color: AppColors.secondaryText,
                            width: 1.2,
                          ),
                          onChanged: (bool? value) {
                            print(
                                labourUndertakingController.isCheckedSin.value);
                            labourUndertakingController.toggleCheckboxSign();
                          },
                        )),
                  ),
                  SizedBox(width: 8), // Adds spacing
                  AppTextWidget(
                    text: 'Sign on behalf of inductee',
                    fontSize: AppTextSize.textSizeSmalle,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 4,
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 6,
              ),
            ]),
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
                onTap: () async {
                  await labourUndertakingController.saveSignature();

                  labourUndertakingController.checkboxError.value = '';
                  if (!labourUndertakingController.areAllChecked()) {
                    labourUndertakingController.checkboxError.value =
                        "Please check all the required undertaking statements.";
                  }

                  if (labourUndertakingController.areAllChecked() &&
                      labourUndertakingController
                          .signatureController.isNotEmpty) {
                    log('-------------${addLabourController.profilePhoto.value}');
                    labourUndertakingController.signatureError.value = '';

                    Get.to(LabourPreviewScreen(
                      categoryId: categoryId,
                      userId: userId,
                      userName: userName,
                      userImg: userImg,
                      userDesg: userDesg,
                      projectId: projectId,
                    ));
                    log('-----------------------$categoryId');
                    print("Navigating to Labour Preview with:");
                    print("User ID: $userId");
                    print("User Name: $userName");
                    print("Project ID: $projectId");
                  } else {
                    if (labourUndertakingController
                        .signatureController.isEmpty) {
                      labourUndertakingController.signatureError.value =
                          "Please fill in the signature.";
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
