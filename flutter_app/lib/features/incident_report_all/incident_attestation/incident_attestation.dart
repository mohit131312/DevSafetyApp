import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/incident_report_all/incedent_report_preview/incedent_report_preview_screen.dart';
import 'package:flutter_app/features/incident_report_all/incident_attestation/incident_attestation_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_informed_people/select_informed_people_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_injured/select_injured_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

// ignore: must_be_immutable
class IncidentAttestation extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;

  IncidentAttestation({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final IncidentAttestationController incidentAttestationController =
      Get.put(IncidentAttestationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //  resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.heightMultiplier * 10),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            scrolledUnderElevation: 0.0,
            elevation: 0,
            backgroundColor: AppColors.buttoncolor,
            foregroundColor: AppColors.buttoncolor,
            centerTitle: true,
            toolbarHeight: SizeConfig.heightMultiplier * 10,
            title: Padding(
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
              child: AppTextWidget(
                text: 'Preview',
                fontSize: AppTextSize.textSizeMedium,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ),
            leading: Padding(
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: SizeConfig.heightMultiplier * 2.5,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 4,
            vertical: SizeConfig.heightMultiplier * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 1,
                      backgroundColor: AppColors.searchfeildcolor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.defaultPrimary),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '03/03',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.5,
              ),
              AppTextWidget(
                text: 'Attestation',
                fontSize: AppTextSize.textSizeMediumm,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 0.3,
              ),
              AppTextWidget(
                text: 'Add authority signature.',
                fontSize: AppTextSize.textSizeSmalle,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryText,
              ),

              //------------------------------
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              Row(
                children: [
                  Container(
                    width: SizeConfig.imageSizeMultiplier * 15,
                    height: SizeConfig.imageSizeMultiplier * 15,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: userImg.isNotEmpty
                          ? NetworkImage("$baseUrl${userImg}")
                          : AssetImage("assets/images/default_avatar.png")
                              as ImageProvider,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 3,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                          text: userName,
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText),
                      AppTextWidget(
                          text: userDesg,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w400,
                          color: AppColors.searchfeild),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 1,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Row(
                children: [
                  AppTextWidget(
                    text: AppTexts.signature,
                    fontSize: AppTextSize.textSizeMedium,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  AppTextWidget(
                      text: AppTexts.star,
                      fontSize: AppTextSize.textSizeExtraSmall,
                      fontWeight: FontWeight.w400,
                      color: AppColors.starcolor),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 20, bottom: 20),
                      height: 305,
                      decoration: BoxDecoration(
                        color: AppColors.textfeildcolor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              incidentAttestationController
                                  .clearIncidentattestationSignature();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                    'assets/icons/reload.png',
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                AppTextWidget(
                                  text: 'Clear',
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryText,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 4,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Signature(
                              height: 206,
                              controller: incidentAttestationController
                                  .signatureattestationController,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() => incidentAttestationController
                      .signatureattestationError.value.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4, left: 12),
                      child: Text(
                        incidentAttestationController
                            .signatureattestationError.value,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 174, 75, 68),
                            fontSize: 12),
                      ),
                    )
                  : SizedBox()),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              AppTextWidget(
                  text: 'Date',
                  fontSize: AppTextSize.textSizeSmalle,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              AppTextWidget(
                  text: '06 Oct 2024 11:14 AM',
                  fontSize: AppTextSize.textSizeSmall,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              AppTextWidget(
                  text: 'Location of Submission',
                  fontSize: AppTextSize.textSizeSmalle,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              AppTextWidget(
                  text:
                      'Sade Satra Nali, Pune, Hadapsar, 411028, Maharashtra, Pune',
                  fontSize: AppTextSize.textSizeSmall,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),

              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppMediumButton(
                        label: "Previous",
                        borderColor: AppColors.buttoncolor,
                        iconColor: AppColors.buttoncolor,
                        backgroundColor: Colors.white,
                        textColor: AppColors.buttoncolor,
                        imagePath: 'assets/icons/arrow-narrow-left.png',
                      ),
                    ),
                    SizedBox(width: SizeConfig.widthMultiplier * 5),
                    GestureDetector(
                      onTap: () async {
                        await incidentAttestationController
                            .saveSafetyIncidentSignature();

                        final SelectInformedIncidentController
                            selectInformedIncidentController =
                            Get.put(SelectInformedIncidentController());
                        final SelectInjuredController selectInjuredController =
                            Get.put(SelectInjuredController());
                        selectInjuredController.updateCombinedList();

                        selectInformedIncidentController
                            .convertIncidentInvolveIdsToMap();

                        if (incidentAttestationController
                            .signatureattestationController.isEmpty) {
                          incidentAttestationController
                              .signatureattestationError
                              .value = "Please fill in the signature.";
                        }
                        if (incidentAttestationController
                            .signatureattestationController.isNotEmpty) {
                          print(
                              '----------------${incidentAttestationController.savedAttestationSignature.value}');
                          Get.to(IncedentReportPreviewScreen(
                              userId: userId,
                              userName: userName,
                              userImg: userImg,
                              userDesg: userDesg,
                              projectId: projectId));
                          // Get.to(SafetyPreviewScreen(
                          //     userId: userId,
                          //     userName: userName,
                          //     userImg: userImg,
                          //     userDesg: userDesg));
                        }
                      },
                      child: AppMediumButton(
                        label: "Preview",
                        borderColor: AppColors.backbuttoncolor,
                        iconColor: Colors.white,
                        textColor: Colors.white,
                        backgroundColor: AppColors.buttoncolor,
                        imagePath2: 'assets/icons/arrow-narrow-right.png',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
