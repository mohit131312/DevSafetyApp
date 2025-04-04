import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/contractor/add_contractor/add_contractor_controller.dart';
import 'package:flutter_app/features/home/home_screen.dart';
import 'package:flutter_app/features/induction_training/induction_training_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class ContractorSubmit extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;

  ContractorSubmit({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
  });
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
                    text:
                        'Labour details has been added successfully intothe database.',
                    fontSize: AppTextSize.textSizeSmalle,
                    fontWeight: FontWeight.w500,
                    color: AppColors.searchfeild,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 33,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: AppElevatedButton(
                          text: 'Done',
                          onPressed: () {
                            final AddContractorController
                                addContractorController = Get.find();

                            addContractorController
                                .clearUserFieldsFinalContractor();
                            InductionTrainingScreen inductionTrainingScreen =
                                Get.put(InductionTrainingScreen(
                              userId: userId,
                              userName: userName,
                              projectId: projectId,
                            ));
                            inductionTrainingScreen.isFabExpanded.value = true;
                            Get.offUntil(
                              GetPageRoute(
                                  page: () => InductionTrainingScreen(
                                        userId: userId,
                                        userName: userName,
                                        projectId: projectId,
                                      )),
                              (route) {
                                if (route is GetPageRoute) {
                                  return route.page!().runtimeType ==
                                      HomeScreen;
                                }
                                return false;
                              },
                            );
                          })),
                  SizedBox(height: SizeConfig.heightMultiplier * 5),
                ],
              ),
            )),
      ),
    );
  }
}
