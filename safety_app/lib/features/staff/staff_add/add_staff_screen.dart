// ignore: must_be_immutable
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/features/staff/staff_add/add_staff_controller.dart';
import 'package:flutter_app/features/staff/staff_documentation/staff_documentation.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/matched_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddStaffScreen extends StatelessWidget {
  final int categoryId;

  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  AddStaffScreen({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });

  final AddStaffController addStaffController = Get.find();
  final InductionTrainingController inductionTrainingController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void showDatePicker(
      BuildContext context, AddStaffController addStaffController) {
    DateTime today = DateTime.now();

    DateTime tempPickedDate = addStaffController.selectedDate.value ??
        DateTime(today.year - 18, today.month, today.day);

    DateTime maxDate = DateTime(today.year - 18, today.month, today.day);

    DateTime minDate = DateTime(1980, 1, 1); // Minimum selectable date

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
                    text: 'Date of Birth',
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
                        initialDateTime: tempPickedDate.isAfter(maxDate)
                            ? maxDate
                            : tempPickedDate,
                        minimumDate: minDate,
                        maximumDate: maxDate, // Ensures the user is at least 18
                        onDateTimeChanged: (DateTime newDate) {
                          addStaffController.age =
                              addStaffController.calculateStaffAge(newDate);
                          log("Selected Age: ${addStaffController.age}");

                          if (addStaffController.age >= 18) {
                            tempPickedDate = newDate;
                          } else {
                            log("User must be at least 18 years old.");
                          }
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
                        addStaffController
                            .updateStaffDate(tempPickedDate); // Save date
                        int age = addStaffController
                            .calculateStaffAge(tempPickedDate);
                        log('----------$age');
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

  Widget buildTextField(BuildContext context, String hint, index) {
    List<FocusNode> focusNodes = [
      addStaffController.streetFocusNode,
      addStaffController.cityFocusNode,
      addStaffController.talukaFocusNode,
      addStaffController.pincodeFocusNode,
    ];
    return AppTextFormfeild(
      controller: addStaffController.addressControllers[index],
      hintText: hint,
      keyboardType: index == 3 ? TextInputType.number : TextInputType.name,
      textInputAction: TextInputAction.next,
      focusNode: focusNodes[index],
      onFieldSubmitted: (_) {
        focusNodes[index].unfocus();
      },
      enabled: !addStaffController
          .userFound.value, // ✅ Editable only if user NOT found
      readOnly:
          addStaffController.userFound.value, // ✅ Read-only if user is found

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Current Address cannot be empty';
        }
        if (index == 3 && !RegExp(r'^\d{6}$').hasMatch(value)) {
          return 'Enter a valid 6-digit pincode';
        }
        return null;
      },
      onChanged: (value) {
        addStaffController.updateStaffFormattedAddress();
      },
    );
  }

  Widget buildTextField2(BuildContext context, String hint, index) {
    List<FocusNode> focusNodes = [
      addStaffController.streetPermanatFocusNode,
      addStaffController.cityPermanatFocusNode,
      addStaffController.talukaPermanatFocusNode,
      addStaffController.pincodePermanatFocusNode,
    ];
    return AppTextFormfeild(
      controller: addStaffController.permanantAddressController[index],
      hintText: hint,
      keyboardType: index == 3 ? TextInputType.number : TextInputType.name,
      textInputAction: TextInputAction.next,
      focusNode: focusNodes[index],
      onFieldSubmitted: (_) {
        focusNodes[index].unfocus();
      },
      enabled: !addStaffController
          .userFound.value, // ✅ Editable only if user NOT found
      readOnly:
          addStaffController.userFound.value, // ✅ Read-only if user is found

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Permanent Address cannot be empty';
        }
        if (index == 3 && !RegExp(r'^\d{6}$').hasMatch(value)) {
          return 'Enter a valid 6-digit pincode';
        }
        return null;
      },
      onChanged: (value) {
        addStaffController.updateStaffpermanantFormattedAddress();
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
        // resizeToAvoidBottomInset: false,
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
              text: 'Add Staff',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.2,
                          backgroundColor: AppColors.searchfeildcolor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.defaultPrimary),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '01/05',
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
                    text: AppTexts.personaldetailss,
                    fontSize: AppTextSize.textSizeMediumm,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.3,
                  ),
                  AppTextWidget(
                    text: AppTexts.enterstaffdetails,
                    fontSize: AppTextSize.textSizeSmalle,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  AppTextWidget(
                    text: 'Search Staff',
                    fontSize: AppTextSize.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.widthMultiplier * 44,
                        child: TextFormField(
                          controller: addStaffController.searchController,
                          focusNode: addStaffController.searchFocusNodeAll,
                          onFieldSubmitted: (_) {
                            addStaffController.searchFocusNodeAll.unfocus();
                          },
                          textInputAction: TextInputAction.next,
                          style: GoogleFonts.inter(
                            fontSize: AppTextSize.textSizeSmallm,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryText,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search Staff By ID',
                            hintStyle: GoogleFonts.inter(
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.searchfeild,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 13, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              borderSide: BorderSide(
                                  color: AppColors.searchfeildcolor, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              borderSide: BorderSide(
                                  color: AppColors.searchfeildcolor, width: 1),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 126, 16, 9),
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 126, 16, 9),
                                width: 1,
                              ),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                                width: 1, color: AppColors.searchfeildcolor),
                            right: BorderSide(
                                width: 1, color: AppColors.searchfeildcolor),
                            bottom: BorderSide(
                                width: 1, color: AppColors.searchfeildcolor),
                            left: BorderSide(
                                width: 0.3, color: AppColors.searchfeildcolor),
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 12,
                            ),
                            width: SizeConfig.widthMultiplier * 30,
                            child: Obx(
                              () => DropdownButton<String>(
                                alignment: Alignment.center,
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                value: addStaffController
                                        .searchType.value.isNotEmpty
                                    ? addStaffController.searchType.value
                                    : null,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.searchfeild,
                                  size: 30,
                                ),
                                style: GoogleFonts.inter(
                                  fontSize: AppTextSize.textSizeSmallm,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryText,
                                ),
                                items: ['ID', 'Name']
                                    .map((type) => DropdownMenuItem(
                                        value: type, child: Text(type)))
                                    .toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    addStaffController.searchType.value =
                                        newValue;
                                    print(
                                        '---------${addStaffController.searchType.value}');
                                    print(
                                        '---------${addStaffController.searchType.value}');
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 2,
                      ),

                      //-----------------------------------------

                      GestureDetector(
                        onTap: () async {
                          String value =
                              addStaffController.searchController.text;

                          if (addStaffController.searchType.value == 'ID') {
                            print(
                                '---------${addStaffController.searchType.value}');

                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomLoadingPopup());

                            await addStaffController.getSafetyStaffDetails(
                                value, context, true, false, projectId);
                            Navigator.pop(context);
                          } else {
                            print(
                                '---------${addStaffController.searchType.value}');
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomLoadingPopup());
                            await addStaffController
                                .getSafetyStaffMatchedDetails(
                                    value, context, projectId);
                            Navigator.pop(context);

                            if (addStaffController.searchResults.isNotEmpty &&
                                addStaffController.searchResults.length > 1) {
                              log('In the if getSafetyLabourMatchedDetails ');
                              showDialog(
                                context: context,
                                builder: (context) => MatchedUser(
                                  items: addStaffController.searchResults,
                                  categoryId: categoryId,
                                  onItemSelected: (context, id) async {
                                    await addStaffController
                                        .getSafetyStaffDetails(id, context,
                                            false, true, projectId);
                                  },
                                ),
                              );
                            } else {
                              log('In the else getSafetyDetails ');

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomLoadingPopup());
                              print('---------${value}');

                              await addStaffController.getSafetyStaffDetails(
                                  value, context, false, false, projectId);
                              print('---------${value}');
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Container(
                            height: SizeConfig.heightMultiplier * 6.2,
                            width: SizeConfig.widthMultiplier * 14,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.searchfeildcolor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.search,
                              color: AppColors.searchfeild,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.5,
                  ),
                  Row(
                    children: [
                      AppTextWidget(
                          text: AppTexts.profilephoto,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
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
                  // Obx(
                  //   () => addStaffController.userFound.value
                  //       ? Row(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Obx(
                  //               () => Container(
                  //                 decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   color: AppColors.textfeildcolor,
                  //                 ),
                  //                 height: SizeConfig.imageSizeMultiplier * 28,
                  //                 width: SizeConfig.imageSizeMultiplier * 28,
                  //                 child: ClipOval(
                  //                   child: addStaffController
                  //                           .profilePhoto.isNotEmpty
                  //                       ? Image.network(
                  //                           "$baseUrl${addStaffController.profilePhoto.value}",
                  //                           fit: BoxFit.cover,
                  //                         )
                  //                       : SizedBox(),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         )
                  //       :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Stack(
                            children: [
                              Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                    shape:
                                        BoxShape.circle, // Circular container
                                    color: AppColors.textfeildcolor,
                                  ),
                                  height: SizeConfig.imageSizeMultiplier * 28,
                                  width: SizeConfig.imageSizeMultiplier * 28,
                                  child: ClipOval(
                                    child: addStaffController
                                            .profilePhoto.isNotEmpty
                                        ? Image.file(
                                            File(addStaffController
                                                .profilePhoto.value),
                                            fit: BoxFit.cover,
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: Image.asset(
                                              'assets/images/blackUser.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: SizeConfig.heightMultiplier * 1,
                            left: SizeConfig.heightMultiplier * 7,
                            child: GestureDetector(
                              onTap: () => addStaffController
                                  .pickStaffImage(ImageSource.camera),
                              child: Container(
                                height: SizeConfig.imageSizeMultiplier * 8,
                                width: SizeConfig.imageSizeMultiplier * 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.fourtText,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.thirdText,
                                  ),
                                  height: SizeConfig.imageSizeMultiplier * 6,
                                  width: SizeConfig.imageSizeMultiplier * 6,
                                  child: Image.asset(
                                      "assets/icons/camera_icon.png"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    // ),
                  ),
                  Obx(() => addStaffController.profilePhoto.value.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 4, left: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                addStaffController.profilePhotoEroor.value,
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
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppTextWidget(
                              text: AppTexts.fullname,
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
                            controller: addStaffController.staffnameController,
                            hintText: 'Full Name',
                            focusNode: addStaffController.fullnameFocusNode,
                            onFieldSubmitted: (_) {
                              addStaffController.fullnameFocusNode.unfocus();
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,

                            enabled: !addStaffController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addStaffController.userFound
                                .value, // ✅ Read-only if user is found
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
                              text: AppTexts.gender,
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
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                                addStaffController.gendersStaff.length,
                                (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 1),
                                child: ChoiceChip(
                                  label: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        addStaffController.gendersStaff[index]
                                                ['icon']
                                            .toString(),
                                        height:
                                            SizeConfig.imageSizeMultiplier * 4,
                                        width:
                                            SizeConfig.imageSizeMultiplier * 4,
                                      ),
                                      SizedBox(width: 5),
                                      Text(addStaffController
                                              .gendersStaff[index]['label'] ??
                                          ''),
                                    ],
                                  ),
                                  selected: addStaffController
                                          .selectedStaffGender.value ==
                                      index,
                                  onSelected: addStaffController.userFound.value
                                      ? null
                                      : (selected) {
                                          addStaffController
                                              .selectGender(index);
                                        },
                                  selectedColor:
                                      Colors.white, // Adjust as needed
                                  backgroundColor: Colors.white,
                                  side: BorderSide(
                                    color: addStaffController
                                                .selectedStaffGender.value ==
                                            index
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                  ),
                                  labelStyle: TextStyle(
                                    color: addStaffController
                                                .selectedStaffGender.value ==
                                            index
                                        ? Colors.black
                                        : Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        // Row(
                        //   children: [
                        //     AppTextWidget(
                        //       text: 'Literacy',
                        //       fontSize: AppTextSize.textSizeSmall,
                        //       fontWeight: FontWeight.w500,
                        //       color: AppColors.primaryText,
                        //     ),
                        //     AppTextWidget(
                        //         text: AppTexts.star,
                        //         fontSize: AppTextSize.textSizeExtraSmall,
                        //         fontWeight: FontWeight.w400,
                        //         color: AppColors.starcolor),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: SizeConfig.heightMultiplier * 1,
                        // ),
                        // Obx(
                        //   () => AppNormalDropdown(
                        //     enabled: !addStaffController.userFound
                        //         .value, // ✅ Editable only if user NOT found
                        //     items: addStaffController.literacyStatus,
                        //     selectedItem: addStaffController
                        //             .selectedLiteratre.value.isNotEmpty
                        //         ? addStaffController.selectedLiteratre.value
                        //         : null,
                        //     hint: AppTextWidget(
                        //       text: 'Select Literacy',
                        //       fontSize: AppTextSize.textSizeSmall,
                        //       fontWeight: FontWeight.w400,
                        //       color: AppColors.searchfeild,
                        //     ),
                        //     onChanged: (value) {
                        //       addStaffController.selectedLiteratre.value =
                        //           value ?? '';
                        //     },
                        //     validator: (value) {
                        //       if (value == null ||
                        //           value.toString().trim().isEmpty) {
                        //         return 'Please select a literacy status';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: SizeConfig.heightMultiplier * 2,
                        // ),
                        // Row(
                        //   children: [
                        //     AppTextWidget(
                        //       text: 'Marital Status',
                        //       fontSize: AppTextSize.textSizeSmall,
                        //       fontWeight: FontWeight.w500,
                        //       color: AppColors.primaryText,
                        //     ),
                        //     AppTextWidget(
                        //         text: AppTexts.star,
                        //         fontSize: AppTextSize.textSizeExtraSmall,
                        //         fontWeight: FontWeight.w400,
                        //         color: AppColors.starcolor),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: SizeConfig.heightMultiplier * 1,
                        // ),
                        // Obx(
                        //   () => AppNormalDropdown(
                        //     enabled: !addStaffController.userFound
                        //         .value, // ✅ Editable only if user NOT found
                        //     items: addStaffController.maritalStatus,
                        //     selectedItem: addStaffController
                        //             .selectedmarried.value.isNotEmpty
                        //         ? addStaffController.selectedmarried.value
                        //         : null,
                        //     hint: AppTextWidget(
                        //       text: 'Select Marital Status',
                        //       fontSize: AppTextSize.textSizeSmall,
                        //       fontWeight: FontWeight.w400,
                        //       color: AppColors.searchfeild,
                        //     ),
                        //     onChanged: (value) {
                        //       addStaffController.selectedmarried.value =
                        //           value ?? '';
                        //     },
                        //     validator: (value) {
                        //       if (value == null ||
                        //           value.toString().trim().isEmpty) {
                        //         return 'Please select a Marital status';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Row(
                          children: [
                            AppTextWidget(
                              text: AppTexts.dob,
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
                        GestureDetector(
                          onTap: () {
                            // if (!addStaffController.userFound.value) {
                            showDatePicker(context, addStaffController);
                            // }
                            log(addStaffController.dateController.text);
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: addStaffController.dateController,

                              // onChanged: (value) {
                              //   addStaffController.selectedDate.value =
                              //       (value) as DateTime?;
                              // },
                              style: GoogleFonts.inter(
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryText,
                              ),
                              decoration: InputDecoration(
                                hintText: "Select Date",
                                hintStyle: TextStyle(
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
                                        context, addStaffController),
                                    child: Image.asset(
                                      'assets/icons/calendar.png',
                                      height:
                                          SizeConfig.imageSizeMultiplier * 3,
                                      width: SizeConfig.imageSizeMultiplier * 3,
                                    ),
                                  ),
                                ),
                              ),

                              enabled: !addStaffController.userFound.value, //
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Row(
                          children: [
                            AppTextWidget(
                              text: AppTexts.bloodgrp,
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
                            enabled: !addStaffController.userFound
                                .value, // ✅ Editable only if user NOT found

                            items: inductionTrainingController.bloodGrpTypes
                                .map(
                                  (bloodgrp) => bloodgrp.type,
                                )
                                .toList(),
                            selectedItem: addStaffController
                                    .selectedBloodGroup.value.isNotEmpty
                                ? addStaffController.selectedBloodGroup.value
                                : null,
                            hintText: 'Select Blood Group',
                            onChanged: (value) {
                              addStaffController.selectedBloodGroup.value =
                                  value ?? '';
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.toString().trim().isEmpty) {
                                return 'Please select a Blood Group';
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
                              text: AppTexts.reasonforvisit,
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
                            items:
                                inductionTrainingController.reasonForVisitList
                                    .map(
                                      (reason) => reason.listDetails,
                                    )
                                    .toList(),
                            selectedItem: addStaffController
                                    .selectedreasons.value.isNotEmpty
                                ? addStaffController.selectedreasons.value
                                : null,
                            hintText: 'Select Reason',
                            onChanged: (value) {
                              addStaffController.selectedreasons.value =
                                  value ?? '';

                              if (value != null) {
                                // Ensure we are matching with the correct field (ID or reason name)
                                var selectedReasonObj =
                                    inductionTrainingController
                                        .reasonForVisitList
                                        .firstWhereOrNull((state) =>
                                            state.listDetails == value);

                                if (selectedReasonObj != null) {
                                  addStaffController.selectedReasonId.value =
                                      selectedReasonObj.id;
                                  log('Selected Reason ID: ${addStaffController.selectedReasonId.value}');
                                  log('Selected Reason Name: ${addStaffController.selectedreasons.value}');
                                } else {
                                  log('No matching reason found for: $value');
                                }
                              }
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.toString().trim().isEmpty) {
                                return 'Please select a Reason ';
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
                                addStaffController.contactnumberController,
                            hintText: 'Contact Number',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            enabled: !addStaffController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addStaffController.userFound
                                .value, // ✅ Read-only if user is found

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
                              addStaffController.contactFocusNode.unfocus();
                            },
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 13, bottom: 0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.searchfeildcolor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  addStaffController.toggleExpansion();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AppTextWidget(
                                            text: 'Current Address',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryText,
                                          ),
                                          AppTextWidget(
                                            text: AppTexts.star,
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.starcolor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons
                                          .keyboard_arrow_down, // Your custom dropdown icon
                                      color: AppColors
                                          .searchfeild, // Adjust color as needed
                                      size: 27,
                                    ),
                                  ],
                                ),
                              ),
                              Obx(() => addStaffController.isExpanded.value
                                  ? Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(4, (index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        1),
                                                AppTextWidget(
                                                  text: addStaffController
                                                      .addressLabels[index],
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.primaryText,
                                                ),
                                                SizedBox(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        1),
                                                buildTextField(
                                                  context,
                                                  "Enter ${addStaffController.addressLabels[index]}",
                                                  index,
                                                ),
                                                SizedBox(height: 20),
                                              ],
                                            );
                                          }),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                              text: 'State',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryText,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    1),
                                        Obx(
                                          () => AppSearchDropdown(
                                            enabled: !addStaffController
                                                .userFound
                                                .value, // ✅ Editable only if user NOT found

                                            items: inductionTrainingController
                                                .stateList
                                                .map(
                                                  (state) => state.stateName,
                                                )
                                                .toList(),
                                            selectedItem: addStaffController
                                                    .selectedState
                                                    .value
                                                    .isNotEmpty
                                                ? addStaffController
                                                    .selectedState.value
                                                : null,
                                            hintText: 'Select State',
                                            onChanged: (value) async {
                                              addStaffController.selectedState
                                                  .value = value ?? '';
                                              //-----------------------------------------------------------------------------------
                                              if (value != null) {
                                                var selectedStateObj =
                                                    inductionTrainingController
                                                        .stateList
                                                        .firstWhere(
                                                  (state) =>
                                                      state.stateName == value,
                                                  orElse: () =>
                                                      inductionTrainingController
                                                          .stateList.first,
                                                );

                                                addStaffController
                                                        .selectedStateId.value =
                                                    selectedStateObj.id;

                                                log('Selected State ID: ${addStaffController.selectedStateId}');

                                                // Fetch districts for selected state

                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        CustomLoadingPopup());
                                                Map<String, dynamic>
                                                    requestData = {
                                                  "state_id": addStaffController
                                                      .selectedStateId.value
                                                };
                                                await addStaffController
                                                    .getAssociatedDistrictsList(
                                                        requestData, context);
                                                Navigator.pop(context);

                                                log('addStaffController selectedStateId------------${addStaffController.selectedStateId}');
                                              }

                                              addStaffController
                                                  .updateStaffFormattedAddress();
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Please select a State';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                              text: 'District',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryText,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    1),
                                        Obx(
                                          () => AppSearchDropdown(
                                            enabled: !addStaffController
                                                .userFound.value, //

                                            items: addStaffController
                                                .districtListMatched
                                                .map((district) =>
                                                    district.districtName)
                                                .toList(),
                                            selectedItem: addStaffController
                                                    .selectedDistrict
                                                    .value
                                                    .isNotEmpty
                                                ? addStaffController
                                                    .selectedDistrict.value
                                                : null,
                                            hintText: 'Select District',
                                            onChanged: (value) {
                                              addStaffController
                                                  .selectedDistrict
                                                  .value = value ?? '';

                                              //---------------------

                                              if (value != null) {
                                                var selectedDistrictObj =
                                                    inductionTrainingController
                                                        .districtList
                                                        .firstWhere(
                                                  (district) =>
                                                      district.districtName ==
                                                      value,
                                                  orElse: () =>
                                                      inductionTrainingController
                                                          .districtList.first,
                                                );
                                                addStaffController
                                                        .selectedDistrictId
                                                        .value =
                                                    selectedDistrictObj.id;
                                              }
                                              log('addStaffController selectedDistrictId------------${addStaffController.selectedDistrictId}');

                                              addStaffController
                                                  .updateStaffpermanantFormattedAddress();
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Please select a District';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    1),
                                      ],
                                    )
                                  : SizedBox()),
                              SizedBox(height: 12),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1.5,
                        ),
                        Obx(
                          () => addStaffController.userFound.value
                              ? SizedBox(height: 20)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    addStaffController.userFound.value
                                        ? Checkbox(
                                            activeColor: AppColors.buttoncolor,
                                            side: BorderSide(
                                              color: AppColors.secondaryText,
                                              width: 1.2,
                                            ),
                                            value: addStaffController
                                                .isSameAsCurrent.value,
                                            onChanged: (value) {
                                              addStaffController.isSameAsCurrent
                                                  .value = value ?? false;
                                            },
                                          )
                                        : Obx(() => Checkbox(
                                              activeColor:
                                                  AppColors.buttoncolor,
                                              side: BorderSide(
                                                color: AppColors.secondaryText,
                                                width: 1.2,
                                              ),
                                              value: addStaffController
                                                  .isSameAsCurrent.value,
                                              onChanged: (value) {
                                                addStaffController
                                                    .toggleSameAsCurrent(
                                                        value!);
                                              },
                                            )),
                                    AppTextWidget(
                                      text: "Same as Current Address",
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryText,
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 4),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.searchfeildcolor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  addStaffController.toggleExpansion2();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AppTextWidget(
                                          text: 'Permanent Address',
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryText,
                                        ),
                                        AppTextWidget(
                                          text: AppTexts.star,
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.starcolor,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons
                                          .keyboard_arrow_down, // Your custom dropdown icon
                                      color: AppColors
                                          .searchfeild, // Adjust color as needed
                                      size: 27,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 1),
                              Obx(() => addStaffController.isExpanded2.value
                                  ? Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(4, (index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppTextWidget(
                                                  text: addStaffController
                                                          .addresspermanantLabels[
                                                      index],
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.primaryText,
                                                ),
                                                SizedBox(
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        1),
                                                buildTextField2(
                                                  context,
                                                  "Enter ${addStaffController.addresspermanantLabels[index]}",
                                                  index,
                                                ),
                                                SizedBox(height: 20),
                                              ],
                                            );
                                          }),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                              text: 'State',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryText,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    1),
                                        Obx(
                                          () => AppSearchDropdown(
                                            items: inductionTrainingController
                                                .stateList
                                                .map(
                                                  (state) => state.stateName,
                                                )
                                                .toList(),
                                            selectedItem: addStaffController
                                                    .selectedPermanantState
                                                    .value
                                                    .isNotEmpty
                                                ? addStaffController
                                                    .selectedPermanantState
                                                    .value
                                                : null,
                                            enabled: !addStaffController
                                                .userFound
                                                .value, // ✅ Editable only if user NOT found

                                            hintText: 'Select State',
                                            onChanged: (value) async {
                                              addStaffController
                                                  .selectedPermanantState
                                                  .value = value ?? '';

                                              //-------------------------------
                                              if (value != null) {
                                                var selectedStateObj =
                                                    inductionTrainingController
                                                        .stateList
                                                        .firstWhere(
                                                  (state) =>
                                                      state.stateName == value,
                                                  orElse: () =>
                                                      inductionTrainingController
                                                          .stateList.first,
                                                );

                                                addStaffController
                                                    .selectedPermanantStateId
                                                    .value = selectedStateObj.id;
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        CustomLoadingPopup());
                                                Map<String, dynamic>
                                                    requestData = {
                                                  "state_id": addStaffController
                                                      .selectedPermanantStateId
                                                      .value
                                                };
                                                await addStaffController
                                                    .getAssociatedDistrictsList(
                                                        requestData, context);
                                                Navigator.pop(context);

                                                log('addStaffController selectedPermanantStateId------------${addStaffController.selectedPermanantStateId}');
                                              }

                                              addStaffController
                                                  .updateStaffFormattedAddress();
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Please select a State';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                              text: 'District',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryText,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    1),
                                        Obx(
                                          () => AppSearchDropdown(
                                            items: addStaffController
                                                .districtListMatched
                                                .map(
                                                  (district) =>
                                                      district.districtName,
                                                )
                                                .toList(),
                                            selectedItem: addStaffController
                                                    .selectedPermanantDistrict
                                                    .value
                                                    .isNotEmpty
                                                ? addStaffController
                                                    .selectedPermanantDistrict
                                                    .value
                                                : null,
                                            // enabled: !addStaffController
                                            //         .isSameAsCurrent.value &&
                                            //     !addStaffController.userFound
                                            //         .value, // ✅ Updated Condition
                                            enabled: !addStaffController
                                                .userFound
                                                .value, // ✅ Editable only if user NOT found

                                            hintText: 'Select District',
                                            onChanged: (value) {
                                              addStaffController
                                                  .selectedPermanantDistrict
                                                  .value = value ?? '';

                                              if (value != null) {
                                                var selectedDistrictObj =
                                                    inductionTrainingController
                                                        .districtList
                                                        .firstWhere(
                                                  (district) =>
                                                      district.districtName ==
                                                      value,
                                                  orElse: () =>
                                                      inductionTrainingController
                                                          .districtList.first,
                                                );
                                                addStaffController
                                                    .selectedPermanantDistrictId
                                                    .value = selectedDistrictObj.id;
                                              }
                                              log('addStaffController selectedPermanantDistrictId------------${addStaffController.selectedPermanantDistrictId}');

                                              addStaffController
                                                  .updateStaffpermanantFormattedAddress();
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Please select a District';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    )
                                  : SizedBox()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 4,
                        ),
                        AppTextWidget(
                          text: AppTexts.emergencydetails,
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        Row(
                          children: [
                            AppTextWidget(
                              text: AppTexts.emergencyname,
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
                                addStaffController.econtactnameController,
                            hintText: 'Emergency contact name',
                            focusNode: addStaffController.econtactnameFocusNode,
                            onFieldSubmitted: (_) {
                              addStaffController.econtactnameFocusNode
                                  .unfocus();
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            enabled: !addStaffController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addStaffController.userFound
                                .value, // ✅ Read-only if user is found

                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Emergency contact  name cannot be empty';
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
                              text: AppTexts.emergencynumber,
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
                                addStaffController.econtactnumberController,
                            hintText: 'Emergency contact number',
                            focusNode:
                                addStaffController.econtactnumberFocusNode,
                            onFieldSubmitted: (_) {
                              addStaffController.econtactnumberFocusNode
                                  .unfocus();
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            enabled: !addStaffController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addStaffController.userFound
                                .value, // ✅ Read-only if user is found

                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Emergency contact  number cannot be empty';
                              }
                              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Enter a valid 10-digit number';
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
                              text: AppTexts.emergencyrelation,
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
                                addStaffController.econtactrelationController,
                            hintText: 'Emergency contact relation',
                            focusNode:
                                addStaffController.econtactrelationFocusNode,
                            onFieldSubmitted: (_) {
                              addStaffController.econtactrelationFocusNode
                                  .unfocus();
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            enabled: !addStaffController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addStaffController.userFound
                                .value, // ✅ Read-only if user is found

                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Emergency contact relation cannot be empty';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 5),

                  SizedBox(height: SizeConfig.heightMultiplier * 5),
                ],
              )),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: AppElevatedButton(
              text: 'Next',
              onPressed: () {
                bool isValid = true;

                if (addStaffController.profilePhoto.value.isEmpty) {
                  addStaffController.profilePhotoEroor.value =
                      "Please select a Profile photo";
                  isValid = false;
                } else {
                  addStaffController.profilePhotoEroor.value = "";
                }
                if (!isValid) return;

                if (formKey.currentState!.validate() &&
                    addStaffController.profilePhoto.value.isNotEmpty) {
                  addStaffController.updateStaffFormattedAddress();
                  log('-------------${addStaffController.formattedAddress}');
                  log('-------------${addStaffController.profilePhoto.value}');

                  Get.to(StaffDocumentation(
                    categoryId: categoryId,
                    userId: userId,
                    userName: userName,
                    userImg: userImg,
                    userDesg: userDesg,
                    projectId: projectId,
                  ));
                  print("Navigating to Labourproffessinal with:");

                  print("User ID: $userId");
                  print("User Name: $userName");
                  print("Project ID: $projectId");
                  print("categoryId: $categoryId");
                }
              }),
        ),
      ),
    );
  }
}
