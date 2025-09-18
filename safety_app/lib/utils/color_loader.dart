import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'dart:math';

class ColorLoader extends StatefulWidget {
  final double radius;
  final double dotRadius;

  const ColorLoader({super.key, this.radius = 40.0, this.dotRadius = 7.0});

  @override
  _ColorLoaderState createState() => _ColorLoaderState();
}

class _ColorLoaderState extends State<ColorLoader>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;
  late AnimationController controller;

  late double radius;
  late double dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    print(dotRadius);

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 3000),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = widget.radius * animation_radius_in.value;
        } else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40 * SizeConfig.widthMultiplier,
      height: 40 * SizeConfig.widthMultiplier,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Static image, NOT rotating
          Center(
            child: Image.asset(
              'assets/icons/appstore.png',
              width: dotRadius * 5,
              height: dotRadius * 5,
            ),
          ),

          // Rotating dots only
          RotationTransition(
            turns: animation_rotation,
            child: Stack(
              children: List.generate(8, (index) {
                final angle = index * pi / 4;
                return Transform.translate(
                  offset: Offset(
                    radius * cos(angle),
                    radius * sin(angle),
                  ),
                  child: Dot(
                    radius: dotRadius,
                    color: AppColors.buttoncolor,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  const Dot({super.key, required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
