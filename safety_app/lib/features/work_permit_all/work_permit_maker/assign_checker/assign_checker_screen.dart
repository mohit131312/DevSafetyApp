import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/work_permit_all/work_permit_maker/assign_checker/assign_checker_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AssignCheckerScreen extends StatelessWidget {
  AssignCheckerScreen({super.key});

  final AssignCheckerController assignCheckerController = Get.find();
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
                text: 'Select Checkers',
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
                            assignCheckerController.assigneeDataController,
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
                          assignCheckerController
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
                        assignCheckerController.filteredassigneeData;

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
                                      groupValue: assignCheckerController
                                              .selectedassigneeDataIds.isEmpty
                                          ? null
                                          : assignCheckerController
                                              .selectedassigneeDataIds.first,
                                      onChanged: (int? value) {
                                        if (value != null) {
                                          assignCheckerController
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
                  assignCheckerController.addassigneeData();
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
