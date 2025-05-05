import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/home_screen_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_details_assignor/incident_report_details_assignor_cotroller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class IncidentReportSubmitClosed extends StatelessWidget {
  final int userId;
  final int projectId;
  final int incidentId;

  IncidentReportSubmitClosed(
      {super.key,
      required this.userId,
      required this.projectId,
      required this.incidentId});
  final IncidentReportDetailsAssignorCotroller
      incidentReportDetailsAssignorCotroller =
      Get.put(IncidentReportDetailsAssignorCotroller());
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
                      text: 'Closed Successfully!',
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
                          'Incident report $incidentId has been Closed successfully.',
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
                  final IncidentReportController incidentReportController =
                      Get.put(IncidentReportController());

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
                  incidentReportDetailsAssignorCotroller.resetAssigneeForm();
                  Navigator.pop(context);

                  Get.back(); // Go back to the previous screen
                  Get.back();
                }),
          ),
        ),
      ),
    );
  }
}
