import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_search_dropdown.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/incident_report_all/incident_details/incident_details_controller.dart';
import 'package:flutter_app/features/incident_report_all/incident_more_details/incident_more_details_screen.dart';
import 'package:flutter_app/features/incident_report_all/incident_report/incident_report_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_assigne/select_assigne_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_assigne/select_assigne_screen.dart';
import 'package:flutter_app/features/incident_report_all/select_informed_people/select_informed_people_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_informed_people/select_informed_people_screen.dart';
import 'package:flutter_app/features/incident_report_all/select_injured/select_injured_controller.dart';
import 'package:flutter_app/features/incident_report_all/select_injured/select_injured_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class IncidentDetailsScreen extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;

  IncidentDetailsScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final IncidentDetailsController incidentDetailsController = Get.find();
  final IncidentReportController incidentReportController = Get.find();
  final SelectInjuredController selectInjuredController = Get.find();
  final SelectInformedIncidentController selectInformedIncidentController =
      Get.find();

  final SelectAssigneController selectAssigneController = Get.find();

//---------

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.33,
                      backgroundColor: AppColors.searchfeildcolor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.defaultPrimary),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '01/03',
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
                text: 'Incident Details',
                fontSize: AppTextSize.textSizeMediumm,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 0.3,
              ),
              AppTextWidget(
                text: 'Enter incident details.',
                fontSize: AppTextSize.textSizeSmalle,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryText,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1.5,
              ),

              ////---------------
              Column(
                children: [
                  Row(
                    children: [
                      AppTextWidget(
                        text: 'Photo',
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
                    () => incidentDetailsController.incidentImageCount < 1
                        ? GestureDetector(
                            onTap: () {
                              incidentDetailsController.pickIncidentImages();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: SizeConfig.widthMultiplier * 92,
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 24, bottom: 24),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.orange, width: 2),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.orange.shade50,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                  SizedBox(height: 8),
                                  AppTextWidget(
                                      text: 'Maximum 10 photos',
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryText),
                                ],
                              ),
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
                                      child: GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: incidentDetailsController
                                              .incidentimg.length,
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
                                                          incidentDetailsController
                                                              .incidentimg[
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
                                                      incidentDetailsController
                                                          .removeAdharImage(
                                                              index);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
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
                                  GestureDetector(
                                    onTap: () {
                                      incidentDetailsController
                                          .pickIncidentImages();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height:
                                          SizeConfig.imageSizeMultiplier * 18,
                                      width:
                                          SizeConfig.imageSizeMultiplier * 18,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.orange, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.orange,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                  incidentDetailsController.incidentImageCount < 1
                      ? SizedBox(
                          height: SizeConfig.heightMultiplier * 2.5,
                        )
                      : SizedBox(),
                  Obx(() => incidentDetailsController
                              .incidentImageCount.value ==
                          0
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 5),
                              child: Text(
                                incidentDetailsController.photoError.value,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 174, 75, 68),
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        )
                      : SizedBox()),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: AppTextWidget(
                          text: 'Select Building',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
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
                      items: incidentReportController.buildingList
                          .map(
                            (building) => building.buildingName,
                          )
                          .whereType<String>()
                          .toList(),
                      selectedItem: incidentDetailsController
                              .selectBuilding.value.isNotEmpty
                          ? incidentDetailsController.selectBuilding.value
                          : null,
                      hintText: 'Select Building',
                      onChanged: (value) async {
                        incidentDetailsController.selectBuilding.value =
                            value ?? '';
                        var selectedBuilding = incidentReportController
                            .buildingList
                            .firstWhereOrNull(
                                (building) => building.buildingName == value);

                        if (selectedBuilding != null) {
                          incidentDetailsController.selectBuildingId.value =
                              selectedBuilding.id;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CustomLoadingPopup());
                          await incidentDetailsController.getSafetyIncidentData(
                              incidentDetailsController.selectBuildingId.value);
                          Get.back();
                          log(' Selected selectBuilding: ${incidentDetailsController.selectBuilding.value}');
                          log(' Selected selectBuildingId ID: ${incidentDetailsController.selectBuildingId.value}');
                        } else {}
                      },
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please select a type';
                        }
                        return null;
                      },
                    ),
                  ),

                  //-----------------------------
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.5,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: AppTextWidget(
                          text: 'Area of Work',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
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
                      items: incidentDetailsController.floorList
                          .map((floor) => floor.floorName)
                          .whereType<String>()
                          .toList(),
                      selectedItem:
                          incidentDetailsController.selectFloor.value.isNotEmpty
                              ? incidentDetailsController.selectFloor.value
                              : null,
                      hintText: 'Select Area of Work',
                      onChanged: (value) async {
                        incidentDetailsController.selectFloor.value =
                            value ?? '';
                        var selectedFloor = incidentDetailsController.floorList
                            .firstWhereOrNull(
                                (floor) => floor.floorName == value);

                        if (selectedFloor != null) {
                          incidentDetailsController.selectFloorId.value =
                              selectedFloor.id;

                          log(' Selected selectFloor: ${incidentDetailsController.selectFloor.value}');
                          log(' Selected selectFloorId ID: ${incidentDetailsController.selectFloorId.value}');
                        } else {}
                      },
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please select a type';
                        }
                        return null;
                      },
                    ),
                  ),
                  //-----------------------------------------------
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.5,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: AppTextWidget(
                          text: 'Involved Contractor Firm ',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
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
                      items: incidentReportController.contractorCompanyList
                          .map(
                            (company) => company.contractorCompanyName,
                          )
                          .whereType<String>()
                          .toList(),
                      selectedItem: incidentDetailsController
                              .selectCompany.value.isNotEmpty
                          ? incidentDetailsController.selectCompany.value
                          : null,
                      hintText: 'Select Contractor Firm',
                      onChanged: (value) async {
                        incidentDetailsController.selectCompany.value =
                            value ?? '';
                        var selectedCompany = incidentReportController
                            .contractorCompanyList
                            .firstWhereOrNull((company) =>
                                company.contractorCompanyName == value);

                        if (selectedCompany != null) {
                          incidentDetailsController.selectCompanyId.value =
                              selectedCompany.id;

                          log(' Selected selectCompany: ${incidentDetailsController.selectCompany.value}');
                          log(' Selected selectCompanyId ID: ${incidentDetailsController.selectCompanyId.value}');
                        } else {}
                      },
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please select a type';
                        }
                        return null;
                      },
                    ),
                  ),

                  //------------------------------
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Row(
                    children: [
                      AppTextWidget(
                        text: 'Incident Details',
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
                    controller: incidentDetailsController.incidentController,
                    hintText: 'Enter Incident Details',
                    focusNode: incidentDetailsController.incidentFocusNode,
                    onFieldSubmitted: (_) {
                      incidentDetailsController.incidentFocusNode.unfocus();
                    },
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Incident Details cannot be empty';
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
                        text: 'Severity',
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
                      // enabled: !addLabourController
                      //     .userFound.value, // ✅ Editable only if user NOT found

                      items: incidentReportController.severitylevelList
                          .map(
                            (severity) => severity.incidentDetails,
                          )
                          .toList(),
                      selectedItem: incidentDetailsController
                              .selectSeverity.value.isNotEmpty
                          ? incidentDetailsController.selectSeverity.value
                          : null,
                      hintText: 'Select Severity',

                      onChanged: (value) {
                        incidentDetailsController.selectSeverity.value =
                            value ?? '';
                        var selectedSeverity = incidentReportController
                            .severitylevelList
                            .firstWhereOrNull((severity) =>
                                severity.incidentDetails == value);

                        if (selectedSeverity != null) {
                          incidentDetailsController.selectSeverityId.value =
                              selectedSeverity.id;
                          log(' Selected selectSeverity: ${incidentDetailsController.selectSeverity.value}');
                          log(' Selected selectSeverityId ID: ${incidentDetailsController.selectSeverityId.value}');
                        } else {}
                      },
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please select a type';
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
                        text: 'Select Injured / Involved People',
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
                    () => selectInjuredController
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
                  Obx(() => selectInjuredController
                          .selectedIncidentLabourIdsFinal.isNotEmpty
                      ? SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        )
                      : SizedBox()),
                  Obx(
                    () {
                      final selectedList =
                          selectInjuredController.addIncidentInvolvePerson;

                      return selectInjuredController
                              .selectedIncidentLabourIdsFinal.isNotEmpty
                          ? Container(
                              padding:
                                  EdgeInsets.only(left: 8, right: 8, top: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.7,
                                      color: AppColors.searchfeildcolor),
                                  borderRadius: BorderRadius.circular(8)),
                              height: selectInjuredController
                                          .selectedIncidentLabourIdsFinal
                                          .length >
                                      1
                                  ? SizeConfig.heightMultiplier * 24
                                  : SizeConfig.heightMultiplier * 11,
                              child: Scrollbar(
                                radius: Radius.circular(10),
                                thickness: 4,
                                child: ListView.builder(
                                  primary: false,
                                  controller: incidentDetailsController
                                      .scrollLabourController,
                                  itemCount: selectedList.length,
                                  itemBuilder: (context, index) {
                                    final labour = selectedList[index];

                                    return ListTile(
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
                                      trailing: GestureDetector(
                                        onTap: () {
                                          selectInjuredController
                                              .removeIncidentData(index);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox();
                    },
                  ),
                  Obx(() => selectInjuredController
                          .selectedIncidentStaffIdsFinal.isNotEmpty
                      ? SizedBox(
                          height: SizeConfig.heightMultiplier * 4,
                        )
                      : SizedBox()),
                  Obx(
                    () => selectInjuredController
                            .selectedIncidentStaffIdsFinal.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text: 'Select Staff',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                            ],
                          )
                        : SizedBox(),
                  ),

                  Obx(() => selectInjuredController
                          .selectedIncidentStaffIdsFinal.isNotEmpty
                      ? SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        )
                      : SizedBox()),
                  Obx(
                    () {
                      final selectedList =
                          selectInjuredController.addInvolveIncidentStaffPerson;

                      return selectInjuredController
                              .selectedIncidentStaffIdsFinal.isNotEmpty
                          ? Container(
                              padding:
                                  EdgeInsets.only(left: 8, right: 8, top: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.7,
                                      color: AppColors.searchfeildcolor),
                                  borderRadius: BorderRadius.circular(8)),
                              height: selectInjuredController
                                          .selectedIncidentStaffIdsFinal
                                          .length >
                                      1
                                  ? SizeConfig.heightMultiplier * 24
                                  : SizeConfig.heightMultiplier * 11,
                              child: Scrollbar(
                                child: ListView.builder(
                                  controller: incidentDetailsController
                                      .scrollStaffController,
                                  itemCount: selectedList.length,
                                  itemBuilder: (context, index) {
                                    final staff = selectedList[index];

                                    return ListTile(
                                      contentPadding:
                                          EdgeInsets.only(left: 0, right: 20),
                                      leading: CircleAvatar(
                                        radius: 22,
                                        backgroundImage: NetworkImage(
                                            "$baseUrl${staff.userPhoto}"),
                                      ),
                                      title: AppTextWidget(
                                        text: staff.staffName.toString(),
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryText,
                                      ),
                                      subtitle: AppTextWidget(
                                        text: staff.contactNumber.toString(),
                                        fontSize: AppTextSize.textSizeSmalle,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.secondaryText,
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          selectInjuredController
                                              .removeIncidentStaffData(index);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox();
                    },
                  ),
                  Obx(() => selectInjuredController
                          .selectedIncidentContractorIdsFinal.isNotEmpty
                      ? SizedBox(
                          height: SizeConfig.heightMultiplier * 4,
                        )
                      : SizedBox()),

                  //---------------------------------------------------------

                  Obx(
                    () => selectInjuredController
                            .selectedIncidentContractorIdsFinal.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text: 'Select Contractor',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                            ],
                          )
                        : SizedBox(),
                  ),

                  Obx(() => selectInjuredController
                          .selectedIncidentContractorIdsFinal.isNotEmpty
                      ? SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        )
                      : SizedBox()),
                  Obx(
                    () {
                      final selectedList = selectInjuredController
                          .addInvolveIncidentContractorPerson;

                      return selectInjuredController
                              .selectedIncidentContractorIdsFinal.isNotEmpty
                          ? Container(
                              padding:
                                  EdgeInsets.only(left: 8, right: 8, top: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.7,
                                      color: AppColors.searchfeildcolor),
                                  borderRadius: BorderRadius.circular(8)),
                              height: selectInjuredController
                                          .selectedIncidentContractorIdsFinal
                                          .length >
                                      1
                                  ? SizeConfig.heightMultiplier * 24
                                  : SizeConfig.heightMultiplier * 11,
                              child: Scrollbar(
                                child: ListView.builder(
                                  controller: incidentDetailsController
                                      .scrollContractorController,
                                  itemCount: selectedList.length,
                                  itemBuilder: (context, index) {
                                    final contractor = selectedList[index];

                                    return ListTile(
                                      contentPadding:
                                          EdgeInsets.only(left: 0, right: 20),
                                      leading: CircleAvatar(
                                        radius: 22,
                                        backgroundImage: NetworkImage(
                                            "$baseUrl${contractor.documentPath}"),
                                      ),
                                      title: AppTextWidget(
                                        text: contractor.contractorName
                                            .toString(),
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryText,
                                      ),
                                      subtitle: AppTextWidget(
                                        text: contractor.contractorPhoneNo
                                            .toString(),
                                        fontSize: AppTextSize.textSizeSmalle,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.secondaryText,
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          selectInjuredController
                                              .removeIncidentContractorData(
                                                  index);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox();
                    },
                  ),

                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Obx(() => selectInjuredController
                              .selectedIncidentStaffIdsFinal.isEmpty &&
                          selectInjuredController
                              .selectedIncidentContractorIdsFinal.isEmpty &&
                          selectInjuredController
                              .selectedIncidentLabourIdsFinal.isEmpty
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 5),
                              child: Text(
                                incidentDetailsController.involvedError.value,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 174, 75, 68),
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        )
                      : SizedBox()),

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
                      Get.to(SelectInjuredScreen());
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
                          text: "Add People",
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w400,
                          color: AppColors.thirdText,
                        ),
                      ],
                    ),
                  ),
                  //-----------------------------------

                  //--------------------------------

                  SizedBox(height: SizeConfig.heightMultiplier * 2),

                  Row(
                    children: [
                      AppTextWidget(
                        text: 'Select Assignee',
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
                    () {
                      final selectedList =
                          selectAssigneController.addInvolveassigneeDataPerson;

                      return selectAssigneController
                              .selectedassigneeDataIdsFinal.isNotEmpty
                          ? Container(
                              padding:
                                  EdgeInsets.only(left: 8, right: 8, top: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.7,
                                      color: AppColors.searchfeildcolor),
                                  borderRadius: BorderRadius.circular(8)),
                              height: SizeConfig.heightMultiplier * 10,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: selectedList.length,
                                itemBuilder: (context, index) {
                                  final assgneeData = selectedList[index];

                                  return ListTile(
                                    contentPadding:
                                        EdgeInsets.only(left: 0, right: 20),
                                    leading: CircleAvatar(
                                      radius: 22,
                                      backgroundImage: NetworkImage(
                                          "$baseUrl${assgneeData.profilePhoto}"),
                                    ),
                                    title: AppTextWidget(
                                      text: assgneeData.firstName.toString(),
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryText,
                                    ),
                                    subtitle: AppTextWidget(
                                      text: assgneeData.designation.toString(),
                                      fontSize: AppTextSize.textSizeSmalle,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryText,
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        selectAssigneController
                                            .removeassigneeData(index);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox();
                    },
                  ),

                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Obx(() => selectAssigneController
                          .selectedassigneeDataIdsFinal.isEmpty
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 5),
                              child: Text(
                                incidentDetailsController.assigneeError.value,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 174, 75, 68),
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        )
                      : SizedBox()),
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
                      Get.to(SelectAssigneScreen());
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
                          text: "Add Assignee",
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w400,
                          color: AppColors.thirdText,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),

                  //-----------------------------------------------------------------

                  Row(
                    children: [
                      AppTextWidget(
                        text: 'Select Informed People ',
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
                    () {
                      final selectedList = selectInformedIncidentController
                          .addInvolveIncidentPerson;

                      return selectInformedIncidentController
                              .selectedAssIncidentIdsFinal.isNotEmpty
                          ? Container(
                              padding:
                                  EdgeInsets.only(left: 8, right: 8, top: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.7,
                                      color: AppColors.searchfeildcolor),
                                  borderRadius: BorderRadius.circular(8)),
                              height: selectInformedIncidentController
                                          .selectedAssIncidentIdsFinal.length >
                                      1
                                  ? SizeConfig.heightMultiplier * 24
                                  : SizeConfig.heightMultiplier * 11,
                              child: Scrollbar(
                                child: ListView.builder(
                                  controller: incidentDetailsController
                                      .scrollAssigneeInformedController,
                                  itemCount: selectedList.length,
                                  itemBuilder: (context, index) {
                                    final assgneeInformed = selectedList[index];

                                    return ListTile(
                                      contentPadding:
                                          EdgeInsets.only(left: 0, right: 20),
                                      leading: CircleAvatar(
                                        radius: 22,
                                        backgroundImage: NetworkImage(
                                            "$baseUrl${assgneeInformed.profilePhoto}"),
                                      ),
                                      title: AppTextWidget(
                                        text: assgneeInformed.firstName
                                            .toString(),
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryText,
                                      ),
                                      subtitle: AppTextWidget(
                                        text: assgneeInformed.designation
                                            .toString(),
                                        fontSize: AppTextSize.textSizeSmalle,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.secondaryText,
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          selectInformedIncidentController
                                              .removeIncidentAssigneeData(
                                                  index);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox();
                    },
                  ),

                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Obx(() => selectInformedIncidentController
                          .selectedAssIncidentIdsFinal.isEmpty
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 5),
                              child: Text(
                                incidentDetailsController.informedError.value,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 174, 75, 68),
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        )
                      : SizedBox()),
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
                      Get.to(SelectInformedPeopleScreen());
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
                          text: "Add Informed People",
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w400,
                          color: AppColors.thirdText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              AppElevatedButton(
                  text: 'Next',
                  onPressed: () {
                    if (incidentDetailsController.incidentimg.isEmpty) {
                      incidentDetailsController.photoError.value =
                          "Please insert Images.";
                    }

                    if (selectInformedIncidentController
                        .selectedAssIncidentIdsFinal.isEmpty) {
                      incidentDetailsController.informedError.value =
                          "Please Select Informed People.";
                    }

                    if (selectInjuredController
                            .selectedIncidentStaffIdsFinal.isEmpty &&
                        selectInjuredController
                            .selectedIncidentContractorIdsFinal.isEmpty &&
                        selectInjuredController
                            .selectedIncidentLabourIdsFinal.isEmpty) {
                      incidentDetailsController.involvedError.value =
                          "Please Select Involved People.";
                    }

                    if (selectAssigneController
                        .selectedassigneeDataIdsFinal.isEmpty) {
                      incidentDetailsController.assigneeError.value =
                          "Please Select Assignee People.";
                    }
                    if (formKey.currentState!.validate() &&
                        selectInformedIncidentController
                            .selectedAssIncidentIdsFinal.isNotEmpty &&
                        selectAssigneController
                            .selectedassigneeDataIdsFinal.isNotEmpty &&
                        (selectInjuredController
                                .selectedIncidentStaffIdsFinal.isNotEmpty ||
                            selectInjuredController
                                .selectedIncidentContractorIdsFinal
                                .isNotEmpty ||
                            selectInjuredController
                                .selectedIncidentLabourIdsFinal.isNotEmpty)) {
                      Get.to(IncidentMoreDetailsScreen(
                          userId: userId,
                          userName: userName,
                          userImg: userImg,
                          userDesg: userDesg,
                          projectId: projectId));
                    }
                  }),
              SizedBox(height: SizeConfig.heightMultiplier * 5),
            ]),
          ),
        ),
      ),
    );
  }
}
