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
                    ? Container(
                        width: 26,
                        height: 26,
                        child: Image.network(
                          iconPath!,
                          errorBuilder: (_, __, ___) => CircleAvatar(
                            radius: 24,
                            child: Image.asset(
                              'assets/icons/image.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 28,
                        height: 28,
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
