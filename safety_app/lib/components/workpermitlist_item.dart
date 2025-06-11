import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/home/home_screen_controller.dart';
import 'package:flutter_app/features/home/work_permit_details/work_permit_details_controller.dart';
import 'package:flutter_app/features/home/work_permit_details/work_permit_details_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/check_internet.dart';
import 'package:flutter_app/utils/validation_popup.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkPermitListItem extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  WorkPermitListItem({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final WorkPermitDetailsController workPermitAllController =
      Get.put(WorkPermitDetailsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final filteredList = homeScreenController.workPermitListing;
      return SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            final work = filteredList[index];

            return GestureDetector(
              onTap: () async {
                if (await CheckInternet.checkInternet()) {
                  workPermitAllController.resetData();

                  await workPermitAllController.getWorkPermitAllDetails(
                      projectId, userId, 1, work.id);
                  Get.to(WorkPermitDetailsScreen(
                    userId: userId,
                    userName: userName,
                    userImg: userImg,
                    userDesg: userDesg,
                    projectId: projectId,
                    wpId: work.id,
                  ));
                } else {
                  await showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) {
                      return CustomValidationPopup(
                          message: "Please check your internet connection.");
                    },
                  );
                }
              },
              child: Column(
                children: [
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: work.uniqueId!,
                          fontSize: AppTextSize.textSizeSmalle,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                        AppTextWidget(
                          text: work.nameOfWorkpermit,
                          fontSize: AppTextSize.textSizeSmalle,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (work.description != null)
                          AppTextWidget(
                            text: work.description!,
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                        AppTextWidget(
                          text: (work.createdAt != null)
                              ? DateFormat('dd MMMM yyyy').format(
                                  work.createdAt is String
                                      ? DateTime.parse(work.createdAt as String)
                                      : work.createdAt ?? DateTime.now(),
                                )
                              : '',
                          fontSize: AppTextSize.textSizeExtraSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                      ],
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextWidget(
                            text: work.status == "0"
                                ? 'Open'
                                : work.status == "1"
                                    ? 'Accepted'
                                    : work.status == "2"
                                        ? 'Rejected'
                                        : work.status == "3"
                                            ? 'Closed'
                                            : 'Unknown',
                            fontSize: AppTextSize.textSizeExtraSmall,
                            fontWeight: FontWeight.w500,
                            color: work.status == "0"
                                ? AppColors.buttoncolor // Open → Orange
                                : work.status == "1"
                                    ? Colors.green // Accepted → Green
                                    : work.status == "2"
                                        ? Colors.red // Rejected → Red
                                        : work.status == "3"
                                            ? Colors.grey // Closed → Grey
                                            : Colors
                                                .black, // Fallback for unknown statuses
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.textfeildcolor,
                    thickness: 1.5,
                    height: 2,
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
