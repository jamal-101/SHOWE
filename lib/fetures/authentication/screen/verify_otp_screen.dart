


import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:digital_event/fetures/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../core/utils/app_utils.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final String userEmail = Get.arguments ?? "";
    debugPrint(">>>> Received Email: $userEmail");
    final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

    final defaultPinTheme = PinTheme(
      width: 45.w,
      height: 55.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: const Color(0xFF0F4C5C),
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.transparent),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Colors.white,
      border: Border.all(color: const Color(0xFF0F4C5C).withValues(alpha: 0.5)),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF0F4C5C).withValues(alpha: 0.5)),
      ),
    );

    return Scaffold(
      body: GetBuilder<AuthController>(
        // init: AuthController(),
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _otpFormKey,
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
                          onPressed: () => Navigator.pop(context),
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
                      "Verify Account",
                      style: GoogleFonts.montserrat(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F4C5C),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Enter your verification code that we have sent to your email $userEmail",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "Enter OTP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F4C5C),
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Center(
                      child: Pinput(
                        controller: controller.otpController,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        showCursor: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: Utils.otpValidator,
                      ),
                    ),
                    SizedBox(height: 25.h),

                    Obx(() {
                      return controller.remainingSeconds.value > 0
                          ? Text(
                        "This code is valid for ${controller.timerText}",
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF0F4C5C),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                          : InkWell(
                        onTap: () {
                          controller.resendOtp(email: userEmail);
                        },
                        child: Text(
                          "Resend Code",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFFF2A900),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 40.h),
                    Obx(() {
                      return controller.isOtpLoading.value
                          ? const Center(child: CircularProgressIndicator(color: Color(0xFF0F4C5C)))
                          : CommonButton(
                        title: 'Verify',
                        backgroundColor: controller.isSheetOpen
                            ? const Color(0xFFF2A900).withValues(alpha: 0.5)
                            : const Color(0xFFF2A900),
                        onTap: () {
                          if (_otpFormKey.currentState!.validate()) {
                            controller.verifyOtp(email: userEmail);
                          }
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//>>>>>>>>>>>>>>>>>>>> show incorrectSheet <<<<<<<<<<<<<<<<<<<<<<<<<<//

void showIncorrectOtpSheet(BuildContext context, AuthController controller) {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(height: 25.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: Color(0xFFFFEBEB),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.close, color: Colors.red, size: 30.sp),
          ),
          SizedBox(height: 20.h),
          Text(
            "Incorrect code entered",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Please check the OTP code and\ntry again",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2A900),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "Got it",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    ),
    isScrollControlled: true,
  ).whenComplete(() {
    controller.setSheetState(false);
  });
}
