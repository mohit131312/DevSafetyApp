import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/home_screen.dart';
import 'package:flutter_app/features/home/home_screen_controller.dart';
import 'package:flutter_app/features/incident_report_all/incedent_report_preview/incedent_report_preview_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_screen.dart';
import 'package:flutter_app/features/incident_report_all/select_injured/select_injured_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class IncidentReportSubmit extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;

  IncidentReportSubmit({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final IncedentReportPreviewController incedentReportPreviewController =
      Get.find();
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
                      text: 'Created Successfully!',
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    AppTextWidget(
                      text: 'Incident report has been created successfully.',
                      fontSize: AppTextSize.textSizeSmalle,
                      fontWeight: FontWeight.w500,
                      color: AppColors.searchfeild,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 23,
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
                  incedentReportPreviewController.clearData();
                  final IncidentReportController incidentReportController =
                      Get.find();

                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomLoadingPopup());
                  await incidentReportController.getIncidentReportAllListing(
                      projectId, userId, 1);
                  await incidentReportController
                      .getIncidentReportAssignorListing(projectId, userId, 2);
                  await incidentReportController
                      .getIncidentReportAssigneeListing(projectId, userId, 3);
                  final HomeScreenController homeScreenController =
                      Get.put(HomeScreenController());
                  await homeScreenController.getCardListing(projectId, userId);
                  final SelectInjuredController selectInjuredController =
                      Get.find();
                  selectInjuredController.resetData();
                  Get.back();
                  Get.offUntil(
                    GetPageRoute(
                        page: () => IncidentReportScreen(
                              userId: userId,
                              userName: userName,
                              userImg: userImg,
                              userDesg: userDesg,
                              projectId: projectId,
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
