import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines; // Add this
  final TextOverflow? overflow; // Add this

  const AppTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.textAlign,
    this.decoration,
    this.maxLines, // Add to constructor
    this.overflow, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
      ),
      softWrap: true,
      overflow: overflow ?? TextOverflow.clip, // Default to clip if null
      maxLines: maxLines, // Use the passed value
      textAlign: textAlign,
    );
  }
}
