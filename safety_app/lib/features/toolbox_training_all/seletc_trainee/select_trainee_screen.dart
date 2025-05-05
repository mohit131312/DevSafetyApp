import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild.dart';
import 'package:flutter_app/features/toolbox_training_all/seletc_trainee/select_trainee_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/logout_user.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class SelectTraineeScreen extends StatelessWidget {
  SelectTraineeScreen({super.key});
  final SelectTraineeController selectTraineeController =
      Get.put(SelectTraineeController());

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 1,
    //   child:

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
              text: 'Select Trainees',
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
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              // Container(
              //   height: SizeConfig.heightMultiplier * 6,
              //   width: SizeConfig.widthMultiplier * 92,
              //   padding: EdgeInsets.symmetric(
              //     vertical: SizeConfig.heightMultiplier * 0.8,
              //     horizontal: SizeConfig.widthMultiplier * 1.5,
              //   ),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: AppColors.textfeildcolor,
              //   ),
              //   child: TabBar(
              //     controller: selectTraineeController.tabController,
              //     isScrollable: true,
              //     indicatorColor: AppColors.textfeildcolor,
              //     labelColor: AppColors.primary,
              //     unselectedLabelColor: AppColors.searchfeild,
              //     indicator: BoxDecoration(
              //       color: AppColors.thirdText,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     indicatorSize: TabBarIndicatorSize.tab,
              //     dividerHeight: 0,
              //     tabAlignment: TabAlignment.start,
              //     tabs: [
              //       SizedBox(
              //         width: SizeConfig.widthMultiplier * 20,
              //         child: Tab(
              //           text: 'Labour',
              //         ),
              //       ),
              //       // SizedBox(
              //       //   width: SizeConfig.widthMultiplier * 20,
              //       //   child: const Tab(
              //       //     text: 'Staff',
              //       //   ),
              //       // ),
              //       // SizedBox(
              //       //   child: const Tab(
              //       //     text: 'Contractor',
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 0.2,
              ),
              // Expanded(
              //   child: TabBarView(
              //       controller: selectTraineeController.tabController,
              //       children: [
              SingleChildScrollView(
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
                            controller:
                                selectTraineeController.searchController,
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
                              selectTraineeController
                                  .updateIncidentSearchQuery(value);
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
                            selectTraineeController.filteredIncidentLabours;

                        return ListView.builder(
                            itemCount: filteredList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final labour = filteredList[index];

                              return ListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 0, right: 20),
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
                                            value: selectTraineeController
                                                .selectedIncidentLabourIds
                                                .contains(labour.id),
                                            onChanged: (value) {
                                              selectTraineeController
                                                  .toggleIncidentSelection(
                                                      labour.id);
                                            },
                                            activeColor: AppColors.thirdText,
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
                                              .grey.shade200, // Fallback color
                                          child: ClipOval(
                                            child: Image.network(
                                              "$baseUrl${labour.userPhoto}",
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
                                  text: labour.labourName.toString(),
                                  fontSize: AppTextSize.textSizeSmall,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText,
                                ),
                                subtitle: AppTextWidget(
                                  text: labour.contactNumber.toString(),
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
            ],
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
              selectTraineeController.addIncidentData();
              //        selectTraineeController.addIncidentStaffData();
              //      selectTraineeController.addIncidentContractorData();

              Get.back();
            },
          ),
        ),
        // ),
      ),
    );
  }
}
