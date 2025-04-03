import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';

class LabourRowDetails extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? imgvalue; // Optional widget for displaying an image

  const LabourRowDetails({
    super.key,
    required this.label,
    this.value,
    this.imgvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.widthMultiplier * 50,
          child: AppTextWidget(
            text: label,
            fontSize: AppTextSize.textSizeSmalle,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryText,
          ),
        ),
        Flexible(
          child: imgvalue != null
              ? imgvalue!
              : AppTextWidget(
                  text: value ?? '',
                  fontSize: AppTextSize.textSizeSmall,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                  textAlign: TextAlign.start,
                ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 4,
        ),
      ],
    );
  }
}
