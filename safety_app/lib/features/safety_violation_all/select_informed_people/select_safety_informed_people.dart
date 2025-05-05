import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/safety_violation_all/select_informed_people/select_safety_informed_people_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SelectSafetyInformedPeople extends StatelessWidget {
  SelectSafetyInformedPeople({super.key});

  final SelectSafetyInformedPeopleController
      selectSafetyInformedPeopleController = Get.find();

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
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
              text: 'Select Informed Persons',
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
          child: SizedBox(
            height: SizeConfig.heightMultiplier * 70,
            child: Column(
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
                        controller: selectSafetyInformedPeopleController
                            .informedController,
                        hintText: 'Search By  Name..',
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
                          selectSafetyInformedPeopleController
                              .updateSearchAssigneeQuery(value);
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
                        selectSafetyInformedPeopleController.filteredAssignee;

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final assignee = filteredList[index];

                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 0, right: 20),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                    scale: 1.1,
                                    child: Obx(
                                      () => Checkbox(
                                        side: BorderSide(
                                            color: AppColors.searchfeild,
                                            width: 1),
                                        value:
                                            selectSafetyInformedPeopleController
                                                .selectedAssigneeIds
                                                .contains(assignee.id),
                                        onChanged: (value) {
                                          selectSafetyInformedPeopleController
                                              .toggleAssigneeSelection(
                                                  assignee.id);
                                        },
                                        activeColor: AppColors.thirdText,
                                      ),
                                    )),
                                // CircleAvatar(
                                //   radius: 22,
                                //   backgroundImage: NetworkImage(
                                //       "$baseUrl${assignee.profilePhoto}"),
                                // ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Colors
                                          .grey.shade200, // Fallback color
                                      child: ClipOval(
                                        child: Image.network(
                                          "$baseUrl${assignee.profilePhoto}",
                                          fit: BoxFit.cover,
                                          width: 56, // Diameter = radius * 2
                                          height: 56,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child:
                                                    CircularProgressIndicator(
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
                              ],
                            ),
                            title: AppTextWidget(
                              text: assignee.firstName.toString(),
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                            subtitle: AppTextWidget(
                              text: assignee.designation.toString(),
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
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: AppElevatedButton(
            text: "Add",
            onPressed: () {
              selectSafetyInformedPeopleController.addAsgineeData();
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
