import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/contractor/add_contractor/add_contractor_controller.dart';
import 'package:flutter_app/features/contractor/service_details/service_details_controller.dart';
import 'package:flutter_app/features/contractor/service_undertaking/service_undertaking.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ServiceDetailsScreen extends StatelessWidget {
  final int categoryId;
  final int userId;
  final String userName;
  final int projectId;
  ServiceDetailsScreen({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.projectId,
  });
  final ServiceDetailsController serviceDetailsController =
      Get.put(ServiceDetailsController());
  final InductionTrainingController inductionTrainingController = Get.find();
  final AddContractorController addContractorController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Form Key

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
          child: Form(
            key: formKey, // Assign the key
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.75,
                          backgroundColor: AppColors.searchfeildcolor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.defaultPrimary),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '03/05',
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
                    text: 'Services Details',
                    fontSize: AppTextSize.textSizeMediumm,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.3,
                  ),
                  AppTextWidget(
                    text: 'Enter contractor services details',
                    fontSize: AppTextSize.textSizeSmalle,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  //primaryContactPerson

                  Row(
                    children: [
                      AppTextWidget(
                        text: 'Select Activity',
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
                  Obx(
                    () => AppSearchDropdown(
                      //   enabled: !addContractorController.userFound.value, //
                      items: addContractorController.userFound.value
                          ? serviceDetailsController.activityExist
                              .map(
                                (activity) => inductionTrainingController
                                        .activityList
                                        .any((a) =>
                                            a.id.toString() ==
                                            activity['activity_id'].toString())
                                    ? inductionTrainingController.activityList
                                        .firstWhere((a) =>
                                            a.id.toString() ==
                                            activity['activity_id'].toString())
                                        .activityName
                                    : 'No Matching Activity',
                              )
                              .toList()
                          : inductionTrainingController.activityList
                              .map((activity) => activity.activityName)
                              .toList(),
                      selectedItem: serviceDetailsController
                              .selectedactivity.value.isNotEmpty
                          ? serviceDetailsController.selectedactivity.value
                          : null,
                      hintText: 'Select Activity',
                      onChanged: (value) async {
                        serviceDetailsController.selectedactivity.value =
                            value ?? '';
                        if (addContractorController.userFound.value) {
                          log('User found, skipping API call.');
                          return; // Exit early if user is present
                        }

                        if (value != null) {
                          var selectedActivityObj = inductionTrainingController
                              .activityList
                              .firstWhereOrNull(
                                  (activity) => activity.activityName == value);

                          if (selectedActivityObj != null) {
                            serviceDetailsController.selectedActivityId.value =
                                selectedActivityObj.id;

                            // Fetch districts for selected state

                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomLoadingPopup());
                            int id = serviceDetailsController
                                .selectedActivityId.value;

                            await serviceDetailsController.getSubActivtyList(
                                id, context);
                            Navigator.pop(context);

                            log('addLabourController selectedStateId------------${id}');

                            log('Selected selectedActivityId ID: ${serviceDetailsController.selectedActivityId.value}');
                            log('Selected selectedActivity Name: ${serviceDetailsController.selectedactivity.value}');
                          } else {
                            log('No matching reason found for: $value');
                          }
                        }
                      },
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please select a Activity ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Obx(() => serviceDetailsController.activityError.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 4, left: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                serviceDetailsController.activityError.value,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 174, 75, 68),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink()),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),

                  Row(
                    children: [
                      AppTextWidget(
                        text: 'Select SubActivity',
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Obx(
                    () => AppSearchDropdown(
                      //    enabled: !addContractorController.userFound.value, //

                      items: addContractorController.userFound.value
                          ? serviceDetailsController.activityExist
                              .map(
                                (activity) => inductionTrainingController
                                        .subActivityList
                                        .any((a) =>
                                            a.id.toString() ==
                                            activity['sub_activity_id']
                                                .toString())
                                    ? inductionTrainingController
                                        .subActivityList
                                        .firstWhere((a) =>
                                            a.id.toString() ==
                                            activity['sub_activity_id']
                                                .toString())
                                        .subactivityName
                                    : 'No Matching Activity',
                              )
                              .toList()
                          : serviceDetailsController.subActivityMatchedList
                              .map(
                                (actmateched) => actmateched.subActivityName,
                              )
                              .toList(),
                      selectedItem: serviceDetailsController
                              .selectedSubactivity.value.isNotEmpty
                          ? serviceDetailsController.selectedSubactivity.value
                          : null,
                      hintText: 'Select Sub Activity',
                      onChanged: (value) {
                        serviceDetailsController.selectedSubactivity.value =
                            value ?? '';

                        if (value != null) {
                          var selectedSubActivityObj = serviceDetailsController
                              .subActivityMatchedList
                              .firstWhereOrNull(
                                  (subact) => subact.subActivityName == value);

                          if (selectedSubActivityObj != null) {
                            serviceDetailsController.selectedSubActivityId
                                .value = selectedSubActivityObj.id;
                            log('Selected selectedsubActivityId ID: ${serviceDetailsController.selectedSubActivityId.value}');
                            log('Selected selectedsubActivity Name: ${serviceDetailsController.selectedSubactivity.value}');
                          } else {
                            log('No matching reason found for: $value');
                          }
                        }
                      },
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please select a SubActivity ';
                        } else if (serviceDetailsController
                            .selectSubActivityList
                            .contains(value)) {
                          return 'This SubActivity is already selected';
                        }
                        return null;
                      },
                    ),
                  ),
                  Obx(() => serviceDetailsController.subActivityError.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 4, left: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                serviceDetailsController.subActivityError.value,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 174, 75, 68),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink()),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.thirdText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: AppColors.thirdText,
                          width: 0.8,
                        ),
                      ),
                      minimumSize: Size(double.infinity, 42),
                    ),
                    onPressed: addContractorController.userFound.value
                        ? null
                        : () {
                            serviceDetailsController.subActivityError.value =
                                '';
                            serviceDetailsController.activityError.value = '';
                            if (serviceDetailsController
                                    .selectedactivity.value.isNotEmpty &&
                                serviceDetailsController
                                        .selectedActivityId.value !=
                                    0 &&
                                serviceDetailsController
                                    .selectedSubactivity.value.isNotEmpty &&
                                serviceDetailsController
                                        .selectedSubActivityId.value !=
                                    0) {
                              serviceDetailsController.addActivity(
                                  serviceDetailsController
                                      .selectedactivity.value,
                                  serviceDetailsController
                                      .selectedActivityId.value,
                                  serviceDetailsController
                                      .selectedSubactivity.value,
                                  serviceDetailsController
                                      .selectedSubActivityId.value);

                              serviceDetailsController.clearOne();
                            } else {
                              serviceDetailsController.activityError.value =
                                  "Please select a Activity ";
                              serviceDetailsController.subActivityError.value =
                                  "Please select a SubActivity ";
                            }
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextWidget(
                          text: "Add Service",
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w400,
                          color: addContractorController.userFound.value
                              ? AppColors.thirdText
                              : AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),

                  Obx(
                    () => serviceDetailsController.selectActivityList.isEmpty
                        ? addContractorController.userFound.value
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primary,
                                    border: Border.all(
                                        width: 0.7,
                                        color: AppColors.backbuttoncolor)),
                                width: SizeConfig.widthMultiplier * 92,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    child: ListView.separated(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          serviceDetailsController
                                                              .activityExist
                                                              .length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (index >=
                                                            serviceDetailsController
                                                                .activityExist
                                                                .length) {
                                                          return SizedBox
                                                              .shrink();
                                                        }
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        AppTextWidget(
                                                                            text:
                                                                                'Activity',
                                                                            fontSize:
                                                                                AppTextSize.textSizeSmall,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: AppColors.searchfeild),
                                                                        SizedBox(
                                                                          height:
                                                                              SizeConfig.heightMultiplier * 1,
                                                                        ),
                                                                        AppTextWidget(
                                                                            text: inductionTrainingController.activityList.any((activity) => activity.id.toString() == serviceDetailsController.activityExist[index]['activity_id'].toString())
                                                                                ? inductionTrainingController.activityList.firstWhere((activity) => activity.id.toString() == serviceDetailsController.activityExist[index]['activity_id'].toString()).activityName
                                                                                : 'No Matching Activity',
                                                                            fontSize: AppTextSize.textSizeSmalle,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: AppColors.primaryText),
                                                                        SizedBox(
                                                                          height:
                                                                              SizeConfig.heightMultiplier * 2.5,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            2.5,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        AppTextWidget(
                                                                            text:
                                                                                'Sub Activity',
                                                                            fontSize:
                                                                                AppTextSize.textSizeSmall,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: AppColors.searchfeild),
                                                                        SizedBox(
                                                                          height:
                                                                              SizeConfig.heightMultiplier * 1,
                                                                        ),
                                                                        AppTextWidget(
                                                                            // text:
                                                                            //     serviceDetailsController.activityExist[index]['sub_activity_id'].toString(),
                                                                            text: inductionTrainingController.subActivityList.any((subActivity) => subActivity.id.toString() == serviceDetailsController.activityExist[index]['sub_activity_id'].toString())
                                                                                ? inductionTrainingController.subActivityList.firstWhere((subActivity) => subActivity.id.toString() == serviceDetailsController.activityExist[index]['sub_activity_id'].toString()).subactivityName
                                                                                : 'No Matching Sub-Activity',
                                                                            fontSize: AppTextSize.textSizeSmalle,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: AppColors.primaryText),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Container(
                                                          height: 1,
                                                          color: AppColors
                                                              .searchfeildcolor,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primary,
                                border: Border.all(
                                    width: 0.7,
                                    color: AppColors.backbuttoncolor)),
                            width: SizeConfig.widthMultiplier * 92,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: ListView.separated(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      serviceDetailsController
                                                          .selectActivityList
                                                          .length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (index >=
                                                        serviceDetailsController
                                                            .selectSubActivityList
                                                            .length) {
                                                      return SizedBox.shrink();
                                                    }
                                                    return Stack(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8),
                                                                ),
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              height: SizeConfig
                                                                      .imageSizeMultiplier *
                                                                  10,
                                                              width: SizeConfig
                                                                      .widthMultiplier *
                                                                  10,
                                                              child: IconButton(
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 20,
                                                                ),
                                                                onPressed: () {
                                                                  serviceDetailsController
                                                                      .removeSubActivity(
                                                                          index);
                                                                  serviceDetailsController
                                                                      .removeActivity(
                                                                          index);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        AppTextWidget(
                                                                            text:
                                                                                'Activity',
                                                                            fontSize:
                                                                                AppTextSize.textSizeSmall,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: AppColors.searchfeild),
                                                                        SizedBox(
                                                                          height:
                                                                              SizeConfig.heightMultiplier * 1,
                                                                        ),
                                                                        AppTextWidget(
                                                                            text:
                                                                                serviceDetailsController.selectActivityList[index],
                                                                            fontSize: AppTextSize.textSizeSmalle,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: AppColors.primaryText),
                                                                        SizedBox(
                                                                          height:
                                                                              SizeConfig.heightMultiplier * 2.5,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            2.5,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        AppTextWidget(
                                                                            text:
                                                                                'Sub Activity',
                                                                            fontSize:
                                                                                AppTextSize.textSizeSmall,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: AppColors.searchfeild),
                                                                        SizedBox(
                                                                          height:
                                                                              SizeConfig.heightMultiplier * 1,
                                                                        ),
                                                                        AppTextWidget(
                                                                            text:
                                                                                serviceDetailsController.selectSubActivityList[index],
                                                                            fontSize: AppTextSize.textSizeSmalle,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: AppColors.primaryText),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      height: 1,
                                                      color: AppColors
                                                          .searchfeildcolor,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),

                  //---------------------------------------------

                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
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
                          onTap: () {
                            if (serviceDetailsController
                                .selectActivityIdList.isEmpty) {
                              serviceDetailsController.activityError.value =
                                  "Please select a Activity ";
                            } else {
                              serviceDetailsController.activityError.value = "";
                            }
                            if (serviceDetailsController
                                .selectActivityIdList.isEmpty) {
                              serviceDetailsController.subActivityError.value =
                                  "Please select a SubActivity ";
                            } else {
                              serviceDetailsController.subActivityError.value =
                                  "";
                            }
                            if (serviceDetailsController
                                    .selectActivityIdList.isNotEmpty &&
                                serviceDetailsController
                                    .selectSubActivityIdList.isNotEmpty) {
                              Get.to(ServiceUndertaking(
                                categoryId: categoryId,
                                userId: userId,
                                userName: userName,
                                projectId: projectId,
                              ));
                            }
                            print("Navigating to ServiceUndertaking with:");

                            print("User ID: $userId");
                            print("User Name: $userName");
                            print("Project ID: $projectId");
                            print("categoryId: $categoryId");
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
      ),
    );
  }
}
