import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_elevated_button.dart';
import 'package:flutter_app/components/app_text_widget.dart';
import 'package:flutter_app/components/app_textformfeild_login.dart';
import 'package:flutter_app/features/login/login_controller.dart';
import 'package:flutter_app/features/select_role/select_role.dart';
import 'package:flutter_app/utils/app_color.dart';
import 'package:flutter_app/utils/app_texts.dart';
import 'package:flutter_app/utils/app_textsize.dart';
import 'package:flutter_app/utils/loader_screen.dart';
import 'package:flutter_app/utils/size_config.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    height: SizeConfig.heightMultiplier * 32,
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
                  padding: EdgeInsets.only(
                    left: SizeConfig.widthMultiplier * 5,
                    right: SizeConfig.widthMultiplier * 5,
                    top: SizeConfig.heightMultiplier * 2,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: AppTexts.welcome,
                          fontSize: AppTextSize.textSizeMedium,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 0.8),
                        AppTextWidget(
                          text: AppTexts.welcometext,
                          fontSize: AppTextSize.textSizeSmall,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryText,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2),
                        Form(
                          key: loginController.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text: AppTexts.username,
                                fontSize: AppTextSize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1.2,
                              ),
                              AppTextFormfeildLogin(
                                controller: loginController.usernameController,
                                hintText: 'Enter Username',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/icons/user-circle.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                focusNode: loginController.userNameFocusNode,
                                onFieldSubmitted: (_) {
                                  loginController.userNameFocusNode.unfocus();
                                },
                                validator: loginController.usernameValidator,
                                onChanged: (value) =>
                                    loginController.username.value = value,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1.5,
                              ),
                              AppTextWidget(
                                text: AppTexts.password,
                                fontSize: AppTextSize.textSizeSmalle,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryText,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              ),
                              Obx(
                                () => AppTextFormfeildLogin(
                                  controller:
                                      loginController.passwordController,
                                  hintText: 'Enter Password',
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/lock (1).png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      loginController.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.secondaryText,
                                    ),
                                    onPressed: () {
                                      loginController.isPasswordVisible.value =
                                          !loginController
                                              .isPasswordVisible.value;
                                    },
                                  ),
                                  focusNode: loginController.passwordFocusNode,
                                  onFieldSubmitted: (_) {
                                    loginController.passwordFocusNode.unfocus();
                                  },
                                  obscureText:
                                      !loginController.isPasswordVisible.value,
                                  onChanged: (value) =>
                                      loginController.password.value = value,
                                  validator: loginController.passwordValidator,
                                ),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier * 1),
                              SizedBox(
                                  height: SizeConfig.heightMultiplier * 2.0),
                              AppElevatedButton(
                                text: 'Log In',
                                onPressed: () async {
                                  if (loginController.formKey.currentState
                                          ?.validate() ??
                                      false) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CustomLoadingPopup());

                                    bool success =
                                        await loginController.login();

                                    Get.back();

                                    if (success) {
                                      Get.offAll(() => SelectRole());
                                      loginController.formKey.currentState
                                          ?.reset();
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppTextWidget(
                              text: AppTexts.bottomheading,
                              fontSize: AppTextSize.textSizeExtraSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.fourtText,
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: AppTextWidget(
                                text: "Terms of Service",
                                fontSize: AppTextSize.textSizeExtraSmall,
                                fontWeight: FontWeight.w400,
                                color: AppColors.defaultPrimary,
                                textAlign: TextAlign.center,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: AppTextWidget(
                                text: "Privacy Policy",
                                fontSize: AppTextSize.textSizeExtraSmall,
                                fontWeight: FontWeight.w400,
                                color: AppColors.defaultPrimary,
                                textAlign: TextAlign.center,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: AppTextWidget(
                                text: "Content Policy",
                                fontSize: AppTextSize.textSizeExtraSmall,
                                fontWeight: FontWeight.w400,
                                color: AppColors.defaultPrimary,
                                textAlign: TextAlign.center,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1.5,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: SizeConfig.heightMultiplier * 2,
            left: SizeConfig.widthMultiplier * 14,
            right: SizeConfig.widthMultiplier * 14,
            child: Image.asset("assets/images/kumarname.png",
                fit: BoxFit.contain, height: SizeConfig.heightMultiplier * 10),
          ),
          Positioned(
            top: SizeConfig.heightMultiplier * 12,
            left: SizeConfig.widthMultiplier * 25,
            right: SizeConfig.widthMultiplier * 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextWidget(
                    text: "SAFETY APP",
                    fontSize: AppTextSize.textSizeMediumm,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ],
            ),
          ),
          Positioned(
            top: SizeConfig.heightMultiplier * 18,
            left: SizeConfig.widthMultiplier * 10,
            right: SizeConfig.widthMultiplier * 10,
            child: Image.asset('assets/images/Group.png',
                fit: BoxFit.contain, height: SizeConfig.heightMultiplier * 20),
          ),
        ],
      ),
    );
  }
}
