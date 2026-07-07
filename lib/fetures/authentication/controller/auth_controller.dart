import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_key.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../screen/verify_otp_screen.dart';

class AuthController extends GetxController{

  var isGoogleLoading = false.obs;
  var isFacebookLoading = false.obs;
  var isSignUpLoading = false.obs;

  //>>>>>>>>>>>>>>>> logIn <<<<<<<<<<<<<<//

  var isLoginSelected = true.obs;
  var rememberMe = false.obs;
  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  //>>>>>>>>>>>>>>> SingUP <<<<<<<<<<<<<<<<<//


  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isSignUpLoading.value = true;

      Map<String, dynamic> requestBody = {
        "name": name,
        "email": email,
        "password": password,
        "role": "USER",
      };

      ApiResponseModel response = await ApiService.post(
        ApiEndPoint.signUp,
        body: requestBody,
      );
      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          response.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        // isLoginSelected.value = true;
        Get.toNamed(
          AppRoutes.verifyOtpScreen,
          arguments: email,
        );
      } else {
        Get.snackbar(
          "Failed",
          response.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSignUpLoading.value = false;
    }
  }

  var singUpIsPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  void sinUpTogglePasswordVisibility() {
    singUpIsPasswordVisible.value = !singUpIsPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  final TextEditingController otpController = TextEditingController();
  var isOtpLoading = false.obs;
  bool isSheetOpen = false;

  void setSheetState(bool value) {
    isSheetOpen = value;
    update();
  }

  Future<void> verifyOtp({required String email}) async {
    try {
      isOtpLoading.value = true;
      Map<String, dynamic> requestBody = {
        "oneTimeCode": int.parse(otpController.text.trim()),
        "email": email,
      };

      ApiResponseModel response = await ApiService.post(
        ApiEndPoint.otpVerify,
        body: requestBody,
      );

      if (response.isSuccess) {
        print(">>>> Full Response Data: ${response.data}");
        if (response.data != null && response.data['data'] != null && response.data['data']['accessToken'] != null) {
          String receivedToken = response.data['data']['accessToken'];
          await LocalStorage.setString(LocalStorageKeys.token, receivedToken);
          await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
          await LocalStorage.getAllPrefData();
        }

        print("Token is: ${LocalStorage.token}");
        otpController.clear();
        Get.snackbar(
          "Success",
          response.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.toNamed(AppRoutes.setFaceRecognition);
      } else {
        setSheetState(true);
        showIncorrectOtpSheet(Get.context!, this);
      }
    } catch (e) {
      setSheetState(true);
      showIncorrectOtpSheet(Get.context!, this);
    } finally {
      isOtpLoading.value = false;
    }
  }

  //>>>>>>>>>>>>>>>> set New Password <<<<<<<<<<<<<<//

  var newPasswordVisible = false.obs;
  var confirmNewPasswordVisible = false.obs;

  void toggleNewPasswordVisibility() => newPasswordVisible.value = !newPasswordVisible.value;
  void toggleConfirmNewPasswordVisibility() => confirmNewPasswordVisible.value = !confirmNewPasswordVisible.value;

  ///>>>>>>>>>>>>>>>>> google Login <<<<<<<<<<<<<<<<<///

  void googleLogin() async {
    isGoogleLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isGoogleLoading.value = false;
  }

  void faceBookLogin() async {
    isFacebookLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isFacebookLoading.value = false;
  }

}