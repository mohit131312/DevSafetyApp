import 'package:flutter/material.dart';
import 'package:flutter_app/utils/gloabal_var.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:flutter_app/utils/app_color.dart';

class ShimmerProject extends StatelessWidget {
  const ShimmerProject({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: shimmerproject.value, // Placeholder for 5 project items
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListTile(
                  leading: Container(
                    width: SizeConfig.imageSizeMultiplier * 14,
                    height: SizeConfig.imageSizeMultiplier * 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  trailing: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: AppColors.textfeildcolor,
              thickness: 1.5,
              height: 2,
            ),
          ],
        );
      },
    );
  }
}
