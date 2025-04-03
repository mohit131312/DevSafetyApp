import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';

class CustomValidationPopup extends StatelessWidget {
  final String message;

  const CustomValidationPopup({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(4 * SizeConfig.widthMultiplier)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.info,
              size: 40, color: AppColors.buttoncolor), // Added an info icon
          SizedBox(height: 16),
          AppTextWidget(
            text: message, // Display the passed message
            fontSize: AppTextSize.textSizeMedium,
            color: AppColors.buttoncolor,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the popup
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttoncolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 6 * SizeConfig.widthMultiplier),
        ],
      ),
    );
  }
}
