import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';

// ignore: must_be_immutable
class MatchedUser extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Future<void> Function(BuildContext, String) onItemSelected;
  final int categoryId;

  MatchedUser(
      {super.key,
      required this.items,
      required this.onItemSelected,
      required this.categoryId});

  String id = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      content: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: double.maxFinite,
        height: SizeConfig.heightMultiplier * 38,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            print("Current Item: ${items[index]}");

            String name = "Unknown";

            if (categoryId == 1) {
              name = items[index]['labour_name'] ?? '';
              print("In Category Labour 1: $name");

              //  id = items[index]['labour_id'].toString();
            } else if (categoryId == 2) {
              name = items[index]['contractor_name'] ?? '';
              print("In Category Contarctor 2: $name");

              //  id = items[index]['contractor_id'].toString();
            } else if (categoryId == 3) {
              name = items[index]['staff_name'] ?? '';
              //  id = items[index]['staff_id'].toString();
              print("In Category Staff 3: $name");
            }

            print("Resolved Name: $name");
            print("Resolved id: $id");

            return GestureDetector(
              onTap: () async {
                if (categoryId == 1) {
                  name = items[index]['labour_name'] ?? '';
                  id = items[index]['labour_id'].toString();
                  print("In Category Labour 1: $id");
                } else if (categoryId == 2) {
                  name = items[index]['contractor_name'] ?? '';
                  id = items[index]['contractor_id'].toString();
                  print("In Category Contarctor 2: $id");
                } else if (categoryId == 3) {
                  name = items[index]['staff_name'] ?? '';
                  id = items[index]['staff_id'].toString();
                  print("In Category Staff 3: $id");
                }

                showDialog(
                  context: context,
                  builder: (BuildContext context) => const CustomLoadingPopup(),
                );
                await onItemSelected(context, id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.heightMultiplier * 6,
                child: Column(
                  children: [
                    AppTextWidget(
                      text: name,
                      fontSize: AppTextSize.textSizeSmallm,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Container(
                      height: 1,
                      color: AppColors.buttoncolor,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
