import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bottom_navigation.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/workpermitlist_item.dart';
import 'package:flutter_app/features/profile/profile_screen.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/quick_action_grid.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final int userId, roleId;
  final String selectedproject;
  final int projectId;
  String userName;
  String userImg;
  String userDesg;

  HomeScreen({
    super.key,
    required this.userId,
    required this.roleId,
    required this.selectedproject,
    required this.projectId,
    required this.userName,
    required this.userImg,
    required this.userDesg,
  });

  static List dummyListData = [
    {
      'image': 'assets/images/leading_img.png',
      'title': 'Parc Residencies',
      'location': 'Magarpatta'
    },
  ];

  final RxBool isFabExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    log('print $userId');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.heightMultiplier * 20),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            toolbarHeight: SizeConfig.heightMultiplier * 20,
            backgroundColor: AppColors.buttoncolor,
            title: SizedBox(
              width: SizeConfig.widthMultiplier * 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTexts.hometitle,
                            style: TextStyle(
                              fontSize: AppTextSize.textSizeMediumm,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 1,
                          ),
                          Text(
                            AppTexts.daydate,
                            style: TextStyle(
                                fontSize: AppTextSize.textSizeSmalle,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        child: Image.asset(
                          'assets/icons/Bell.png',
                          height: 26,
                          width: 26,
                        ),
                        // child: Image.asset("assets/icons/Bell_icon.png"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(dummyListData[0]['image']),
                        radius: 25,
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: selectedproject,
                            fontSize: AppTextSize.textSizeMediumm,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                          AppTextWidget(
                            text: dummyListData[0]['location'],
                            fontSize: AppTextSize.textSizeSmalle,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 22,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.heightMultiplier * 3.5),

//------------------------
              SizedBox(
                height: 102,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6E90B8), Color(0xFF004A94)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.4, 0.4],
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 180,
                                      child: AppTextWidget(
                                          text: 'Safety Actionable',
                                          fontSize: AppTextSize.textSizeSmall,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.appwhitecolor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 12,
                              height: SizeConfig.heightMultiplier * 12.7,
                              child: CustomPaint(
                                size: const Size(40, 100),
                                painter: ChevronPainter(),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AppTextWidget(
                                            text: 'Open',
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.backbuttoncolor),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "00",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AppTextWidget(
                                            text: 'Closed',
                                            fontSize:
                                                AppTextSize.textSizeExtraSmall,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.backbuttoncolor),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "00",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 1.3),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.5,
                    width: SizeConfig.widthMultiplier * 10,
                    child: LinearProgressIndicator(
                      value: 0.50,
                      backgroundColor: AppColors.searchfeildcolor,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.buttoncolor),
                    ),
                  ),
                ],
              ),
              //-------------------------------
              SizedBox(height: SizeConfig.heightMultiplier * 3),
              GestureDetector(
                onTap: () {
                  print("Selected Project: $projectId");
                },
                child: AppTextWidget(
                    text: AppTexts.quickaction,
                    fontSize: AppTextSize.textSizeSmallm,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              QuickActionsGrid(
                  userId: userId,
                  userName: userName,
                  projectId: projectId,
                  userImg: userImg,
                  userDesg: userDesg,
                  selectedproject: selectedproject),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              AppTextWidget(
                  text: AppTexts.todaywork,
                  fontSize: AppTextSize.textSizeSmallm,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              WorkPermitListItem(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.appwhitecolor,
        items: [
          BottomNavigationBarItem(
            icon: CustomBottomNavItem(
              iconPath: 'assets/icons/Labours.png',
              height: SizeConfig.heightMultiplier * 4,
              //    width: 24,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavItem(
              onTap: () {
                BottomNavigationBarItem(
                  icon: CustomBottomNavItem(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                  label: "Add New",
                );
              },
              height: SizeConfig.heightMultiplier * 4,
            ),
            label: "Add New",
          ),
          BottomNavigationBarItem(
            icon: CustomBottomNavItem(
              iconPath: 'assets/icons/Profile.png',
              height: SizeConfig.heightMultiplier * 4,
              onTap: () async {
                log('print $userId');

                Get.to(ProfileScreen(
                  selectedproject: selectedproject,
                  userId: userId,
                  roleId: roleId,
                ));
              },
              // width: 24,
            ),
            label: "Profile",
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontSize: AppTextSize.textSizeExtraSmall,
          fontWeight: FontWeight.w400,
          color: AppColors.fourtText,
        ),
        selectedItemColor: AppColors.buttoncolor,
        unselectedItemColor: AppColors.fourtText,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() => _buildFloatingActionButton(context)),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        FloatingActionButton(
            backgroundColor: AppColors.buttoncolor,
            elevation: 5,
            shape: const CircleBorder(),
            child: Icon(
              isFabExpanded.value ? Icons.close : Icons.add,
              size: 26,
              color: AppColors.primary,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          isFabExpanded.value = !isFabExpanded.value;
                        }, // Tap outside to close
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 100, // Adjust above FAB
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: SizeConfig.widthMultiplier * 90,
                            padding:
                                EdgeInsets.only(top: 15, left: 6, right: 10),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 3),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 4,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: fabItems.length,
                                  itemBuilder: (context, index) {
                                    final item = fabItems[index];
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(item['icon'],
                                            height: 30, width: 30),
                                        SizedBox(height: 6),
                                        Flexible(
                                          child: Text(
                                            item['title'],
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize:
                                                  AppTextSize.textSizeSmalle,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              isFabExpanded.value = !isFabExpanded.value;
            }),
      ],
    );
  }

  // Widget _fabItem(String icon, String text, BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pop(context);
  //       isFabExpanded.value = !isFabExpanded.value;

  //       print('$text clicked');
  //     },
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Image.asset(icon, height: 30, width: 30),
  //         SizedBox(height: 6),
  //         Flexible(
  //           child: Text(
  //             text,
  //             textAlign: TextAlign.center,
  //             overflow: TextOverflow.ellipsis,
  //             maxLines: 2,
  //             style: TextStyle(
  //               fontSize: AppTextSize.textSizeSmalle,
  //               color: Colors.black,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
//       floatingActionButton: Obx(() => Stack(
//             clipBehavior: Clip.none, // Ensure FAB options are not clipped

//             alignment: Alignment.bottomCenter,
//             children: [
//               if (isFabExpanded.value)
//                 Positioned(
//                   bottom: 75, // Keeps the FAB at a fixed position

//                   child: _buildFabOptions(),
//                 ),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 child: FloatingActionButton(
//                   onPressed: () => isFabExpanded.value = !isFabExpanded.value,
//                   backgroundColor: AppColors.buttoncolor,
//                   elevation: 5,
//                   shape: const CircleBorder(),
//                   child: Icon(
//                     isFabExpanded.value ? Icons.close : Icons.add,
//                     size: 36,
//                     color: AppColors.primary,
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }

//   Widget _buildFabOptions() {
//     return Container(
//       width: SizeConfig.widthMultiplier * 92,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
//       ),
//       child: Padding(
//           padding: EdgeInsets.only(left: 18, right: 18, top: 13),
//           child: GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3, // 3 columns
//                 crossAxisSpacing: 6,
//                 mainAxisSpacing: 4,
//                 childAspectRatio: 1,
//               ),
//               itemCount: fabItems.length,
//               itemBuilder: (context, index) {
//                 final item = fabItems[index];
//                 return _fabItem(item['icon'], item['title']);
//               })),
//     );
//   }

//   Widget _fabItem(String icon, String text) {
//     return GestureDetector(
//       onTap: () => print('$text clicked'),
//       child: Container(
// //padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               icon,
//               height: 28,
//               width: 28,
//             ),
//             SizedBox(height: 6),
//             Flexible(
//               child: Text(
//                 text,
//                 textAlign: TextAlign.center,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//                 style: TextStyle(
//                   fontSize: AppTextSize.textSizeSmalle,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  final List<Map<String, dynamic>> fabItems = [
    {'title': 'Create Work Permit', 'icon': 'assets/icons/Create_WP.png'},
    {'title': 'Add Labour', 'icon': 'assets/icons/Add_Labour.png'},
    {'title': 'Create Incident Report', 'icon': 'assets/icons/Create_IR.png'},
    {'title': 'Create TBT', 'icon': 'assets/icons/Create_TBT.png'},
    {'title': 'Create Safety Violation', 'icon': 'assets/icons/Create_SA.png'},
  ];
}

class ChevronPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF6E90B8);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height * 10);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.5, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
