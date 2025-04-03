import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;
  final FontWeight fontWeight;
  final Color hintTextColor;
  final Color borderColor;
  final Color errorBorderColor;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.verticalPadding = 15,
    this.horizontalPadding = 15,
    this.fontSize =
        AppTextSize.textSizeSmalle, // Replace with AppTextSize.textSizeSmalle
    this.fontWeight = FontWeight.w400,
    this.hintTextColor =
        AppColors.secondaryText, // Replace with AppColors.secondaryText
    this.borderColor =
        AppColors.searchfeildcolor, // Replace with AppColors.searchfeildcolor
    this.errorBorderColor = const Color.fromARGB(255, 126, 16, 9),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorBorderColor,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: errorBorderColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
