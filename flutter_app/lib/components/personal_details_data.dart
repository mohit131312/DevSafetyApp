import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';

import '../utils/app_color.dart';

class PersonalDetailData extends StatelessWidget {
  final String label;
  final String value;

  const PersonalDetailData(
      {required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 1),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                text: label,
                fontSize: AppTextSize.textSizeExtraSmall,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryText,
              ),
              AppTextWidget(
                text: value,
                fontSize: AppTextSize.textSizeSmall,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
                //textAlign: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
