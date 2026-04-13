import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


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
  void logout() {
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
      // এখানে আপনার API কল করুন
    } else {
      Get.snackbar("Error", "Please enter a valid 6-digit OTP");
    }
  }

}