import 'package:digital_event/core/constans/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import '../controller/profile_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: AppColors.appBackgroundColor,
        surfaceTintColor: AppColors.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C), size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Change Password",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          "Please set your new password",
                          style: GoogleFonts.montserrat(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1F2A37),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        _buildLabel("Current Password"),
                        _buildPasswordField(
                          controller: controller.currentPasswordController,
                          hint: "****************",
                        ),
                        SizedBox(height: 20.h),
                        _buildLabel("New Password"),
                        _buildPasswordField(
                          controller: controller.newPasswordController,
                          hint: "****************",
                        ),
                        SizedBox(height: 20.h),
                        _buildLabel("Confirm New Password"),
                        _buildPasswordField(
                          controller: controller.confirmPasswordController,
                          hint: "****************",
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: CommonButton(
                    title: "Update Password",
                    onTap: () {
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordField({required TextEditingController controller, required String hint}) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6), fontSize: 14.sp),
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5C5C5C),
        ),
      ),
    );
  }
}