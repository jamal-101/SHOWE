import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/route/app_routes.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_key.dart';


enum Gender { male, female, other}

class ProfileController extends GetxController{

///>>>>>>>>>>>>> ProfileInformation <<<<<<<<<<<<<<<///
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ///>>>>>>>>>>>>>>>>>>>>>>> SetNewPassword <<<<<<<<<<<<<<<<<<<<<<<<<///
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


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

  // void logout() {
  // }

  Future<void> logout() async {
    try {
      // ১. আপনার তৈরি করা মেথড যা SharedPreferences ক্লিয়ার করে সব ভেরিয়েবল রিসেট করে দেবে
      await LocalStorage.removeAllPrefData();

      // ২. ডায়ালগ বন্ধ করে সরাসরি লগইন স্ক্রিনে পাঠিয়ে দেওয়া
      Get.offAllNamed(AppRoutes.singUpLoginScreen);
    } catch (e) {
      Get.snackbar(
          "Logout Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>> NotificationSwitch<<<<<<<<<<<<<<<<<<<///

  bool isGeneralNotification = true;
  bool isLocationEnabled = true;

  void toggleGeneralNotification(bool value) {
    isGeneralNotification = value;
    update();
  }

  void toggleLocation(bool value) {
    isLocationEnabled = value;
    update();
  }
///>>>>>>>>>>>>>>>>>>>>>>>>>>>>> HelpCenter <<<<<<<<<<<<<<<<<<<///
  final TextEditingController helpTitleController = TextEditingController();
  final TextEditingController helpDescriptionController = TextEditingController();
  void submitHelpRequest() {}

///>>>>>>>>>>>>>>>> otp Section <<<<<<<<<<<<<<<<///
  String otpCode = ""; // OTP স্টোর করার জন্য

  // OTP আপডেট করার ফাংশন
  void setOtpCode(String value) {
    otpCode = value;
    update();
  }

  void finalDeleteAccount() {
    if (otpCode.length == 6) {
      print("Deleting account with OTP: $otpCode");
      Get.back();
      // এখানে আপনার API কল করুন
    } else {
      Get.snackbar("Error", "Please enter a valid 6-digit OTP");
    }
  }

}