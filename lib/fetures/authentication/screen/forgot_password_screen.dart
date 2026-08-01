import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF0F4C5C),
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Image.asset(
                    AppImages.appLogo,
                    height: 40.h,
                    width: 60.w,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 50.w),
              ],
            ),
            SizedBox(height: 40.h),
            Text(
              "Forgot Password",
              style: GoogleFonts.montserrat(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F4C5C),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter your email and get One Time Passcode for verification",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              "Email",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F4C5C),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.forgetPasswordEmailController, // কন্ট্রোলার অ্যাসাইন করা হলো
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Loisbecket@gmail.com",
                filled: true,
                fillColor: const Color(0xFFF7F7F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Obx(() {
              return controller.isForgetPasswordLoading.value
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF0F4C5C),
                ),
              )
                  : CommonButton(
                title: 'Get OTP',
                onTap: () {
                  controller.forgotPassword();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}