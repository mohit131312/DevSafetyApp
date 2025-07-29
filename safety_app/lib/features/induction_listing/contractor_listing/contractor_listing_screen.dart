import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/induction_listing/contractor_listing/contractor_listing_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContractorListingScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final int projectId;
  final String userImg;
  final String userDesg;

  ContractorListingScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.projectId,
    required this.userImg,
    required this.userDesg,
  });

  final ContractorListingController contractorListingController =
      Get.put(ContractorListingController());
  final LocationController locationController = Get.find();
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
              text: AppTexts.preview,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppTexts.previewsubmit,
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.3,
                    ),
                    AppTextWidget(
                      text: AppTexts.checkdetailssubmit,
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: "Induction ID :  ",
                          fontSize: AppTextSize.textSizeSmallm,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                        AppTextWidget(
                          text: contractorListingController
                              .contractorInductionTrainingsList[0].inductionId
                              .toString(),
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                  ],
                ),
              ),
              Obx(
                () => contractorListingController
                        .isPersonalDetailsExpanded.value
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4,
                          vertical: SizeConfig.heightMultiplier * 2,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Image.asset(
                                          'assets/icons/Contractor.png')),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  AppTextWidget(
                                    text: AppTexts.contractordetails,
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttoncolor,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        contractorListingController
                                            .toggleExpansion();
                                      },
                                      child: Icon(Icons.keyboard_arrow_up)),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 4,
                                  vertical: SizeConfig.heightMultiplier * 3,
                                ),
                                width: SizeConfig.widthMultiplier * 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.appgreycolor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 40,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                                text: AppTexts.contractorfirm,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: (contractorListingController
                                                            .contractorCompanyDetailsList
                                                            .isNotEmpty &&
                                                        contractorListingController
                                                                .contractorCompanyDetailsList[
                                                                    0]
                                                                // ignore: unnecessary_null_comparison
                                                                .contractorCompanyName !=
                                                            null &&
                                                        contractorListingController
                                                            .contractorCompanyDetailsList[
                                                                0]
                                                            .contractorCompanyName
                                                            .trim()
                                                            .isNotEmpty)
                                                    ? contractorListingController
                                                        .contractorCompanyDetailsList[
                                                            0]
                                                        .contractorCompanyName
                                                    : '',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                            AppTextWidget(
                                                text: AppTexts.gstn,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                              text: contractorListingController
                                                      .contractorCompanyDetailsList
                                                      .isNotEmpty
                                                  ? (contractorListingController
                                                                  .contractorCompanyDetailsList[
                                                                      0]
                                                                  .gstnNumber ??
                                                              '')
                                                          .trim()
                                                          .isNotEmpty
                                                      ? contractorListingController
                                                          .contractorCompanyDetailsList[
                                                              0]
                                                          .gstnNumber!
                                                          .trim()
                                                      : ''
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText,
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 20,
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 36,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                                text: AppTexts.reasonforvisit,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.searchfeild),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                                text: contractorListingController
                                                        .contractorReasonOfVisitList[
                                                            0]
                                                        .reasonOfVisit!
                                                        .isNotEmpty
                                                    ? contractorListingController
                                                        .contractorReasonOfVisitList[
                                                            0]
                                                        .reasonOfVisit!
                                                    : '',
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryText),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      2.5,
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4,
                          vertical: SizeConfig.heightMultiplier * 2,
                        ),
                        width: SizeConfig.widthMultiplier * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFFEFEFE),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(
                                        'assets/icons/Contractor.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: AppTexts.contractordetails,
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      contractorListingController
                                          .toggleExpansion();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                          ],
                        ),
                      ),
              ),

              //---------------------------------------------------------------------

              //-----------------------------------------------------------------
              Obx(() => contractorListingController
                      .isidproofDetailsExpanded.value
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 2,
                      ),
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFEFEFE),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(
                                        'assets/icons/phone_small_phone.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: 'Contact Details',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      contractorListingController
                                          .toggleExpansionidProof();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            AppTextWidget(
                              text: 'Primary Contact Details',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.searchfeild,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4,
                                vertical: SizeConfig.heightMultiplier * 3,
                              ),
                              width: SizeConfig.widthMultiplier * 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.appgreycolor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 43,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                              text: AppTexts.name,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: contractorListingController
                                                      .contractorDetailsList[0]
                                                      .contractorName
                                                      .isNotEmpty
                                                  ? contractorListingController
                                                      .contractorDetailsList[0]
                                                      .contractorName
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text: AppTexts.emailid,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                            text: contractorListingController
                                                    .contractorDetailsList[0]
                                                    .contractorEmail!
                                                    .isNotEmpty
                                                ? contractorListingController
                                                    .contractorDetailsList[0]
                                                    .contractorEmail!
                                                : '',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text: AppTexts.idproofno,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                            text: contractorListingController
                                                    .contractorDetailsList[0]
                                                    .idProofNumber!
                                                    .isNotEmpty
                                                ? contractorListingController
                                                    .contractorDetailsList[0]
                                                    .idProofNumber!
                                                    .toString()
                                                : '',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 4,
                                  ),
                                  SizedBox(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                              text: AppTexts.contactno,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: contractorListingController
                                                      .contractorDetailsList[0]
                                                      .contractorPhoneNo!
                                                      .isNotEmpty
                                                  ? contractorListingController
                                                      .contractorDetailsList[0]
                                                      .contractorPhoneNo!
                                                      .toString()
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text: AppTexts.idprooftype,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                            text: contractorListingController.
                                                        // ignore: unnecessary_null_comparison
                                                        documentType !=
                                                    null
                                                ? contractorListingController
                                                    .documentType
                                                    .toString()
                                                : '',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText,
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                          AppTextWidget(
                                              text: AppTexts.photos,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (contractorListingController
                                                      .contractorDetailsList
                                                      .isNotEmpty &&
                                                  contractorListingController
                                                          .contractorDetailsList[
                                                              0]
                                                          // ignore: unnecessary_null_comparison
                                                          .documentPath !=
                                                      null &&
                                                  contractorListingController
                                                      .contractorDetailsList[0]
                                                      .documentPath!
                                                      .isNotEmpty) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: InteractiveViewer(
                                                        panEnabled: true,
                                                        minScale: 0.5,
                                                        maxScale: 3.0,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.network(
                                                            "$baseUrl${contractorListingController.contractorDetailsList[0].documentPath}",
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: SizedBox(
                                              height: SizeConfig
                                                      .imageSizeMultiplier *
                                                  16,
                                              width: SizeConfig
                                                      .imageSizeMultiplier *
                                                  16,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: (contractorListingController
                                                            .contractorDetailsList[
                                                                0]
                                                            .documentPath!
                                                            .isNotEmpty &&
                                                        // ignore: unnecessary_null_comparison
                                                        contractorListingController
                                                                .contractorDetailsList[
                                                                    0]
                                                                .documentPath !=
                                                            null)
                                                    ? Image.network(
                                                        "$baseUrl${contractorListingController.contractorDetailsList[0].documentPath}",
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(""),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),

                            //----------------------------

                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            AppTextWidget(
                              text: 'Secondary Contact Details',
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.searchfeild,
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 2),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4,
                                vertical: SizeConfig.heightMultiplier * 3,
                              ),
                              width: SizeConfig.widthMultiplier * 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.appgreycolor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 40,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                              text: AppTexts.name,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: contractorListingController
                                                      .contractorDetailsList[0]
                                                      .secondaryContactPersonName!
                                                      .isNotEmpty
                                                  ? contractorListingController
                                                      .contractorDetailsList[0]
                                                      .secondaryContactPersonName!
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 40,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                              text: AppTexts.contactno,
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.searchfeild),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier * 1,
                                          ),
                                          AppTextWidget(
                                              text: contractorListingController
                                                      .contractorDetailsList[0]
                                                      .secondaryContactPersonNumber!
                                                      .isNotEmpty
                                                  ? contractorListingController
                                                      .contractorDetailsList[0]
                                                      .secondaryContactPersonNumber!
                                                  : '',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryText),
                                          SizedBox(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    2.5,
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 4,
                        vertical: SizeConfig.heightMultiplier * 2,
                      ),
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFEFEFE),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                      'assets/icons/phone_small_phone.png')),
                              SizedBox(
                                width: 5,
                              ),
                              AppTextWidget(
                                text: 'Contact Details',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttoncolor,
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    contractorListingController
                                        .toggleExpansionidProof();
                                  },
                                  child: Icon(Icons.keyboard_arrow_up)),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                        ],
                      ),
                    )),
              //------------------------------------------------------------------
              Obx(
                () =>
                    contractorListingController
                            .isprecautionDetailsExpanded.value
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 4,
                              vertical: SizeConfig.heightMultiplier * 2,
                            ),
                            width: SizeConfig.widthMultiplier * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFFFEFEFE),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x10000000),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                  offset: Offset(0, -4),
                                ),
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Image.asset(
                                              'assets/icons/precaution.png')),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      AppTextWidget(
                                        text: 'Service Details',
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.buttoncolor,
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                          onTap: () {
                                            contractorListingController
                                                .toggleExpansionPrecaution();
                                          },
                                          child: Icon(Icons.keyboard_arrow_up)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 3,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.widthMultiplier * 4,
                                      vertical: SizeConfig.widthMultiplier * 4,
                                    ),
                                    width: SizeConfig.widthMultiplier * 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.appgreycolor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                contractorListingController
                                                        .contractorServicesDetail
                                                        .isNotEmpty
                                                    ? Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                // color:
                                                                //     AppColors.primary,
                                                                border: Border.all(
                                                                    width: 0.7,
                                                                    color: AppColors
                                                                        .backbuttoncolor)),
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            92,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right: 6),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            child:
                                                                                ListView.separated(
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              itemCount: contractorListingController.contractorServicesDetail.length,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (context, index) {
                                                                                if (index >= contractorListingController.contractorServicesDetail.length) {
                                                                                  return SizedBox.shrink();
                                                                                }
                                                                                return Padding(
                                                                                  padding: EdgeInsets.only(top: 20),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                AppTextWidget(text: 'Activity', fontSize: AppTextSize.textSizeSmall, fontWeight: FontWeight.w400, color: AppColors.searchfeild),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 1,
                                                                                                ),
                                                                                                AppTextWidget(text: contractorListingController.contractorServicesDetail[index].activityName, fontSize: AppTextSize.textSizeSmalle, fontWeight: FontWeight.w400, color: AppColors.primaryText),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 2.5,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: SizeConfig.widthMultiplier * 1,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                AppTextWidget(text: 'Sub Activity', fontSize: AppTextSize.textSizeSmall, fontWeight: FontWeight.w400, color: AppColors.searchfeild),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 1,
                                                                                                ),
                                                                                                AppTextWidget(
                                                                                                    // text:
                                                                                                    //     serviceDetailsController.activityExist[index]['sub_activity_id'].toString(),
                                                                                                    text: contractorListingController.contractorServicesDetail[index].activityName,
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
                                                                              separatorBuilder: (BuildContext context, int index) {
                                                                                return Container(
                                                                                  height: 1,
                                                                                  color: AppColors.searchfeildcolor,
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
                                                    : Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: AppColors
                                                                .primary,
                                                            border: Border.all(
                                                                width: 0.7,
                                                                color: AppColors
                                                                    .backbuttoncolor)),
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            92,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        child: ListView
                                                                            .separated(
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          itemCount: contractorListingController
                                                                              .contractorServicesDetail
                                                                              .length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            if (index >=
                                                                                contractorListingController.contractorServicesDetail.length) {
                                                                              return SizedBox.shrink();
                                                                            }
                                                                            return Stack(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: 20),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                AppTextWidget(text: 'Activity', fontSize: AppTextSize.textSizeSmall, fontWeight: FontWeight.w400, color: AppColors.searchfeild),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 1,
                                                                                                ),
                                                                                                AppTextWidget(text: contractorListingController.contractorServicesDetail[index].activityName, fontSize: AppTextSize.textSizeSmalle, fontWeight: FontWeight.w400, color: AppColors.primaryText),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 2.5,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: SizeConfig.heightMultiplier * 2.5,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                AppTextWidget(text: 'Sub Activity', fontSize: AppTextSize.textSizeSmall, fontWeight: FontWeight.w400, color: AppColors.searchfeild),
                                                                                                SizedBox(
                                                                                                  height: SizeConfig.heightMultiplier * 1,
                                                                                                ),
                                                                                                AppTextWidget(text: contractorListingController.contractorServicesDetail[index].subActivityName, fontSize: AppTextSize.textSizeSmalle, fontWeight: FontWeight.w400, color: AppColors.primaryText),
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
                                                                              (BuildContext context, int index) {
                                                                            return Container(
                                                                              height: 1,
                                                                              color: AppColors.searchfeildcolor,
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.widthMultiplier * 4,
                              vertical: SizeConfig.heightMultiplier * 2,
                            ),
                            width: SizeConfig.widthMultiplier * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFFFEFEFE),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x10000000),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                  offset: Offset(0, -4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/icons/precaution.png')),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    AppTextWidget(
                                      text: 'Service Details',
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.buttoncolor,
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          contractorListingController
                                              .toggleExpansionPrecaution();
                                        },
                                        child: Icon(Icons.keyboard_arrow_up)),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 3,
                                ),
                              ],
                            ),
                          ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 3,
                ),
                width: SizeConfig.widthMultiplier * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.appgreycolor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                        text: 'Inducted By',
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryText),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Row(
                      children: [
                        Container(
                          width: SizeConfig.imageSizeMultiplier * 15,
                          height: SizeConfig.imageSizeMultiplier * 15,
                          child: Image.network(
                            "$baseUrl${userImg}",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                                text: userName,
                                fontSize: AppTextSize.textSizeSmallm,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText),
                            AppTextWidget(
                                text: userDesg,
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w400,
                                color: AppColors.searchfeild),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    AppTextWidget(
                        text: 'Created On',
                        fontSize: AppTextSize.textSizeSmalle,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryText),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    AppTextWidget(
                      text: contractorListingController
                                  // ignore: unnecessary_null_comparison
                                  .contractorInductionTrainingsList[0]
                                  // ignore: unnecessary_null_comparison
                                  .createdAt !=
                              null
                          ? DateFormat('dd-MM-yyyy hh:mm a')
                              .format(DateTime.parse(contractorListingController
                                  // ignore: unnecessary_null_comparison
                                  .contractorInductionTrainingsList[0]
                                  // ignore: unnecessary_null_comparison
                                  .createdAt
                                  .toString()))
                          : "",
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    AppTextWidget(
                        text: 'Geolocation',
                        fontSize: AppTextSize.textSizeSmalle,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryText),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Obx(() {
                      final city = locationController.cityName.value;

                      return AppTextWidget(
                        text: city.isNotEmpty
                            ? 'City: $city'
                            : 'Fetching city...',
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText,
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 6,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: AppElevatedButton(
              text: 'Close',
              onPressed: () {
                Get.back();
              }),
        ),
      ),
    );
  }
}
