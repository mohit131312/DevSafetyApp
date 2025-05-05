import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/incident_report_all/incident_attestation/incident_attestation.dart';
import 'package:flutter_app/features/incident_report_all/incident_more_details/incident_more_details_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class IncidentMoreDetailsScreen extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;

  IncidentMoreDetailsScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final IncidentMoreDetailsController incidentMoreDetailsController =
      Get.put(IncidentMoreDetailsController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // ✅ Form key

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        //  resizeToAvoidBottomInset: false,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: AppColors.buttoncolor,
          centerTitle: true,
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: AppTextWidget(
              text: 'Incident Report',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 4,
              vertical: SizeConfig.heightMultiplier * 2,
            ),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.66,
                            backgroundColor: AppColors.searchfeildcolor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.defaultPrimary),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '02/03',
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
                      text: 'More Details',
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.3,
                    ),
                    AppTextWidget(
                      text: 'Enter cause & preventive measures details.',
                      fontSize: AppTextSize.textSizeSmalle,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),

                    //------------------------------
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: 'Root Cause',
                          fontSize: AppTextSize.textSizeSmall,
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
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    AppTextFormfeild(
                      controller:
                          incidentMoreDetailsController.rootcauseController,
                      hintText: 'Location of Incident',
                      focusNode:
                          incidentMoreDetailsController.rootcauseFocusNode,
                      onFieldSubmitted: (_) {
                        incidentMoreDetailsController.rootcauseFocusNode
                            .unfocus();
                      },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Location of Incident cannot be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: 'Preventive Measures',
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
                    Obx(
                      () => incidentMoreDetailsController
                              .selectedMoreIncidentIds.isEmpty
                          ? Row(
                              children: [
                                Text(
                                  incidentMoreDetailsController
                                      .preventionError.value,
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 174, 75, 68),
                                      fontSize: 12),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: Checkbox(
                              value: incidentMoreDetailsController
                                  .isCheckedMeasures.value,
                              activeColor: AppColors.buttoncolor,
                              side: BorderSide(
                                color: AppColors.secondaryText,
                                width: 1.2,
                              ),
                              onChanged: (bool? value) {
                                incidentMoreDetailsController
                                    .toggleSelectAllMeasures();
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: SizeConfig.widthMultiplier * 2),
                        AppTextWidget(
                          text: AppTexts.selectall,
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryText,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 3,
                      ),
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.appgreycolor,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 5.2,
                                    width: SizeConfig.widthMultiplier * 80,
                                    child: AppTextFormfeild(
                                      controller: incidentMoreDetailsController
                                          .searchController,
                                      hintText: 'Search By Name..',
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      prefixIcon: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/icons/Search.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        incidentMoreDetailsController
                                            .updatePreventiveSearchQuery(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                          SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () {
                                      final filteredList =
                                          incidentMoreDetailsController
                                              .filteredIncidentMeasures;

                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: filteredList.length,
                                          itemBuilder: (context, index) {
                                            final measure = filteredList[index];

                                            return ListTile(
                                              dense: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: 0,
                                                  right: 20,
                                                  top: 0,
                                                  bottom: 0),
                                              leading: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Transform.scale(
                                                      scale: 1,
                                                      child: Obx(
                                                        () => Checkbox(
                                                          activeColor: AppColors
                                                              .buttoncolor,
                                                          side: BorderSide(
                                                            color: AppColors
                                                                .secondaryText,
                                                            width: 1.2,
                                                          ),
                                                          value: incidentMoreDetailsController
                                                              .selectedMoreIncidentIds
                                                              .contains(
                                                                  measure.id),
                                                          onChanged: (value) {
                                                            incidentMoreDetailsController
                                                                .toggleIncidentSelection(
                                                                    measure.id);
                                                          },
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              title: AppTextWidget(
                                                text: measure.incidentDetails
                                                    .toString(),
                                                fontSize:
                                                    AppTextSize.textSizeSmalle,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.secondaryText,
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 5,
                    ),

                    SizedBox(height: SizeConfig.heightMultiplier * 5),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
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
                onTap: () {
                  incidentMoreDetailsController
                      .updateSelectedIncidentMeasuresList(userId);
                  if (incidentMoreDetailsController
                      .selectedMoreIncidentIds.isEmpty) {
                    incidentMoreDetailsController.preventionError.value =
                        "Please Select Prevention Measure";
                  }
                  if (formKey.currentState!.validate()) {
                    if (incidentMoreDetailsController
                        .selectedMoreIncidentIds.isNotEmpty) {
                      Get.to(IncidentAttestation(
                          userId: userId,
                          userName: userName,
                          userImg: userImg,
                          userDesg: userDesg,
                          projectId: projectId));
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
      ),
    );
  }
}
