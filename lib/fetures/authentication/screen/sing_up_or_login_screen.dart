import 'dart:io';

import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/constans/app_string.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:digital_event/fetures/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_utils.dart';

class SingUpOrLoginScreen extends StatelessWidget {
  SingUpOrLoginScreen({super.key});

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  final TextEditingController _signUpNameController = TextEditingController();
  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPasswordController =
      TextEditingController();
  final TextEditingController _signUpConfirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Image.asset(AppImages.appLogo, height: 80.h, width: 111),
                  SizedBox(height: 30.h),
                  Obx(
                    () => Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Row(
                        children: [
                          _buildTabItem(
                            AppString.login,
                            controller.isLoginSelected.value,
                            () {
                              controller.isLoginSelected.value = true;
                            },
                          ),
                          _buildTabItem(
                            AppString.singUp,
                            !controller.isLoginSelected.value,
                            () {
                              controller.isLoginSelected.value = false;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Obx(() {
                    if (controller.isLoginSelected.value) {
                      return Form(
                        key: _loginFormKey,
                        child: _buildLoginForm(controller),
                      );
                    } else {
                      return Form(
                        key: _signUpFormKey,
                        child: _buildSignUpForm(controller),
                      );
                    }
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabItem(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0F4C5C) : Colors.transparent,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF0F4C5C),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(AuthController controller) {
    return Column(
      children: [
        _buildTextField(
          label: "Email",
          hint: "Enter Your Email",
          controller: _loginEmailController,
          validator: Utils.emailValidator,
        ),
        SizedBox(height: 20.h),
        _buildTextField(
          label: "Password",
          controller: _loginPasswordController,
          hint: "********",
          isPassword: true,
          visibilityVariable: controller.isPasswordVisible,
          onIconTap: () => controller.togglePasswordVisibility(),
          validator: Utils.passwordValidator,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: (val) => controller.rememberMe.value = val!,
                  ),
                ),
                const Text(AppString.rememberMe),
              ],
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.forgotPasswordScreen);

                // Get.toNamed(AppRoutes.setNewPass);
              },
              child: const Text(
                AppString.forgotPass,
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        Row(
          children: [
            Expanded(
              child: Obx(
                () => controller.isLoginLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF0F4C5C),
                        ),
                      )
                    : CommonButton(
                        title: AppString.login,
                        onTap: () {
                          if (_loginFormKey.currentState!.validate()) {
                            controller.loginUser(
                              email: _loginEmailController.text.trim(),
                              password: _loginPasswordController.text.trim(),
                            );
                          }
                        },
                      ),
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.faceRecognitionLoginScreen);
              },
              child: Container(
                height: 48.h,
                width: 48.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2A900),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.loginQrIcon,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        _buildSocialLogin(controller),
      ],
    );
  }

  Widget _buildSignUpForm(AuthController controller) {
    return Column(
      children: [
        _buildTextField(
          label: AppString.name,
          hint: "Lois becket",
          validator: Utils.fullNameValidator,
          controller: _signUpNameController,
        ),
        SizedBox(height: 15.h),
        _buildTextField(
          controller: _signUpEmailController,
          label: AppString.email,
          hint: "Loisbecket@gmail.com",
          validator: Utils.emailValidator,
        ),
        SizedBox(height: 15.h),
        _buildTextField(
          label: AppString.password,
          controller: _signUpPasswordController,
          hint: "********",
          isPassword: true,
          validator: Utils.passwordValidator,
          visibilityVariable: controller.singUpIsPasswordVisible,
          onIconTap: () => controller.sinUpTogglePasswordVisibility(),
        ),
        SizedBox(height: 15.h),
        _buildTextField(
          controller: _signUpConfirmPasswordController,
          label: AppString.confirmPass,
          validator: (value) => Utils.confirmPasswordValidator(
            value,
            _signUpPasswordController.text,
          ),
          hint: "********",
          isPassword: true,
          visibilityVariable: controller.isConfirmPasswordVisible,
          onIconTap: () => controller.toggleConfirmPasswordVisibility(),
        ),
        SizedBox(height: 30.h),
        Obx(
          () => controller.isSignUpLoading.value
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF0F4C5C)),
                )
              : CommonButton(
                  title: AppString.singUp,
                  onTap: () {
                    if (_signUpFormKey.currentState!.validate()) {
                      controller.registerUser(
                        name: _signUpNameController.text.trim(),
                        email: _signUpEmailController.text.trim(),
                        password: _signUpPasswordController.text.trim(),
                      );
                    }
                  },
                ),
        ),
        SizedBox(height: 20.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText(
              text: AppString.alreadyHave,
              color: Color(0xFF5C5C5C),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                controller.isLoginSelected.value = true;
              },
              child: CommonText(
                text: AppString.login,
                color: Color(0xFFF2A900),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 32.h),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "By continuing you agree to our ",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.termsConditionScreen);
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF060606), width: 1),
                  ),
                ),
                child: Text(
                  "Terms & Conditions",
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF060606),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Text(
              " and have read our ",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.privacyPolicyScreen);
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF060606), width: 1), //
                  ),
                ),
                child: Text(
                  "Privacy Policy",
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF060606),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    bool isPassword = false,
    RxBool? visibilityVariable,
    VoidCallback? onIconTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F4C5C),
          ),
        ),
        SizedBox(height: 8.h),
        isPassword && visibilityVariable != null
            ? Obx(
                () => TextFormField(
                  validator: validator,
                  controller: controller,
                  obscureText: !visibilityVariable.value,
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: const Color(0xFFF7F7F7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: onIconTap,
                      child: Padding(
                        padding: EdgeInsets.all(14.w),
                        child: Image.asset(
                          visibilityVariable.value
                              ? AppImages.toggleOn
                              : AppImages.toggleOff,
                          height: 10.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : TextFormField(
                controller: controller,
                validator: validator,
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: const Color(0xFFF7F7F7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildSocialLogin(AuthController controller) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Row(
          children: [
            const Expanded(
              child: Divider(thickness: 1, color: Color(0xFFEDF1F3)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                AppString.or,
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
            ),
            const Expanded(
              child: Divider(thickness: 1, color: Color(0xFFEDF1F3)),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Obx(
          () => Column(
            children: [
              if (Platform.isIOS)
                _socialButton(
                  AppString.continueApple,
                  isLoading: controller.isAppleLoading.value,
                  AppImages.appleIcon,
                  onTap: () => controller.appleLogin(),
                )
              else
                _socialButton(
                  AppString.continueGoogle,
                  isLoading: controller.isGoogleLoading.value,
                  AppImages.googleIcon,
                  onTap: () => controller.googleLogin(),
                ),
              SizedBox(height: 12.h),
              _socialButton(
                AppString.continueFacebook,
                isLoading: controller.isFacebookLoading.value,
                AppImages.facebookIcon,
                onTap: () => controller.faceBookLogin(),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText(
              text: AppString.donTHave,
              color: Color(0xFF5C5C5C),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                controller.isLoginSelected.value = false;
              },
              child: CommonText(
                text: AppString.singUp,
                color: Color(0xFFF2A900),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 32.h),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "By continuing you agree to our ",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.termsConditionScreen);
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF060606), width: 1),
                  ),
                ),
                child: Text(
                  "Terms & Conditions",
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF060606),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Text(
              " and have read our ",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.privacyPolicyScreen);
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF060606), width: 1),
                  ),
                ),
                child: Text(
                  "Privacy Policy",
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF060606),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget _socialButton(String title, String iconPath,{required VoidCallback onTap}) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: EdgeInsets.symmetric(vertical: 12.h),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey.shade300),
  //         borderRadius: BorderRadius.circular(50.r),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Image.asset(iconPath, height: 24.h, width: 24.w, fit: BoxFit.contain),
  //           SizedBox(width: 10.w),
  //           Text(title),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _socialButton(
    String title,
    String iconPath, {
    required VoidCallback onTap,
    required bool isLoading,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 20.h,
                  width: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF0F4C5C),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    iconPath.endsWith('.svg')
                        ? SvgPicture.asset(
                            iconPath,
                            height: 24.h,
                            width: 24.w,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            iconPath,
                            height: 24.h,
                            width: 24.w,
                            fit: BoxFit.contain,
                          ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
