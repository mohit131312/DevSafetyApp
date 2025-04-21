import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/Labour_add/add_labour_controller.dart';
import 'package:flutter_app/features/Labour_add/add_labour_screen.dart';
import 'package:flutter_app/features/contractor/add_contractor/add_contractor.dart';
import 'package:flutter_app/features/contractor/add_contractor/add_contractor_controller.dart';
import 'package:flutter_app/features/induction_listing/contractor_listing/contractor_listing_controller.dart';
import 'package:flutter_app/features/induction_listing/contractor_listing/contractor_listing_screen.dart';
import 'package:flutter_app/features/induction_listing/staff_listing/staff_listing_controller.dart';
import 'package:flutter_app/features/induction_listing/staff_listing/staff_listing_screen.dart';
import 'package:flutter_app/features/induction_training/induction_training_controller.dart';
import 'package:flutter_app/features/induction_listing/labour_listing/labour_listing_screen.dart';
import 'package:flutter_app/features/induction_listing/labour_listing/labour_listing_controller.dart';
import 'package:flutter_app/features/staff/staff_add/add_staff_controller.dart';
import 'package:flutter_app/features/staff/staff_add/add_staff_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class InductionTrainingScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userImg;
  final String userDesg;
  final int projectId;

  InductionTrainingScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
    required this.projectId,
  });
  final InductionTrainingController inductionTrainingController = Get.find();
  final LabourListingController labourListingController =
      Get.put(LabourListingController());
  final StaffListingController staffListingController =
      Get.put(StaffListingController());
  final ContractorListingController contractorListingController =
      Get.put(ContractorListingController());
  String getUserTypeLabel(dynamic userType) {
    int? userTypeInt;

    if (userType is int) {
      userTypeInt = userType;
    } else if (userType is String) {
      userTypeInt = int.tryParse(userType);
    }

    switch (userTypeInt) {
      case 1:
        return "Labour";
      case 2:
        return "Contractor";
      case 3:
        return "Staff";
      default:
        return "Unknown";
    }
  }

  String getUserTypeImage(String userType) {
    switch (userType.toLowerCase()) {
      case "1":
        return "assets/icons/Labours.png"; // Labour icon
      case "2":
        return "assets/icons/Contractor.png"; // Contractor icon
      case "3":
        return "assets/icons/User_orange.png"; // Staff icon

      default:
        return "assets/icons/Labours.png"; // Default icon
    }
  }

  final RxBool isFabExpanded = true.obs;

  void _showFabMenu(
      BuildContext context, int userId, String userName, int projectId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              isFabExpanded.value =
                  !isFabExpanded.value; // Ensure FAB state is updated
              return true; // Allow the dialog to close
            },
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    isFabExpanded.value = !isFabExpanded.value;

                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 100,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: SizeConfig.widthMultiplier * 90,
                      padding:
                          const EdgeInsets.only(top: 15, left: 6, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 4,
                              childAspectRatio: 1,
                            ),
                            itemCount: inductionTrainingController
                                .selectCatogery.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  if (inductionTrainingController
                                          .selectCatogery[index].id ==
                                      1) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CustomLoadingPopup());
                                    await inductionTrainingController
                                        .getInductionTrainingAdd(
                                            inductionTrainingController
                                                .selectCatogery[index].id);

                                    Navigator.pop(context);
                                    isFabExpanded.value = !isFabExpanded.value;

                                    Navigator.pop(context);

                                    if (logStatus == true) {
                                      final AddLabourController
                                          addLabourController =
                                          Get.put(AddLabourController());
                                      addLabourController
                                          .clearUserFieldsFinal();
                                      Get.to(AddLabourScreen(
                                        categoryId: inductionTrainingController
                                            .selectCatogery[index].id,
                                        userId: userId,
                                        userName: userName,
                                        userImg: userImg,
                                        userDesg: userDesg,
                                        projectId: projectId,
                                      ));

                                      print("Navigating to AddLabour with:");
                                      print("User ID: $userId");
                                      print("User Name: $userName");
                                      print("Project ID: $projectId");
                                    } else {
                                      logout();
                                    }
                                    print(
                                        "Tapped on item 1-----------AddLabourScreen");
                                  } else if (inductionTrainingController
                                          .selectCatogery[index].id ==
                                      2) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CustomLoadingPopup());
                                    await inductionTrainingController
                                        .getInductionTrainingAdd(
                                            inductionTrainingController
                                                .selectCatogery[index].id);

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    isFabExpanded.value = !isFabExpanded.value;
                                    if (logStatus == true) {
                                      final AddContractorController
                                          addContractorController =
                                          Get.put(AddContractorController());
                                      addContractorController
                                          .clearUserFieldsFinalContractor();
                                      Get.to(AddContractor(
                                        categoryId: inductionTrainingController
                                            .selectCatogery[index].id,
                                        userId: userId,
                                        userName: userName,
                                        userImg: userImg,
                                        userDesg: userDesg,
                                        projectId: projectId,
                                      ));

                                      print(
                                          "Navigating to AddContractor with:");
                                      print("User ID: $userId");
                                      print("User Name: $userName");
                                      print("Project ID: $projectId");
                                    }

                                    print(
                                        "Tapped on item 2----------------AddContractor");
                                  } else if (inductionTrainingController
                                          .selectCatogery[index].id ==
                                      3) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CustomLoadingPopup());
                                    await inductionTrainingController
                                        .getInductionTrainingAdd(
                                            inductionTrainingController
                                                .selectCatogery[index].id);

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    isFabExpanded.value = !isFabExpanded.value;

                                    if (logStatus == true) {
                                      final AddStaffController
                                          addStaffController =
                                          Get.put(AddStaffController());
                                      addStaffController
                                          .clearStaffUserFieldsFinal();

                                      Get.to(AddStaffScreen(
                                        categoryId: inductionTrainingController
                                            .selectCatogery[index].id,
                                        userId: userId,
                                        userName: userName,
                                        userImg: userImg,
                                        userDesg: userDesg,
                                        projectId: projectId,
                                      ));

                                      print(
                                          "Navigating to AddStaffScreen with:");
                                      print("User ID: $userId");
                                      print("User Name: $userName");
                                      print("Project ID: $projectId");
                                    }
                                    print(
                                        "Tapped on item 3--------AddStaffScreen");
                                  } else if (index == 3) {
                                  } else if (index == 4) {
                                    print("Tapped on item 2");
                                  } else {
                                    print("Tapped on item $index");
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.network(
                                      '$baseUrl2${inductionTrainingController.selectCatogery[index].iconPath}',
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(height: 6),
                                    Flexible(
                                      child: Text(
                                        inductionTrainingController
                                            .selectCatogery[index].categoryName,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: AppTextSize.textSizeSmalle,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                  text: AppTexts.inductiontraining,
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
                vertical: SizeConfig.heightMultiplier * 2,
              ),
              child: SizedBox(
                height: SizeConfig.heightMultiplier * 6.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 6.4,
                      width: SizeConfig.widthMultiplier * 92,
                      child: AppTextFormfeild(
                        controller:
                            inductionTrainingController.searchIndListController,
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
                          inductionTrainingController
                              .updateSearchIndListQuery(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: SizeConfig.heightMultiplier * 6,
              width: SizeConfig.widthMultiplier * 92,
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 0.8,
                horizontal: SizeConfig.widthMultiplier * 1.5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.textfeildcolor,
              ),
              child: TabBar(
                isScrollable: true,
                indicatorColor: AppColors.textfeildcolor,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.searchfeild,
                indicator: BoxDecoration(
                  color: AppColors.thirdText,
                  borderRadius: BorderRadius.circular(20),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,
                tabAlignment: TabAlignment.start,
                tabs: [
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 20,
                    child: const Tab(
                      text: AppTexts.all,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 20,
                    child: const Tab(
                      text: AppTexts.inductees,
                    ),
                  ),
                  SizedBox(
                    child: const Tab(
                      text: AppTexts.bulkInduction,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(
                    () {
                      final filteredList =
                          inductionTrainingController.filteredIndList;

                      return ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final ind = filteredList[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    log('${ind.userType}');
                                    if (ind.userType == '1') {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomLoadingPopup());
                                      await labourListingController
                                          .getInductionListing(
                                              ind.userId,
                                              ind.userType,
                                              ind.reasonOfVisit,
                                              ind.inductedById,
                                              ind.id,
                                              ind.projectId,
                                              ind.tradeId,
                                              ind.contractorCompanyId);

                                      Navigator.pop(context);
                                      if (labourListingController.statusApi) {
                                        Get.to(LabourListingScreen(
                                          userId: userId,
                                          userName: userName,
                                          userImg: userImg,
                                          userDesg: userDesg,
                                          projectId: projectId,
                                        ));
                                      }
                                    } else if (ind.userType == "2") {
                                      log('in user contractor ${ind.userType}');
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomLoadingPopup());
                                      await contractorListingController
                                          .getContractorInductionListing(
                                        ind.userId,
                                        ind.userType,
                                        ind.reasonOfVisit,
                                        ind.inductedById,
                                        ind.id,
                                        ind.projectId,
                                      );
                                      Navigator.pop(context);
                                      if (contractorListingController
                                          .statusApi) {
                                        Get.to(ContractorListingScreen(
                                          userId: userId,
                                          userName: userName,
                                          userImg: userImg,
                                          userDesg: userDesg,
                                          projectId: projectId,
                                        ));
                                      }
                                    } else if (ind.userType == "3") {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomLoadingPopup());
                                      await staffListingController
                                          .getStaffInductionListing(
                                        ind.userId,
                                        ind.userType,
                                        ind.reasonOfVisit,
                                        ind.inductedById,
                                        ind.id,
                                        ind.projectId,
                                      );

                                      Navigator.pop(context);
                                      if (staffListingController.statusApi) {
                                        Get.to(StaffListingScreen(
                                          userId: userId,
                                          userName: userName,
                                          userImg: userImg,
                                          userDesg: userDesg,
                                          projectId: projectId,
                                        ));
                                      }
                                    }
                                  },
                                  child: ListTile(
                                    leading: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 28,
                                          backgroundColor: Colors
                                              .grey.shade200, // Fallback color
                                          child: ClipOval(
                                            child: Image.network(
                                              "$baseUrl${ind.userPhoto}",
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
                                    title: SizedBox(
                                      width: SizeConfig.widthMultiplier * 60,
                                      child: AppTextWidget(
                                        text: (ind.inducteeName?.isNotEmpty ??
                                                false)
                                            ? ind.inducteeName!
                                            : "",
                                        fontSize: AppTextSize.textSizeSmall,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.widthMultiplier * 70,
                                          child: AppTextWidget(
                                            text: (ind.inductionId.isNotEmpty)
                                                ? ind.inductionId
                                                : "",
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.secondaryText,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.widthMultiplier * 60,
                                          child: AppTextWidget(
                                            text: (ind.createdAt != null)
                                                ? DateFormat('dd MMMM yyyy')
                                                    .format(ind.createdAt
                                                            is String
                                                        ? DateTime.parse(
                                                            ind.createdAt
                                                                as String)
                                                        : ind.createdAt ??
                                                            DateTime.now())
                                                : '',
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.secondaryText,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            237, 245, 225, 203),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 8,
                                            bottom: 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              getUserTypeImage(
                                                  ind.userType.toString()),
                                              height: SizeConfig
                                                      .imageSizeMultiplier *
                                                  4,
                                              width: SizeConfig
                                                      .imageSizeMultiplier *
                                                  4,
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      1,
                                            ),
                                            AppTextWidget(
                                              text: getUserTypeLabel(
                                                  ind.userType),
                                              fontSize: AppTextSize
                                                  .textSizeExtraSmall,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.buttoncolor,
                                            ),
                                          ],
                                        ),
                                      ),
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
                          });
                    },
                  ),
                  Center(child: Text('Second Tab Content')),
                  Center(child: Text('Third Tab Content')),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () => SizedBox(
            width: isFabExpanded.value
                ? SizeConfig.widthMultiplier * 36
                : SizeConfig.widthMultiplier * 14,
            height: isFabExpanded.value
                ? SizeConfig.heightMultiplier * 6
                : SizeConfig.heightMultiplier * 6,
            child: FloatingActionButton(
              onPressed: () {
                isFabExpanded.value = !isFabExpanded.value;

                _showFabMenu(context, userId, userName, projectId);
              },
              backgroundColor: AppColors.buttoncolor,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isFabExpanded.value
                      ? Icon(
                          Icons.add,
                          size: 26,
                          color: AppColors.primary,
                        )
                      : Icon(
                          Icons.close,
                          size: 26,
                          color: AppColors.primary,
                        ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 1,
                  ),
                  isFabExpanded.value
                      ? AppTextWidget(
                          text: "Add",
                          fontSize: AppTextSize.textSizeMedium,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        )
                      : AppTextWidget(
                          text: "",
                          fontSize: AppTextSize.textSizeMedium,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
