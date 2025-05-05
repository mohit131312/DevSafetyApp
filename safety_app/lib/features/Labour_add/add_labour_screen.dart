import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_normal_dropdown.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/Labour_add/add_labour_controller.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/features/labour_professional_details/labour_profess_details.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/matched_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddLabourScreen extends StatelessWidget {
  final int categoryId;

  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  AddLabourScreen({
    super.key,
    required this.categoryId,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });

  final AddLabourController addLabourController = Get.find();
  final InductionTrainingController inductionTrainingController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void showDatePicker(
      BuildContext context, AddLabourController addLabourController) {
    DateTime today = DateTime.now();

    DateTime tempPickedDate = addLabourController.selectedDate.value ??
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
                          addLabourController.age =
                              addLabourController.calculateAge(newDate);
                          log("Selected Age: ${addLabourController.age}");

                          if (addLabourController.age >= 18) {
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
                        addLabourController
                            .updateDate(tempPickedDate); // Save date
                        int age =
                            addLabourController.calculateAge(tempPickedDate);
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
      addLabourController.streetFocusNode,
      addLabourController.cityFocusNode,
      addLabourController.talukaFocusNode,
      addLabourController.pincodeFocusNode,
    ];
    return AppTextFormfeild(
      controller: addLabourController.addressControllers[index],
      hintText: hint,
      keyboardType: index == 3 ? TextInputType.number : TextInputType.name,
      textInputAction: TextInputAction.next,
      focusNode: focusNodes[index],
      onFieldSubmitted: (_) {
        focusNodes[index].unfocus();
      },
      enabled: !addLabourController
          .userFound.value, // ✅ Editable only if user NOT found
      readOnly:
          addLabourController.userFound.value, // ✅ Read-only if user is found

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
        addLabourController.updateFormattedAddress();
      },
    );
  }

  Widget buildTextField2(BuildContext context, String hint, index) {
    List<FocusNode> focusNodes = [
      addLabourController.streetPermanatFocusNode,
      addLabourController.cityPermanatFocusNode,
      addLabourController.talukaPermanatFocusNode,
      addLabourController.pincodePermanatFocusNode,
    ];
    return AppTextFormfeild(
      controller: addLabourController.permanantAddressController[index],
      hintText: hint,
      keyboardType: index == 3 ? TextInputType.number : TextInputType.name,
      textInputAction: TextInputAction.next,
      focusNode: focusNodes[index],
      onFieldSubmitted: (_) {
        focusNodes[index].unfocus();
      },
      enabled: !addLabourController
          .userFound.value, // ✅ Editable only if user NOT found
      readOnly:
          addLabourController.userFound.value, // ✅ Read-only if user is found

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
        addLabourController.updatepermanantFormattedAddress();
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
                    text: AppTexts.enterlabourdetails,
                    fontSize: AppTextSize.textSizeSmalle,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  AppTextWidget(
                    text: 'Search Labour',
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
                          controller: addLabourController.searchController,
                          focusNode: addLabourController.searchFocusNodeAll,
                          onFieldSubmitted: (_) {
                            addLabourController.searchFocusNodeAll.unfocus();
                          },
                          textInputAction: TextInputAction.next,
                          style: GoogleFonts.inter(
                            fontSize: AppTextSize.textSizeSmallm,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryText,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search Labour By ID',
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
                                value: addLabourController
                                        .searchType.value.isNotEmpty
                                    ? addLabourController.searchType.value
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
                                    addLabourController.searchType.value =
                                        newValue;
                                    print(
                                        '---------${addLabourController.searchType.value}');
                                    print(
                                        '---------${addLabourController.searchType.value}');
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
                              addLabourController.searchController.text;

                          if (addLabourController.searchType.value == 'ID') {
                            print(
                                '---------${addLabourController.searchType.value}');

                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomLoadingPopup());

                            await addLabourController.getSafetyLabourDetails(
                                value, context, true, false, projectId);

                            Navigator.pop(context);
                          } else {
                            print(
                                '---------${addLabourController.searchType.value}');
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomLoadingPopup());
                            await addLabourController
                                .getSafetyLabourMatchedDetails(
                                    value, context, projectId);
                            Navigator.pop(context);

                            if (addLabourController.searchResults.isNotEmpty &&
                                addLabourController.searchResults.length > 1) {
                              log('In the if getSafetyLabourMatchedDetails ');
                              showDialog(
                                context: context,
                                builder: (context) => MatchedUser(
                                  items: addLabourController.searchResults,
                                  categoryId: categoryId,
                                  onItemSelected: (context, id) async {
                                    await addLabourController
                                        .getSafetyLabourDetails(id, context,
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

                              await addLabourController.getSafetyLabourDetails(
                                  value, context, false, false, projectId);
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
                  //   () => addLabourController.userFound.value
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
                  //                   child: addLabourController
                  //                           .profilePhoto.isNotEmpty
                  //                       ? Image.network(
                  //                           "$baseUrl${addLabourController.profilePhoto.value}",
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
                                    child: addLabourController
                                            .profilePhoto.isNotEmpty
                                        ? Image.file(
                                            File(addLabourController
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
                              onTap: () => addLabourController
                                  .pickImage(ImageSource.camera),
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
                  Obx(() => addLabourController.profilePhoto.value.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 4, left: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                addLabourController.profilePhotoEroor.value,
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
                            controller:
                                addLabourController.labournameController,
                            hintText: 'Full Name',
                            focusNode: addLabourController.fullnameFocusNode,
                            onFieldSubmitted: (_) {
                              addLabourController.fullnameFocusNode.unfocus();
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,

                            enabled: !addLabourController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addLabourController.userFound
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
                                addLabourController.genders.length, (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier * 1),
                                child: ChoiceChip(
                                  label: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        addLabourController.genders[index]
                                                ['icon']
                                            .toString(),
                                        height:
                                            SizeConfig.imageSizeMultiplier * 4,
                                        width:
                                            SizeConfig.imageSizeMultiplier * 4,
                                      ),
                                      SizedBox(width: 5),
                                      Text(addLabourController.genders[index]
                                              ['label'] ??
                                          ''),
                                    ],
                                  ),
                                  selected: addLabourController
                                          .selectedGender.value ==
                                      index,
                                  onSelected:
                                      addLabourController.userFound.value
                                          ? null
                                          : (selected) {
                                              addLabourController
                                                  .selectGender(index);
                                            },
                                  selectedColor:
                                      Colors.white, // Adjust as needed
                                  backgroundColor: Colors.white,
                                  side: BorderSide(
                                    color: addLabourController
                                                .selectedGender.value ==
                                            index
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                  ),
                                  labelStyle: TextStyle(
                                    color: addLabourController
                                                .selectedGender.value ==
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
                        Row(
                          children: [
                            AppTextWidget(
                              text: 'Literacy',
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
                          () => AppNormalDropdown(
                            enabled: !addLabourController.userFound
                                .value, // ✅ Editable only if user NOT found
                            items: addLabourController.literacyStatus,
                            selectedItem: addLabourController
                                    .selectedLiteratre.value.isNotEmpty
                                ? addLabourController.selectedLiteratre.value
                                : null,
                            hint: AppTextWidget(
                              text: 'Select Literacy',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.searchfeild,
                            ),
                            onChanged: (value) {
                              addLabourController.selectedLiteratre.value =
                                  value ?? '';
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.toString().trim().isEmpty) {
                                return 'Please select a literacy status';
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
                              text: 'Marital Status',
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
                          () => AppNormalDropdown(
                            enabled: !addLabourController.userFound
                                .value, // ✅ Editable only if user NOT found
                            items: addLabourController.maritalStatus,
                            selectedItem: addLabourController
                                    .selectedmarried.value.isNotEmpty
                                ? addLabourController.selectedmarried.value
                                : null,
                            hint: AppTextWidget(
                              text: 'Select Marital Status',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.searchfeild,
                            ),
                            onChanged: (value) {
                              addLabourController.selectedmarried.value =
                                  value ?? '';
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.toString().trim().isEmpty) {
                                return 'Please select a Marital status';
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
                            // if (!addLabourController.userFound.value) {
                            showDatePicker(context, addLabourController);
                            // }
                            log(addLabourController.dateController.text);
                          },
                          child: Obx(
                            () => TextFormField(
                              controller: addLabourController.dateController,

                              // onChanged: (value) {
                              //   addLabourController.selectedDate.value =
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
                                        context, addLabourController),
                                    child: Image.asset(
                                      'assets/icons/calendar.png',
                                      height:
                                          SizeConfig.imageSizeMultiplier * 3,
                                      width: SizeConfig.imageSizeMultiplier * 3,
                                    ),
                                  ),
                                ),
                              ),

                              enabled: !addLabourController.userFound.value, //
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
                            enabled: !addLabourController.userFound
                                .value, // ✅ Editable only if user NOT found

                            items: inductionTrainingController.bloodGrpTypes
                                .map(
                                  (bloodgrp) => bloodgrp.type,
                                )
                                .toList(),
                            selectedItem: addLabourController
                                    .selectedBloodGroup.value.isNotEmpty
                                ? addLabourController.selectedBloodGroup.value
                                : null,
                            hintText: 'Select Blood Group',
                            onChanged: (value) {
                              addLabourController.selectedBloodGroup.value =
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
                            selectedItem: addLabourController
                                    .selectedreasons.value.isNotEmpty
                                ? addLabourController.selectedreasons.value
                                : null,
                            hintText: 'Select Reason',
                            onChanged: (value) {
                              addLabourController.selectedreasons.value =
                                  value ?? '';

                              if (value != null) {
                                // Ensure we are matching with the correct field (ID or reason name)
                                var selectedReasonObj =
                                    inductionTrainingController
                                        .reasonForVisitList
                                        .firstWhereOrNull((state) =>
                                            state.listDetails == value);

                                if (selectedReasonObj != null) {
                                  addLabourController.selectedReasonId.value =
                                      selectedReasonObj.id;
                                  log('Selected Reason ID: ${addLabourController.selectedReasonId.value}');
                                  log('Selected Reason Name: ${addLabourController.selectedreasons.value}');
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
                                addLabourController.contactnumberController,
                            hintText: 'Contact Number',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            enabled: !addLabourController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addLabourController.userFound
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
                              addLabourController.contactFocusNode.unfocus();
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
                                  addLabourController.toggleExpansion();
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
                              Obx(() => addLabourController.isExpanded.value
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
                                                  text: addLabourController
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
                                                  "Enter ${addLabourController.addressLabels[index]}",
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
                                            enabled: !addLabourController
                                                .userFound
                                                .value, // ✅ Editable only if user NOT found

                                            items: inductionTrainingController
                                                .stateList
                                                .map(
                                                  (state) => state.stateName,
                                                )
                                                .toList(),
                                            selectedItem: addLabourController
                                                    .selectedState
                                                    .value
                                                    .isNotEmpty
                                                ? addLabourController
                                                    .selectedState.value
                                                : null,
                                            hintText: 'Select State',
                                            onChanged: (value) async {
                                              addLabourController.selectedState
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

                                                addLabourController
                                                        .selectedStateId.value =
                                                    selectedStateObj.id;

                                                log('Selected State ID: ${addLabourController.selectedStateId}');

                                                // Fetch districts for selected state

                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        CustomLoadingPopup());
                                                Map<String, dynamic>
                                                    requestData = {
                                                  "state_id":
                                                      addLabourController
                                                          .selectedStateId.value
                                                };
                                                await addLabourController
                                                    .getAssociatedDistrictsList(
                                                        requestData, context);
                                                Navigator.pop(context);

                                                log('addLabourController selectedStateId------------${addLabourController.selectedStateId}');
                                              }

                                              addLabourController
                                                  .updateFormattedAddress();
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
                                            enabled: !addLabourController
                                                .userFound.value, //

                                            items: addLabourController
                                                .districtListMatched
                                                .map((district) =>
                                                    district.districtName)
                                                .toList(),
                                            selectedItem: addLabourController
                                                    .selectedDistrict
                                                    .value
                                                    .isNotEmpty
                                                ? addLabourController
                                                    .selectedDistrict.value
                                                : null,
                                            hintText: 'Select District',
                                            onChanged: (value) {
                                              addLabourController
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
                                                addLabourController
                                                        .selectedDistrictId
                                                        .value =
                                                    selectedDistrictObj.id;
                                              }
                                              log('addLabourController selectedDistrictId------------${addLabourController.selectedDistrictId}');

                                              addLabourController
                                                  .updatepermanantFormattedAddress();
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
                          () => addLabourController.userFound.value
                              ? SizedBox(height: 20)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    addLabourController.userFound.value
                                        ? Checkbox(
                                            activeColor: AppColors.buttoncolor,
                                            side: BorderSide(
                                              color: AppColors.secondaryText,
                                              width: 1.2,
                                            ),
                                            value: addLabourController
                                                .isSameAsCurrent.value,
                                            onChanged: (value) {
                                              addLabourController
                                                  .isSameAsCurrent
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
                                              value: addLabourController
                                                  .isSameAsCurrent.value,
                                              onChanged: (value) {
                                                addLabourController
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
                                  addLabourController.toggleExpansion2();
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
                              Obx(() => addLabourController.isExpanded2.value
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
                                                  text: addLabourController
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
                                                  "Enter ${addLabourController.addresspermanantLabels[index]}",
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
                                            selectedItem: addLabourController
                                                    .selectedPermanantState
                                                    .value
                                                    .isNotEmpty
                                                ? addLabourController
                                                    .selectedPermanantState
                                                    .value
                                                : null,
                                            enabled: !addLabourController
                                                .userFound
                                                .value, // ✅ Editable only if user NOT found

                                            hintText: 'Select State',
                                            onChanged: (value) async {
                                              addLabourController
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

                                                addLabourController
                                                    .selectedPermanantStateId
                                                    .value = selectedStateObj.id;
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        CustomLoadingPopup());
                                                Map<String, dynamic>
                                                    requestData = {
                                                  "state_id": addLabourController
                                                      .selectedPermanantStateId
                                                      .value
                                                };
                                                await addLabourController
                                                    .getAssociatedDistrictsList(
                                                        requestData, context);
                                                Navigator.pop(context);

                                                log('addLabourController selectedPermanantStateId------------${addLabourController.selectedPermanantStateId}');
                                              }

                                              addLabourController
                                                  .updateFormattedAddress();
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
                                            items: addLabourController
                                                .districtListMatched
                                                .map(
                                                  (district) =>
                                                      district.districtName,
                                                )
                                                .toList(),
                                            selectedItem: addLabourController
                                                    .selectedPermanantDistrict
                                                    .value
                                                    .isNotEmpty
                                                ? addLabourController
                                                    .selectedPermanantDistrict
                                                    .value
                                                : null,
                                            // enabled: !addLabourController
                                            //         .isSameAsCurrent.value &&
                                            //     !addLabourController.userFound
                                            //         .value, // ✅ Updated Condition
                                            enabled: !addLabourController
                                                .userFound
                                                .value, // ✅ Editable only if user NOT found

                                            hintText: 'Select District',
                                            onChanged: (value) {
                                              addLabourController
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
                                                addLabourController
                                                    .selectedPermanantDistrictId
                                                    .value = selectedDistrictObj.id;
                                              }
                                              log('addLabourController selectedPermanantDistrictId------------${addLabourController.selectedPermanantDistrictId}');

                                              addLabourController
                                                  .updatepermanantFormattedAddress();
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
                                addLabourController.econtactnameController,
                            hintText: 'Emergency contact name',
                            focusNode:
                                addLabourController.econtactnameFocusNode,
                            onFieldSubmitted: (_) {
                              addLabourController.econtactnameFocusNode
                                  .unfocus();
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            enabled: !addLabourController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addLabourController.userFound
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
                                addLabourController.econtactnumberController,
                            hintText: 'Emergency contact number',
                            focusNode:
                                addLabourController.econtactnumberFocusNode,
                            onFieldSubmitted: (_) {
                              addLabourController.econtactnumberFocusNode
                                  .unfocus();
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            enabled: !addLabourController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addLabourController.userFound
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
                                addLabourController.econtactrelationController,
                            hintText: 'Emergency contact relation',
                            focusNode:
                                addLabourController.econtactrelationFocusNode,
                            onFieldSubmitted: (_) {
                              addLabourController.econtactrelationFocusNode
                                  .unfocus();
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            enabled: !addLabourController.userFound
                                .value, // ✅ Editable only if user NOT found
                            readOnly: addLabourController.userFound
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

                if (addLabourController.profilePhoto.value.isEmpty) {
                  addLabourController.profilePhotoEroor.value =
                      "Please select a Profile photo";
                  isValid = false;
                } else {
                  addLabourController.profilePhotoEroor.value = "";
                }
                if (!isValid) return;

                if (formKey.currentState!.validate() &&
                    addLabourController.profilePhoto.value.isNotEmpty) {
                  addLabourController.updateFormattedAddress();
                  log('-------------${addLabourController.formattedAddress}');
                  log('-------------${addLabourController.profilePhoto.value}');

                  Get.to(LabourProfessDetails(
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
