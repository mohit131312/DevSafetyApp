import 'package:flutter/material.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_screen.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/features/induction_training/induction_training_screen.dart';
import 'package:flutter_app/features/project_labour/project_labour_controller.dart';
import 'package:flutter_app/features/project_labour/project_labour_screen.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/sefety_violation_screen.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_screen.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_controller.dart';
import 'package:flutter_app/features/work_permit_all/work_permit/work_permit_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class QuickActionsGrid extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;
  final String selectedproject;

  QuickActionsGrid({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
    required this.selectedproject,
  });
  final InductionTrainingController inductionTrainingController =
      Get.put(InductionTrainingController());
  final ProjectLabourController projectLabourController =
      Get.put(ProjectLabourController());
  final WorkPermitController workPermitController =
      Get.put(WorkPermitController());
  ToolboxTrainingController toolboxTrainingController =
      Get.put(ToolboxTrainingController());
  @override
  Widget build(BuildContext context) {
    final actions = [
      {'img': "assets/icons/bag.png", 'label': 'Work Permit (WP)'},
      {'img': "assets/icons/TBT.png", 'label': 'Toolbox Training (TBT)'},
      {'img': "assets/icons/User.png", 'label': 'Induction Training'},
      {'img': "assets/icons/SA.png", 'label': 'Safety Violation'},
      {'img': "assets/icons/IR.png", 'label': 'Incident Report'},
      {'img': "assets/icons/Labours.png", 'label': 'Project Labour'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 10,
        childAspectRatio: 2.7,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            switch (index) {
              case 0:
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomLoadingPopup());
                await workPermitController.getWorkPermitAllListing(
                    projectId, userId, 1);
                await workPermitController.getWorkPermitMakerListing(
                    projectId, userId, 2);
                await workPermitController.getWorkPermitCheckerListing(
                    projectId, userId, 3);

                Navigator.pop(context);
                if (logStatus == true) {
                  Get.to(() => WorkPermitScreen(
                      userId: userId,
                      userName: userName,
                      userImg: userImg,
                      userDesg: userDesg,
                      projectId: projectId));
                  print("Navigating to WorkPermitScreen with:");
                  print("User ID: $userId");
                  print("User Name: $userName");
                  print("Project ID: $projectId");
                } else {
                  logout();
                }
                break;
              case 1:
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomLoadingPopup());
                await toolboxTrainingController.getToolBoxListingAll(
                    projectId, userId, 1);
                await toolboxTrainingController.getToolBoxListingMaker(
                    projectId, userId, 2);
                await toolboxTrainingController.getToolBoxListingReviewer(
                    projectId, userId, 3);

                Navigator.pop(context);
                if (logStatus == true) {
                  Get.to(() => ToolboxTrainingScreen(
                      userId: userId,
                      userName: userName,
                      userImg: userImg,
                      userDesg: userDesg,
                      projectId: projectId));
                  print("Navigating to ToolboxTrainingScreen with:");
                  print("User ID: $userId");
                  print("User Name: $userName");
                  print("Project ID: $projectId");
                } else {
                  logout();
                }
                break;
              case 2:
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomLoadingPopup());
                await inductionTrainingController.getProjectDetails();
                await inductionTrainingController.getInductionListing(
                    projectId, userId);

                Navigator.pop(context);
                if (logStatus == true) {
                  Get.to(() => InductionTrainingScreen(
                        userId: userId,
                        userName: userName,
                        userImg: userImg,
                        userDesg: userDesg,
                        projectId: projectId,
                      ));
                  print("Navigating to InductionTrainingScreen with:");
                  print("User ID: $userId");
                  print("User Name: $userName");
                  print("Project ID: $projectId");
                } else {
                  logout();
                }
                break;
              case 3:
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) => CustomLoadingPopup());
                // Navigator.pop(context);
                if (logStatus == true) {
                  Get.to(() => SefetyViolationScreen(
                        userId: userId,
                        userName: userName,
                        userImg: userImg,
                        userDesg: userDesg,
                        projectId: projectId,
                      ));
                  print("Navigating to SefetyViolationScreen with:");
                  print("User ID: $userId");
                  print("User Name: $userName");
                } else {
                  logout();
                }
                break;
              case 4:
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomLoadingPopup());
                Navigator.pop(context);
                if (logStatus == true) {
                  Get.to(() => IncidentReportScreen(
                      userId: userId,
                      userName: userName,
                      userImg: userImg,
                      userDesg: userDesg,
                      projectId: projectId));
                  print("Navigating to IncidentReportScreen with:");
                  print("User ID: $userId");
                  print("User Name: $userName");
                } else {
                  logout();
                }
                break;
              case 5:
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomLoadingPopup());
                await projectLabourController.getLabourDetails(projectId);
                Navigator.pop(context);
                if (logStatus == true) {
                  Get.to(ProjectLabourScreen(
                    selectedproject: selectedproject,
                    projectId: projectId,
                  ));
                  print("Navigating to IncidentReportScreen with:");
                  print("User ID: $userId");
                  print("User Name: $userName");
                } else {
                  logout();
                }

                break;

              default:
                break;
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 227, 226, 226)),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: SizeConfig.widthMultiplier * 3.5,
                  child: Image.asset(
                    actions[index]['img']!,
                    color: AppColors.buttoncolor,
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                  child: Text(
                    actions[index]['label'].toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: AppTextSize.textSizeSmalle,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
