import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/labour_row_details.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LabourDetailsScreen extends StatelessWidget {
  LabourDetailsScreen({super.key});
  final List labourData = [
    {
      "Image": "assets/icons/profile_icon.png",
      "Name": "Sai Ram",
      "Location": "Parc Residencies",
      "Contact": "+91 84857 86598",
      "Gender": "Male",
      "Blood Group": "A+",
      "DOB": "12 Jan 1988",
      "Age": 36,
      "Address": "22, Hind Rajasthan Bldg, Dadasaheb Phalke Road, Dadar(e)",
      "Trade": "Helper",
      "Skill": "Unskilled",
      "Experience": 2,
      "Firm": "Dream Group Constructions",
      "FirmContact": "+91 8745962132",
      "EmergencyContact": {
        "Name": "Govinda",
        "Relation": "Brother",
        "Contact": "+91 8473546847",
      }
    }
  ];

  final List documentData = [
    {
      "Type": "Aadhar Card",
      "IDNumber": "12345678974",
      "Validity": "-",
      "Photos": "assets/images/adhar_img.png",
    }
  ];

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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: labourData.length,
              itemBuilder: (context, index) {
                var item = labourData[index];
                return Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    ListTile(
                      leading: Container(
                        width: SizeConfig.imageSizeMultiplier * 18.11,
                        height: SizeConfig.imageSizeMultiplier * 18.11,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(item['Image'].toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: AppTextWidget(
                        text: item['Name'],
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: item['Location'],
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                          AppTextWidget(
                            text: item['Contact'].toString(),
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: SizeConfig.imageSizeMultiplier * 9,
                        height: SizeConfig.imageSizeMultiplier * 9,
                        child: Image.asset(
                          "assets/icons/phone_orange.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        _makeCall("102");
                      },
                    ),
                  ],
                );
              },
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
                      itemCount: labourData.length,
                      itemBuilder: (context, index) {
                        final item = labourData[index];
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
                              value: item["Name"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Contact Number",
                              value: item["Contact"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Gender",
                              value: item["Gender"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Blood Group",
                              value: item["Blood Group"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Date of Birth",
                              value: item["DOB"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Age",
                              value: item["Age"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Address",
                              value: item["Address"].toString(),
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
                              value: item["Trade"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Skills",
                              value: item["Skill"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Year of Experience",
                              value: item["Experience"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Contractor Firm Name",
                              value: item["Firm"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Firm Contact Number",
                              value: item["FirmContact"].toString(),
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
                                  item["EmergencyContact"]["Name"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Relation",
                              value: item["EmergencyContact"]["Relation"]
                                  .toString(),
                            ),
                            LabourRowDetails(
                              label: "Contact Number",
                              value: item["EmergencyContact"]["Contact"]
                                  .toString(),
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
                      itemCount: documentData.length,
                      itemBuilder: (context, index) {
                        final item = documentData[index];
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
                              value: item["Type"].toString(),
                            ),
                            LabourRowDetails(
                              label: "ID Number",
                              value: item["IDNumber"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Validity",
                              value: item["Validity"].toString(),
                            ),
                            LabourRowDetails(
                              label: "Photos",
                              imgvalue: Row(
                                children: [
                                  Image.asset(
                                    item["Photos"].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 2,
                                  ),
                                  Image.asset(
                                    item["Photos"].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ],
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
