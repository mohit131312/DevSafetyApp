import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/edit_profile/edit_profile_controller.dart';
import 'package:flutter_app/features/profile_details/profile_details_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  final int? userId, roleId;

  const EditProfileScreen({super.key, this.userId, this.roleId});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileDetailsController profileDetailsControllers =
      Get.put(ProfileDetailsController());
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  List<Map<String, String>> personalDetails = [];

  @override
  void initState() {
    super.initState();
    // Initialize the personal details from the profile details controller
    personalDetails = [
      {
        "label": "First Name",
        "value": profileDetailsControllers.profiledetails["first_name"] ?? ""
      },
      {
        "label": "Last Name",
        "value": profileDetailsControllers.profiledetails["last_name"] ?? ""
      },
      {
        "label": "User Name",
        "value":
            "${profileDetailsControllers.profiledetails['first_name']?.trim() ?? ''}"
                    "_${profileDetailsControllers.profiledetails['last_name']?.trim() ?? ''}"
                .replaceAll(RegExp(r'\s+'), '')
      },
      {
        "label": "User Role",
        "value": profileDetailsControllers.profiledetails["role"].toString()
      },
      {
        "label": "Contact Number",
        "value": profileDetailsControllers.profiledetails["mobile_number"]
      },
      {
        "label": "Email Id",
        "value": profileDetailsControllers.profiledetails["email"]
      },
    ];
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userRoleController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailIdController = TextEditingController();

  TextEditingController _getControllerForField(int index) {
    switch (index) {
      case 0:
        return nameController;
      case 1:
        return lastnameController;
      case 2:
        return userNameController;
      case 3:
        return userRoleController;
      case 4:
        return contactNumberController;
      case 5:
        return emailIdController;
      default:
        return TextEditingController();
    }
  }

  Map<String, dynamic> updatedData = {};

  void _saveProfileChanges() async {
    updatedData = {
      "first_name": nameController.text,
      "user_id": widget.userId,
      "last_name": lastnameController.text,
      "contact_number": contactNumberController.text,
      "email": emailIdController.text,
    };
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    nameController.dispose();
    lastnameController.dispose();
    userNameController.dispose();
    userRoleController.dispose();
    contactNumberController.dispose();
    emailIdController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void showConfirmationDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          title: AppTextWidget(
            text: 'Are You Sure?',
            fontSize: AppTextSize.textSizeMediumm,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          content: AppTextWidget(
              text: 'Are you sure you want to edit profile details?',
              fontSize: AppTextSize.textSizeSmall,
              fontWeight: FontWeight.w500,
              color: AppColors.searchfeild),
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppTextWidget(
                        text: 'No',
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (await CheckInternet.checkInternet()) {
                      log('Before---------------$updatedData');
                      _saveProfileChanges();
                      log('after---------------$updatedData');
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CustomLoadingPopup());
                      await editProfileController.getEditProfileDetails(
                          updatedData, context);
                      Get.back();

                      if (editProfileController.validationmsg ==
                          'Profile updated successfully') {
                        Get.back();
                        Get.back();
                        Get.back();
                      }
                      // if (labourPreviewController.validationmsg ==
                      //     'Induction training data saved.') {
                      //   Get.to(() => LabourSubmit(
                      //         categoryId: categoryId,
                      //         userId: userId,
                      //         userName: userName,
                      //         userImg: userImg,
                      //         userDesg: userDesg,
                      //         projectId: projectId,
                      //       ));
                      // }
                    } else {
                      await showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return CustomValidationPopup(
                              message:
                                  "Please check your internet connection.");
                        },
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.buttoncolor,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppTextWidget(
                        text: 'Yes',
                        fontSize: AppTextSize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    log('print ${widget.userId}');

    nameController.text = personalDetails[0]["value"]!;
    lastnameController.text = personalDetails[1]["value"]!;

    userNameController.text = personalDetails[2]["value"]!;
    userRoleController.text = personalDetails[3]["value"]!;
    contactNumberController.text = personalDetails[4]["value"]!;
    emailIdController.text = personalDetails[5]["value"]!;
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          scrolledUnderElevation: 0.0,
          backgroundColor: AppColors.buttoncolor,
          centerTitle: true,
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: AppTextWidget(
              text: AppTexts.editprofile,
              fontSize: AppTextSize.textSizeMediumm,
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
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.imageSizeMultiplier * 30,
                                    width: SizeConfig.imageSizeMultiplier * 30,
                                    child: Image.network(
                                        "$baseUrl${profileDetailsControllers.profiledetails['profile_photo']}"),
                                  ),
                                  // Positioned(
                                  //   bottom: SizeConfig.heightMultiplier * 1,
                                  //   left: SizeConfig.heightMultiplier * 7,
                                  //   child: Container(
                                  //     height:
                                  //         SizeConfig.imageSizeMultiplier * 8,
                                  //     width: SizeConfig.imageSizeMultiplier * 8,
                                  //     decoration: BoxDecoration(
                                  //       shape: BoxShape.circle,
                                  //       color: AppColors.fourtText,
                                  //     ),
                                  //     child: SizedBox(
                                  //       height:
                                  //           SizeConfig.imageSizeMultiplier * 6,
                                  //       width:
                                  //           SizeConfig.imageSizeMultiplier * 6,
                                  //       child: Image.asset(
                                  //           "assets/icons/camera_icon.png"),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: personalDetails.length,
                            itemBuilder: (context, index) {
                              final field = personalDetails[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  index == 3
                                      ? SizedBox()
                                      : AppTextWidget(
                                          text: field["label"]!,
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryText,
                                        ),
                                  index == 3
                                      ? SizedBox()
                                      : SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 1),
                                  index == 3
                                      ? SizedBox()
                                      : Container(
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(),
                                          child: TextFormField(
                                            readOnly: index == 2 || index == 3,
                                            enabled: index != 2 && index != 3,
                                            controller:
                                                _getControllerForField(index),
                                            style: GoogleFonts.inter(
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: index == 2 ||
                                                      index == 3
                                                  ? AppColors.textfeildcolor
                                                  : Colors
                                                      .white, // Grey background for disabled fields
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 13,
                                                      horizontal: 15),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .searchfeildcolor,
                                                    width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .searchfeildcolor,
                                                    width: 1),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (index == 0 || index == 1) {
                                                final RegExp regex = RegExp(
                                                    r'^[a-zA-Z0-9]+$'); // Letters and numbers only
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return '${field["label"]} is required';
                                                }
                                                if (!regex.hasMatch(value)) {
                                                  return '${field["label"]} can only contain letters and numbers';
                                                }
                                                if (value.length > 50) {
                                                  return '${field["label"]} cannot be longer than 50 characters';
                                                }
                                              }

                                              // Contact Number: Only digits, 10-15 digits allowed
                                              if (index == 4) {
                                                final RegExp numberRegex = RegExp(
                                                    r'^[0-9]+$'); // Only digits
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Contact Number is required';
                                                }
                                                if (!numberRegex
                                                    .hasMatch(value)) {
                                                  return 'Contact Number must contain only digits';
                                                }
                                                if (value.length < 10) {
                                                  return 'Contact Number must be at least 10 digits';
                                                }
                                                if (value.length > 15) {
                                                  return 'Contact Number cannot exceed 15 digits';
                                                }
                                              }

                                              // Email: Valid email format check
                                              if (index == 5) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Email is required';
                                                }
                                                final emailRegex = RegExp(
                                                    r"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$"); // Basic email pattern
                                                if (!emailRegex
                                                    .hasMatch(value)) {
                                                  return 'Enter a valid email';
                                                }
                                              }

                                              return null;
                                            },
                                            inputFormatters:
                                                index == 0 || index == 1
                                                    ? [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[a-zA-Z\s]'))
                                                      ]
                                                    : index == 4
                                                        ? [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly,
                                                            LengthLimitingTextInputFormatter(
                                                                10),
                                                          ]
                                                        : [],
                                          ),
                                        ),
                                  index == 3
                                      ? SizedBox()
                                      : SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 2),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 5),
                          AppElevatedButton(
                              text: "Save",
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  showConfirmationDialog(context);
                                }
                              }),
                          SizedBox(height: SizeConfig.heightMultiplier * 2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
