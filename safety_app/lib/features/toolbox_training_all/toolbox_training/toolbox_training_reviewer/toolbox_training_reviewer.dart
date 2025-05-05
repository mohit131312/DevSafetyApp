import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_reviewer/toolbox_reviewer_closed.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_reviewer/toolbox_training_reviewer_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class ToolboxTrainingReviewer extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int toolBox;

  ToolboxTrainingReviewer(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userImg,
      required this.userDesg,
      required this.projectId,
      required this.toolBox});

  //-----------------------------------------------------------------------
  final ToolboxTrainingReviewerController toolboxTrainingReviewerController =
      Get.put(ToolboxTrainingReviewerController());
  final LocationController locationController = Get.find();
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
          child: Form(
            key: formKey,
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
                Obx(() => toolboxTrainingReviewerController
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
                                      child:
                                          Image.asset('assets/icons/TBT.png')),
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
                                        toolboxTrainingReviewerController
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        AppTextWidget(
                                            text: 'Name of Work Permit',
                                            fontSize: AppTextSize.textSizeSmall,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.searchfeild),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 1,
                                        ),

                                        AppTextWidget(
                                            text: toolboxTrainingReviewerController
                                                        .safetyToolboxReviwerTraining
                                                        .isNotEmpty &&
                                                    toolboxTrainingReviewerController
                                                            .safetyToolboxReviwerTraining[
                                                                0]
                                                            .nameOfTbTraining !=
                                                        null &&
                                                    toolboxTrainingReviewerController
                                                        .safetyToolboxReviwerTraining[
                                                            0]
                                                        .nameOfTbTraining!
                                                        .isNotEmpty
                                                ? toolboxTrainingReviewerController
                                                    .safetyToolboxReviwerTraining[
                                                        0]
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
                                          height:
                                              SizeConfig.heightMultiplier * 1,
                                        ),
                                        AppTextWidget(
                                            text: toolboxTrainingReviewerController
                                                .safetyToolboxReviwerTraining[0]
                                                .toolboxCategoryId
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
                                          height:
                                              SizeConfig.heightMultiplier * 1,
                                        ),
                                        AppTextWidget(
                                            text: toolboxTrainingReviewerController
                                                        .safetyToolboxReviwerTraining
                                                        .isNotEmpty &&
                                                    toolboxTrainingReviewerController
                                                            .safetyToolboxReviwerTraining[
                                                                0]
                                                            .details !=
                                                        null &&
                                                    toolboxTrainingReviewerController
                                                        .safetyToolboxReviwerTraining[
                                                            0]
                                                        .details!
                                                        .isNotEmpty
                                                ? toolboxTrainingReviewerController
                                                    .safetyToolboxReviwerTraining[
                                                        0]
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
                                                            toolboxTrainingReviewerController
                                                                .tbtMakerAddedPhotos
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
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12), // Clip image to match container

                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      if (toolboxTrainingReviewerController
                                                                              .tbtMakerAddedPhotos
                                                                              .isNotEmpty &&
                                                                          toolboxTrainingReviewerController
                                                                                  .tbtMakerAddedPhotos[index]
                                                                                  // ignore: unnecessary_null_comparison
                                                                                  .photoPath !=
                                                                              null &&
                                                                          toolboxTrainingReviewerController
                                                                              .tbtMakerAddedPhotos[index]
                                                                              // ignore: unnecessary_null_comparison
                                                                              .photoPath!
                                                                              .isNotEmpty) {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Dialog(
                                                                              backgroundColor: Colors.transparent,
                                                                              child: InteractiveViewer(
                                                                                panEnabled: true,
                                                                                minScale: 0.5,
                                                                                maxScale: 3.0,
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  child: Image.network(
                                                                                    "$baseUrl${toolboxTrainingReviewerController.tbtMakerAddedPhotos[index].photoPath}",
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
                                                                      width:
                                                                          SizeConfig.imageSizeMultiplier *
                                                                              16,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        child: (toolboxTrainingReviewerController
                                                                                .tbtMakerAddedPhotos[index]
                                                                                // ignore: unnecessary_null_comparison
                                                                                .photoPath!
                                                                                .isNotEmpty
                                                                            // ignore: unnecessary_null_comparison
                                                                            )
                                                                            ? Image.network(
                                                                                "$baseUrl${toolboxTrainingReviewerController.tbtMakerAddedPhotos[index]
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
                                      toolboxTrainingReviewerController
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
                  () => toolboxTrainingReviewerController.istraineedetails.value
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
                                          toolboxTrainingReviewerController
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            toolboxTrainingReviewerController
                                                        .traineeMakerLaboursList
                                                        .length >
                                                    1
                                                ? SizeConfig.heightMultiplier *
                                                    24
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
                                                toolboxTrainingReviewerController
                                                    .traineeMakerLaboursList
                                                    .length,

                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                contentPadding: EdgeInsets.only(
                                                    left: 0, right: 20),
                                                leading: CircleAvatar(
                                                  radius: 22,
                                                  backgroundImage: NetworkImage(
                                                      "$baseUrl${toolboxTrainingReviewerController.traineeMakerLaboursList[index].userPhoto}"),
                                                ),
                                                title: AppTextWidget(
                                                  text: toolboxTrainingReviewerController
                                                      .traineeMakerLaboursList[
                                                          index]
                                                      .labourName!,
                                                  fontSize:
                                                      AppTextSize.textSizeSmall,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primaryText,
                                                ),
                                                subtitle: AppTextWidget(
                                                  text: '',
                                                  fontSize: AppTextSize
                                                      .textSizeSmalle,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColors.secondaryText,
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
                                        toolboxTrainingReviewerController
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
                  () => toolboxTrainingReviewerController.isprecaution.value
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
                                          toolboxTrainingReviewerController
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppTextWidget(
                                              text: 'Instructions Given',
                                              fontSize:
                                                  AppTextSize.textSizeSmall,
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
                                            toolboxTrainingReviewerController
                                                .toolboxMakerInstructionsList
                                                .length,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .primaryText),
                                                ),
                                                SizedBox(
                                                    width: SizeConfig
                                                            .widthMultiplier *
                                                        2),
                                                Expanded(
                                                  child: AppTextWidget(
                                                      text: toolboxTrainingReviewerController
                                                          .toolboxMakerInstructionsList[
                                                              index]
                                                          .toolboxInstructions,
                                                      fontSize: AppTextSize
                                                          .textSizeSmall,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .primaryText),
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
                                        toolboxTrainingReviewerController
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
                    vertical: SizeConfig.heightMultiplier * 1,
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
                          text: 'Maker',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText),
                      Container(
                        padding: EdgeInsets.only(
                          right: 8,
                        ),
                        height: SizeConfig.heightMultiplier * 10,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: toolboxTrainingReviewerController
                              .makerMakerUser.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 0, right: 20),
                              leading: CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage(
                                    "$baseUrl${toolboxTrainingReviewerController.makerMakerUser[index].profilePhoto}"),
                              ),
                              title: AppTextWidget(
                                text: toolboxTrainingReviewerController
                                    .makerMakerUser[index].firstName
                                    .toString(),
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                              ),
                              subtitle: AppTextWidget(
                                text: toolboxTrainingReviewerController
                                    .makerMakerUser[index].designation
                                    .toString(),
                                fontSize: AppTextSize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryText,
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: SizeConfig.widthMultiplier * 100,
                        height: 1.5,
                        color: AppColors.searchfeildcolor,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
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
                        enabled:
                            !toolboxTrainingReviewerController.userFound.value,
                        controller: toolboxTrainingReviewerController
                            .reviewerController,

                        hintText: 'Comments',
                        // focusNode: newWorkPermitController.dow,
                        // onFieldSubmitted: (_) {
                        //   newWorkPermitController.dow.unfocus();
                        // },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a comment';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          Row(
                            children: [
                              AppTextWidget(
                                text: "Reviewer Signature",
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(40, 40, 40, 0.941),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 20, bottom: 20),
                                  height: 305,
                                  decoration: BoxDecoration(
                                    color: AppColors.textfeildcolor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      toolboxTrainingReviewerController
                                              .userFound.value
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                toolboxTrainingReviewerController
                                                    .clearSafetyattestationSignature();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child: Image.asset(
                                                      'assets/icons/reload.png',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  AppTextWidget(
                                                    text: 'Clear',
                                                    fontSize: AppTextSize
                                                        .textSizeSmallm,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.primaryText,
                                                  ),
                                                ],
                                              ),
                                            ),
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier * 4,
                                      ),
                                      Obx(() {
                                        if (toolboxTrainingReviewerController
                                            .userFound.value) {
                                          // Show saved signature image
                                          return toolboxTrainingReviewerController
                                                  .savedSignatureUrlfetch
                                                  .value
                                                  .isNotEmpty
                                              ? SizedBox(
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      25,
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      80,
                                                  child: Image.network(
                                                    "$baseUrl${toolboxTrainingReviewerController.savedSignatureUrlfetch.value}",
                                                    fit: BoxFit.contain,
                                                  ),
                                                )
                                              : const Text(
                                                  "No signature available");
                                        } else {
                                          // Show signature pad
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Signature(
                                              height: 206,
                                              controller:
                                                  toolboxTrainingReviewerController
                                                      .signatureattestationController,
                                              backgroundColor: Colors.white,
                                            ),
                                          );
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => toolboxTrainingReviewerController
                                  .signatureattestationError.value.isNotEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        toolboxTrainingReviewerController
                                            .signatureattestationError.value,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 174, 75, 68),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox()),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      AppTextWidget(
                          text: 'Reviewer',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText),
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
                          itemCount: toolboxTrainingReviewerController
                              .reviewerMakerUser.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 0, right: 20),
                              leading: CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage(
                                    "$baseUrl${toolboxTrainingReviewerController.reviewerMakerUser[index].profilePhoto}"),
                              ),
                              title: AppTextWidget(
                                text: toolboxTrainingReviewerController
                                    .reviewerMakerUser[index].firstName
                                    .toString(),
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                              ),
                              subtitle: AppTextWidget(
                                text: toolboxTrainingReviewerController
                                    .reviewerMakerUser[index].designation
                                    .toString(),
                                fontSize: AppTextSize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryText,
                              ),
                            );
                          },
                        ),
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
                        text: toolboxTrainingReviewerController
                                    // ignore: unnecessary_null_comparison
                                    .safetyToolboxReviwerTraining[0]
                                    // ignore: unnecessary_null_comparison
                                    .createdAt !=
                                null
                            ? DateFormat('dd-MM-yyyy hh:mm a').format(
                                DateTime.parse(toolboxTrainingReviewerController
                                    .safetyToolboxReviwerTraining[0].createdAt
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: Obx(
            () => AppElevatedButton(
                text: toolboxTrainingReviewerController.userFound.value
                    ? 'Close'
                    : 'Submit',
                onPressed: () async {
                  if (toolboxTrainingReviewerController.userFound.value) {
                    Get.back();
                  } else {
                    if (formKey.currentState!.validate()) {
                      await toolboxTrainingReviewerController
                          .saveSafetyattestationSignature();

                      if (toolboxTrainingReviewerController
                          .signatureattestationController.isEmpty) {
                        toolboxTrainingReviewerController
                            .signatureattestationError
                            .value = "Please fill in the signature.";
                        return;
                      }
                      if (toolboxTrainingReviewerController
                              .signatureattestationController.isNotEmpty &&
                          toolboxTrainingReviewerController
                              .reviewerController.text.isNotEmpty) {}
                      // ignore: use_build_context_synchronously
                      showConfirmationDialogClosed(context);
                      //   Get.to(WorkPermitPrecautionScreen());
                    }
                  }
                }),
          ),
        ),
      ),
    );
  }

  void showConfirmationDialogClosed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
              text: 'Are you sure you want to Check ToolBox training?',
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
                    await toolboxTrainingReviewerController
                        .safetySaveReviewerComment(context, toolBox);
                    if (toolboxTrainingReviewerController.apiStatus == true) {
                      Get.to(() => ToolboxReviewerClosed(
                            userId: userId,
                            projectId: projectId,
                            tbtID: toolBox,
                          ));
                    }

                    //      Get.to(WorkSubmitClosedScreen());
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
}
