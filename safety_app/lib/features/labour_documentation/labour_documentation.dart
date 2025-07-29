import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_search_dropdown_astric.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/Labour_add/add_labour_controller.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/features/labour_documentation/labour_documentation_controller.dart';
import 'package:flutter_app/features/labour_precaution/labour_precaustion_screen.dart';
import 'package:flutter_app/features/labour_precaution/labour_precaution_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class LabourDocumentation extends StatelessWidget {
  final int categoryId;

  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  LabourDocumentation({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final LabourDocumentationController labourDocumentationController =
      Get.find();
  final InductionTrainingController inductionTrainingController = Get.find();
  final LabourPrecautionController controller = Get.find();
  final AddLabourController addLabourController = Get.find();
  void showDatePicker(BuildContext context,
      LabourDocumentationController labourDocumentationController) {
    DateTime tempPickedDate =
        labourDocumentationController.selectedDateValidity.value ??
            DateTime.now();

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextWidget(
                    text: 'Enter Validity',
                    fontSize: AppTextSize.textSizeMediumm,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
                Container(
                  width: SizeConfig.widthMultiplier * 100,
                  height: SizeConfig.heightMultiplier * 0.1,
                  color: AppColors.secondaryText,
                ),
                // Date Picker
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttoncolor,
                          ),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        minimumDate: DateTime.now().toLocal().copyWith(
                            hour: 0,
                            minute: 0,
                            second: 0,
                            millisecond: 0,
                            microsecond: 0),
                        maximumDate:
                            DateTime.now().add(Duration(days: 365 * 50)),
                        onDateTimeChanged: (DateTime newDate) {
                          tempPickedDate = newDate;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: AppTextWidget(
                        text: 'Cancel',
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        labourDocumentationController
                            .updateDateValidity(tempPickedDate);
                        Navigator.pop(context);
                      },
                      child: AppTextWidget(
                        text: 'Done',
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttoncolor,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
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
              text: AppTexts.addlabour,
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.6,
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
                text: AppTexts.documentation,
                fontSize: AppTextSize.textSizeMediumm,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 0.3,
              ),
              AppTextWidget(
                text: AppTexts.uploadreqdoc,
                fontSize: AppTextSize.textSizeSmalle,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryText,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1.5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.textfeildcolor,
                ),
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                width: SizeConfig.widthMultiplier * 92,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppTexts.adharCard,
                      fontSize: AppTextSize.textSizeMedium,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                            text: AppTexts.adharnum,
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryText),
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
                    Form(
                      key: formKey,
                      child: AppTextFormfeild(
                        enabled: !addLabourController.userFound
                            .value, // ✅ Editable only if user NOT found
                        readOnly: addLabourController
                            .userFound.value, // ✅ Read-only if user is found
                        controller:
                            labourDocumentationController.adharnoController,
                        hintText: 'Enter Adhar ID number',
                        focusNode: labourDocumentationController.adharnoFocus,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (_) {
                          labourDocumentationController.adharnoFocus.unfocus();
                        },
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(12),
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Adhar number cannot be empty';
                          }
                          if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                            return 'Enter a valid 12-Adhar number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                  ],
                ),
              ),
              //-------------------------------------------------------------------------
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.textfeildcolor,
                ),
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                // height: SizeConfig.heightMultiplier * 69,
                width: SizeConfig.widthMultiplier * 92,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppTexts.otherIdproof,
                      fontSize: AppTextSize.textSizeMedium,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                            text: AppTexts.doctype,
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryText),
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
                      () => AppSearchDropdownAstric(
                        items: inductionTrainingController.idProofList
                            .map((idproof) => idproof.compulsory == 1
                                ? '${idproof.listDetails} *'
                                : idproof.listDetails)
                            .toList(),
                        selectedItem: labourDocumentationController
                                .selectedDoctType.value.isNotEmpty
                            ? labourDocumentationController
                                .selectedDoctType.value
                            : null,
                        hintText: 'Select document type',
                        onChanged: (value) {
                          labourDocumentationController.selectedDoctType.value =
                              value ?? '';

                          // var selectedProof = inductionTrainingController
                          //     .idProofList
                          //     .firstWhereOrNull(
                          //         (idproof) => idproof.listDetails == value);
                          String cleanedValue =
                              value?.replaceAll(' *', '') ?? '';

                          var selectedProof = inductionTrainingController
                              .idProofList
                              .firstWhereOrNull((idproof) =>
                                  idproof.listDetails == cleanedValue);

                          if (selectedProof != null) {
                            labourDocumentationController
                                .selectedIdProofId.value = selectedProof.id;
                            if (labourDocumentationController
                                .selectedDoctType.value.isEmpty) {
                              labourDocumentationController.documentError
                                  .value = "Please select a document type";
                            } else {
                              labourDocumentationController.documentError
                                  .value = ""; // Clear error if valid
                            }

                            print(
                                "Selected Document ID: ${labourDocumentationController.selectedDoctType.value}");
                            print(
                                "Selected Document ID: ${labourDocumentationController.selectedIdProofId.value}");
                          }
                        },
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'Please select a document';
                          }
                          return null;
                        },
                      ),
                    ),

                    Obx(() => labourDocumentationController
                            .documentError.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 4, left: 13),
                            child: Text(
                              labourDocumentationController.documentError.value,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 174, 75, 68),
                                  fontSize: 12),
                            ),
                          )
                        : SizedBox.shrink()),

                    //------------------------------

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                            text: AppTexts.docphoto,
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryText),
                        AppTextWidget(
                            text: AppTexts.star,
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.starcolor),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Obx(
                      () => labourDocumentationController.otherImageCount < 1
                          ? Container(
                              alignment: Alignment.center,
                              width: SizeConfig.widthMultiplier * 82,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.orange, width: 2),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.orange.shade50,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      labourDocumentationController
                                          .pickotherImages(ImageSource.camera);
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
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.secondaryText),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      labourDocumentationController
                                          .pickotherImages(ImageSource.gallery);
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
                                            text: 'Open Gallery',
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.secondaryText),
                                      ],
                                    ),
                                  )
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
                                        height: SizeConfig.imageSizeMultiplier *
                                            20, // Adjust based on UI needs

                                        child: GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                labourDocumentationController
                                                    .labourotherimg.length,
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
                                                            labourDocumentationController
                                                                .labourotherimg[
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
                                                        labourDocumentationController
                                                            .removeOtherImage(
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
                                                              .withOpacity(0.8),
                                                        ),
                                                        child: Icon(Icons.close,
                                                            color: Colors.white,
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
                                      width: SizeConfig.imageSizeMultiplier * 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),

                    Obx(() => labourDocumentationController
                            .photoError.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 4, left: 13),
                            child: Text(
                              labourDocumentationController.photoError.value,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 174, 75, 68),
                                  fontSize: 12),
                            ),
                          )
                        : SizedBox.shrink()),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                            text: AppTexts.idno,
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryText),
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
                      controller: labourDocumentationController.idnoController,

                      hintText: 'Enter ID number',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      enabled: true, // Set to false to disable the field
                      readOnly:
                          false, // Set to true if you don't want it editable
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'Id cannot be empty';
                      //   }

                      //   return null;
                      // },
                      onChanged: (value) {
                        //    labourDocumentationController.idNumber.value = value;
                        if (value.trim().isNotEmpty) {
                          labourDocumentationController.idNumberError.value =
                              "";
                        }
                      },
                    ),

                    Obx(() => labourDocumentationController
                            .idNumberError.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 4, left: 13),
                            child: Text(
                              labourDocumentationController.idNumberError.value,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 174, 75, 68),
                                  fontSize: 12),
                            ),
                          )
                        : SizedBox.shrink()),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),

                    GestureDetector(
                      onTap: () {
                        // labourDocumentationController.removeByAll();
                      },
                      child: Row(
                        children: [
                          AppTextWidget(
                              text: AppTexts.validity,
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryText),
                          AppTextWidget(
                              text: AppTexts.star,
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.starcolor),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),

                    GestureDetector(
                      onTap: () {
                        //  if (!addLabourController.userFound.value) {
                        showDatePicker(context, labourDocumentationController);
                      },
                      child: Container(
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: labourDocumentationController
                                .validityController,
                            style: GoogleFonts.inter(
                              fontSize: AppTextSize.textSizeSmallm,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryText,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter Validity",
                              hintStyle: GoogleFonts.inter(
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w400,
                                color: AppColors.searchfeild,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppColors.searchfeildcolor,
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppColors.searchfeildcolor,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppColors.searchfeildcolor,
                                    width: 1),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () => showDatePicker(
                                      context, labourDocumentationController),
                                  child: Image.asset(
                                    'assets/images/calender.png',
                                    height: SizeConfig.imageSizeMultiplier * 3,
                                    width: SizeConfig.imageSizeMultiplier * 3,
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              labourDocumentationController
                                  .validatiyoptional.value = value;
                              if (labourDocumentationController
                                  .validityController.text.isEmpty) {
                                labourDocumentationController.validityError
                                    .value = "Validity is required";
                              } else {
                                labourDocumentationController
                                    .validityError.value = "";
                              }
                            },
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Validity cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),

                    Obx(() => labourDocumentationController
                            .validityError.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 4, left: 13),
                            child: Text(
                              labourDocumentationController.validityError.value,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 174, 75, 68),
                                  fontSize: 12),
                            ),
                          )
                        : SizedBox.shrink()),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                    // AppTextFormfeild(
                    //   controller:
                    //       labourDocumentationController.validityController,
                    //   hintText: 'Enter validity',
                    //   keyboardType: TextInputType.name,
                    //   textInputAction: TextInputAction.next,
                    //   enabled: true, // Set to false to disable the field
                    //   readOnly:
                    //       false, // Set to true if you don't want it editable
                    //   validator: (value) {
                    //     if (value == null || value.trim().isEmpty) {
                    //       return 'Validity cannot be empty';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
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
                      onPressed: () async {
                        //   labourDocumentationController.removeByAll();

                        if (labourDocumentationController
                                .labourotherimg.isNotEmpty &&
                            labourDocumentationController
                                .selectedDoctType.value.isNotEmpty &&
                            labourDocumentationController
                                .validityController.text.isNotEmpty &&
                            labourDocumentationController
                                .idnoController.text.isNotEmpty) {
                          bool res =
                              await labourDocumentationController.addImg();
                          if (res) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Document Added.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13, // Slightly smaller font
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: AppColors
                                    .buttoncolor, // Material green (success)
                                duration: const Duration(seconds: 2),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 6,
                              ),
                            );
                          }
                        }

                        if (labourDocumentationController
                                .labourotherimg.isEmpty ||
                            labourDocumentationController
                                .selectedDoctType.value.isEmpty ||
                            labourDocumentationController
                                .validityController.text.isEmpty ||
                            labourDocumentationController
                                .idnoController.text.isEmpty) {
                          // ID Proof Validation
                          if (labourDocumentationController
                              .selectedDoctType.value.isEmpty) {
                            labourDocumentationController.documentError.value =
                                "Please select a document type";
                          } else {
                            labourDocumentationController.documentError.value =
                                ""; // Clear error if valid
                          }

                          if (labourDocumentationController
                              .idnoController.text.isEmpty) {
                            labourDocumentationController.idNumberError.value =
                                "ID Number is required";
                          } else {
                            labourDocumentationController.idNumberError.value =
                                "";
                          }

                          if (labourDocumentationController
                              .validityController.text.isEmpty) {
                            labourDocumentationController.validityError.value =
                                "Validity is required";
                          } else {
                            labourDocumentationController.validityError.value =
                                "";
                          }

                          if (labourDocumentationController
                              .labourotherimg.isEmpty) {
                            labourDocumentationController.photoError.value =
                                "Photo is required";
                          } else {
                            labourDocumentationController.photoError.value = "";
                          }
                        }

                        if (labourDocumentationController
                                .labourotherimg.isNotEmpty &&
                            labourDocumentationController
                                .selectedDoctType.isNotEmpty &&
                            labourDocumentationController
                                .idnoController.text.isNotEmpty &&
                            labourDocumentationController
                                .validityController.text.isNotEmpty) {
                          labourDocumentationController.clearAll();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 28,
                            color: AppColors.primary,
                            weight: 0.2,
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1,
                          ),
                          AppTextWidget(
                            text: "Add Document",
                            fontSize: AppTextSize.textSizeSmallm,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),

              Obx(
                () => labourDocumentationController.idNumber.isEmpty
                    ? SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primary,
                            border: Border.all(
                                width: 0.7, color: AppColors.backbuttoncolor)),
                        width: SizeConfig.widthMultiplier * 92,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                  labourDocumentationController
                                                      .idNumber.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                if (index >=
                                                    labourDocumentationController
                                                        .labourimg.length) {
                                                  return SizedBox.shrink();
                                                }
                                                return Stack(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(8),
                                                            ),
                                                            color: Colors.red,
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
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                            onPressed: () {
                                                              labourDocumentationController
                                                                  .removeByIndex(
                                                                      index);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
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
                                                              Column(
                                                                children: [
                                                                  AppTextWidget(
                                                                      text: AppTexts
                                                                          .docphoto,
                                                                      fontSize:
                                                                          AppTextSize
                                                                              .textSizeSmall,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .searchfeild),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            1.5,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.imageSizeMultiplier *
                                                                            18,
                                                                    width: SizeConfig
                                                                            .imageSizeMultiplier *
                                                                        18,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12), // Clip image to match container

                                                                      child: Image
                                                                          .file(
                                                                        File(labourDocumentationController
                                                                            .labourimg[index]
                                                                            .path),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            1.5,
                                                                  ),
                                                                  AppTextWidget(
                                                                      text: AppTexts
                                                                          .doctype,
                                                                      fontSize:
                                                                          AppTextSize
                                                                              .textSizeSmall,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .searchfeild),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            1,
                                                                  ),
                                                                  AppTextWidget(
                                                                      text: labourDocumentationController
                                                                              .documentTypeName[
                                                                          index],
                                                                      fontSize:
                                                                          AppTextSize
                                                                              .textSizeSmall,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .primaryText),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            2.5,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    2.5,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  AppTextWidget(
                                                                      text: AppTexts
                                                                          .idno,
                                                                      fontSize:
                                                                          AppTextSize
                                                                              .textSizeSmall,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .searchfeild),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            1,
                                                                  ),
                                                                  AppTextWidget(
                                                                      text: labourDocumentationController
                                                                              .idNumber[
                                                                          index],
                                                                      fontSize:
                                                                          AppTextSize
                                                                              .textSizeSmall,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .primaryText),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            7.5,
                                                                  ),
                                                                  AppTextWidget(
                                                                      text: AppTexts
                                                                          .validity,
                                                                      fontSize:
                                                                          AppTextSize
                                                                              .textSizeSmall,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .searchfeild),
                                                                  SizedBox(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            1,
                                                                  ),
                                                                  AppTextWidget(
                                                                      text: labourDocumentationController
                                                                              .validity[
                                                                          index],
                                                                      fontSize:
                                                                          AppTextSize
                                                                              .textSizeSmall,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .primaryText),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .heightMultiplier *
                                                                    2.5,
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

              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 6,
              ),
            ]),
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
                  imagePath: 'assets/images/leftarrow.png',
                ),
              ),
              SizedBox(width: SizeConfig.widthMultiplier * 5),
              GestureDetector(
                onTap: () async {
                  validateAndFocusFirstInvalidField();
                  if (formKey.currentState!.validate() &&
                      labourDocumentationController
                          .adharnoController.text.isNotEmpty &&
                      labourDocumentationController.labourimg.isNotEmpty &&
                      labourDocumentationController
                          .documentTypeName.isNotEmpty &&
                      labourDocumentationController.idNumber.isNotEmpty) {
                    if (formKey.currentState!.validate()) {
                      log('-------------${addLabourController.profilePhoto.value}');
                      log('-------------${labourDocumentationController.labourimg.length}');
                      log('-------------${labourDocumentationController.documentTypeName.length}'); // Compulsory Document Validation
                      if (!labourDocumentationController
                          .areAllCompulsoryDocumentsAdded()) {
                        final missingDocs = labourDocumentationController
                            .getMissingCompulsoryDocuments();
                        String message =
                            "${missingDocs.join(', ')} ${missingDocs.length > 1 ? 'are' : 'is'} compulsory";
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomValidationPopup(
                              message: message,
                            );
                          },
                        );
                        return;
                      }
                      labourDocumentationController.aadhaarError.value = '';

                      Get.to(LabourPrecaustionScreen(
                        categoryId: categoryId,
                        userId: userId,
                        userName: userName,
                        userImg: userImg,
                        userDesg: userDesg,
                        projectId: projectId,
                      ));
                      log('-----------------------$categoryId');
                      print("Navigating to Labour precaution with:");
                      print("User ID: $userId");
                      print("User Name: $userName");
                      print("Project ID: $projectId");
                      print("categoryId: $categoryId");
                    }
                  } else {
                    if (labourDocumentationController.adharnoController.text
                                .trim()
                                .length ==
                            12 &&
                        labourDocumentationController.labourimg.isEmpty &&
                        labourDocumentationController
                            .documentTypeName.isEmpty &&
                        labourDocumentationController.idNumber.isEmpty) {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomValidationPopup(
                              message: "Please Add Document ");
                        },
                      );
                    } else {
                      if (labourDocumentationController.adharnoController.text
                          .trim()
                          .isEmpty) {
                        labourDocumentationController.adharnoFocus
                            .requestFocus();
                      }
                    }
                    bool isValid = true;

                    if (labourDocumentationController
                        .adharnoController.text.isEmpty) {
                      labourDocumentationController.aadhaarError.value =
                          "Aadhaar number is required";
                      isValid = false;
                    } else if (!RegExp(r'^\d{12}$').hasMatch(
                        labourDocumentationController.adharnoController.text)) {
                      labourDocumentationController.aadhaarError.value =
                          "Aadhaar number must be exactly 12 digits";
                      isValid = false;
                    } else {
                      labourDocumentationController.aadhaarError.value = "";
                    }

                    // ID Proof Validation
                    if (labourDocumentationController
                            .documentTypeName.isEmpty &&
                        labourDocumentationController
                            .selectedDoctType.value.isEmpty) {
                      labourDocumentationController.documentError.value =
                          "Please select a document type";
                      isValid = false;
                    } else {
                      labourDocumentationController.documentError.value = "";
                    }

                    // ID Number Validation
                    if (labourDocumentationController.idNumber.isEmpty &&
                        labourDocumentationController
                            .idnoController.text.isEmpty) {
                      labourDocumentationController.idNumberError.value =
                          "ID Number is required";
                      isValid = false;
                    } else {
                      labourDocumentationController.idNumberError.value = "";
                    }
                    // ID Number Validation
                    if (labourDocumentationController.validity.isEmpty &&
                        labourDocumentationController
                            .validityController.text.isEmpty) {
                      labourDocumentationController.validityError.value =
                          "Validity is required";
                      isValid = false;
                    } else {
                      labourDocumentationController.validityError.value = "";
                    }
                    if (labourDocumentationController.labourimg.isEmpty) {
                      if (labourDocumentationController.otherImageCount.value >
                          0) {
                        labourDocumentationController.photoError.value = "";
                      } else {
                        labourDocumentationController.photoError.value =
                            "Photo is required";

                        isValid = false;
                      }
                    }

                    if (!isValid) return;
                  }
                },
                child: AppMediumButton(
                  label: "Next",
                  borderColor: AppColors.backbuttoncolor,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  backgroundColor: AppColors.buttoncolor,
                  imagePath2: 'assets/images/rightarrow.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void scrollToWidget(GlobalKey key) {
    final context = key.currentContext;
    if (context != null && context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.2,
        );
      });
    }
  }

  void validateAndFocusFirstInvalidField() {
    if (!formKey.currentState!.validate()) {
      if (labourDocumentationController.adharnoController.text.trim().isEmpty) {
        labourDocumentationController.adharnoFocus.requestFocus();
      }
    }
  }
}
