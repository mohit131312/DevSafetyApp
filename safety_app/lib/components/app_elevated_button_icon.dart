import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';

class AppElevatedButtonIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final BorderRadiusGeometry borderRadius;
  final Icon? icon; // Added nullable icon parameter

  // Constructor
  const AppElevatedButtonIcon({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.buttoncolor,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.textStyle = const TextStyle(),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.icon, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        textStyle: textStyle,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!, // Display icon if provided
            SizedBox(width: 8), // Spacing between icon and text
          ],
          Text(
            text,
            style: textStyle.copyWith(
              color: Colors.white,
              fontSize: AppTextSize.textSizeSmall,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}