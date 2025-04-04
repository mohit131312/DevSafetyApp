import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bottom_navigation.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/profile_list_item.dart';
import 'package:flutter_app/features/change_password/change_password_screen.dart';
import 'package:flutter_app/features/emergency_contact/emergency_contact_screen.dart';
import 'package:flutter_app/features/login/login_screen.dart';
import 'package:flutter_app/features/profile_details/profile_details_controller.dart';
import 'package:flutter_app/features/profile_details/profile_details_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final int? userId, roleId;
  final String? selectedproject;

  ProfileScreen({super.key, this.userId, this.roleId, this.selectedproject});
  final List dataList = [
    {
      'image': 'assets/icons/user-circle.png',
      'title': 'Profile Details',
    },
    {
      'image': 'assets/icons/lock_black.png',
      'title': 'Change Password',
    },
    {
      'image': 'assets/icons/phone.png',
      'title': 'Emergency Contacts',
    },
    {
      'image': 'assets/icons/phone.png',
      'title': 'Change Role',
    },
  ];

  @override
  Widget build(BuildContext context) {
    log('print $userId');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.heightMultiplier * 32),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            scrolledUnderElevation: 0.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            toolbarHeight: SizeConfig.heightMultiplier * 32,
            backgroundColor: AppColors.buttoncolor,
            title: SizedBox(
              child: Column(
                children: [
                  AppTextWidget(
                    text: AppTexts.myprofile,
                    fontSize: AppTextSize.textSizeMediumm,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    height: SizeConfig.imageSizeMultiplier * 5,
                  ),
                  SizedBox(
                    height: SizeConfig.imageSizeMultiplier * 20,
                    width: SizeConfig.imageSizeMultiplier * 20,
                    child: Image.asset("assets/images/profile_big.png"),
                  ),
                  SizedBox(
                    height: SizeConfig.imageSizeMultiplier * 2,
                  ),
                  AppTextWidget(
                    text: "Navin Shah",
                    fontSize: AppTextSize.textSizeMediumm,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    height: SizeConfig.imageSizeMultiplier * 1,
                  ),
                  AppTextWidget(
                    text: "Access Type",
                    fontSize: AppTextSize.textSizeExtraSmall,
                    fontWeight: FontWeight.w300,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.widthMultiplier * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: AppTexts.account,
              fontSize: AppTextSize.textSizeMediumm,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            ProfileListItem(
              imagePath: 'assets/icons/user-circle_black.png',
              title: AppTexts.profiledetails,
              onTap: () async {
                final ProfileDetailsController profileDetailsController =
                    Get.put(ProfileDetailsController());
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomLoadingPopup());
                await profileDetailsController.getProfileDetails();
                Navigator.pop(context);

                if (logStatus == true) {
                  Get.to(ProfileDetailsScreen(
                    selectedproject: selectedproject,
                    userId: userId,
                    roleId: roleId,
                  ));
                } else {
                  logout();
                }
              },
            ),
            ProfileListItem(
              imagePath: 'assets/icons/lock_black.png',
              title: AppTexts.changepassword,
              onTap: () {
                Get.to(ChangePasswordScreen(
                  userId: userId,
                ));
              },
            ),
            ProfileListItem(
              imagePath: 'assets/icons/phone.png',
              title: AppTexts.emergencycontanct,
              onTap: () {
                Get.to(EmergencyContactScreen());
              },
            ),
            ProfileListItem(
              imagePath: 'assets/icons/changerole.png',
              title: AppTexts.changerole,
              onTap: () {
                Get.toNamed('/emergencycontact');
              },
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            GestureDetector(
              onTap: () {
                logout();
                Get.offAll(() => LoginScreen());
              },
              child: ListTile(
                leading: Image.asset("assets/icons/logout.png"),
                title: AppTextWidget(
                  text: AppTexts.logout,
                  fontSize: AppTextSize.textSizeSmall,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryText,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: CustomBottomNavItem(
              iconPath: 'assets/icons/home_icon_black.png',
              height: SizeConfig.heightMultiplier * 4,
              //    width: 24,
              onTap: () {
                Get.toNamed("/homescreen");
              },
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavItem(
              height: SizeConfig.heightMultiplier * 4,
              //   width: 24,
            ),
            label: "Add New",
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavItem(
              iconPath: 'assets/icons/Profile.png',
              height: SizeConfig.heightMultiplier * 4,
              onTap: () {
                Get.toNamed("/profilescreen");
              },
              // width: 24,
            ),
            label: "Profile",
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontSize: AppTextSize.textSizeExtraSmall,
          fontWeight: FontWeight.w400,
          color: AppColors.fourtText,
        ),
        selectedItemColor: AppColors.fourtText,
        unselectedItemColor: AppColors.fourtText,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.buttoncolor,
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: AppColors.buttoncolor,
          elevation: 0,
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            size: 38,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
