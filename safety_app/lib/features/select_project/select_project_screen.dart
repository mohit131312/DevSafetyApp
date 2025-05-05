import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/home_screen.dart';
import 'package:flutter_app/features/home/home_screen_controller.dart';
import 'package:flutter_app/features/select_project/select_project_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SelectProjectScreen extends StatelessWidget {
  final SelectProjectController selectProjectController =
      Get.put(SelectProjectController());
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  int userId, roleId;
  String userName;
  String userImg;
  String userDesg;
  SelectProjectScreen({
    super.key,
    required this.userId,
    required this.roleId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
  });

  final bool isCircleBlack = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        automaticallyImplyLeading: false,

        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.buttoncolor,
        centerTitle: true,
        toolbarHeight: SizeConfig.heightMultiplier * 10,
        title: Padding(
          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
          child: AppTextWidget(
            text: AppTexts.selectproject,
            fontSize: AppTextSize.textSizeMediumm,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
        // leading: Padding(
        //   padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
        //   child: IconButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_ios,
        //       size: SizeConfig.heightMultiplier * 2.5,
        //       color: AppColors.primary,
        //     ),
        //   ),
        // ),
      ),
      body: ListView.builder(
          itemCount: selectProjectController.selectProject.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    selectProjectController.selectProjectAtIndex(index);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            CustomLoadingPopup());

                    await homeScreenController.getWorkPermitAllListing(
                        await selectProjectController
                            .selectProject[index].projectId);
                    await homeScreenController.getCardListing(
                        selectProjectController.selectProject[index].projectId,
                        userId);
                    Get.back();
                    Get.to(HomeScreen(
                      userId: userId,
                      roleId: roleId,
                      userImg: userImg,
                      selectedproject: selectProjectController
                          .selectProject[index].projectName,
                      userName: userName,
                      projectId: selectProjectController
                          .selectProject[index].projectId,
                      userDesg: userDesg,
                    ));
                    print("Navigating to HomeScreen with:");
                    print("User ID: $userId");
                    print("Role ID: $roleId");
                    print("Userimg: $userImg");
                    print("userName: $userName");
                    print("userDesg: $userDesg");
                    print(
                        "Selected Project: ${selectProjectController.selectProject[index].projectName}");
                    print(
                        "Project ID: ${selectProjectController.selectProject[index].projectId}");
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      leading: SizedBox(
                        width: SizeConfig.imageSizeMultiplier * 14,
                        height: SizeConfig.imageSizeMultiplier * 14,
                        child: Image.asset('assets/icons/project_building.png'),
                      ),
                      title: AppTextWidget(
                        text: selectProjectController
                            .selectProject[index].projectName,
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                      // subtitle: AppTextWidget(
                      //   text: dummyListData[index]['location'],
                      //   fontSize: AppTextSize.textSizeExtraSmall,
                      //   fontWeight: FontWeight.w400,
                      //   color: AppColors.secondaryText,
                      // ),
                      trailing: GestureDetector(
                        onTap: () {
                          selectProjectController.toggleCircleColor();
                        },
                        child: Obx(
                          () => SizedBox(
                            width: 20,
                            height: 20,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  color: AppColors.thirdText,
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectProjectController
                                                .selectedProjectIndex.value ==
                                            index
                                        ? AppColors.thirdText
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.textfeildcolor,
                  thickness: 1.5,
                  height: 2,
                ),
              ],
            );
          }),
    );
  }
}
