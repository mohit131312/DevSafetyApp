import 'package:flutter/material.dart';
import 'package:flutter_app/utils/gloabal_var.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/size_config.dart';

class ShimmerRole extends StatelessWidget {
  const ShimmerRole({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: shimmerrole.value,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textfeildcolor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.searchfeildcolor, width: 1),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 8,
            ),
            height: SizeConfig.heightMultiplier * 9,
            width: SizeConfig.widthMultiplier * 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // SizedBox(
                //   width: SizeConfig.widthMultiplier * 6,
                //   child: Icon(
                //     Icons.arrow_forward_ios,
                //     size: SizeConfig.heightMultiplier * 2.5,
                //     color: Colors.black,
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
