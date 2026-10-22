

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/route/app_routes.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_key.dart';
import '../../../core/utils/api_enpoint.dart';
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

  RxString rxUserName = ''.obs;

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
    rxUserName.value = LocalStorage.myName;
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
          rxUserName.value = userData.name ?? "";
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



  void clearUserData() {
    profileModel = null;
    profileImage = null;
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    rxUserName.value = '';
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    deleteAccountController.clear();
    isCurrentObscure = true;
    isNewObscure = true;
    isConfirmObscure = true;
    update();
  }




  // Future<void> logout() async {
  //   try {
  //
  //
  //     await _clearSession();
  //     Get.offAllNamed(AppRoutes.singUpLoginScreen);
  //   } catch (e) {
  //     Get.snackbar(
  //       "Logout Error",
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }



  RxBool isLogoutLoading = false.obs;

  Future<void> logout() async {
    if (isLogoutLoading.value) return;
    try {
      isLogoutLoading.value = true;
      update();

      // 1. Age backend ke bolo (token ekhono ache), jate FCM token remove hoy
      try {
        final ApiResponseModel response = await ApiService.post("${ApiEndPoint.baseUrl}/auth/logout");
        debugPrint("Logout API status: ${response.statusCode}");
      } catch (e) {
        debugPrint("Logout API error: $e");
      }
      await _clearSession();

      // 3. Login screen e jao
      Get.offAllNamed(AppRoutes.singUpLoginScreen);
    } catch (e) {
      Get.snackbar(
        "Logout Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLogoutLoading.value = false;
    }
  }


  // Future<void> _clearSession() async {
  //   // 1. Google / Firebase sign out
  //   try {
  //     await GoogleSignIn.instance.signOut(); // v6 hole: GoogleSignIn().signOut()
  //   } catch (e) {
  //     debugPrint("Google signout error: $e");
  //   }
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //   } catch (e) {
  //     debugPrint("Firebase signout error: $e");
  //   }
  //
  //   // 2. Facebook sign out
  //   try {
  //     await FacebookAuth.instance.logOut();
  //   } catch (e) {
  //     debugPrint("Facebook signout error: $e");
  //   }
  //
  //   // 3. Local storage clear
  //   await LocalStorage.removeAllPrefData();
  //   await LocalStorage.getAllPrefData(); // static variable (myName, token...) refresh
  //
  //   // 4. Controller data clear
  //   clearUserData();
  // }


  Future<void> _clearSession() async {
    // 1. Google / Firebase sign out
    try {
      await GoogleSignIn.instance.signOut();
    } catch (e) {
      debugPrint("Google signout error: $e");
    }
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint("Firebase signout error: $e");
    }

    // 2. Facebook sign out
    try {
      await FacebookAuth.instance.logOut();
    } catch (e) {
      debugPrint("Facebook signout error: $e");
    }

    // 3. Local storage clear (এখানে আইডি রিসেটের কোনো কোড থাকবে না)
    await LocalStorage.removeAllPrefData();
    await LocalStorage.getAllPrefData();

    // 4. Controller data clear
    clearUserData();
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

        final String msg =
            response.data['message']?.toString() ?? "Account deleted successfully";

        // Firebase user thakle delete (fail korle backend delete already hoyeche, tai ignore)
        try {
          await FirebaseAuth.instance.currentUser?.delete();
        } catch (e) {
          debugPrint("Firebase user delete error: $e");
        }

        await _clearSession();
        Get.offAllNamed(AppRoutes.singUpLoginScreen);

        Get.snackbar(
          "Success",
          msg,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }else {
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

  var privacyPolicyHtml = "".obs;
  var termsConditionHtml = "".obs;
  var isPrivacyLoading = false.obs;
  var isTermsLoading = false.obs;

  Future<void> fetchPrivacyPolicy() async {
    try {
      isPrivacyLoading.value = true;
      update();
      ApiResponseModel response = await ApiService.get("${ApiEndPoint.disclaimer}?type=privacy-user");
      if (response.isSuccess) {
        final data = response.data['data'];
        if (data is String) {
          privacyPolicyHtml.value = data;
        } else if (data is Map) {
          privacyPolicyHtml.value = data['description']?.toString() ??
              data['content']?.toString() ??
              data['disclaimer']?.toString() ??
              data['text']?.toString() ??
              data.values.firstWhere((v) => v is String, orElse: () => '')?.toString() ??
              "";
        } else if (data != null) {
          privacyPolicyHtml.value = data.toString();
        }
      }
    } catch (e) {
      debugPrint("Fetch Privacy Policy Error: $e");
    } finally {
      isPrivacyLoading.value = false;
      update();
    }
  }

  Future<void> fetchTermsCondition() async {
    try {
      isTermsLoading.value = true;
      update();
      ApiResponseModel response = await ApiService.get("${ApiEndPoint.disclaimer}?type=terms-user");
      if (response.isSuccess) {
        final data = response.data['data'];
        if (data is String) {
          termsConditionHtml.value = data;
        } else if (data is Map) {
          termsConditionHtml.value = data['description']?.toString() ??
              data['content']?.toString() ??
              data['disclaimer']?.toString() ??
              data['text']?.toString() ??
              data.values.firstWhere((v) => v is String, orElse: () => '')?.toString() ??
              "";
        } else if (data != null) {
          termsConditionHtml.value = data.toString();
        }
      }
    } catch (e) {
      debugPrint("Fetch Terms Condition Error: $e");
    } finally {
      isTermsLoading.value = false;
      update();
    }
  }
}
