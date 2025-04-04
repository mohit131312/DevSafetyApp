import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/features/reset_password/rest_pass_controller.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultPrimary,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 35,
                child: Center(
                  child: Image.asset(
                    "assets/images/backgroundonly.png",
                    fit: BoxFit.cover,
                    height: SizeConfig.heightMultiplier * 30,
                    width: SizeConfig.widthMultiplier * 90,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 5,
                    vertical: SizeConfig.heightMultiplier * 3,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: AppTexts.resetpassword,
                          fontSize: AppTextSize.textSizeMedium,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1),
                        AppTextWidget(
                          text: AppTexts.resetpasswordtext,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.normal,
                          color: AppColors.secondaryText,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2.5),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text: AppTexts.email,
                                fontSize: AppTextSize.textSizeSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 1),
                              Container(
                                child: TextFormField(
                                  controller: emailController,
                                  onChanged: (value) => resetPasswordController
                                      .email.value = value,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.textfeildcolor,
                                    hintText: 'Enter Email',
                                    hintStyle: TextStyle(
                                      fontSize: AppTextSize.textSizeSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryText,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: AppColors.textfeildcolor,
                                          width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: AppColors.textfeildcolor,
                                        width: 1,
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: AppColors.secondaryText,
                                    ),
                                  ),
                                  validator:
                                      resetPasswordController.emailValidator,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 4),
                              AppElevatedButton(
                                text: "Submit",
                                // onPressed: () {
                                //   if (_formKey.currentState!.validate()) {
                                //     print(
                                //         "Email submitted: ${emailController.text}");
                                //   }
                                // },
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Trigger navigation if valid
                                    //  Get.toNamed('/selectproject');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: SizeConfig.heightMultiplier *
                18, //Adjust top position as needed
            left: SizeConfig.widthMultiplier *
                10, // Adjust left position as needed
            right: SizeConfig.widthMultiplier *
                10, // Adjust right position as needed
            child: Image.asset('assets/images/Group.png',
                fit: BoxFit.contain,
                height:
                    SizeConfig.heightMultiplier * 20 // Adjust size as needed
                ),
          ),
        ],
      ),
    );
  }
}
