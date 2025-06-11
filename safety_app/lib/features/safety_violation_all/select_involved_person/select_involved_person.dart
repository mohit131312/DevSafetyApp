import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/safety_violation_all/safety_violation_details/safety_violation_details_controller.dart';
import 'package:flutter_app/features/safety_violation_all/select_involved_person/select_involved_person_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class SelectInvolvedPerson extends StatelessWidget {
  SelectInvolvedPerson({super.key});

  final SafetyViolationDetailsController safetyViolationDetailsController =
      Get.find();
  final SelectInvolvedPersonController selectInvolvedPersonController =
      Get.find();
  final ScrollController labourScrollController = ScrollController();
  final ScrollController staffScrollController = ScrollController();
  final ScrollController contractorScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
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
                text: 'Select Involved Persons',
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
              Container(
                width: SizeConfig.widthMultiplier * 95,
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 1,
                  horizontal: SizeConfig.widthMultiplier * 1,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.textfeildcolor,
                ),
                child: TabBar(
                  //     controller: selectInvolvedPersonController.tabController,
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
                  tabAlignment: TabAlignment.center,
                  tabs: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                      width: SizeConfig.widthMultiplier * 20,
                      child: Tab(
                        text: 'Labour',
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                      width: SizeConfig.widthMultiplier * 20,
                      child: const Tab(
                        text: 'Staff',
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                      child: const Tab(
                        text: 'Contractor',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 0.2,
              ),
              Expanded(
                child: PrimaryScrollController.none(
                  child: TabBarView(
                      //      controller: selectInvolvedPersonController.tabController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 5, top: 16),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: SizeConfig.heightMultiplier * 5.8,
                                    width: SizeConfig.widthMultiplier * 92,
                                    child: AppTextFormfeild(
                                      controller: selectInvolvedPersonController
                                          .searchController,
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
                                        selectInvolvedPersonController
                                            .updateSearchQuery(value);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1.5,
                            ),
                            Expanded(
                              child: ScrollbarTheme(
                                data: ScrollbarThemeData(
                                  thumbVisibility:
                                      WidgetStateProperty.all(true),
                                  thickness: WidgetStateProperty.all(3),
                                  radius: const Radius.circular(8),
                                  trackVisibility:
                                      WidgetStateProperty.all(true),
                                  thumbColor: WidgetStateProperty.all(
                                      AppColors.buttoncolor),
                                  trackColor: WidgetStateProperty.all(
                                      const Color.fromARGB(26, 101, 99, 99)),
                                  trackBorderColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Scrollbar(
                                  controller: labourScrollController,
                                  interactive: true,
                                  child: Obx(
                                    () {
                                      final filteredList =
                                          selectInvolvedPersonController
                                              .filteredLabours;

                                      return ListView.builder(
                                          controller: labourScrollController,
                                          itemCount: filteredList.length,
                                          itemBuilder: (context, index) {
                                            final labour = filteredList[index];

                                            return ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 0, right: 20),
                                              leading: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Transform.scale(
                                                      scale: 1.1,
                                                      child: Obx(
                                                        () => Checkbox(
                                                          side: BorderSide(
                                                              color: AppColors
                                                                  .searchfeild,
                                                              width: 1),
                                                          value: selectInvolvedPersonController
                                                              .selectedLabourIds
                                                              .contains(
                                                                  labour.id),
                                                          onChanged: (value) {
                                                            selectInvolvedPersonController
                                                                .toggleSelection(
                                                                    labour.id);
                                                          },
                                                          activeColor: AppColors
                                                              .buttoncolor,
                                                        ),
                                                      )),
                                                  // CircleAvatar(
                                                  //   radius: 22,
                                                  //   backgroundImage: NetworkImage(
                                                  //       "$baseUrl${labour.userPhoto}"),
                                                  // ),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 28,
                                                        backgroundColor: Colors
                                                            .grey
                                                            .shade200, // Fallback color
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            "$baseUrl${labour.userPhoto}",
                                                            fit: BoxFit.cover,
                                                            width:
                                                                56, // Diameter = radius * 2
                                                            height: 56,
                                                            loadingBuilder:
                                                                (context, child,
                                                                    loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null)
                                                                return child;
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 24,
                                                                  height: 24,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2,
                                                                    color: AppColors
                                                                        .buttoncolor,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                'assets/icons/image.png',
                                                                fit: BoxFit
                                                                    .cover,
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
                                                text: labour.labourName
                                                    .toString(),
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primaryText,
                                              ),
                                              subtitle: AppTextWidget(
                                                text: labour.contactNumber
                                                    .toString(),
                                                fontSize:
                                                    AppTextSize.textSizeSmalle,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.secondaryText,
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),

                        //---------------------------------------------------------------------

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 5, top: 16),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: SizeConfig.heightMultiplier * 5.8,
                                    width: SizeConfig.widthMultiplier * 92,
                                    child: AppTextFormfeild(
                                      controller: selectInvolvedPersonController
                                          .searchStaffController,
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
                                        selectInvolvedPersonController
                                            .updateSearchStaffQuery(value);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 1.5,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1.5,
                            ),
                            Expanded(
                              child: ScrollbarTheme(
                                data: ScrollbarThemeData(
                                  thumbVisibility:
                                      WidgetStateProperty.all(true),
                                  thickness: WidgetStateProperty.all(3),
                                  radius: const Radius.circular(8),
                                  trackVisibility:
                                      WidgetStateProperty.all(true),
                                  thumbColor: WidgetStateProperty.all(
                                      AppColors.buttoncolor),
                                  trackColor: WidgetStateProperty.all(
                                      const Color.fromARGB(26, 101, 99, 99)),
                                  trackBorderColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Scrollbar(
                                  controller: staffScrollController,
                                  interactive: true,
                                  child: Obx(
                                    () {
                                      final filteredList =
                                          selectInvolvedPersonController
                                              .filteredStaff;

                                      return ListView.builder(
                                          controller: staffScrollController,
                                          itemCount: filteredList.length,
                                          itemBuilder: (context, index) {
                                            final staff = filteredList[index];

                                            return ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 0, right: 20),
                                              leading: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Transform.scale(
                                                      scale: 1.1,
                                                      child: Obx(
                                                        () => Checkbox(
                                                          side: BorderSide(
                                                              color: AppColors
                                                                  .searchfeild,
                                                              width: 1),
                                                          value: selectInvolvedPersonController
                                                              .selectedStaffIds
                                                              .contains(
                                                                  staff.id),
                                                          onChanged: (value) {
                                                            selectInvolvedPersonController
                                                                .toggleStaffSelection(
                                                                    staff.id);
                                                          },
                                                          activeColor: AppColors
                                                              .buttoncolor,
                                                        ),
                                                      )),
                                                  // CircleAvatar(
                                                  //   radius: 22,
                                                  //   backgroundImage: NetworkImage(
                                                  //       "$baseUrl${labour.userPhoto}"),
                                                  // ),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 28,
                                                        backgroundColor: Colors
                                                            .grey
                                                            .shade200, // Fallback color
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            "$baseUrl${staff.userPhoto}",
                                                            fit: BoxFit.cover,
                                                            width:
                                                                56, // Diameter = radius * 2
                                                            height: 56,
                                                            loadingBuilder:
                                                                (context, child,
                                                                    loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null)
                                                                return child;
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 24,
                                                                  height: 24,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2,
                                                                    color: AppColors
                                                                        .buttoncolor,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                'assets/icons/image.png',
                                                                fit: BoxFit
                                                                    .cover,
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
                                                text:
                                                    staff.staffName.toString(),
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primaryText,
                                              ),
                                              subtitle: AppTextWidget(
                                                text: staff.contactNumber
                                                    .toString(),
                                                fontSize:
                                                    AppTextSize.textSizeSmalle,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.secondaryText,
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),

                        //-------------------------------------------
                        // Column(
                        //   children: [
                        //     SizedBox(
                        //       height: SizeConfig.heightMultiplier * 3,
                        //     ),
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         SizedBox(
                        //           height: SizeConfig.heightMultiplier * 5.8,
                        //           width: SizeConfig.widthMultiplier * 92,
                        //           child: AppTextFormfeild(
                        //             controller: selectInvolvedPersonController
                        //                 .searchContractorController,
                        //             hintText: 'Search By Contractor Name..',
                        //             keyboardType: TextInputType.name,
                        //             textInputAction: TextInputAction.next,
                        //             prefixIcon: Container(
                        //               padding: EdgeInsets.all(10.0),
                        //               child: Image.asset(
                        //                 'assets/icons/Search.png',
                        //                 fit: BoxFit.contain,
                        //               ),
                        //             ),
                        //             onChanged: (value) {
                        //               selectInvolvedPersonController
                        //                   .updateSearchContractorQuery(value);
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       height: SizeConfig.heightMultiplier * 1.5,
                        //     ),
                        //     Expanded(
                        //       child: Obx(
                        //         () {
                        //           final filteredList =
                        //               selectInvolvedPersonController
                        //                   .filteredContractor;

                        //           return ListView.builder(
                        //               itemCount: filteredList.length,
                        //               itemBuilder: (context, index) {
                        //                 final contractor = filteredList[index];

                        //                 return ListTile(
                        //                   contentPadding:
                        //                       EdgeInsets.only(left: 0, right: 20),
                        //                   leading: Row(
                        //                     mainAxisSize: MainAxisSize.min,
                        //                     children: [
                        //                       Transform.scale(
                        //                           scale: 1.1,
                        //                           child: Obx(
                        //                             () => Checkbox(
                        //                               side: BorderSide(
                        //                                   color:
                        //                                       AppColors.searchfeild,
                        //                                   width: 1),
                        //                               value:
                        //                                   selectInvolvedPersonController
                        //                                       .selectedContractorIds
                        //                                       .contains(
                        //                                           contractor.id),
                        //                               onChanged: (value) {
                        //                                 selectInvolvedPersonController
                        //                                     .toggleContractorSelection(
                        //                                         contractor.id);
                        //                               },
                        //                               activeColor:
                        //                                   AppColors.thirdText,
                        //                             ),
                        //                           )),
                        //                       // CircleAvatar(
                        //                       //   radius: 22,
                        //                       //   backgroundImage: NetworkImage(
                        //                       //       "$baseUrl${contractor.documentPath}"),
                        //                       // ),
                        //                       Stack(
                        //                         alignment: Alignment.center,
                        //                         children: [
                        //                           CircleAvatar(
                        //                             radius: 28,
                        //                             backgroundColor: Colors.grey
                        //                                 .shade200, // Fallback color
                        //                             child: ClipOval(
                        //                               child: Image.network(
                        //                                 "$baseUrl${contractor.documentPath}",
                        //                                 fit: BoxFit.cover,
                        //                                 width:
                        //                                     56, // Diameter = radius * 2
                        //                                 height: 56,
                        //                                 loadingBuilder: (context,
                        //                                     child,
                        //                                     loadingProgress) {
                        //                                   if (loadingProgress ==
                        //                                       null) return child;
                        //                                   return Center(
                        //                                     child: SizedBox(
                        //                                       width: 24,
                        //                                       height: 24,
                        //                                       child:
                        //                                           CircularProgressIndicator(
                        //                                         strokeWidth: 2,
                        //                                         color: AppColors
                        //                                             .buttoncolor,
                        //                                       ),
                        //                                     ),
                        //                                   );
                        //                                 },
                        //                                 errorBuilder: (context,
                        //                                     error, stackTrace) {
                        //                                   return Image.asset(
                        //                                     'assets/icons/image.png',
                        //                                     fit: BoxFit.cover,
                        //                                   );
                        //                                 },
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   title: AppTextWidget(
                        //                     text: contractor.contractorName
                        //                         .toString(),
                        //                     fontSize: AppTextSize.textSizeSmall,
                        //                     fontWeight: FontWeight.w600,
                        //                     color: AppColors.primaryText,
                        //                   ),
                        //                   subtitle: AppTextWidget(
                        //                     text: contractor.contractorPhoneNo
                        //                         .toString(),
                        //                     fontSize: AppTextSize.textSizeSmalle,
                        //                     fontWeight: FontWeight.w400,
                        //                     color: AppColors.secondaryText,
                        //                   ),
                        //                 );
                        //               });
                        //         },
                        //       ),
                        //     )
                        //   ],
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 5, top: 16),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: SizeConfig.heightMultiplier * 5.8,
                                    width: SizeConfig.widthMultiplier * 92,
                                    child: AppTextFormfeild(
                                      controller: selectInvolvedPersonController
                                          .searchContractorController,
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
                                        selectInvolvedPersonController
                                            .updateSearchContractorQuery(value);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 2,
                                )
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1.5,
                            ),
                            Expanded(
                              child: ScrollbarTheme(
                                data: ScrollbarThemeData(
                                  thumbVisibility:
                                      WidgetStateProperty.all(true),
                                  thickness: WidgetStateProperty.all(3),
                                  radius: const Radius.circular(8),
                                  trackVisibility:
                                      WidgetStateProperty.all(true),
                                  thumbColor: WidgetStateProperty.all(
                                      AppColors.buttoncolor),
                                  trackColor: WidgetStateProperty.all(
                                      const Color.fromARGB(26, 101, 99, 99)),
                                  trackBorderColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Scrollbar(
                                  controller: contractorScrollController,
                                  interactive: true,
                                  child: Obx(
                                    () {
                                      final filteredList =
                                          selectInvolvedPersonController
                                              .filteredContractor;

                                      return ListView.builder(
                                          controller:
                                              contractorScrollController,
                                          itemCount: filteredList.length,
                                          itemBuilder: (context, index) {
                                            final contractor =
                                                filteredList[index];

                                            return ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 0, right: 20),
                                              leading: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Transform.scale(
                                                      scale: 1.1,
                                                      child: Obx(
                                                        () => Checkbox(
                                                          side: BorderSide(
                                                              color: AppColors
                                                                  .searchfeild,
                                                              width: 1),
                                                          value: selectInvolvedPersonController
                                                              .selectedContractorIds
                                                              .contains(
                                                                  contractor
                                                                      .id),
                                                          onChanged: (value) {
                                                            selectInvolvedPersonController
                                                                .toggleContractorSelection(
                                                                    contractor
                                                                        .id);
                                                          },
                                                          activeColor: AppColors
                                                              .buttoncolor,
                                                        ),
                                                      )),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 28,
                                                        backgroundColor: Colors
                                                            .grey
                                                            .shade200, // Fallback color
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            "$baseUrl${contractor.documentPath}",
                                                            fit: BoxFit.cover,
                                                            width:
                                                                56, // Diameter = radius * 2
                                                            height: 56,
                                                            loadingBuilder:
                                                                (context, child,
                                                                    loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null)
                                                                return child;
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 24,
                                                                  height: 24,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2,
                                                                    color: AppColors
                                                                        .buttoncolor,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                'assets/icons/image.png',
                                                                fit: BoxFit
                                                                    .cover,
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
                                                text: contractor.contractorName
                                                    .toString(),
                                                fontSize:
                                                    AppTextSize.textSizeSmall,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primaryText,
                                              ),
                                              subtitle: AppTextWidget(
                                                text: contractor
                                                    .contractorPhoneNo
                                                    .toString(),
                                                fontSize:
                                                    AppTextSize.textSizeSmalle,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.secondaryText,
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 4,
                  vertical: SizeConfig.heightMultiplier * 1,
                ),
                child: AppElevatedButton(
                  text: "Add",
                  onPressed: () {
                    selectInvolvedPersonController.addData();
                    selectInvolvedPersonController.addStaffData();
                    selectInvolvedPersonController.addContractorData();

                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
