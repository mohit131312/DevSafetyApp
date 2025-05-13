import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/toolbox_training_all/seletc_trainee/select_trainee_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/seletc_trainee/select_trainee_screen.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_add_trainee/toolbox_add_trainee_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_attestation/toolbox_attestation_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

class ToolboxAddTraineeScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  ToolboxAddTraineeScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });
  final SelectTraineeController selectTraineeController =
      Get.find(); // ✅ Get the controller
  final ToolboxAddTraineeController toolboxAddTraineeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
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
              text: AppTexts.toolboxtrainingadd,
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
              vertical: SizeConfig.heightMultiplier * 1.3,
            ),
            child: SizedBox(
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
                              AppColors.thirdText),
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
                  SizedBox(height: SizeConfig.heightMultiplier * 4),
                  AppTextWidget(
                      text: AppTexts.traineesdetails,
                      fontSize: AppTextSize.textSizeMedium,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText),
                  SizedBox(height: SizeConfig.heightMultiplier * 0.7),
                  AppTextWidget(
                    text: AppTexts.entertraineesdetails,
                    fontSize: AppTextSize.textSizeSmalle,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                  Row(
                    children: [
                      AppTextWidget(
                        text: AppTexts.photos,
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
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      Obx(
                        () => toolboxAddTraineeController.traineeImageCount < 1
                            ? Container(
                                alignment: Alignment.center,
                                width: SizeConfig.widthMultiplier * 92,
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 24, bottom: 24),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.orange, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.orange.shade50,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            toolboxAddTraineeController
                                                .picktraineeImages(
                                                    source: ImageSource.camera);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.orange,
                                                size: 30,
                                              ),
                                              SizedBox(height: 8),
                                              AppTextWidget(
                                                  text: 'Click Photo',
                                                  fontSize: AppTextSize
                                                      .textSizeExtraSmall,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColors.secondaryText),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                toolboxAddTraineeController
                                                    .picktraineeImages(
                                                        source: ImageSource
                                                            .gallery);
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.photo_library,
                                                    color: Colors.orange,
                                                    size: 30,
                                                  ),
                                                  SizedBox(height: 8),
                                                  AppTextWidget(
                                                      text: 'Open Galley',
                                                      fontSize: AppTextSize
                                                          .textSizeExtraSmall,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .secondaryText),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 14),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.buttoncolor),
                                      height: 1,
                                    ),
                                    SizedBox(height: 14),
                                    AppTextWidget(
                                        text: 'Maximum 10 photos',
                                        fontSize:
                                            AppTextSize.textSizeExtraSmall,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.secondaryText),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Ensure items align properly

                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          // height: SizeConfig.imageSizeMultiplier *
                                          //     90, // Adjust based on UI needs

                                          child: GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  toolboxAddTraineeController
                                                      .traineeimg.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    3, // Ensures one row (horizontal scroll)

                                                childAspectRatio:
                                                    1, // Keeps items square
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing:
                                                    10, // Spacing between images
                                              ),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .imageSizeMultiplier *
                                                          18,
                                                      width: SizeConfig
                                                              .imageSizeMultiplier *
                                                          18,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12), // Clip image to match container

                                                        child: Image.file(
                                                          File(
                                                              toolboxAddTraineeController
                                                                  .traineeimg[
                                                                      index]
                                                                  .path),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 1,
                                                      right: 1,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          toolboxAddTraineeController
                                                              .removetraineeImage(
                                                                  index);
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                          child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
                                                              size: 15),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            SizeConfig.imageSizeMultiplier * 5,
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              toolboxAddTraineeController
                                                  .picktraineeImages(
                                                      source:
                                                          ImageSource.camera);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.orange,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.orange,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              toolboxAddTraineeController
                                                  .picktraineeImages(
                                                      source:
                                                          ImageSource.gallery);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.orange,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.photo_library,
                                                color: Colors.orange,
                                                size: 30,
                                              ),
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
                  Row(
                    children: [
                      Obx(
                        () => toolboxAddTraineeController
                                .photoError.value.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4, left: 5),
                                child: Text(
                                  toolboxAddTraineeController.photoError.value,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 174, 75,
                                        68), // Red color for error
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Row(
                    children: [
                      AppTextWidget(
                        text: AppTexts.selectretrainees,
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
                  Obx(() {
                    return (selectTraineeController
                                .selectedIncidentStaffIdsFinal.isNotEmpty ||
                            selectTraineeController
                                .selectedIncidentContractorIdsFinal
                                .isNotEmpty ||
                            selectTraineeController
                                .selectedIncidentLabourIdsFinal.isNotEmpty)
                        ? SizedBox(height: SizeConfig.heightMultiplier * 2)
                        : SizedBox();
                  }),
                  Obx(
                    () => selectTraineeController
                            .selectedIncidentLabourIdsFinal.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text: 'Select Labour',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                            ],
                          )
                        : SizedBox(),
                  ),
                  Obx(() => selectTraineeController
                          .selectedIncidentLabourIdsFinal.isNotEmpty
                      ? SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        )
                      : SizedBox()),
                  Obx(
                    () {
                      final selectedList =
                          selectTraineeController.addIncidentInvolvePerson;

                      return selectTraineeController
                              .selectedIncidentLabourIdsFinal.isNotEmpty
                          ? Container(
                              padding:
                                  EdgeInsets.only(left: 8, right: 8, top: 8),
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         width: 0.7,
                              //         color: AppColors.searchfeildcolor),
                              //     borderRadius: BorderRadius.circular(8)),
                              // height: selectTraineeController
                              //             .selectedIncidentLabourIdsFinal.length >
                              //         1
                              //     ? SizeConfig.heightMultiplier * 24
                              //     : SizeConfig.heightMultiplier * 11,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: selectedList.length,
                                itemBuilder: (context, index) {
                                  final labour = selectedList[index];
                                  if (index == 0) {
                                    toolboxAddTraineeController
                                        .toggleSignature(labour.id);
                                  }
                                  return Column(
                                    children: [
                                      ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 0, right: 20),
                                        leading: CircleAvatar(
                                          radius: 22,
                                          backgroundImage: NetworkImage(
                                              "$baseUrl${labour.userPhoto}"),
                                        ),
                                        title: AppTextWidget(
                                          text: labour.labourName.toString(),
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryText,
                                        ),
                                        subtitle: AppTextWidget(
                                          text: labour.contactNumber.toString(),
                                          fontSize: AppTextSize.textSizeSmalle,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryText,
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize
                                              .min, // Ensures the Row takes minimal space

                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                selectTraineeController
                                                    .removeIncidentData(index);
                                                toolboxAddTraineeController
                                                    .removeIncidentData2(
                                                        labour.id);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectTraineeController
                                                    .makeCall(
                                                        labour.contactNumber ??
                                                            '');
                                              },
                                              child: SizedBox(
                                                height: SizeConfig
                                                        .imageSizeMultiplier *
                                                    10,
                                                width: SizeConfig
                                                        .imageSizeMultiplier *
                                                    10,
                                                child: Image.asset(
                                                    'assets/icons/phone_orange.png'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  toolboxAddTraineeController
                                                      .toggleSignature(
                                                          labour.id);
                                                },
                                                child: Obx(() => Icon(
                                                      toolboxAddTraineeController
                                                                      .signatureVisibility[
                                                                  labour.id] ??
                                                              false
                                                          ? Icons
                                                              .keyboard_arrow_up // 🔼 If signature is visible
                                                          : Icons
                                                              .keyboard_arrow_down, // 🔽 If signature is hidden
                                                    )))
                                          ],
                                        ),
                                      ), // Signature Field (Only if Arrow is Clicked)
                                      Obx(() {
                                        return toolboxAddTraineeController
                                                        .signatureVisibility[
                                                    labour.id] ??
                                                false
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .textfeildcolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  padding: EdgeInsets.all(12),
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          toolboxAddTraineeController
                                                              .clearSignature(
                                                                  labour.id);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Icon(Icons.refresh,
                                                                color: Colors
                                                                    .orange),
                                                            SizedBox(width: 4),
                                                            Text(
                                                              'Clear',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    AppTextSize
                                                                        .textSizeSmallm,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Signature(
                                                          height: 200,
                                                          controller:
                                                              toolboxAddTraineeController
                                                                      .signatureControllers[
                                                                  labour.id]!,
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      // Show success message below the ListTile
                                                      Obx(() {
                                                        final message =
                                                            toolboxAddTraineeController
                                                                    .signatureSaveMessages[
                                                                labour.id
                                                                    .toString()];
                                                        return message !=
                                                                    null &&
                                                                message
                                                                    .isNotEmpty
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 8,
                                                                        left:
                                                                            5),
                                                                child: Text(
                                                                  message,
                                                                  style:
                                                                      TextStyle(
                                                                    color: message ==
                                                                            "Signature cannot be empty"
                                                                        ? const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            159,
                                                                            40,
                                                                            31)
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              )
                                                            : SizedBox.shrink();
                                                      }),

                                                      Row(
                                                        children: [
                                                          Obx(
                                                            () => Checkbox(
                                                              side: BorderSide(
                                                                  color: AppColors
                                                                      .searchfeild,
                                                                  width: 1),
                                                              value: toolboxAddTraineeController
                                                                          .traineeSignBehalf[
                                                                      labour
                                                                          .id] ??
                                                                  false,
                                                              onChanged:
                                                                  (value) {
                                                                toolboxAddTraineeController
                                                                    .toggleTraineeSignBehalf(
                                                                        labour
                                                                            .id); // ✅ Toggles selection
                                                              },
                                                              activeColor:
                                                                  AppColors
                                                                      .buttoncolor,
                                                            ),
                                                          ),
                                                          AppTextWidget(
                                                            fontSize: AppTextSize
                                                                .textSizeSmall,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .secondaryText,
                                                            text:
                                                                'Sign on behalf of trainee',
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          await toolboxAddTraineeController
                                                              .updateCombinedList(
                                                                  true,
                                                                  labour.id);
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .orange, // Background color
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // Rounded corners
                                                          ),
                                                          child: Text(
                                                            "Save Signature",
                                                            style: GoogleFonts
                                                                .inter(
                                                              color: Colors
                                                                  .white, // Text color
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox();
                                      })
                                    ],
                                  );
                                },
                              ),
                            )
                          : SizedBox();
                    },
                  ),
                  Obx(() =>
                      toolboxAddTraineeController.trainnerError.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4, left: 5),
                              child: Text(
                                toolboxAddTraineeController.trainnerError.value,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 174, 75, 68),
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : SizedBox.shrink()),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: AppColors.thirdText,
                          width: 0.8,
                        ),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Get.to(SelectTraineeScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 28,
                          color: AppColors.thirdText,
                          weight: 0.2,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1,
                        ),
                        AppTextWidget(
                          text: "Add Trainees",
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w400,
                          color: AppColors.thirdText,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 6),
                ],
              ),
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
                  log("----------${selectTraineeController.addIncidentInvolvePerson.length}");
                  log("----------${toolboxAddTraineeController.signatureControllers.length}");
                  await toolboxAddTraineeController.updateCombinedList(
                      false, 0);
                  toolboxAddTraineeController.validateTraineeImage();
                  toolboxAddTraineeController.validateIncidentSelection();
                  if (toolboxAddTraineeController
                      .combinedIncidentIdsFinal.isEmpty) {
                    toolboxAddTraineeController.trainnerError.value =
                        "Please add at least one trainee & Signature is required for all trainees.";
                    return;
                  }

                  if (toolboxAddTraineeController.traineeImageCount.value > 0 &&
                      toolboxAddTraineeController.trainnerError.value.isEmpty &&
                      toolboxAddTraineeController
                          .combinedIncidentIdsFinal.isNotEmpty) {
                    Get.to(ToolboxAttestationScreen(
                        userId: userId,
                        userName: userName,
                        userImg: userImg,
                        userDesg: userDesg,
                        projectId: projectId));
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
