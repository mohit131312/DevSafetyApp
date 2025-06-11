import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_all_list_details/toolbox_training_all_listdet_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ToolboxTrainingAllListdet extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int toolBox;

  ToolboxTrainingAllListdet(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userImg,
      required this.userDesg,
      required this.projectId,
      required this.toolBox});

  //-----------------------------------------------------------------------
  final ToolboxTrainingAllListdetController
      toolboxTrainingAllListdetController =
      Get.put(ToolboxTrainingAllListdetController());
  final LocationController locationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
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
              text: 'Toolbox Training',
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
                      text: 'Verify & Submit',
                      fontSize: AppTextSize.textSizeMediumm,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.3,
                    ),
                    AppTextWidget(
                      text: 'Verify the details, ',
                      fontSize: AppTextSize.textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.5,
                    ),
                  ],
                ),
              ),

              //---------------------------------------------------------------------

              //-----------------------------------------------------------------
              Obx(() => toolboxTrainingAllListdetController
                      .istoolboxExpanded.value
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
                                    child: Image.asset('assets/icons/TBT.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: 'Toolbox Training Details',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      toolboxTrainingAllListdetController
                                          .toolboxtoggleExpansion();
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                          text: 'Name of Work Permit',
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.searchfeild),
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier * 1,
                                      ),

                                      AppTextWidget(
                                          text: toolboxTrainingAllListdetController
                                                      .safetyToolboxTraining
                                                      .isNotEmpty &&
                                                  toolboxTrainingAllListdetController
                                                          .safetyToolboxTraining[
                                                              0]
                                                          .nameOfTbTraining !=
                                                      null &&
                                                  toolboxTrainingAllListdetController
                                                      .safetyToolboxTraining[0]
                                                      .nameOfTbTraining!
                                                      .isNotEmpty
                                              ? toolboxTrainingAllListdetController
                                                  .safetyToolboxTraining[0]
                                                  .nameOfTbTraining!
                                              : "",
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryText),

                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 1.5,
                                      ),
                                      AppTextWidget(
                                          text: 'Category',
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.searchfeild),
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier * 1,
                                      ),
                                      AppTextWidget(
                                          text:
                                              toolboxTrainingAllListdetController
                                                  .toolboxCategoryList[0]
                                                  .categoryName
                                                  .toString(),
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryText),

                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 1.5,
                                      ),
                                      AppTextWidget(
                                          text: 'Details of Training.',
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.searchfeild),
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier * 1,
                                      ),
                                      AppTextWidget(
                                          text: toolboxTrainingAllListdetController
                                                      .safetyToolboxTraining
                                                      .isNotEmpty &&
                                                  toolboxTrainingAllListdetController
                                                          .safetyToolboxTraining[
                                                              0]
                                                          .details !=
                                                      null &&
                                                  toolboxTrainingAllListdetController
                                                      .safetyToolboxTraining[0]
                                                      .details!
                                                      .isNotEmpty
                                              ? toolboxTrainingAllListdetController
                                                  .safetyToolboxTraining[0]
                                                  .details!
                                              : "",
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryText),
                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 1.5,
                                      ),

                                      //
                                      AppTextWidget(
                                          text: 'Photos',
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.searchfeild),
                                      SizedBox(
                                        height:
                                            SizeConfig.heightMultiplier * 1.5,
                                      ),

                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                      itemCount:
                                                          toolboxTrainingAllListdetController
                                                              .tbtAddedPhotos
                                                              .length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount:
                                                            4, // Ensures one row (horizontal scroll)

                                                        childAspectRatio:
                                                            1, // Keeps items square
                                                        mainAxisSpacing: 12,
                                                        crossAxisSpacing:
                                                            12, // Spacing between images
                                                      ),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Stack(
                                                          children: [
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .imageSizeMultiplier *
                                                                  20,
                                                              width: SizeConfig
                                                                      .imageSizeMultiplier *
                                                                  20,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12), // Clip image to match container

                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    if (toolboxTrainingAllListdetController
                                                                            .tbtAddedPhotos
                                                                            .isNotEmpty &&
                                                                        toolboxTrainingAllListdetController
                                                                                .tbtAddedPhotos[index]
                                                                                // ignore: unnecessary_null_comparison
                                                                                .photoPath !=
                                                                            null &&
                                                                        toolboxTrainingAllListdetController
                                                                            .tbtAddedPhotos[index]
                                                                            // ignore: unnecessary_null_comparison
                                                                            .photoPath!
                                                                            .isNotEmpty) {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return Dialog(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            child:
                                                                                InteractiveViewer(
                                                                              panEnabled: true,
                                                                              minScale: 0.5,
                                                                              maxScale: 3.0,
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                child: Image.network(
                                                                                  "$baseUrl${toolboxTrainingAllListdetController.tbtAddedPhotos[index].photoPath}",
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    }
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    height:
                                                                        SizeConfig.imageSizeMultiplier *
                                                                            16,
                                                                    width: SizeConfig
                                                                            .imageSizeMultiplier *
                                                                        16,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child: (toolboxTrainingAllListdetController
                                                                              .tbtAddedPhotos[index]
                                                                              // ignore: unnecessary_null_comparison
                                                                              .photoPath!
                                                                              .isNotEmpty
                                                                          // ignore: unnecessary_null_comparison
                                                                          )
                                                                          ? Image.network(
                                                                              "$baseUrl${toolboxTrainingAllListdetController.tbtAddedPhotos[index]
                                                                                  // ignore: unnecessary_null_comparison
                                                                                  .photoPath}",
                                                                              fit: BoxFit.cover,
                                                                            )
                                                                          : Image.asset(""),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //--------------------------
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
                                  child: Image.asset('assets/icons/TBT.png')),
                              SizedBox(
                                width: 5,
                              ),
                              AppTextWidget(
                                text: 'Toolbox Training Details',
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttoncolor,
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    toolboxTrainingAllListdetController
                                        .toolboxtoggleExpansion();
                                    ();
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

              //---------------------------------------------------

              Obx(
                () => toolboxTrainingAllListdetController.istraineedetails.value
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
                                          'assets/icons/twouser.png')),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  AppTextWidget(
                                    text: 'Trainees Details',
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttoncolor,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        toolboxTrainingAllListdetController
                                            .toggletraineedetailsExpansion();
                                      },
                                      child: Icon(Icons.keyboard_arrow_up)),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 3,
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
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.7,
                                              color:
                                                  AppColors.searchfeildcolor),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height:
                                          toolboxTrainingAllListdetController
                                                      .traineeLaboursList
                                                      .length >
                                                  1
                                              ? SizeConfig.heightMultiplier * 24
                                              : SizeConfig.heightMultiplier *
                                                  11,
                                      child: Scrollbar(
                                        radius: Radius.circular(10),
                                        thickness: 4,
                                        child: ListView.builder(
                                          primary: false,
                                          // controller:
                                          //     toolboxTDetailsController
                                          //         .scrollLabourController,
                                          itemCount:
                                              toolboxTrainingAllListdetController
                                                  .traineeLaboursList.length,

                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 0, right: 20),
                                              leading: CircleAvatar(
                                                radius: 22,
                                                backgroundImage: NetworkImage(
                                                    "$baseUrl${toolboxTrainingAllListdetController.traineeLaboursList[index].userPhoto}"),
                                              ),
                                              title: AppTextWidget(
                                                text:
                                                    toolboxTrainingAllListdetController
                                                        .traineeLaboursList[
                                                            index]
                                                        .labourName!,
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primaryText,
                                              ),
                                              subtitle: AppTextWidget(
                                                text: '',
                                                fontSize:
                                                    AppTextSize.textSizeSmalle,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.secondaryText,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )

                                    //---------------------------------------------------------
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
                                        'assets/icons/twouser.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextWidget(
                                  text: 'Trainees Details',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      toolboxTrainingAllListdetController
                                          .toggletraineedetailsExpansion();
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
              //--------------------------------------------select informed people

              Obx(
                () => toolboxTrainingAllListdetController.isprecaution.value
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
                                    text: 'Instructions Given',
                                    fontSize: AppTextSize.textSizeSmall,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttoncolor,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        toolboxTrainingAllListdetController
                                            .toggleExpansionisprecaution();
                                      },
                                      child: Icon(Icons.keyboard_arrow_up)),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 3,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 3,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppTextWidget(
                                            text: 'Instructions Given',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryText),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 2,
                                    ),
                                    Container(
                                      width: SizeConfig.widthMultiplier * 100,
                                      height: 1.5,
                                      color: AppColors.searchfeildcolor,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 3,
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          NeverScrollableScrollPhysics(), // Prevents inner scrolling
                                      itemCount:
                                          toolboxTrainingAllListdetController
                                              .toolboxInstructionsList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${index + 1}.", // 🔢 Show index (1-based)
                                                style: TextStyle(
                                                    fontSize: AppTextSize
                                                        .textSizeSmall,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.primaryText),
                                              ),
                                              SizedBox(
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      2),
                                              Expanded(
                                                child: AppTextWidget(
                                                    text: toolboxTrainingAllListdetController
                                                        .toolboxInstructionsList[
                                                            index]
                                                        .toolboxInstructions,
                                                    fontSize: AppTextSize
                                                        .textSizeSmall,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.primaryText),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 3,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 3,
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
                                  text: 'Instructions Given',
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttoncolor,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      toolboxTrainingAllListdetController
                                          .toggleExpansionisprecaution();
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

              //---------------------------------
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 3,
                ),
                width: SizeConfig.widthMultiplier * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                        text: 'Reviewer',
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 8,
                      ),
                      height: SizeConfig.heightMultiplier * 10,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: toolboxTrainingAllListdetController
                            .reviewerUser.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 0, right: 20),
                            leading: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                      Colors.grey.shade200, // Fallback color
                                  child: ClipOval(
                                    child: Image.network(
                                      "$baseUrl${toolboxTrainingAllListdetController.reviewerUser[index].profilePhoto}",
                                      fit: BoxFit.cover,
                                      width: 56, // Diameter = radius * 2
                                      height: 56,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: AppColors.buttoncolor,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/icons/image.png',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: AppTextWidget(
                              text: toolboxTrainingAllListdetController
                                  .reviewerUser[index].firstName
                                  .toString(),
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            subtitle: AppTextWidget(
                              text: toolboxTrainingAllListdetController
                                  .reviewerUser[index].designation
                                  .toString(),
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryText,
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: 'Reviewer Comments',
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
                      enabled: false,
                      controller: toolboxTrainingAllListdetController
                          .reviewerController,

                      hintText: 'Comments',
                      // focusNode: newWorkPermitController.dow,
                      // onFieldSubmitted: (_) {
                      //   newWorkPermitController.dow.unfocus();
                      // },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter a comment';
                      //   }
                      //   return null;
                      // },
                      fillColor: AppColors.textfeildcolor,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    AppTextWidget(
                        text: 'Doer',
                        fontSize: AppTextSize.textSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 8,
                      ),
                      height: SizeConfig.heightMultiplier * 10,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: toolboxTrainingAllListdetController
                            .makerUser.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 0, right: 20),
                            leading: CircleAvatar(
                              radius: 26,
                              backgroundImage: NetworkImage(
                                  "$baseUrl${toolboxTrainingAllListdetController.makerUser[index].profilePhoto}"),
                            ),
                            title: AppTextWidget(
                              text: toolboxTrainingAllListdetController
                                  .makerUser[index].firstName
                                  .toString(),
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            subtitle: AppTextWidget(
                              text: toolboxTrainingAllListdetController
                                  .makerUser[index].designation
                                  .toString(),
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryText,
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        AppTextWidget(
                          text: 'Doer Comments',
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
                      enabled: false,
                      controller:
                          toolboxTrainingAllListdetController.makerController,
                      fillColor: AppColors.textfeildcolor,

                      hintText: 'Comments',
                      // focusNode: newWorkPermitController.dow,
                      // onFieldSubmitted: (_) {
                      //   newWorkPermitController.dow.unfocus();
                      // },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter a comment';
                      //   }
                      //   return null;
                      // },
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
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
                      text: toolboxTrainingAllListdetController
                                  // ignore: unnecessary_null_comparison
                                  .safetyToolboxTraining[0]
                                  // ignore: unnecessary_null_comparison
                                  .createdAt !=
                              null
                          ? DateFormat('dd-MM-yyyy hh:mm a').format(
                              DateTime.parse(toolboxTrainingAllListdetController
                                  .safetyToolboxTraining[0].createdAt
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
              onPressed: () async {
                Get.back();
              }),
        ),
      ),
    );
  }
}
