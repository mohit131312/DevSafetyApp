import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_undertaking/work_permit_under_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../work_permit_preview/work_permit_preview_screen.dart';

// ignore: must_be_immutable
class WorkPermitUnderScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  WorkPermitUnderScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final WorkPermitUnderController workPermitUnderController = Get.find();
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
                        value: workPermitUnderController
                            .isCheckedUndertaking.value,
                        activeColor: AppColors.buttoncolor,
                        side: BorderSide(
                          color: AppColors.secondaryText,
                          width: 1.2,
                        ),
                        onChanged: (bool? value) {
                          workPermitUnderController
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
              Obx(() => workPermitUnderController.checkboxError.value.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4, left: 12),
                      child: Text(
                        workPermitUnderController.checkboxError.value,
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
                          itemCount: workPermitUnderController
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
                                      value: workPermitUnderController
                                              .filteredDetailsUndertaking[index]
                                          ['isChecked'] as bool,
                                      activeColor: AppColors.buttoncolor,
                                      side: BorderSide(
                                        color: AppColors.secondaryText,
                                        width: 1.2,
                                      ),
                                      onChanged: (bool? value) {
                                        workPermitUnderController
                                            .toggleCheckboxUndertaking(index);
                                      },
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      //${index + 1}.

                                      Flexible(
                                        child: AppTextWidget(
                                          text: workPermitUnderController
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
                height: SizeConfig.heightMultiplier * 4,
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
                              workPermitUnderController.clearSignature();
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
                              controller:
                                  workPermitUnderController.signatureController,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ), // Validation message (Reactive)
              Obx(() =>
                  workPermitUnderController.signatureError.value.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4, left: 12),
                          child: Text(
                            workPermitUnderController.signatureError.value,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 174, 75, 68),
                                fontSize: 12),
                          ),
                        )
                      : SizedBox()),
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
                  imagePath: 'assets/icons/arrow-narrow-left.png',
                ),
              ),
              SizedBox(width: SizeConfig.widthMultiplier * 5),
              GestureDetector(
                onTap: () async {
                  await workPermitUnderController.saveSignature();

                  workPermitUnderController.checkboxError.value = '';
                  if (!workPermitUnderController.areAllChecked()) {
                    workPermitUnderController.checkboxError.value =
                        "Please check all the required undertaking statements.";
                  }

                  if (workPermitUnderController.areAllChecked() &&
                      workPermitUnderController
                          .signatureController.isNotEmpty) {
                    workPermitUnderController.signatureError.value = '';

                    Get.to(WorkPermitPreviewScreen(
                        userId: userId,
                        userName: userName,
                        userImg: userImg,
                        userDesg: userDesg,
                        projectId: projectId));
                    print("Navigating to Labour Preview with:");
                    print("User ID: $userId");
                    print("User Name: $userName");
                    print("Project ID: $projectId");
                  } else {
                    if (workPermitUnderController.signatureController.isEmpty) {
                      workPermitUnderController.signatureError.value =
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
