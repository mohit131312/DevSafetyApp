import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/home_screen_controller.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/sefety_violation_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class SafetyResolvedScreen extends StatelessWidget {
  final int userId;
  final int projectId;
  final int safetyId;
  final String uniqueId;

  SafetyResolvedScreen(
      {super.key,
      required this.userId,
      required this.projectId,
      required this.safetyId,
      required this.uniqueId});
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
                        text: 'Resolved Successfully!',
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
                            'safety violation $uniqueId has been Resolved successfully.',
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
                    final SefetyViolationController sefetyViolationController =
                        Get.find();

                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            CustomLoadingPopup());
                    await sefetyViolationController
                        .getSafetyViolationAllListing(projectId, userId, 1);
                    await sefetyViolationController
                        .getSafetyViolationAssignorListing(
                            projectId, userId, 2);
                    await sefetyViolationController
                        .getSafetyViolationAssigneeListing(
                            projectId, userId, 3);
                    final HomeScreenController homeScreenController =
                        Get.put(HomeScreenController());
                    await homeScreenController.getCardListing(
                        projectId, userId);

                    Navigator.pop(context);

                    Get.back(); // Go back to the previous screen
                    Get.back();
                  }),
            ),
          ),
        ));
  }
}
