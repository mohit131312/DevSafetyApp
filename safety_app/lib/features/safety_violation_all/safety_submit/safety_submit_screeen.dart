import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/home_screen.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation/sefety_violation_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class SafetySubmitScreeen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  SafetySubmitScreeen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false, // Prevents back button press
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
                      text: 'safety violation has been created successfully.',
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
                              Get.offUntil(
                                GetPageRoute(
                                    page: () => SefetyViolationScreen(
                                        userId: userId,
                                        userName: userName,
                                        userImg: userImg,
                                        userDesg: userDesg,
                                        projectId: projectId)),
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
        ));
  }
}
