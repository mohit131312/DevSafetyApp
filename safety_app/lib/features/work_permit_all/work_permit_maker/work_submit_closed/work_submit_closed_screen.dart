import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/work_permit_details/work_permit_preview_maker_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class WorkSubmitClosedScreen extends StatelessWidget {
  final int userId;
  final int projectId;
  final int wpId;

  WorkSubmitClosedScreen({
    super.key,
    required this.userId,
    required this.projectId,
    required this.wpId,
  });
  final WorkPermitPreviewMakerController workPermitPreviewMakerController =
      Get.find();
  final WorkPermitController workPermitController =
      Get.put(WorkPermitController());
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
                        text: 'Closed Successfully!!',
                        fontSize: AppTextSize.textSizeMediumm,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      AppTextWidget(
                        text: 'Work permit $wpId has been closed successfully.',
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
                    workPermitPreviewMakerController.clearwpComment();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            CustomLoadingPopup());
                    await workPermitController.getWorkPermitAllListing(
                        projectId, userId, 1);
                    await workPermitController.getWorkPermitMakerListing(
                        projectId, userId, 2);
                    await workPermitController.getWorkPermitCheckerListing(
                        projectId, userId, 3);

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
