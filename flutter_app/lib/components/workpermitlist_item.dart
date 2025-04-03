import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';

class WorkPermitListItem extends StatelessWidget {
  WorkPermitListItem({super.key});

  final List listData = [
    {
      'title': 'Work Permit',
      'sub': 'Work Permit detail',
      'subtitle': '12 Mar 2024, 02:22 PM',
      'status': 'Open'
    },
    {
      'title': 'Work Permit',
      'sub': 'Work Permit detail',
      'subtitle': '13 Mar 2024, 03:30 PM',
      'status': 'open'
    },
    {
      'title': 'Work Permit',
      'sub': 'Work Permit detail',
      'subtitle': '14 Mar 2024, 01:15 PM',
      'status': 'Open'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            listData[index]['title']!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppTextSize.textSizeSmall,
              color: AppColors.primaryText,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                listData[index]['sub']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppTextSize.textSizeExtraSmall,
                  color: AppColors.secondaryText,
                ),
              ),
              Text(
                listData[index]['subtitle']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppTextSize.textSizeExtraSmall,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          trailing: Text(
            listData[index]['status']!,
            style: TextStyle(
              color: AppColors.buttoncolor,
              fontWeight: FontWeight.bold,
              fontSize: AppTextSize.textSizeExtraSmall,
            ),
          ),
        );
      },
    );
  }
}
