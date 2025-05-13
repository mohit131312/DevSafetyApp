import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/emergency_contact/emergency_contact_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class EmergencyContactScreen extends StatelessWidget {
  EmergencyContactScreen({super.key});
  final EmergencyContactController emergencyContactController =
      Get.put(EmergencyContactController());
  final List items = [
    {
      'title': 'Ambulance',
      'subtitle': '102',
      'image': 'assets/icons/phone_orange.png',
    },
    {
      'title': 'National Emergency Number',
      'subtitle': '112',
      'image': 'assets/icons/phone_orange.png',
    },
    {
      'title': 'Police',
      'subtitle': '112',
      'image': 'assets/icons/phone_orange.png',
    },
    {
      'title': 'Fire',
      'subtitle': '101',
      'image': 'assets/icons/phone_orange.png',
    },
    {
      'title': 'Ambulance',
      'subtitle': '102',
      'image': 'assets/icons/phone_orange.png',
    },
    {
      'title': 'National Emergency Number',
      'subtitle': '112',
      'image': 'assets/icons/phone_orange.png',
    },
    {
      'title': 'Police',
      'subtitle': '112',
      'image': 'assets/icons/phone_orange.png',
    },
    {
      'title': 'Fire',
      'subtitle': '101',
      'image': 'assets/icons/phone_orange.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.heightMultiplier * 10),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: AppColors.buttoncolor,
            centerTitle: true,
            toolbarHeight: SizeConfig.heightMultiplier * 10,
            title: Padding(
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
              child: AppTextWidget(
                text: AppTexts.emergencycontact,
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
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            color: AppColors.primary,
            margin: EdgeInsets.only(
              top: SizeConfig.heightMultiplier * 2,
              left: SizeConfig.widthMultiplier * 4,
              right: SizeConfig.widthMultiplier * 4,
            ),
            child: ListTile(
              title: AppTextWidget(
                text: items[index]['title'],
                fontSize: AppTextSize.textSizeExtraSmall,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryText,
              ),
              subtitle: AppTextWidget(
                text: items[index]['subtitle'],
                fontSize: AppTextSize.textSizeSmall,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
              ),
              trailing: SizedBox(
                width: SizeConfig.imageSizeMultiplier * 9,
                height: SizeConfig.imageSizeMultiplier * 9,
                child: Image.asset(
                  items[index]['image'],
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                emergencyContactController.makeCall(items[index]['subtitle']);
              },
            ),
          );
        },
      ),
    );
  }
}
