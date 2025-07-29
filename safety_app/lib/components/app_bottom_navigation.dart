import 'package:flutter/material.dart';

class CustomBottomNavItem extends StatelessWidget {
  final String? iconPath;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool isNetwork; //

  const CustomBottomNavItem({
    super.key,
    this.iconPath,
    this.width,
    this.height,
    this.onTap,
    this.isNetwork = false, // default is false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconPath != null
                ? isNetwork
                    ? CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(iconPath!),
                        onBackgroundImageError: (_, __) {},
                      )
                    : SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          iconPath!,
                          width: width,
                          height: height,
                        ),
                      )
                : SizedBox.shrink(),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
