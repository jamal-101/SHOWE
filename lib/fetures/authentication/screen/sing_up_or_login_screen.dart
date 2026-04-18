import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/constans/app_string.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:digital_event/fetures/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SingUpOrLoginScreen extends StatelessWidget {
  const SingUpOrLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Obx(
                    () => controller.isLoginSelected.value
                        ? _buildLoginForm(controller)
                        : _buildSignUpForm(controller),
                  ),
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
        _buildTextField(label: "Email", hint: "Loisbecket@gmail.com"),
        SizedBox(height: 20.h),
        _buildTextField(
          label: "Password",
          hint: "********",
          isPassword: true,
          visibilityVariable: controller.isPasswordVisible,
          onIconTap: () => controller.togglePasswordVisibility(),
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
              child: CommonButton(
                title: AppString.login,
                onTap: () {
                  Get.toNamed(AppRoutes.homeScreen);
                },
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.setFaceRecognition);
              },
              child: Container(
                height: 48.h,
                width: 48.w,
                decoration: BoxDecoration(
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
        _buildTextField(label: AppString.name, hint: "Lois becket"),
        SizedBox(height: 15.h),
        _buildTextField(label: AppString.email, hint: "Loisbecket@gmail.com"),
        SizedBox(height: 15.h),
        _buildTextField(
          label: AppString.password,
          hint: "********",
          isPassword: true,
          visibilityVariable: controller.singUpIsPasswordVisible,
          onIconTap: () => controller.sinUpTogglePasswordVisibility(),
        ),
        SizedBox(height: 15.h),
        _buildTextField(
          label: AppString.confirmPass,
          hint: "********",
          isPassword: true,
          visibilityVariable: controller.isConfirmPasswordVisible,
          onIconTap: () => controller.toggleConfirmPasswordVisibility(),
        ),
        SizedBox(height: 30.h),
        CommonButton(
          title: AppString.singUp,
          onTap: () {
            controller.isLoginSelected.value = true;
          },
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
              onTap: () {},
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
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF060606),
                      width: 1,
                    ), // আন্ডারলাইন
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
                () => TextField(
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
                              : AppImages.toggleoff,
                          height: 10.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : TextField(
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
              onTap: () {},
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
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF060606),
                      width: 1,
                    ),
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
        padding: EdgeInsets.symmetric(vertical: 12.h),
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
                  children: [
                    Image.asset(
                      iconPath,
                      height: 24.h,
                      width: 24.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10.w),
                    Text(title),
                  ],
                ),
        ),
      ),
    );
  }
}
