import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_medium_button.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/contractor/add_contractor/add_contractor_controller.dart';
import 'package:flutter_app/features/contractor/contractor_details/contractor_details_controller.dart';
import 'package:flutter_app/features/contractor/service_details/service_details_screen.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ContractorDetailsScreen extends StatelessWidget {
  final int categoryId;

  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  ContractorDetailsScreen({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final ContractorDetailsController contractorDetailsController = Get.find();

  final AddContractorController addContractorController = Get.find();
  final InductionTrainingController inductionTrainingController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                            value: 0.50,
                            backgroundColor: AppColors.searchfeildcolor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.defaultPrimary),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '02/05',
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
                      text: AppTexts.contdetails,
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.3,
                    ),
                    AppTextWidget(
                      text: AppTexts.entercontractorcontactdetails,
                      fontSize: AppTextSize.textSizeSmalle,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),

                    //primaryContactPerson
                    AppTextWidget(
                      text: AppTexts.primaryContactPerson,
                      fontSize: AppTextSize.textSizeMedium,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.name,
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
                      () => AppTextFormfeild(
                        controller: contractorDetailsController.nameController,
                        hintText: 'Full Name',
                        focusNode:
                            contractorDetailsController.nameControllerFocusNode,
                        onFieldSubmitted: (_) {
                          contractorDetailsController.nameControllerFocusNode
                              .unfocus();
                        },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        enabled: !addContractorController.userFound.value,
                        readOnly: addContractorController.userFound.value,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Full Name cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.contactno,
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
                      () => AppTextFormfeild(
                        controller:
                            contractorDetailsController.contactnoController,
                        focusNode:
                            contractorDetailsController.contactnoFocusNode,
                        hintText: 'Contact Number',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        enabled: !addContractorController.userFound.value,
                        readOnly: addContractorController.userFound.value,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Contact No cannot be empty';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit number';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          contractorDetailsController.contactnoFocusNode
                              .unfocus();
                        },
                        onChanged: (value) {},
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),

                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.emailid,
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
                      () => AppTextFormfeild(
                        controller:
                            contractorDetailsController.emailidController,
                        hintText: 'Email',
                        focusNode: contractorDetailsController.emailidFocusNode,
                        onFieldSubmitted: (_) {
                          contractorDetailsController.emailidFocusNode
                              .unfocus();
                        },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        enabled: !addContractorController.userFound.value,
                        readOnly: addContractorController.userFound.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          String pattern =
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                          RegExp regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),

                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.idprooftype,
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
                        items: inductionTrainingController.idProofList
                            .map(
                              (idproof) => idproof.listDetails,
                            )
                            .toList(),
                        selectedItem: contractorDetailsController
                                .selectedDoctType.value.isNotEmpty
                            ? contractorDetailsController.selectedDoctType.value
                            : null,
                        hintText: 'Select document type',
                        onChanged: (value) {
                          contractorDetailsController.selectedDoctType.value =
                              value ?? '';

                          var selectedProof = inductionTrainingController
                              .idProofList
                              .firstWhereOrNull(
                                  (idproof) => idproof.listDetails == value);

                          if (selectedProof != null) {
                            contractorDetailsController
                                .selectedIdProofId.value = selectedProof.id;
                            print(
                                "Selected Document ID: ${contractorDetailsController.selectedDoctType.value}");
                            print(
                                "Selected Document ID: ${contractorDetailsController.selectedIdProofId.value}");
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
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),

                    Row(
                      children: [
                        AppTextWidget(
                          text: AppTexts.idproofno,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    AppTextFormfeild(
                      controller: contractorDetailsController.idproofController,
                      focusNode: contractorDetailsController.idproofFocusNode,
                      hintText: 'Contact Number',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Id Proof No cannot be empty';
                        }

                        return null;
                      },
                      onFieldSubmitted: (_) {
                        contractorDetailsController.idproofFocusNode.unfocus();
                      },
                      onChanged: (value) {},
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        // staffDocumentationController.removeByAll();
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
                        showDatePicker(context, contractorDetailsController);
                        // }
                      },
                      child: Container(
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: contractorDetailsController
                                .validityController, // onChanged: (value) {
                            //   addLabourController.selectedDate.value =
                            //       (value) as DateTime?;
                            // },
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
                                      context, contractorDetailsController),
                                  child: Image.asset(
                                    'assets/icons/calendar.png',
                                    height: SizeConfig.imageSizeMultiplier * 3,
                                    width: SizeConfig.imageSizeMultiplier * 3,
                                  ),
                                ),
                              ),
                            ),

                            //   enabled: !addLabourController.userFound.value, //
                            //enabled: !addLabourController.userFound.value, //
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
                    Obx(() => contractorDetailsController
                            .validityError.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 4, left: 13),
                            child: Text(
                              contractorDetailsController.validityError.value,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 174, 75, 68),
                                  fontSize: 12),
                            ),
                          )
                        : SizedBox.shrink()),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                    ////---------------
                    Column(
                      children: [
                        Row(
                          children: [
                            AppTextWidget(
                              text: AppTexts.docphoto,
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
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Obx(
                          () => contractorDetailsController.docImgCount.value ==
                                  0
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await contractorDetailsController
                                              .pickDocImages(ImageSource
                                                  .camera); // Capture from camera
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
                                                color: AppColors.secondaryText),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await contractorDetailsController
                                              .pickDocImages(ImageSource
                                                  .gallery); // Capture from camera
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
                                                fontSize: AppTextSize
                                                    .textSizeExtraSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.secondaryText),
                                          ],
                                        ),
                                      ),
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
                                            height: SizeConfig
                                                    .imageSizeMultiplier *
                                                20, // Adjust based on UI needs

                                            child: GridView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    contractorDetailsController
                                                        .docImg.length,
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
                                                                contractorDetailsController
                                                                    .docImg[
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
                                                            contractorDetailsController
                                                                .removeDocImage(
                                                                    index);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8),
                                                            ),
                                                            child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
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
                                              SizeConfig.imageSizeMultiplier *
                                                  5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        Obx(() => contractorDetailsController
                                .documentError.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: 4, left: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      contractorDetailsController
                                          .documentError.value,
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 174, 75, 68),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink()),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1.5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            //primaryContactPerson
                            AppTextWidget(
                              text: AppTexts.secContactPerson,
                              fontSize: AppTextSize.textSizeMedium,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryText,
                            ),

                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            Row(
                              children: [
                                AppTextWidget(
                                  text: AppTexts.name,
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
                              controller: contractorDetailsController
                                  .secondarynameController,
                              hintText: 'Full Name',
                              focusNode: contractorDetailsController
                                  .secondarynameFoucsNode,
                              onFieldSubmitted: (_) {
                                contractorDetailsController
                                    .secondarynameFoucsNode
                                    .unfocus();
                              },
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              enabled: !addContractorController.userFound.value,
                              // readOnly: addContractorController.userFound.value,
                              validator: (value) {
                                String contactNumber =
                                    contractorDetailsController
                                        .secondarycontactController.text
                                        .trim();

                                if (value == null || value.trim().isEmpty) {
                                  if (contactNumber.isNotEmpty) {
                                    return 'Full name is required when contact number is provided';
                                  }
                                }
                                return null;
                              },
                              onChanged: (value) {},
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            Row(
                              children: [
                                AppTextWidget(
                                  text: AppTexts.contactno,
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
                              controller: contractorDetailsController
                                  .secondarycontactController,
                              focusNode: contractorDetailsController
                                  .secondarycontactnoFocusNode,
                              hintText: 'Contact Number',
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              enabled: !addContractorController.userFound.value,
                              // readOnly: addContractorController.userFound.value,
                              validator: (value) {
                                String fullName = contractorDetailsController
                                    .secondarynameController.text
                                    .trim();
                                if (value == null || value.trim().isEmpty) {
                                  if (fullName.isNotEmpty) {
                                    return 'Contact number is required when name is provided';
                                  }
                                } else if (!RegExp(r'^\d{10}$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid 10-digit number';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                contractorDetailsController
                                    .secondarycontactnoFocusNode
                                    .unfocus();
                              },
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                      ],
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
                  if (contractorDetailsController.docImgCount == 0) {
                    contractorDetailsController.documentError.value =
                        "Please select a document photo";
                  } else {
                    contractorDetailsController.documentError.value = "";
                  }
                  if (contractorDetailsController
                      .validityController.text.isEmpty) {
                    contractorDetailsController.validityError.value =
                        "Validity is required";
                    return;
                  } else {
                    contractorDetailsController.validityError.value = "";
                  }
                  if (formKey.currentState!.validate() &&
                      contractorDetailsController.docImgCount != 0) {
                    // ID Proof Validation

                    Get.to(ServiceDetailsScreen(
                      categoryId: categoryId,
                      userId: userId,
                      userName: userName,
                      userImg: userImg,
                      userDesg: userDesg,
                      projectId: projectId,
                    ));
                  }
                  print("Navigating to ServiceDetailsScreen with:");

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
      ),
    );
  }

  void showDatePicker(BuildContext context,
      ContractorDetailsController contractorDetailsController) {
    DateTime tempPickedDate =
        contractorDetailsController.selectedDateValidity.value ??
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
                        initialDateTime: tempPickedDate.isBefore(DateTime.now())
                            ? DateTime.now().toLocal().copyWith(
                                hour: 0,
                                minute: 0,
                                second: 0,
                                millisecond: 0,
                                microsecond: 0)
                            : tempPickedDate.toLocal().copyWith(
                                hour: 0,
                                minute: 0,
                                second: 0,
                                millisecond: 0,
                                microsecond: 0),
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
                        contractorDetailsController
                            .updateDateValidity(tempPickedDate); // Save date
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
}
