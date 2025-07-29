import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/home/location_controller.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_maker/tool_maker_closed.dart';
import 'package:flutter_app/features/toolbox_training_all/toolbox_training/toolbox_training_maker/toolbox_training_maker_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

class ToolboxTrainingMakerScreen extends StatelessWidget {
  final int userId;
  final int projectId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int toolBox;
  final String uniqueId;

  ToolboxTrainingMakerScreen(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userImg,
      required this.userDesg,
      required this.projectId,
      required this.toolBox,
      required this.uniqueId});

  //-----------------------------------------------------------------------
  final ToolboxTrainingMakerController toolboxTrainingMakerController =
      Get.put(ToolboxTrainingMakerController());
  final LocationController locationController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
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
                        height: SizeConfig.heightMultiplier * 0.8,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: "ToolBox Unique ID :  ",
                            fontSize: AppTextSize.textSizeSmallm,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                          AppTextWidget(
                            text: toolboxTrainingMakerController
                                .safetyToolboxMakerTraining[0].toolboxUniqueId
                                .toString(),
                            fontSize: AppTextSize.textSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText,
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //---------------------------------------------------------------------

                //-----------------------------------------------------------------
                Obx(() => toolboxTrainingMakerController.istoolboxExpanded.value
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
                                        toolboxTrainingMakerController
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
                                            text: toolboxTrainingMakerController
                                                        .safetyToolboxMakerTraining
                                                        .isNotEmpty &&
                                                    toolboxTrainingMakerController
                                                            .safetyToolboxMakerTraining[
                                                                0]
                                                            .nameOfTbTraining !=
                                                        null &&
                                                    toolboxTrainingMakerController
                                                        .safetyToolboxMakerTraining[
                                                            0]
                                                        .nameOfTbTraining!
                                                        .isNotEmpty
                                                ? toolboxTrainingMakerController
                                                    .safetyToolboxMakerTraining[
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
                                            text: toolboxTrainingMakerController
                                                .toolboxMakerCategoryList[0]
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
                                          height:
                                              SizeConfig.heightMultiplier * 1,
                                        ),
                                        AppTextWidget(
                                            text: toolboxTrainingMakerController
                                                        .safetyToolboxMakerTraining
                                                        .isNotEmpty &&
                                                    toolboxTrainingMakerController
                                                            .safetyToolboxMakerTraining[
                                                                0]
                                                            .details !=
                                                        null &&
                                                    toolboxTrainingMakerController
                                                        .safetyToolboxMakerTraining[
                                                            0]
                                                        .details!
                                                        .isNotEmpty
                                                ? toolboxTrainingMakerController
                                                    .safetyToolboxMakerTraining[
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
                                                            toolboxTrainingMakerController
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
                                                                      if (toolboxTrainingMakerController
                                                                              .tbtMakerAddedPhotos
                                                                              .isNotEmpty &&
                                                                          toolboxTrainingMakerController
                                                                                  .tbtMakerAddedPhotos[index]
                                                                                  // ignore: unnecessary_null_comparison
                                                                                  .photoPath !=
                                                                              null &&
                                                                          toolboxTrainingMakerController
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
                                                                                    "$baseUrl${toolboxTrainingMakerController.tbtMakerAddedPhotos[index].photoPath}",
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
                                                                        child: (toolboxTrainingMakerController
                                                                                .tbtMakerAddedPhotos[index]
                                                                                // ignore: unnecessary_null_comparison
                                                                                .photoPath!
                                                                                .isNotEmpty
                                                                            // ignore: unnecessary_null_comparison
                                                                            )
                                                                            ? Image.network(
                                                                                "$baseUrl${toolboxTrainingMakerController.tbtMakerAddedPhotos[index]
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
                                      toolboxTrainingMakerController
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
                  () => toolboxTrainingMakerController.istraineedetails.value
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
                                          toolboxTrainingMakerController
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
                                        height: toolboxTrainingMakerController
                                                    .traineeMakerLaboursList
                                                    .length >
                                                1
                                            ? SizeConfig.heightMultiplier * 24
                                            : SizeConfig.heightMultiplier * 11,
                                        child: Scrollbar(
                                          radius: Radius.circular(10),
                                          thickness: 4,
                                          child: ListView.builder(
                                            primary: false,
                                            // controller:
                                            //     toolboxTDetailsController
                                            //         .scrollLabourController,
                                            itemCount:
                                                toolboxTrainingMakerController
                                                    .traineeMakerLaboursList
                                                    .length,

                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                contentPadding: EdgeInsets.only(
                                                    left: 0, right: 20),
                                                leading: CircleAvatar(
                                                  radius: 22,
                                                  backgroundImage: NetworkImage(
                                                      "$baseUrl${toolboxTrainingMakerController.traineeMakerLaboursList[index].userPhoto}"),
                                                ),
                                                title: AppTextWidget(
                                                  text: toolboxTrainingMakerController
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
                                        toolboxTrainingMakerController
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
                  () => toolboxTrainingMakerController.isprecaution.value
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
                                          toolboxTrainingMakerController
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
                                            toolboxTrainingMakerController
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
                                                      text: toolboxTrainingMakerController
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
                                        toolboxTrainingMakerController
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
                          text: 'Checker',
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
                          itemCount: toolboxTrainingMakerController
                              .reviewerMakerUser.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 0, right: 20),
                              leading: CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage(
                                    "$baseUrl${toolboxTrainingMakerController.reviewerMakerUser[index].profilePhoto}"),
                              ),
                              title: AppTextWidget(
                                text: toolboxTrainingMakerController
                                    .reviewerMakerUser[index].firstName
                                    .toString(),
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                              ),
                              subtitle: AppTextWidget(
                                text: toolboxTrainingMakerController
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
                      Row(
                        children: [
                          AppTextWidget(
                            text: 'Checker Comments',
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
                        controller: toolboxTrainingMakerController
                            .reviewerMakerController,

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
                        fillColor: AppColors.textfeildcolor,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Container(
                        width: SizeConfig.widthMultiplier * 100,
                        height: 1.5,
                        color: AppColors.searchfeildcolor,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      AppTextWidget(
                          text: 'Doer',
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText),

                      Container(
                        padding: EdgeInsets.only(
                          right: 8,
                        ),
                        height: SizeConfig.heightMultiplier * 10,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: toolboxTrainingMakerController
                              .makerMakerUser.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 0, right: 20),
                              leading: CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage(
                                    "$baseUrl${toolboxTrainingMakerController.makerMakerUser[index].profilePhoto}"),
                              ),
                              title: AppTextWidget(
                                text: toolboxTrainingMakerController
                                    .makerMakerUser[index].firstName
                                    .toString(),
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                              ),
                              subtitle: AppTextWidget(
                                text: toolboxTrainingMakerController
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

                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      Column(
                        children: [
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
                            enabled:
                                !toolboxTrainingMakerController.userFound.value,
                            controller: toolboxTrainingMakerController
                                .makerMakerController,
                            hintText: 'Comments',
                            focusNode:
                                toolboxTrainingMakerController.makerFocusNode,
                            onFieldSubmitted: (_) {
                              toolboxTrainingMakerController.makerFocusNode
                                  .unfocus();
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a comment';
                              }
                              return null;
                            },
                            fillColor:
                                toolboxTrainingMakerController.userFound.value
                                    ? AppColors.textfeildcolor
                                    : Colors.white,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          Row(
                            children: [
                              AppTextWidget(
                                text: "Doer Signature",
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.textfeildcolor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      toolboxTrainingMakerController
                                              .userFound.value
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                toolboxTrainingMakerController
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
                                        height: SizeConfig.heightMultiplier * 2,
                                      ),
                                      Obx(() {
                                        if (toolboxTrainingMakerController
                                            .userFound.value) {
                                          // Show saved signature image
                                          return toolboxTrainingMakerController
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
                                                    "$baseUrl${toolboxTrainingMakerController.savedSignatureUrlfetch.value}",
                                                    fit: BoxFit.contain,
                                                  ),
                                                )
                                              : const Text(
                                                  "No signature available");
                                        } else {
                                          // Show signature pad
                                          return Listener(
                                            key: toolboxTrainingMakerController
                                                .signkey,
                                            onPointerDown: (_) {
                                              Future.delayed(
                                                  Duration(milliseconds: 50),
                                                  () {
                                                if (toolboxTrainingMakerController
                                                    .signatureattestationController
                                                    .isNotEmpty) {
                                                  toolboxTrainingMakerController
                                                      .signatureattestationError
                                                      .value = '';
                                                }
                                              });
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Signature(
                                                height: 206,
                                                controller:
                                                    toolboxTrainingMakerController
                                                        .signatureattestationController,
                                                backgroundColor: Colors.white,
                                              ),
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
                          Obx(() => toolboxTrainingMakerController
                                  .signatureattestationError.value.isNotEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        toolboxTrainingMakerController
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
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: SizeConfig.widthMultiplier * 4,
                      //     vertical: SizeConfig.heightMultiplier * 3,
                      //   ),
                      //   width: SizeConfig.widthMultiplier * 100,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Container(
                      //             width: SizeConfig.imageSizeMultiplier * 15,
                      //             height: SizeConfig.imageSizeMultiplier * 15,
                      //             child: Image.network(
                      //               "$baseUrl${workPermitPreviewMakerController.makerInformation[0].photo}",
                      //               fit: BoxFit.contain,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: SizeConfig.widthMultiplier * 3,
                      //           ),
                      //           Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               AppTextWidget(
                      //                   text: workPermitPreviewMakerController
                      //                           .makerInformation.isNotEmpty
                      //                       ? '${workPermitPreviewMakerController.makerInformation[0].firstName} ${workPermitPreviewMakerController.makerInformation[0].lastName}'
                      //                       : 'No Name',
                      //                   fontSize: AppTextSize.textSizeSmallm,
                      //                   fontWeight: FontWeight.w600,
                      //                   color: AppColors.primaryText),
                      //               AppTextWidget(
                      //                   text: workPermitPreviewMakerController
                      //                           .makerInformation.isNotEmpty
                      //                       ? '${workPermitPreviewMakerController.makerInformation[0].designation}'
                      //                       : 'No Name',
                      //                   fontSize: AppTextSize.textSizeSmall,
                      //                   fontWeight: FontWeight.w400,
                      //                   color: AppColors.searchfeild),
                      //               SizedBox(
                      //                 width: SizeConfig.widthMultiplier * 1,
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
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
                        text: toolboxTrainingMakerController
                                    // ignore: unnecessary_null_comparison
                                    .safetyToolboxMakerTraining[0]
                                    // ignore: unnecessary_null_comparison
                                    .createdAt !=
                                null
                            ? DateFormat('dd-MM-yyyy hh:mm a').format(
                                DateTime.parse(toolboxTrainingMakerController
                                    .safetyToolboxMakerTraining[0].createdAt
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
                text: toolboxTrainingMakerController.userFound.value
                    ? 'Close'
                    : 'Close the Toolbox Training',
                onPressed: () async {
                  validateAndFocusFirstInvalidField();
                  if (toolboxTrainingMakerController.userFound.value) {
                    Get.back();
                  } else {
                    if (toolboxTrainingMakerController
                        .signatureattestationController.isEmpty) {
                      toolboxTrainingMakerController.signatureattestationError
                          .value = "Please fill in the signature.";
                    }
                    if (formKey.currentState!.validate()) {
                      await toolboxTrainingMakerController
                          .saveSafetyattestationSignature();

                      if (toolboxTrainingMakerController
                          .signatureattestationController.isEmpty) {
                        toolboxTrainingMakerController.signatureattestationError
                            .value = "Please fill in the signature.";
                        return;
                      }
                      if (toolboxTrainingMakerController
                              .signatureattestationController.isNotEmpty &&
                          toolboxTrainingMakerController
                              .makerMakerController.text.isNotEmpty) {
                        // ignore: use_build_context_synchronously
                        if (await CheckInternet.checkInternet()) {
                          showConfirmationDialogClosed(context);
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
                      }
                      //   Get.to(WorkPermitPrecautionScreen());
                    }
                  }
                }),
          ),
        ),
      ),
    );
  }

  void scrollToWidget(GlobalKey key) {
    final context = key.currentContext;
    if (context != null && context.mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.2,
        );
      });
    }
  }

  void validateAndFocusFirstInvalidField() {
    if (toolboxTrainingMakerController.makerMakerController.text
        .trim()
        .isEmpty) {
      toolboxTrainingMakerController.makerFocusNode.requestFocus();
      return;
    }
    if (toolboxTrainingMakerController.signatureattestationController.isEmpty) {
      scrollToWidget(toolboxTrainingMakerController.signkey);
      return;
    }
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
              text: 'Are you sure you want to close ToolBox training?',
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
                    await toolboxTrainingMakerController.safetySaveMakerComment(
                        context, toolBox);
                    if (toolboxTrainingMakerController.apiStatus == true) {
                      Get.to(() => ToolMakerClosed(
                            userId: userId,
                            projectId: projectId,
                            tbtID: toolBox,
                            uniqueId: uniqueId,
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
