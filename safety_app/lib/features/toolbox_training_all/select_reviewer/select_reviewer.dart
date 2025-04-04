import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/toolbox_training_all/select_reviewer/select_reviewer_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SelectReviewer extends StatelessWidget {
  SelectReviewer({super.key});

  final SelectReviewerController selectReviewerController =
      Get.put(SelectReviewerController());
  final TextEditingController searchController = TextEditingController();

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
            scrolledUnderElevation: 0.0,
            elevation: 0,
            backgroundColor: AppColors.buttoncolor,
            foregroundColor: AppColors.buttoncolor,
            centerTitle: true,
            toolbarHeight: SizeConfig.heightMultiplier * 10,
            title: Padding(
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
              child: AppTextWidget(
                text: 'Select Reviewer',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 5.8,
                      width: SizeConfig.widthMultiplier * 92,
                      child: AppTextFormfeild(
                        controller:
                            selectReviewerController.assigneeDataController,
                        hintText: 'Search By Assignee Name..',
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
                          selectReviewerController
                              .updateSearchassigneeDataQuery(value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Obx(
                  () {
                    final filteredList =
                        selectReviewerController.filteredassigneeData;

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final assigneeData = filteredList[index];

                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 0, right: 20),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 1.1,
                                  child: Obx(
                                    () => Radio<int>(
                                      value: assigneeData.id,
                                      groupValue: selectReviewerController
                                              .selectedassigneeDataIds.isEmpty
                                          ? null
                                          : selectReviewerController
                                              .selectedassigneeDataIds.first,
                                      onChanged: (int? value) {
                                        if (value != null) {
                                          selectReviewerController
                                              .toggleSingleAssigneeSelection(
                                                  value);
                                        }
                                      },
                                      activeColor: AppColors.thirdText,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 22,
                                  backgroundImage: NetworkImage(
                                      "$baseUrl${assigneeData.profilePhoto}"),
                                ),
                              ],
                            ),
                            title: AppTextWidget(
                              text: assigneeData.firstName.toString(),
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            subtitle: AppTextWidget(
                              text: assigneeData.designation.toString(),
                              fontSize: AppTextSize.textSizeSmalle,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryText,
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  selectReviewerController.makeCall(
                                      assigneeData.mobileNumber ?? '');
                                },
                                child: SizedBox(
                                  height: SizeConfig.imageSizeMultiplier * 10,
                                  width: SizeConfig.imageSizeMultiplier * 10,
                                  child: Image.asset(
                                      'assets/icons/phone_orange.png'),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 2,
              ),
              child: AppElevatedButton(
                text: "Add",
                onPressed: () {
                  selectReviewerController.addassigneeData();
                  Get.back();
                },
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 4),
          ],
        ),
      ),
    );
  }
}
