import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/edit_profile/edit_profile_screen.dart';
import 'package:flutter_app/features/profile_details/profile_details_controller.dart';
import 'package:flutter_app/features/select_project/select_project_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final String? selectedproject;
  final int? userId, roleId;

  final SelectProjectController selectProjectController =
      Get.put(SelectProjectController());

  final ProfileDetailsController profileDetailsController =
      Get.put(ProfileDetailsController());
  ProfileDetailsScreen(
      {super.key, this.selectedproject, this.userId, this.roleId});

  @override
  Widget build(BuildContext context) {
    log('print $userId');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.buttoncolor,
        centerTitle: true,
        toolbarHeight: SizeConfig.heightMultiplier * 10,
        title: Padding(
          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
          child: AppTextWidget(
            text: AppTexts.profiledetails,
            fontSize: AppTextSize.textSizeMediumm,
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
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(EditProfileScreen(
                userId: userId,
                roleId: roleId,
              ));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 15, right: 10),
              alignment: Alignment.center,
              height: 50,
              width: 60,
              child: AppTextWidget(
                text: AppTexts.edit,
                fontSize: AppTextSize.textSizeSmall,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.heightMultiplier * 2,
              horizontal: SizeConfig.widthMultiplier * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.imageSizeMultiplier * 30,
                    width: SizeConfig.imageSizeMultiplier * 30,
                    child: Image.network(
                        "$baseUrl${profileDetailsController.profiledetails['profile_photo']}"),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/icons/User.png",
                    height: SizeConfig.imageSizeMultiplier * 6,
                    width: SizeConfig.imageSizeMultiplier * 6,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 1,
                  ),
                  AppTextWidget(
                    text: AppTexts.personaldetails,
                    fontSize: AppTextSize.textSizeSmallm,
                    fontWeight: FontWeight.w500,
                    color: AppColors.buttoncolor,
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 1),
              Container(
                width: SizeConfig.widthMultiplier * 88,
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 1,
                    horizontal: SizeConfig.widthMultiplier * 1),
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 2,
                    horizontal: SizeConfig.widthMultiplier * 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 0.3, color: AppColors.secondaryText)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: 'Name',
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.5,
                    ),
                    AppTextWidget(
                      text:
                          "${profileDetailsController.profiledetails['first_name']} ${profileDetailsController.profiledetails['last_name']}",
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    AppTextWidget(
                      text: 'User Name',
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.5,
                    ),
                    AppTextWidget(
                      text:
                          "${profileDetailsController.profiledetails['first_name']?.trim() ?? ''}_${profileDetailsController.profiledetails['last_name']?.trim() ?? ''}"
                              .replaceAll(RegExp(r'\s+'), ''),
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    AppTextWidget(
                      text: 'Contact Number',
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.5,
                    ),
                    AppTextWidget(
                      text:
                          "${profileDetailsController.profiledetails['mobile_number']}",
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    AppTextWidget(
                      text: 'Email Id',
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.5,
                    ),
                    AppTextWidget(
                      text:
                          "${profileDetailsController.profiledetails['email']}",
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 3),
              Row(
                children: [
                  Image.asset(
                    "assets/icons/home_icon.png",
                    height: SizeConfig.imageSizeMultiplier * 6,
                    width: SizeConfig.imageSizeMultiplier * 6,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 1,
                  ),
                  AppTextWidget(
                    text: AppTexts.profiledetails,
                    fontSize: AppTextSize.textSizeSmallm,
                    fontWeight: FontWeight.w500,
                    color: AppColors.buttoncolor,
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 3),
              Container(
                clipBehavior: Clip.hardEdge,
                width: SizeConfig.widthMultiplier * 88,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 0.5, color: AppColors.secondaryText)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier * 1.5,
                          horizontal: SizeConfig.widthMultiplier * 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 40,
                            child: AppTextWidget(
                              text: 'Current Project',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Flexible(
                            child: AppTextWidget(
                              text: selectedproject ?? 'No project selected',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryText,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier * 1.5,
                          horizontal: SizeConfig.widthMultiplier * 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 40,
                            child: AppTextWidget(
                              text: 'Assigned Projects',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: selectProjectController
                                    .selectProject.length,
                                itemBuilder: (context, index) {
                                  return AppTextWidget(
                                    text: selectProjectController
                                        .selectProject[index].projectName,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryText,
                                    textAlign: TextAlign.start,
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
