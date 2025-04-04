import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/labour_details/labour_details_controller.dart';
import 'package:flutter_app/features/labour_details/labour_details_screen.dart';
import 'package:flutter_app/features/project_labour/project_labour_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class ProjectLabourScreen extends StatelessWidget {
  final String selectedproject;
  final int projectId;
  ProjectLabourScreen({
    super.key,
    required this.selectedproject,
    required this.projectId,
  });
  final LabourDetailsController labourDetailsController =
      Get.put(LabourDetailsController());

  final ProjectLabourController projectLabourController =
      Get.put(ProjectLabourController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            scrolledUnderElevation: 0.0, // This will fix the problem

            elevation: 0,
            backgroundColor: AppColors.buttoncolor,
            centerTitle: true,
            toolbarHeight: SizeConfig.heightMultiplier * 10,
            title: Padding(
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
              child: AppTextWidget(
                text: AppTexts.projectlabour,
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
                child: Image.asset(
                  "assets/icons/frame_icon.png",
                  height: SizeConfig.imageSizeMultiplier * 6,
                  width: SizeConfig.imageSizeMultiplier * 6,
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 4,
          vertical: SizeConfig.heightMultiplier * 2,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 6.4,
                  width: SizeConfig.widthMultiplier * 92,
                  child: AppTextFormfeild(
                    controller: projectLabourController.searchController,
                    hintText: 'Search By Name..',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/icons/Search.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    onChanged: (value) {
                      projectLabourController.updateSearchQuery(value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 1,
            ),
            Obx(
              () {
                final filteredList = projectLabourController.filteredLabours;

                return Expanded(
                  child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final labour = filteredList[index];

                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomLoadingPopup());
                                await labourDetailsController
                                    .getLabourDetailsAll(
                                        labour.labourId, projectId);
                                Navigator.pop(context);
                                Get.to(LabourDetailsScreen());
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 22,
                                  backgroundImage: NetworkImage(
                                      "$baseUrl${labour.labourImageUrl}"),
                                ),
                                title: AppTextWidget(
                                  text: labour.labourName,
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: selectedproject.toString(),
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                    AppTextWidget(
                                      text: labour.contactNumber.toString(),
                                      fontSize: AppTextSize.textSizeExtraSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: SizeConfig.imageSizeMultiplier * 6.67,
                                  height: SizeConfig.imageSizeMultiplier * 6.67,
                                  child: Image.asset(
                                      "assets/icons/forwardarrowblack.png"),
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.textfeildcolor,
                              thickness: 1.5,
                              height: 2,
                            )
                          ],
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: SizedBox(
      //   width: SizeConfig.widthMultiplier * 50,
      //   height: SizeConfig.heightMultiplier * 6.5,
      //   child: FloatingActionButton(
      //     onPressed: () {},
      //     backgroundColor: AppColors.buttoncolor,
      //     elevation: 0,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Icon(
      //           Icons.add,
      //           size: 26,
      //           color: AppColors.primary,
      //         ),
      //         SizedBox(
      //           width: SizeConfig.widthMultiplier * 1,
      //         ),
      //         AppTextWidget(
      //           text: "Add Labour",
      //           fontSize: AppTextSize.textSizeMedium,
      //           fontWeight: FontWeight.w400,
      //           color: AppColors.primary,
      //         )
      //       ],
      //     ),
      //  ),
      //  ),
    );
  }
}
