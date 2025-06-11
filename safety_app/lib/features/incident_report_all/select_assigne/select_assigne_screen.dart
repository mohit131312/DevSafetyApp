import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/incident_report_all/select_assigne/select_assigne_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SelectAssigneScreen extends StatelessWidget {
  SelectAssigneScreen({super.key});

  final SelectAssigneController selectAssigneController = Get.find();

  final TextEditingController searchController = TextEditingController();
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
              text: 'Select Incident Assignee',
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
        body: Column(
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
                    controller: selectAssigneController.assigneeDataController,
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
                      selectAssigneController
                          .updateSearchassigneeDataQuery(value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 1.5,
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbVisibility: WidgetStateProperty.all(true),
                  thickness: WidgetStateProperty.all(3),
                  radius: const Radius.circular(8),
                  trackVisibility: WidgetStateProperty.all(true),
                  thumbColor: WidgetStateProperty.all(AppColors.buttoncolor),
                  trackColor: WidgetStateProperty.all(
                      const Color.fromARGB(26, 101, 99, 99)),
                  trackBorderColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Scrollbar(
                  interactive: true,
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier * 60,
                    child: Obx(
                      () {
                        final filteredList =
                            selectAssigneController.filteredassigneeData;

                        return ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final assigneeData = filteredList[index];

                              return ListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 0, right: 20),
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Obx(
                                        () => Radio<int>(
                                          value: assigneeData.id,
                                          groupValue: selectAssigneController
                                                  .selectedassigneeDataIds
                                                  .isEmpty
                                              ? null
                                              : selectAssigneController
                                                  .selectedassigneeDataIds
                                                  .first,
                                          onChanged: (int? value) {
                                            if (value != null) {
                                              selectAssigneController
                                                  .toggleSingleAssigneeSelection(
                                                      value);
                                            }
                                          },
                                          activeColor: AppColors.buttoncolor,
                                        ),
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   radius: 22,
                                    //   backgroundImage: NetworkImage(
                                    //       "$baseUrl${assigneeData.profilePhoto}"),
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
                                              "$baseUrl${assigneeData.profilePhoto}",
                                              fit: BoxFit.cover,
                                              width:
                                                  56, // Diameter = radius * 2
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
                                                      color:
                                                          AppColors.buttoncolor,
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
                                      selectAssigneController
                                          .makeCall(assigneeData.mobileNumber!);
                                    },
                                    child: SizedBox(
                                      height:
                                          SizeConfig.imageSizeMultiplier * 10,
                                      width:
                                          SizeConfig.imageSizeMultiplier * 10,
                                      child: Image.asset(
                                          'assets/icons/phone_orange.png'),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: AppElevatedButton(
            text: "Add",
            onPressed: () {
              selectAssigneController.addassigneeData();
              // Get.to(SafetyViolationDetails());
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
