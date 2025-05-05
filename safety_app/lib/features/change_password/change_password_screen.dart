import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/change_password/change_password_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  final int? userId;
  const ChangePasswordScreen({super.key, this.userId});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController controller =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          scrolledUnderElevation: 0.0,
          backgroundColor: AppColors.buttoncolor,
          centerTitle: true,
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: AppTextWidget(
              text: AppTexts.changepassword,
              fontSize: AppTextSize.textSizeMedium,
              fontWeight: FontWeight.w400,
              color: AppColors.primary,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: SizeConfig.heightMultiplier * 2.5,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 5,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        AppTextWidget(
                          text: AppTexts.changepasstext,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2.5),

                        AppTextWidget(
                          text: AppTexts.newpassword,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            style: GoogleFonts.inter(
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryText,
                            ),
                            controller: controller.newPasswordController,
                            onChanged: (value) {
                              controller.newPassword.value = value;
                              controller.updatePasswordRequirements(value);
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 11, horizontal: 12),
                              hintText: 'New Password',
                              hintStyle: GoogleFonts.inter(
                                fontSize: AppTextSize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryText,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppColors.searchfeildcolor,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppColors.searchfeildcolor,
                                    width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 126, 16, 9),
                                  width: 1,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 126, 16, 9),
                                  width: 1,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: controller.newPasswordValidator,
                          ),
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2),
                        AppTextWidget(
                          text: AppTexts.confirmpassword,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        Container(
                          decoration: BoxDecoration(),
                          child: TextFormField(
                            style: GoogleFonts.inter(
                              fontSize: AppTextSize.textSizeSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryText,
                            ),
                            textInputAction: TextInputAction.next,
                            controller: controller.confirmPasswordController,
                            onChanged: (value) =>
                                controller.confirmPassword.value = value,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 11, horizontal: 12),
                              hintText: 'Confirm Password',
                              hintStyle: GoogleFonts.inter(
                                fontSize: AppTextSize.textSizeSmalle,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryText,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppColors.searchfeildcolor,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: AppColors.searchfeildcolor,
                                    width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 126, 16, 9),
                                  width: 1,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 126, 16, 9),
                                  width: 1,
                                ),
                              ),
                            ),
                            validator: controller.confirmPasswordValidator,
                          ),
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                        AppTextWidget(
                          text: AppTexts.passwordcontain,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: controller.passwordRequirements
                                .map(
                                  (req) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          req.isValid.value
                                              ? Icons.check_circle_outline
                                              : Icons.radio_button_unchecked,
                                          size: 20,
                                          color: req.isValid.value
                                              ? AppColors.checkcolor
                                              : AppColors.secondaryText,
                                        ),
                                        SizedBox(width: 8),
                                        AppTextWidget(
                                          text: req.text,
                                          fontSize:
                                              AppTextSize.textSizeExtraSmall,
                                          color: req.isValid.value
                                              ? AppColors.checkcolor
                                              : AppColors.secondaryText,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),

                        // Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(
            //       bottom: SizeConfig.heightMultiplier * 3,
            //       left: SizeConfig.widthMultiplier * 4,
            //       right: SizeConfig.widthMultiplier * 4),
            //   child: AppElevatedButton(
            //     text: 'Submit',
            //     onPressed: controller.submit,
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 2,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: AppElevatedButton(
              text: 'Submit',
              onPressed: () async {
                await controller.submit(context, widget.userId);
                print("API Status: ${controller.apiStatus.value}");
                if (controller.apiStatus.value == true) {
                  Get.back();
                }
              }),
        ),
      ),
    );
  }
}

class PasswordRequirement {
  final String text;
  final RxBool isValid;

  PasswordRequirement({required this.text, required this.isValid});
}
