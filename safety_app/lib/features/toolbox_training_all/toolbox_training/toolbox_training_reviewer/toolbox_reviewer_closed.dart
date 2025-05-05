import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/home_screen_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_reviewer/toolbox_training_reviewer_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ToolboxReviewerClosed extends StatelessWidget {
  final int userId;
  final int projectId;
  final int tbtID;
  ToolboxReviewerClosed({
    super.key,
    required this.userId,
    required this.projectId,
    required this.tbtID,
  });

  ToolboxTrainingController toolboxTrainingController =
      Get.put(ToolboxTrainingController());
  final ToolboxTrainingReviewerController toolboxTrainingReviewerController =
      Get.find();
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
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
                    mainAxisAlignment: MainAxisAlignment.end,
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
                        text: 'Checked Successfully!!',
                        fontSize: AppTextSize.textSizeMediumm,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      AppTextWidget(
                        text:
                            'toolbox training $tbtID has been checked successfully.',
                        fontSize: AppTextSize.textSizeSmalle,
                        fontWeight: FontWeight.w500,
                        color: AppColors.searchfeild,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 25,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 5),
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
                    toolboxTrainingReviewerController.cleartoolboxComment();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            CustomLoadingPopup());
                    await toolboxTrainingController.getToolBoxListingAll(
                        projectId, userId, 1);
                    await toolboxTrainingController.getToolBoxListingMaker(
                        projectId, userId, 2);
                    await toolboxTrainingController.getToolBoxListingReviewer(
                        projectId, userId, 3);
                    final HomeScreenController homeScreenController =
                        Get.put(HomeScreenController());
                    await homeScreenController.getCardListing(
                        projectId, userId);
                    Navigator.pop(context);
                    Get.back();
                    Get.back();
                    // Get.offUntil(
                    //   GetPageRoute(
                    //       page: () => HomeScreen()), // Push new screen
                    //   (route) {
                    //     if (route is GetPageRoute) {
                    //       return route.page!().runtimeType ==
                    //           SelectProjectScreen;
                    //     }
                    //     return false;
                    //   },
                    // );
                  }),
            ),
          ),
        ));
  }
}
