import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/utils/app_textsize.dart';

import '../utils/app_color.dart';

class ProfileListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback? onTap;

  const ProfileListItem({
    super.key,
    required this.imagePath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Image.asset(
          imagePath,
          height: 26,
          width: 26,
        ),
        title: AppTextWidget(
          text: title,
          fontSize: AppTextSize.textSizeSmall,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryText,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 17,
        ),
      ),
    );
  }
}
