import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/color_loader.dart';
import 'package:flutter_app/utils/size_config.dart';

class CustomLoadingPopup extends StatelessWidget {
  const CustomLoadingPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(4 * SizeConfig.widthMultiplier)),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorLoader(),
                      AppTextWidget(
                          text: "Please wait..",
                          fontSize: AppTextSize.textSizeMediumm,
                          color: AppColors.buttoncolor,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                ],
              ) //
                  ),
              SizedBox(height: 6 * SizeConfig.widthMultiplier),
            ],
          ),
        ],
      ),
    );
  }
}
