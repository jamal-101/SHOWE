import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:digital_event/fetures/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF0F4C5C),
                          size: 20,
                        ),
                        onPressed: () => Get.back(),
                      ),
                      Image.asset(
                        AppImages.appLogo,
                        height: 40.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 48.w),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "Set New Password",
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F4C5C),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Let's get your account secured with a new password",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  _buildTextField(
                    label: "New Password",
                    hint: "*******",
                    isPassword: true,
                    visibilityVariable: controller.newPasswordVisible,
                    onIconTap: () => controller.toggleNewPasswordVisibility(),
                  ),
                  SizedBox(height: 20.h),
                  _buildTextField(
                    label: "Confirm New Password",
                    hint: "*******",
                    isPassword: true,
                    visibilityVariable: controller.confirmNewPasswordVisible,
                    onIconTap: () =>
                        controller.toggleConfirmNewPasswordVisibility(),
                  ),

                  SizedBox(height: 40.h),
                  CommonButton(title: "Change Password", onTap: () {
                    Get.toNamed(AppRoutes.authSuccessScreen);
                  }),
                ],
              ),
            ),
          );
        },
      ),
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
        Obx(
          () => TextField(
            obscureText: isPassword && visibilityVariable != null
                ? !visibilityVariable.value
                : false,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xFFF7F7F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              suffixIcon: isPassword
                  ? GestureDetector(
                      onTap: onIconTap,
                      child: Padding(
                        padding: EdgeInsets.all(14.w),
                        child: Image.asset(
                          visibilityVariable?.value == true
                              ? AppImages.passDisable
                              : AppImages.appLogo,
                          height: 10.h,
                          fit: BoxFit.cover,
                          color: Color(0xFFACB5BB),
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
