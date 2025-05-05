import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/safety_violation_all/safety_attestaion/safety_attestaion_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_preview/safety_preview_screen.dart';
import 'package:flutter_app/features/safety_violation_all/select_informed_people/select_safety_informed_people_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_involved_person/select_involved_person_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

// ignore: must_be_immutable
class SafetyAttestaionScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  SafetyAttestaionScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final SafetyAttestaionController safetyAttestaionController =
      Get.put(SafetyAttestaionController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        //  resizeToAvoidBottomInset: false,
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
              text: 'Preview',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      '03/03',
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
                  text: 'Attestation',
                  fontSize: AppTextSize.textSizeMediumm,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 0.3,
                ),
                AppTextWidget(
                  text: 'Add authority signature.',
                  fontSize: AppTextSize.textSizeSmalle,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryText,
                ),

                //------------------------------
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),

                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Row(
                  children: [
                    Container(
                      width: SizeConfig.imageSizeMultiplier * 15,
                      height: SizeConfig.imageSizeMultiplier * 15,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: userImg.isNotEmpty
                            ? NetworkImage("$baseUrl${userImg}")
                            : AssetImage("assets/images/default_avatar.png")
                                as ImageProvider,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 3,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                            text: userName,
                            fontSize: AppTextSize.textSizeSmallm,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText),
                        AppTextWidget(
                            text: userDesg,
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.searchfeild),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
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
                            left: 12, right: 12, top: 20, bottom: 20),
                        height: 305,
                        decoration: BoxDecoration(
                          color: AppColors.textfeildcolor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                safetyAttestaionController
                                    .clearSafetyattestationSignature();
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
                              height: SizeConfig.heightMultiplier * 4,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Signature(
                                height: 206,
                                controller: safetyAttestaionController
                                    .signatureattestationController,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(() => safetyAttestaionController
                        .signatureattestationError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 12),
                        child: Text(
                          safetyAttestaionController
                              .signatureattestationError.value,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 174, 75, 68),
                              fontSize: 12),
                        ),
                      )
                    : SizedBox()),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),

                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),

                SizedBox(
                  height: SizeConfig.heightMultiplier * 5,
                ),

                SizedBox(
                  height: SizeConfig.heightMultiplier * 5,
                ),
              ],
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
                  imagePath: 'assets/icons/arrow-narrow-left.png',
                ),
              ),
              SizedBox(width: SizeConfig.widthMultiplier * 5),
              GestureDetector(
                onTap: () async {
                  await safetyAttestaionController
                      .saveSafetyattestationSignature();

                  final SelectInvolvedPersonController
                      selectInvolvedPersonController = Get.find();
                  selectInvolvedPersonController.updateCombinedList();
                  final SelectSafetyInformedPeopleController
                      selectSafetyInformedPeopleController = Get.find();
                  selectSafetyInformedPeopleController
                      .convertAssigneeIdsToMap();

                  if (safetyAttestaionController
                      .signatureattestationController.isEmpty) {
                    safetyAttestaionController.signatureattestationError.value =
                        "Please fill in the signature.";
                  }
                  if (safetyAttestaionController
                      .signatureattestationController.isNotEmpty) {
                    print(
                        '----------------${safetyAttestaionController.savedAttestationSignature.value}');
                    Get.to(SafetyPreviewScreen(
                      userId: userId,
                      userName: userName,
                      userImg: userImg,
                      userDesg: userDesg,
                      projectId: projectId,
                    ));
                  }
                },
                child: AppMediumButton(
                  label: "Preview",
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
      ),
    );
  }
}
