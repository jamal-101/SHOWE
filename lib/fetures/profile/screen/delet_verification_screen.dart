import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../controller/profile_controller.dart';

class DeleteVerificationScreen extends StatelessWidget {
  const DeleteVerificationScreen({super.key});

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
          "Account deletion",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<ProfileController>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "This action will delete all of your programs and permanently erase all your data. You cannot undo this action.",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: Color(0xFF3F3F3F),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "If you are sure you want to proceed, Enter the 6-digit code sent to your registered email (ha***********12@gmail.com)",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: Color(0xFF3F3F3F),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "Enter OTP",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1F2A37),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Center(
                    child: Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 50.w,
                        height: 50.h,
                        textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                      ),
                      separatorBuilder: (index) => SizedBox(width: 22.w),
                      onChanged: (value) => controller.setOtpCode(value),
                      onCompleted: (pin) => controller.setOtpCode(pin),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  CommonButton(
                    title: "Delete Account",
                    onTap: (){
                      Get.toNamed(AppRoutes.singUpLoginScreen);
                    },
                    // onTap: () => controller.finalDeleteAccount(),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}