// ignore_for_file: must_be_immutable

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
import 'package:flutter_app/features/select_role/select_role.dart';
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

  String userName;
  String userImg;
  String userDesg;

  ProfileScreen({
    super.key,
    this.userId,
    this.roleId,
    this.selectedproject,
    required this.userName,
    required this.userImg,
    required this.userDesg,
  });

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
                  CircleAvatar(
                    radius: 40, // Adjust radius to make the circle bigger
                    backgroundColor: Colors.grey.shade200, // Fallback color
                    child: ClipOval(
                      child: Image.network(
                        "$baseUrl${userImg}",
                        fit: BoxFit.cover,
                        width: 80, // Increased width (diameter = 2 * radius)
                        height: 80, // Increased height (diameter = 2 * radius)
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: SizedBox(
                              width: 36,
                              height: 36,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.buttoncolor,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/icons/image.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.imageSizeMultiplier * 2,
                  ),
                  AppTextWidget(
                    text: userName,
                    fontSize: AppTextSize.textSizeMediumm,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    height: SizeConfig.imageSizeMultiplier * 1.5,
                  ),
                  AppTextWidget(
                    text: userDesg,
                    fontSize: AppTextSize.textSizeSmall,
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
              fontSize: AppTextSize.textSizeMedium,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            ProfileListItem(
              imagePath: 'assets/images/blackuser-circle.png',
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
              imagePath: 'assets/images/balcakuserlock.png',
              title: AppTexts.changepassword,
              onTap: () {
                Get.to(ChangePasswordScreen(
                  userId: userId,
                ));
              },
            ),
            ProfileListItem(
              imagePath: 'assets/images/blackuserphone.png',
              title: AppTexts.emergencycontanct,
              onTap: () {
                Get.to(EmergencyContactScreen());
              },
            ),
            ProfileListItem(
              imagePath: 'assets/images/blackkuserusers.png',
              title: AppTexts.changerole,
              onTap: () {
                Get.offAll(() => SelectRole());
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
                leading: Image.asset(
                  "assets/images/blackuserlogout.png",
                  height: 28,
                  width: 28,
                ),
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
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: CustomBottomNavItem(
              iconPath: 'assets/icons/Labours.png',
              height: SizeConfig.heightMultiplier * 3.5,
              //    width: 24,
              onTap: () {
                Get.back();
              },
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavItem(
              iconPath: 'assets/images/home_profileimg.png',
              height: SizeConfig.heightMultiplier * 3.5,
              onTap: () {
                // Get.to(ProfileScreen());
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     color: AppColors.buttoncolor,
      //   ),
      //   child: FloatingActionButton(
      //     onPressed: () {},
      //     backgroundColor: AppColors.buttoncolor,
      //     foregroundColor: AppColors.buttoncolor,
      //     elevation: 0,
      //     shape: CircleBorder(),
      //     child: Icon(
      //       Icons.add,
      //       size: 33,
      //       color: AppColors.primary,
      //     ),
      //   ),
      // )
    );
  }
}
