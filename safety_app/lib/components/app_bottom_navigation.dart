import 'package:flutter/material.dart';

class CustomBottomNavItem extends StatelessWidget {
  final String? iconPath;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const CustomBottomNavItem({
    super.key,
    this.iconPath,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconPath != null
              ? Image.asset(
                  iconPath!,
                  width: width,
                  height: height,
                )
              : Text(""),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
