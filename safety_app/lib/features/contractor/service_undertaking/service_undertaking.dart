import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/contractor/contractor_preview/contractor_preview.dart';
import 'package:flutter_app/features/contractor/service_undertaking/service_undertaking_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

// ignore: must_be_immutable
class ServiceUndertaking extends StatelessWidget {
  final int categoryId;

  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  ServiceUndertaking({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });

  final ServiceUndertakingController serviceUndertakingController =
      Get.put(ServiceUndertakingController());
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
                text: AppTexts.addContractor,
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 1,
                    backgroundColor: AppColors.searchfeildcolor,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.defaultPrimary),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '05/05',
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
              text: AppTexts.undertaking,
              fontSize: AppTextSize.textSizeMediumm,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 0.3,
            ),
            AppTextWidget(
              text: AppTexts.fillundertaking,
              fontSize: AppTextSize.textSizeSmalle,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2.5,
            ),
            Row(
              children: [
                AppTextWidget(
                  text: AppTexts.undertaking,
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
              height: SizeConfig.heightMultiplier * 0.3,
            ),
            AppTextWidget(
              text: AppTexts.ihereby,
              fontSize: AppTextSize.textSizeSmall,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryText,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 4,
                ),
                Obx(
                  () => SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Checkbox(
                      value: serviceUndertakingController
                          .isCheckedUndertaking.value,
                      activeColor: AppColors.buttoncolor,
                      side: BorderSide(
                        color: AppColors.secondaryText,
                        width: 1.2,
                      ),
                      onChanged: (bool? value) {
                        serviceUndertakingController
                            .toggleContactorSelectAllUndertaking();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 2,
                ),
                Row(
                  children: [
                    AppTextWidget(
                      text: AppTexts.selectall,
                      fontSize: AppTextSize.textSizeSmallm,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText,
                    ),
                  ],
                ),
              ],
            ),
            Obx(() =>
                serviceUndertakingController.checkboxError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 12),
                        child: Text(
                          serviceUndertakingController.checkboxError.value,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 174, 75, 68),
                              fontSize: 12),
                        ),
                      )
                    : SizedBox()),
            SizedBox(height: SizeConfig.heightMultiplier * 2.5),

            SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: serviceUndertakingController
                            .filteredDetailsUndertaking.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                visualDensity: VisualDensity.compact,
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 4, right: 3),
                                leading: SizedBox(
                                  width: 24.0,
                                  height: 24.0,
                                  child: Checkbox(
                                    value: serviceUndertakingController
                                            .filteredDetailsUndertaking[index]
                                        ['isChecked'] as bool,
                                    activeColor: AppColors.buttoncolor,
                                    side: BorderSide(
                                      color: AppColors.secondaryText,
                                      width: 1.2,
                                    ),
                                    onChanged: (bool? value) {
                                      serviceUndertakingController
                                          .toggleContactorCheckboxUndertaking(
                                              index);
                                    },
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    //${index + 1}.

                                    Flexible(
                                      child: AppTextWidget(
                                        text: serviceUndertakingController
                                            .filteredDetailsUndertaking[index]
                                                ['title']
                                            .toString(),
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryText,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }), // Display Undertaking Validation Message
                  ],
                ),
              ),
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
                            serviceUndertakingController.clearSignature();
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
                            controller: serviceUndertakingController
                                .signatureController,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ), // Validation message (Reactive)
            Obx(() =>
                serviceUndertakingController.signatureError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 12),
                        child: Text(
                          serviceUndertakingController.signatureError.value,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 174, 75, 68),
                              fontSize: 12),
                        ),
                      )
                    : SizedBox()),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Row(
              children: [
                SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Obx(() => Checkbox(
                        value: serviceUndertakingController.isCheckedSin.value,
                        activeColor: AppColors.buttoncolor,
                        side: BorderSide(
                          color: AppColors.secondaryText,
                          width: 1.2,
                        ),
                        onChanged: (bool? value) {
                          print(
                              serviceUndertakingController.isCheckedSin.value);
                          serviceUndertakingController
                              .toggleContactorCheckboxSign();
                        },
                      )),
                ),
                SizedBox(width: 8), // Adds spacing
                AppTextWidget(
                  text: 'Sign on behalf of inductee',
                  fontSize: AppTextSize.textSizeSmalle,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 4,
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
                      await serviceUndertakingController
                          .saveContactorSignature();

                      serviceUndertakingController.checkboxError.value = '';
                      if (!serviceUndertakingController.areAllChecked()) {
                        serviceUndertakingController.checkboxError.value =
                            "Please check all the required undertaking statements.";
                      }

                      if (serviceUndertakingController.areAllChecked() &&
                          serviceUndertakingController
                              .signatureController.isNotEmpty) {
                        serviceUndertakingController.signatureError.value = '';

                        Get.to(ContractorPreview(
                          categoryId: categoryId,
                          userId: userId,
                          userName: userName,
                          userImg: userImg,
                          userDesg: userDesg,
                          projectId: projectId,
                        ));
                        log('-----------------------$categoryId');
                        print("Navigating to Labour Preview with:");
                        print("User ID: $userId");
                        print("User Name: $userName");
                        print("Project ID: $projectId");
                      } else {
                        if (serviceUndertakingController
                            .signatureController.isEmpty) {
                          serviceUndertakingController.signatureError.value =
                              "Please fill in the signature.";
                        }
                      }
                    },
                    child: AppMediumButton(
                      label: "Next",
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
              height: SizeConfig.heightMultiplier * 6,
            ),
          ]),
        ),
      ),
    );
  }
}
