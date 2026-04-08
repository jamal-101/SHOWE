import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/constans/app_string.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/log_in_controller.dart';
import '../controller/sing_up_controller.dart';


class SingUpOrLoginScreen extends StatelessWidget {
  final LogInController loginController = Get.put(LogInController());
  final SingUpController signUpController = Get.put(SingUpController());

  SingUpOrLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                        loginController.isLoginSelected.value,
                        () {
                          loginController.isLoginSelected.value = true;
                        },
                      ),
                      _buildTabItem(
                        AppString.singUp,
                        !loginController.isLoginSelected.value,
                        () {
                          loginController.isLoginSelected.value = false;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Obx(
                () => loginController.isLoginSelected.value
                    ? _buildLoginForm()
                    : _buildSignUpForm(),
              ),
            ],
          ),
        ),
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

  Widget _buildLoginForm() {
    return Column(
      children: [
        _buildTextField(label: "Email", hint: "Loisbecket@gmail.com"),
        SizedBox(height: 20.h),
        _buildTextField(
          label: "Password",
          hint: "********",
          isPassword: true,
          visibilityVariable: loginController.isPasswordVisible,
          onIconTap: () => loginController.togglePasswordVisibility(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: loginController.rememberMe.value,
                    onChanged: (val) => loginController.rememberMe.value = val!,
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
        _buildMainButton(AppString.login, () {}),
        _buildSocialLogin(),
      ],
    );
  }
  Widget _buildSignUpForm() {
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
          visibilityVariable: signUpController.isPasswordVisible,
          onIconTap: () => signUpController.togglePasswordVisibility(),
        ),
        SizedBox(height: 15.h),
        _buildTextField(
          label: AppString.confirmPass,
          hint: "********",
          isPassword: true,
          visibilityVariable: signUpController.isConfirmPasswordVisible,
          onIconTap: () => signUpController.toggleConfirmPasswordVisibility(),
        ),
        SizedBox(height: 30.h),
        _buildMainButton(AppString.singUp, () {}),
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
            CommonText(
              text: AppString.login,
              color: Color(0xFFF2A900),
              fontSize: 18,
              fontWeight: FontWeight.w700,
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

  // Widget _buildTextField({
  //   required String label,
  //   required String hint,
  //   bool isPassword = false,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(
  //           fontWeight: FontWeight.bold,
  //           color: Color(0xFF0F4C5C),
  //         ),
  //       ),
  //       SizedBox(height: 8.h),
  //       isPassword
  //           ? Obx(
  //               () => TextField(
  //                 obscureText: !loginController.isPasswordVisible.value,
  //                 decoration: InputDecoration(
  //                   hintText: hint,
  //                   filled: true,
  //                   fillColor: const Color(0xFFF7F7F7),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(10.r),
  //                     borderSide: BorderSide.none,
  //                   ),
  //                   suffixIcon: GestureDetector(
  //                     onTap: () {
  //                       loginController.togglePasswordVisibility();
  //                     },
  //                     child: Padding(
  //                       padding: EdgeInsets.all(14.w),
  //                       child: Image.asset(
  //                         loginController.isPasswordVisible.value
  //                             ? AppImages.appLogo
  //                             : AppImages.passDisable,
  //                         height: 10.h,
  //                         fit: BoxFit.contain,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             )
  //           : TextField(
  //               decoration: InputDecoration(
  //                 hintText: hint,
  //                 filled: true,
  //                 fillColor: const Color(0xFFF7F7F7),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10.r),
  //                   borderSide: BorderSide.none,
  //                 ),
  //               ),
  //             ),
  //     ],
  //   );
  // }


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
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F4C5C))),
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
                        ? AppImages.appLogo
                        : AppImages.passDisable,
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

  Widget _buildMainButton(String title, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF2A900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
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
        _socialButton(AppString.continueGoogle, AppImages.googleIcon),
        SizedBox(height: 10.h),
        _socialButton(AppString.continueFacebook, AppImages.facebookIcon),
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
            CommonText(
              text: AppString.singUp,
              color: Color(0xFFF2A900),
              fontSize: 20,
              fontWeight: FontWeight.w700,
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

  Widget _socialButton(String title, String iconPath) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 24.h, width: 24.w, fit: BoxFit.contain),
          SizedBox(width: 10.w),
          Text(title),
        ],
      ),
    );
  }
}
