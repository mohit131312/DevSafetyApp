import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/labour_row_details.dart';
import 'package:flutter_app/features/labour_details/labour_details_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LabourDetailsScreen extends StatelessWidget {
  LabourDetailsScreen({super.key});
  final LabourDetailsController labourDetailsController =
      Get.put(LabourDetailsController());

  Future<void> _makeCall(String phoneNumber) async {
    // Ensure the phone number is valid for the 'tel' scheme
    final Uri callUri = Uri.parse('tel:$phoneNumber');
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(callUri.toString())) {
        // ignore: deprecated_member_use
        await launch(callUri.toString());
      } else {
        Get.snackbar(
          'Error',
          'Unable to launch dialer. Please check your number or phone settings.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while trying to make a call.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
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
                  text: AppTexts.labourdetails,
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
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.heightMultiplier * 2,
                    right: SizeConfig.widthMultiplier * 5,
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "$baseUrl${labourDetailsController.laboursAllDetails[0].userPhoto}"),
              ),
              title: AppTextWidget(
                text: labourDetailsController.laboursAllDetails[0].labourName ??
                    '',
                fontSize: AppTextSize.textSizeSmallm,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: labourDetailsController
                            .laboursAllDetails[0].labourName ??
                        '',
                    fontSize: AppTextSize.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                  AppTextWidget(
                    text: labourDetailsController
                        .laboursAllDetails[0].contactNumber
                        .toString(),
                    fontSize: AppTextSize.textSizeExtraSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                ],
              ),
              trailing: GestureDetector(
                onTap: () {
                  _makeCall(labourDetailsController
                      .laboursAllDetails[0].contactNumber
                      .toString());
                },
                child: SizedBox(
                  width: SizeConfig.imageSizeMultiplier * 11,
                  height: SizeConfig.imageSizeMultiplier * 11,
                  child: Image.asset(
                    "assets/icons/phone_orange.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {},
            ),
            Container(
              child: TabBar(
                indicatorColor: AppColors.buttoncolor,
                labelColor: AppColors.buttoncolor,
                unselectedLabelColor: AppColors.secondaryText,
                tabs: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 50,
                    child: const Tab(
                      text: "Labour Details",
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 50,
                    child: Tab(text: "Documents"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: SizeConfig.heightMultiplier * 1,
                    ),
                    child: ListView.builder(
                      itemCount:
                          labourDetailsController.laboursAllDetails.length,
                      itemBuilder: (context, index) {
                        final labour =
                            labourDetailsController.laboursAllDetails[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                            AppTextWidget(
                              text: AppTexts.personaldetails,
                              fontSize: AppTextSize.textSizeMediumm,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                            LabourRowDetails(
                              label: "Name",
                              value: labour.labourName.toString(),
                            ),
                            LabourRowDetails(
                              label: "Contact Number",
                              value: labour.contactNumber.toString(),
                            ),
                            LabourRowDetails(
                              label: "Gender",
                              value: labour.gender.toString(),
                            ),
                            LabourRowDetails(
                              label: "Blood Group",
                              value: labour.bloodGroup.toString(),
                            ),
                            LabourRowDetails(
                              label: "Date of Birth",
                              value: (labour.birthDate != null)
                                  ? DateFormat('dd MMMM yyyy').format(
                                      labour.birthDate is String
                                          ? DateTime.parse(
                                              labour.birthDate! as String)
                                          : labour.birthDate as DateTime)
                                  : 'N/A',
                            ),
                            LabourRowDetails(
                              label: "Age",
                              value: labour.age.toString(),
                            ),
                            LabourRowDetails(
                              label: "Address",
                              value:
                                  "${labour.currentStreetName ?? ''}, ${labour.currentCity ?? ''}, ${labour.currentTaluka ?? ''}, ${labour.districtName ?? ''}, ${labour.stateName ?? ''}"
                                      .trim()
                                      .replaceAll(RegExp(r'(^, |, $|, ,)'), ''),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                            Divider(
                              color: AppColors.fourtText.withAlpha(50),
                              thickness: 1.5,
                              height: 2,
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            AppTextWidget(
                              text: AppTexts.professionaldetails,
                              fontSize: AppTextSize.textSizeMediumm,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                            LabourRowDetails(
                              label: "Trade",
                              value: labourDetailsController
                                      .laboursAllProjectDetails.isNotEmpty
                                  ? labourDetailsController
                                      .laboursAllProjectDetails[0].tradeName
                                      .toString()
                                  : "-",
                            ),
                            LabourRowDetails(
                              label: "Skills",
                              value: labourDetailsController
                                      .laboursAllProjectDetails.isNotEmpty
                                  ? labourDetailsController
                                      .laboursAllProjectDetails[0].skillType
                                      .toString()
                                  : "-",
                            ),
                            LabourRowDetails(
                              label: "Year of Experience",
                              value:
                                  labour.experienceInYears?.toString() ?? "-",
                            ),
                            LabourRowDetails(
                              label: "Contractor Firm Name",
                              value: labourDetailsController
                                      .laboursAllProjectDetails.isNotEmpty
                                  ? labourDetailsController
                                      .laboursAllProjectDetails[0].firmName
                                      .toString()
                                  : "-",
                            ),
                            LabourRowDetails(
                              label: "Firm Contact Number",
                              value: labourDetailsController
                                      .laboursAllProjectDetails.isNotEmpty
                                  ? labourDetailsController
                                      .laboursAllProjectDetails[0]
                                      .contractorPhoneNo
                                      .toString()
                                  : "-",
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                            Divider(
                              color: AppColors.fourtText.withAlpha(50),
                              thickness: 1.5,
                              height: 2,
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            AppTextWidget(
                              text: AppTexts.emergencycontact,
                              fontSize: AppTextSize.textSizeMediumm,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                            LabourRowDetails(
                              label: "Contact Name",
                              value:
                                  labour.emergencyContactName.isNotEmpty == true
                                      ? labour.emergencyContactName
                                      : '-',
                            ),
                            LabourRowDetails(
                              label: "Relation",
                              value:
                                  labour.emergencyContactRelation.isNotEmpty ==
                                          true
                                      ? labour.emergencyContactRelation
                                      : '-',
                            ),
                            LabourRowDetails(
                              label: "Contact Number",
                              value: labour.emergencyContactNumber.isNotEmpty ==
                                      true
                                  ? labour.emergencyContactNumber
                                  : '-',
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: SizeConfig.heightMultiplier * 1,
                    ),
                    child: ListView.builder(
                      itemCount:
                          labourDetailsController.alldocumentDetails.length,
                      itemBuilder: (context, index) {
                        final item =
                            labourDetailsController.alldocumentDetails[index];
                        final String? photoUrl =
                            item.photos; // Store the photo URL
                        final bool hasImage = photoUrl != null &&
                            photoUrl.isNotEmpty; // Check if photo exist
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                            AppTextWidget(
                              text: AppTexts.idproof,
                              fontSize: AppTextSize.textSizeMediumm,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1,
                            ),
                            LabourRowDetails(
                              label: "Document Type",
                              value: item.docmentType.toString(),
                            ),
                            LabourRowDetails(
                              label: "ID Number",
                              value: item.idNumber.toString(),
                            ),
                            LabourRowDetails(
                              label: "Validity",
                              // ignore: unnecessary_null_comparison
                              value: (item.validity != null)
                                  ? DateFormat('dd MMMM yyyy').format(item
                                          .validity is String
                                      ? DateTime.parse(item.validity as String)
                                      : item.validity)
                                  : '',
                            ),
                            LabourRowDetails(
                              label: "Photos",
                              imgvalue: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: Get.context!,
                                          builder: (context) => Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: SizedBox(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: InteractiveViewer(
                                                  // Allows zooming & panning
                                                  child: Image.network(
                                                    "$baseUrl${item.photos}"
                                                        .toString(),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width:
                                            SizeConfig.imageSizeMultiplier * 25,
                                        height:
                                            SizeConfig.imageSizeMultiplier * 25,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.network(
                                            "$baseUrl${item.photos}".toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
