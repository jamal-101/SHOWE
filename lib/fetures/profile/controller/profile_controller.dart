// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../core/route/app_routes.dart';
// import '../../../core/storage/local_storage.dart';
// import '../../../core/storage/storage_key.dart';
//
//
// // enum Gender { male, female, other}
//
// class ProfileController extends GetxController{
//
// ///>>>>>>>>>>>>> ProfileInformation <<<<<<<<<<<<<<<///
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   ///>>>>>>>>>>>>>>>>>>>>>>> SetNewPassword <<<<<<<<<<<<<<<<<<<<<<<<<///
//   final TextEditingController currentPasswordController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//
//
//   // RxString selectedGender = "Select".obs;
//   // void updateSelectedGender(Gender genderItem) {
//   //   switch (genderItem) {
//   //     case Gender.male:
//   //       selectedGender.value = "male";
//   //       break;
//   //     case Gender.female:
//   //       selectedGender.value = "female";
//   //       break;
//   //     case Gender.other:
//   //       selectedGender.value = "Prefer not to say";
//   //       break;
//   //   }
//   // }
//
//   // void logout() {
//   // }
//
//   Future<void> logout() async {
//     try {
//       await LocalStorage.removeAllPrefData();
//       Get.offAllNamed(AppRoutes.singUpLoginScreen);
//     } catch (e) {
//       Get.snackbar(
//           "Logout Error",
//           e.toString(),
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white
//       );
//     }
//   }
//
//   ///>>>>>>>>>>>>>>>>>>>>> NotificationSwitch<<<<<<<<<<<<<<<<<<<///
//
//   bool isGeneralNotification = true;
//   bool isLocationEnabled = true;
//
//   void toggleGeneralNotification(bool value) {
//     isGeneralNotification = value;
//     update();
//   }
//
//   void toggleLocation(bool value) {
//     isLocationEnabled = value;
//     update();
//   }
// ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>> HelpCenter <<<<<<<<<<<<<<<<<<<///
//   final TextEditingController helpTitleController = TextEditingController();
//   final TextEditingController helpDescriptionController = TextEditingController();
//   void submitHelpRequest() {}
//
// ///>>>>>>>>>>>>>>>> otp Section <<<<<<<<<<<<<<<<///
//   String otpCode = "";
//   void setOtpCode(String value) {
//     otpCode = value;
//     update();
//   }
//
//   void finalDeleteAccount() {
//     if (otpCode.length == 6) {
//       print("Deleting account with OTP: $otpCode");
//       Get.back();
//     } else {
//       Get.snackbar("Error", "Please enter a valid 6-digit OTP");
//     }
//   }
//
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_key.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  ///>>>>>>>>>>>>> ProfileInformation <<<<<<<<<<<<<<<///
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  Profile_model? profileModel;
  bool isCurrentObscure = true;
  bool isNewObscure = true;
  bool isConfirmObscure = true;


  File? profileImage;
  final ImagePicker _picker = ImagePicker();
  var isLoading = false.obs;
  var isPasswordLoading = false.obs;
  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      update();
    }
  }

  void clearSelectedImage() {
    profileImage = null;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    profileImage = null;
    loadLocalProfile();
    getProfile();
  }

  void loadLocalProfile() {
    nameController.text = LocalStorage.myName;
    emailController.text = LocalStorage.myEmail;
    phoneController.text = LocalStorage.deviceId;
    update();
  }

  Future<void> getProfile() async {
    try {
      profileImage = null;
      update();

      String url = "/user/profile";
      ApiResponseModel response = await ApiService.get(url);

      if (response.statusCode == 200) {

        profileModel = Profile_model.fromJson(Map<String, dynamic>.from(response.data));
        if (profileModel?.data != null) {
          var userData = profileModel!.data!;
          nameController.text = userData.name ?? "";
          emailController.text = userData.email ?? "";
          phoneController.text = userData.contact ?? "";
          await LocalStorage.setString(LocalStorageKeys.myName, userData.name ?? "");
          await LocalStorage.setString(LocalStorageKeys.myEmail, userData.email ?? "");
          await LocalStorage.setString(LocalStorageKeys.profileImage, userData.image ?? "");
          await LocalStorage.getAllPrefData();
        }
      }
    } catch (e) {
      debugPrint("Get Profile Error: $e");
    } finally {
      update();
    }
  }



  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      update();
      String url = "/user/profile";
      Map<String, dynamic> bodyData = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "contact": phoneController.text.trim(),
      };
      ApiResponseModel response = await ApiService.multipart(
        url,
        method: "PATCH",
        body: bodyData,
        imageName: 'image',
        imagePath: profileImage?.path,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getProfile();
        Get.snackbar(
          "Success",
          "Profile updated successfully!",
          backgroundColor: const Color(0xFFF2A900),
          colorText: Colors.white,
        );
        Get.toNamed(AppRoutes.profileScreen);
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? "Something went wrong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Profile Update Error: $e");
      Get.snackbar(
        "Error",
        "Failed to update profile",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>位 SetNewPassword <<<<<<<<<<<<<<<<<<<<<<<<<///
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> logout() async {
    try {
      await LocalStorage.removeAllPrefData();
      Get.offAllNamed(AppRoutes.singUpLoginScreen);
    } catch (e) {
      Get.snackbar(
        "Logout Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> changePassword() async {
    try {
      isPasswordLoading.value = true;
      update();
      String url = "/auth/change-password";
      Map<String, dynamic> bodyData = {
        "currentPassword": currentPasswordController.text.trim(),
        "newPassword": newPasswordController.text.trim(),
        "confirmPassword": confirmPasswordController.text.trim(),
      };
      ApiResponseModel response = await ApiService.post(url, body: bodyData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Password changed successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        Get.toNamed(AppRoutes.profileScreen);
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? "Failed to change password",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Change Password Error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isPasswordLoading.value = false;
      update();
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

  void toggleCurrentObscure() {
    isCurrentObscure = !isCurrentObscure;
    update();
  }

  void toggleNewObscure() {
    isNewObscure = !isNewObscure;
    update();
  }

  void toggleConfirmObscure() {
    isConfirmObscure = !isConfirmObscure;
    update();
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>> HelpCenter <<<<<<<<<<<<<<<<<<<///
  final TextEditingController helpTitleController = TextEditingController();
  final TextEditingController helpDescriptionController =
      TextEditingController();
  void submitHelpRequest() {}

  ///>>>>>>>>>>>>>>>> otp Section <<<<<<<<<<<<<<<<///
  String otpCode = "";
  void setOtpCode(String value) {
    otpCode = value;
    update();
  }

  RxBool isDeleteLoading = false.obs;

  final TextEditingController deleteAccountController = TextEditingController();

  Future<void> deleteAccount(String password) async {
    try {
      isDeleteLoading.value = true;
      update();

      String url = "/user/delete-account";
      Map<String, dynamic> body = {"password": password};
      ApiResponseModel response = await ApiService.delete(url, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (Get.isDialogOpen ?? false) Get.back();

        Get.snackbar(
          "Success",
          response.data['message'] ?? "Account deleted successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await LocalStorage.removeAllPrefData();
        Get.offAllNamed(AppRoutes.singUpLoginScreen);
      } else {
        Get.snackbar(
          "Failed",
          response.data['message'] ?? "Something went wrong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Delete Account Error: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isDeleteLoading.value = false;
      update();
    }
  }
}
