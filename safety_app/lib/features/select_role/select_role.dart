import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/login/login_screen.dart';
import 'package:flutter_app/features/select_project/select_project_controller.dart';
import 'package:flutter_app/features/select_project/select_project_screen.dart';
import 'package:flutter_app/features/select_role/select_role_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';

class SelectRole extends StatefulWidget {
  const SelectRole({super.key});
  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  final SelectRoleController selectRoleController =
      Get.put(SelectRoleController());
  final SelectProjectController selectProjectController =
      Get.put(SelectProjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            text: AppTexts.selectrole,
            fontSize: AppTextSize.textSizeMediumm,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: IconButton(
              onPressed: () async {
                if (await CheckInternet.checkInternet()) {
                  logout();
                  Get.offAll(() => LoginScreen());
                } else {
                  await showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) {
                      return CustomValidationPopup(
                          message: "Please check your internet connection.");
                    },
                  );
                }
              },
              icon: Icon(
                Icons.logout,
                size: SizeConfig.heightMultiplier * 2.5,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 4,
            vertical: SizeConfig.heightMultiplier * 1.3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: selectRoleController.roleArray.length,
                  itemBuilder: (context, index) {
                    log('-------------${selectRoleController.roleArray.length}');
                    return GestureDetector(
                      onTap: () async {
                        if (await CheckInternet.checkInternet()) {
                          selectRoleController.roleId.value = 0;
                          selectRoleController.userDesg.value = '';
                          selectRoleController.selectedIndex.value = -1;
                          await selectRoleController.selectRole(index);

                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomLoadingPopup());

                          await selectProjectController.getProjectDetails(
                            selectRoleController.userId.value,
                            selectRoleController.roleId.value,
                          );

                          Navigator.pop(context);

                          log('User ID: ${selectRoleController.userId.value}');
                          log('Role ID: ${selectRoleController.roleId.value}');

                          if (logStatus == true) {
                            Get.to(() => SelectProjectScreen(
                                  userId: selectRoleController.userId.value,
                                  roleId: selectRoleController.roleId.value,
                                  userName: selectRoleController.username.value,
                                  userImg: selectRoleController.userimg.value,
                                  userDesg: selectRoleController.userDesg.value,
                                ));

                            log("User ID: ${selectRoleController.userId.value}");
                            log("Role ID: ${selectRoleController.roleId.value}");
                            log("Username: ${selectRoleController.username.value}");
                            log("UserDesg: ${selectRoleController.userDesg.value}");
                          } else {
                            logout();
                          }
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
                      child: Obx(
                        () {
                          bool isSelected =
                              selectRoleController.selectedIndex.value == index;
                          return Container(
                            decoration: BoxDecoration(
                                color: AppColors.textfeildcolor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: isSelected
                                        ? AppColors.buttoncolor
                                        : AppColors.searchfeildcolor,
                                    width: 1)),
                            padding: EdgeInsets.only(
                                left: SizeConfig.widthMultiplier * 8,
                                right: SizeConfig.widthMultiplier * 8),
                            height: SizeConfig.heightMultiplier * 9,
                            width: SizeConfig.widthMultiplier * 90,
                            child: Row(
                              children: [
                                AppTextWidget(
                                    text: selectRoleController
                                        .roleArray[index].roleName,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? AppColors.buttoncolor
                                        : AppColors.primaryText),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: SizeConfig.heightMultiplier * 2.5,
                                  color: AppColors.primaryText,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
