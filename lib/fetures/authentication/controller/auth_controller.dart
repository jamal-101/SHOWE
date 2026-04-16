import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  var isGoogleLoading = false.obs;
  var isFacebookLoading = false.obs;

  //>>>>>>>>>>>>>>>> logIn <<<<<<<<<<<<<<//

  var isLoginSelected = true.obs;
  var rememberMe = false.obs;
  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  //>>>>>>>>>>>>>>> SingUP <<<<<<<<<<<<<<<<<//

  var singUpIsPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  void sinUpTogglePasswordVisibility() {
    singUpIsPasswordVisible.value = !singUpIsPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  //>>>>>>>>>>>>>>>>>>> OtpVerify <<<<<<<<<<<<<<<<<<<<//

  final TextEditingController otpController = TextEditingController();
  bool isSheetOpen = false;
  void setSheetState(bool state) {
    isSheetOpen = state;
    update();
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