import 'package:digital_event/core/constans/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/screen/home_screen.dart';

enum Gender { male, female, other}

class ProfileInformationController extends GetxController {
  RxString selectedGender = "Select".obs;
  void updateSelectedGender(Gender genderItem) {
    switch (genderItem) {
      case Gender.male:
        selectedGender.value = "male";
        break;
      case Gender.female:
        selectedGender.value = "female";
        break;
      case Gender.other:
        selectedGender.value = "Prefer not to say";
        break;
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>> faceRecognition <<<<<<<<<<<<<<<<<<<<<<///


  bool isScanning = false;

  void startScanning() {
    isScanning = true;
    update();
    Future.delayed(const Duration(seconds: 3), () {
      update();
      // isScanning = false;
      showSuccessDialog();
    });
  }

  void showSuccessDialog() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: const BoxDecoration(
                  color: Color(0xFFF7BD56),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppImages.faceSuccess,height: 100.h,width: 100.w),
              ),
              SizedBox(height: 20.h),
              Text(
                "Congratulations",
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F4C5C),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Your account is ready to use, redirecting to homepage",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              const CircularProgressIndicator(color: Color(0xFFF7BD56)),
            ],
          ),
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      isScanning = false;
      update();
      Get.offAll(()=>HomeScreen());
    });
  }
}