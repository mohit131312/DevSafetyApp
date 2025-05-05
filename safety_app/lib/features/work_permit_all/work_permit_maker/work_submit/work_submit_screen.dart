import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/home_screen.dart';
import 'package:flutter_app/features/home/home_screen_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_screen.dart';

import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_undertaking/work_permit_under_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class WorkSubmitScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  WorkSubmitScreen({
    super.key,
    required this.userImg,
    required this.userDesg,
    required this.userId,
    required this.userName,
    required this.projectId,
  });
  final WorkPermitUnderController workPermitUnderController =
      Get.put(WorkPermitUnderController());
  final WorkPermitController workPermitController =
      Get.put(WorkPermitController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevents back button press
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 2,
              ),
              child: SizedBox(
                height: SizeConfig.heightMultiplier * 100,
                width: SizeConfig.widthMultiplier * 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Success.png',
                      height: 125,
                      width: 125,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 7,
                    ),
                    AppTextWidget(
                      text: 'Submitted Successfully!',
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    AppTextWidget(
                      text: 'Work permit has been created successfully.',
                      fontSize: AppTextSize.textSizeSmalle,
                      fontWeight: FontWeight.w500,
                      color: AppColors.searchfeild,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.heightMultiplier * 1,
              horizontal: SizeConfig.widthMultiplier * 4,
            ),
            child: AppElevatedButton(
                text: 'Done',
                onPressed: () async {
                  workPermitUnderController.filteredDetailsUndertaking.clear();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomLoadingPopup());
                  await workPermitController.getWorkPermitAllListing(
                      projectId, userId, 1);
                  await workPermitController.getWorkPermitMakerListing(
                      projectId, userId, 2);
                  await workPermitController.getWorkPermitCheckerListing(
                      projectId, userId, 3);
                  final HomeScreenController homeScreenController =
                      Get.put(HomeScreenController());
                  await homeScreenController.getWorkPermitAllListing(
                    projectId,
                  );

                  await homeScreenController.getCardListing(projectId, userId);

                  Navigator.pop(context);
                  Get.offUntil(
                    GetPageRoute(
                        page: () => WorkPermitScreen(
                              userId: userId,
                              userName: userName,
                              projectId: projectId,
                              userImg: userImg,
                              userDesg: userDesg,
                            )),
                    (route) {
                      if (route is GetPageRoute) {
                        return route.page!().runtimeType == HomeScreen;
                      }
                      return false;
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }
}
