import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/storage/storage_key.dart';
import '../../../core/utils/api_enpoint.dart';
import '../../../core/utils/api_response_model.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/utils/fcm_service.dart';
import '../screen/verify_otp_screen.dart';

class AuthController extends GetxController {
  var isGoogleLoading = false.obs;
  var isFacebookLoading = false.obs;
  var isSignUpLoading = false.obs;
  var isAppleLoading = false.obs;

  RxInt remainingSeconds = 180.obs;
  Timer? _timer;
  RxBool isResendButtonVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    remainingSeconds.value = 180;
    isResendButtonVisible.value = false;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        isResendButtonVisible.value = true;
        timer.cancel();
      }
    });
  }

  String get timerText {
    int minutes = remainingSeconds.value ~/ 60;
    int seconds = remainingSeconds.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  Future<void> resendOtp({required String email}) async {
    try {
      remainingSeconds.value = 180;
      Map<String, dynamic> requestBody = {"email": email};
      ApiResponseModel response = await ApiService.post(
        ApiEndPoint.forgetPassword,
        body: requestBody,
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "A new verification code has been sent to your email.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        startTimer();
      } else {
        remainingSeconds.value = 0;
        Get.snackbar(
          "Resend Failed",
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      remainingSeconds.value = 0;
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //>>>>>>>>>>>>>>>> logIn <<<<<<<<<<<<<<//

  var isLoginSelected = true.obs;
  var rememberMe = true.obs;
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
      String? fcmToken = await FCMService.getAndPrintFCMToken();

      Map<String, dynamic> requestBody = {
        "name": name,
        "email": email,
        "password": password,
        "fcmToken": fcmToken ?? "",
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
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(AppRoutes.verifyOtpScreen, arguments: email);
      } else {
        final responseData = response.data;
        if ((responseData['suggestRoute'] == "/api/v1/auth/verify-email" ||
            responseData['message'].toString().contains(
              "Account is not verified",
            ))) {
          Get.snackbar(
            "Verification Required",
            responseData['message'] ??
                "Please check your email for verification code.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFFF2A900),
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );
          Get.toNamed(AppRoutes.verifyOtpScreen, arguments: email);
        } else {
          String errorMsg = (responseData['message'] != null)
              ? responseData['message']
              : (response.message);
          Get.snackbar(
            "Failed",
            errorMsg,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
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

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
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
      String? fcmToken = await FCMService.getAndPrintFCMToken();

      Map<String, dynamic> requestBody = {
        "oneTimeCode": int.parse(otpController.text.trim()),
        "email": email,
        "fcmToken": fcmToken ?? "",
      };

      ApiResponseModel response = await ApiService.post(
        ApiEndPoint.otpVerify,
        body: requestBody,
      );

      if (response.isSuccess) {
        debugPrint(">>>> Full Response Data: ${response.data}");
        if (response.data['data'] != null &&
            response.data['data']['accessToken'] != null) {
          String receivedToken = response.data['data']['accessToken'];
          await LocalStorage.setString(LocalStorageKeys.token, receivedToken);

          await LocalStorage.resetDeviceIdForNewUser();

          await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
          await LocalStorage.getAllPrefData();
          await FCMService.getAndPrintFCMToken();
        }

        print("Token is: ${LocalStorage.token}");
        otpController.clear();
        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: Color(0xFFF2A900),
          snackPosition: SnackPosition.TOP,
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

  RxBool isLoginLoading = false.obs;

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      isLoginLoading.value = true;
      String? fcmToken = await FCMService.getAndPrintFCMToken();

      Map<String, dynamic> body = {
        "email": email,
        "password": password,
        "fcmToken": fcmToken ?? "",
      };

      ApiResponseModel response = await ApiService.post(
        ApiEndPoint.userLogin,
        body: body,
      );

      if (response.isSuccess && response.data['success'] == true) {
        if (response.data['data'] != null &&
            response.data['data']['accessToken'] != null) {
          String token = response.data['data']['accessToken'];
          await LocalStorage.setString(LocalStorageKeys.token, token);

          await LocalStorage.resetDeviceIdForNewUser();

          if (rememberMe.value) {
            await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
          } else {
            await LocalStorage.setBool(LocalStorageKeys.isLogIn, false);
          }

          await LocalStorage.getAllPrefData();
          await FCMService.getAndPrintFCMToken();
        }

        isLoginLoading.value = false;
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        isLoginLoading.value = false;
        String errorMsg = response.data['message'];
        Get.snackbar(
          "Login Failed",
          errorMsg,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoginLoading.value = false;
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  var isForgetPasswordLoading = false.obs;
  final TextEditingController forgetPasswordEmailController =
      TextEditingController();
  Future<void> forgotPassword() async {
    String email = forgetPasswordEmailController.text.trim();

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isForgetPasswordLoading.value = true;

      Map<String, dynamic> requestBody = {"email": email};
      ApiResponseModel response = await ApiService.post(
        "/auth/forget-password",
        body: requestBody,
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF2A900),
          colorText: Colors.white,
        );
        startTimer();
        Get.toNamed(AppRoutes.forgotPasswordOtpVerify, arguments: email);
        forgetPasswordEmailController.clear();
      } else {
        String errorMsg = response.data['message'] ?? (response.message);

        Get.snackbar(
          "Failed",
          errorMsg,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isForgetPasswordLoading.value = false;
    }
  }

  var isForgotOtpLoading = false.obs;

  Future<void> verifyForgotPasswordOtp({required String email}) async {
    try {
      if (otpController.text.trim().isEmpty) {
        Get.snackbar(
          "Error",
          "Please enter the OTP code",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      isForgotOtpLoading.value = true;
      Map<String, dynamic> requestBody = {
        "oneTimeCode": int.parse(otpController.text.trim()),
        "email": email,
      };

      ApiResponseModel response = await ApiService.post(
        ApiEndPoint.otpVerify,
        body: requestBody,
      );

      if (response.isSuccess) {
        otpController.clear();
        String resetToken = response.data['data'] ?? "";

        Get.snackbar(
          "Success",
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(AppRoutes.setNewPass, arguments: resetToken);
      } else {
        setSheetState(true);
        showIncorrectOtpSheet(Get.context!, this);
      }
    } catch (e) {
      setSheetState(true);
      showIncorrectOtpSheet(Get.context!, this);
    } finally {
      isForgotOtpLoading.value = false;
    }
  }
  //>>>>>>>>>>>>>>>> set New Password <<<<<<<<<<<<<<//

  var isResetPasswordLoading = false.obs;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var newPasswordVisible = false.obs;
  var confirmPasswordVisible = false.obs;
  Future<void> resetPassword({required String resetToken}) async {
    String newPass = newPasswordController.text.trim();
    String confirmPass = confirmPasswordController.text.trim();

    if (newPass.isEmpty || confirmPass.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPass != confirmPass) {
      Get.snackbar(
        "Error",
        "Passwords do not match!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isResetPasswordLoading.value = true;
      Map<String, dynamic> requestBody = {
        "newPassword": newPass,
        "confirmPassword": confirmPass,
      };
      Map<String, String> headers = {"Authorization": resetToken};

      ApiResponseModel response = await ApiService.post(
        "/auth/reset-password",
        body: requestBody,
        header: headers,
      );

      if (response.isSuccess) {
        newPasswordController.clear();
        confirmPasswordController.clear();

        Get.snackbar(
          "Success",
          response.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed(AppRoutes.authSuccessScreen);
      } else {
        Get.snackbar(
          "Failed",
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isResetPasswordLoading.value = false;
    }
  }

  var confirmNewPasswordVisible = false.obs;

  void toggleNewPasswordVisibility() =>
      newPasswordVisible.value = !newPasswordVisible.value;
  void toggleConfirmNewPasswordVisibility() =>
      confirmNewPasswordVisible.value = !confirmNewPasswordVisible.value;

  ///>>>>>>>>>>>>>>>>> google Login <<<<<<<<<<<<<<<<<///

  ///>>>>>>>>>>>>>>>>> Social Login <<<<<<<<<<<<<<<<<///

  Future<void> googleLogin() async {
    try {
      isGoogleLoading.value = true;

      final googleUser = await GoogleSignIn.instance.authenticate();
      final idToken = googleUser.authentication.idToken;

      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final userCred = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      await _socialLoginToBackend(userCred, socialType: "Google");
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled)
        return; // user cancel korle kichu na
      _showSocialError(e.toString());
    } catch (e) {
      _showSocialError(e.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> appleLogin() async {
    try {
      isAppleLoading.value = true;
      debugPrint("=================== Apple Login Started ===================");

      final appleProvider = AppleAuthProvider()
        ..addScope('email')
        ..addScope('name');

      debugPrint(
        "Triggering FirebaseAuth signInWithProvider(appleProvider)...",
      );
      final userCred = await FirebaseAuth.instance.signInWithProvider(
        appleProvider,
      );

      debugPrint(
        "Apple Auth Success. Firebase User UID: ${userCred.user?.uid}",
      );
      await _socialLoginToBackend(userCred, socialType: "Apple");
    } on FirebaseAuthException catch (e) {
      debugPrint(
        "=================== Apple Login FirebaseAuthException ===================",
      );
      debugPrint("Error Code: ${e.code}");
      debugPrint("Error Message: ${e.message}");
      if (e.code == 'canceled' || e.code == 'web-context-canceled') {
        debugPrint("User canceled Apple Sign In.");
        return;
      }
      _showSocialError(e.message ?? e.toString());
    } catch (e, stack) {
      debugPrint(
        "=================== Apple Login Exception ===================",
      );
      debugPrint("Error: $e");
      debugPrint("Stacktrace: $stack");
      _showSocialError(e.toString());
    } finally {
      isAppleLoading.value = false;
      debugPrint(
        "=================== Apple Login Finished ===================",
      );
    }
  }

  Future<void> _socialLoginToBackend(
    UserCredential userCred, {
    required String socialType,
  }) async {
    final user = userCred.user;
    final firebaseToken = await user?.getIdToken();
    debugPrint(
      "Social Login to Backend - Type: $socialType, Email: ${user?.email}",
    );
    if (user == null || firebaseToken == null) {
      _showSocialError("Could not get authentication token");
      return;
    }

    String? fcmToken = await FCMService.getAndPrintFCMToken();


    debugPrint("========== SOCIAL LOGIN FCM ==========");
    debugPrint("Social Type : $socialType");
    debugPrint("FCM Token   : $fcmToken");
    debugPrint("Token empty?: ${fcmToken == null || fcmToken.isEmpty}");
    debugPrint("======================================");

    final response = await ApiService.post(
      ApiEndPoint.socialLogin,
      body: {
        "name": user.displayName ?? "",
        "email": user.email ?? "",
        "picture": user.photoURL ?? "",
        "appId": user.uid,
        "social_type": socialType,
        // "token": firebaseToken,
        // "fcmToken": fcmToken ?? "",
        "token": fcmToken ?? "",
        "role": "USER",
      },
    );

    debugPrint(
      "Backend Response Status: ${response.isSuccess}, Message: ${response.message}",
    );

    if (response.isSuccess &&
        response.data['data'] != null &&
        response.data['data']['accessToken'] != null) {
      await LocalStorage.setString(
        LocalStorageKeys.token,
        response.data['data']['accessToken'],
      );

      await LocalStorage.resetDeviceIdForNewUser();

      await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
      await LocalStorage.getAllPrefData();
      await FCMService.getAndPrintFCMToken();
      Get.offAllNamed(AppRoutes.homeScreen);
    } else {
      await FirebaseAuth.instance.signOut();
      final msg =
          (response.data['message']) ??
          response.message;
      _showSocialError(msg.toString());
    }
  }

  void _showSocialError(String msg) {
    debugPrint("Social Login Error: $msg");
    Get.snackbar(
      "Login Failed",
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  Future<void> faceBookLogin() async {
    try {
      isFacebookLoading.value = true;
      debugPrint(
        "=================== Facebook Login Started ===================",
      );

      // Log out first to clear any stale cached tokens
      await FacebookAuth.instance.logOut();

      // Generate a raw nonce and its SHA256 hash for Facebook OIDC ID Token
      final rawNonce = DateTime.now().millisecondsSinceEpoch.toString();
      final sha256Nonce = sha256.convert(utf8.encode(rawNonce)).toString();

      debugPrint(
        "Requesting Facebook Login with sha256Nonce: $sha256Nonce (rawNonce: $rawNonce)...",
      );
      final result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
        loginBehavior: LoginBehavior.nativeWithFallback,
        loginTracking: LoginTracking.enabled,
        nonce: sha256Nonce,
      );

      debugPrint("Facebook Login Result Status: ${result.status}");

      if (result.status == LoginStatus.cancelled) {
        debugPrint("User canceled Facebook Login.");
        return;
      }

      if (result.status != LoginStatus.success) {
        debugPrint("Facebook Login Error: ${result.message}");
        _showSocialError(result.message ?? "Facebook login failed");
        return;
      }

      final tokenString = result.accessToken?.tokenString ?? "";
      debugPrint(
        "Facebook Token obtained (Length: ${tokenString.length}). Authenticating with Firebase...",
      );

      UserCredential userCred;
      if (Platform.isIOS) {
        try {
          debugPrint(
            "iOS: Attempting OAuthProvider('facebook.com') with idToken and rawNonce...",
          );
          final credential = OAuthProvider(
            'facebook.com',
          ).credential(idToken: tokenString, rawNonce: rawNonce);
          userCred = await FirebaseAuth.instance.signInWithCredential(
            credential,
          );
        } on FirebaseAuthException catch (iosErr) {
          debugPrint(
            "iOS OAuthProvider failed (${iosErr.code}: ${iosErr.message}). Trying FacebookAuthProvider as fallback...",
          );
          final fallbackCred = FacebookAuthProvider.credential(tokenString);
          userCred = await FirebaseAuth.instance.signInWithCredential(
            fallbackCred,
          );
        }
      } else {
        debugPrint("Android: Using FacebookAuthProvider.credential...");
        final credential = FacebookAuthProvider.credential(tokenString);
        userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      }

      debugPrint(
        "Firebase Auth Success with Facebook. User UID: ${userCred.user?.uid}",
      );
      await _socialLoginToBackend(userCred, socialType: "Facebook");
    } on FirebaseAuthException catch (e) {
      debugPrint(
        "=================== Facebook FirebaseAuthException ===================",
      );
      debugPrint("Error Code: ${e.code}");
      debugPrint("Error Message: ${e.message}");
      if (e.code == 'account-exists-with-different-credential') {
        _showSocialError(
          "An account already exists with this email. Please use the original login method.",
        );
      } else {
        _showSocialError(e.message ?? e.toString());
      }
    } catch (e, stack) {
      debugPrint(
        "=================== Facebook Login Exception ===================",
      );
      debugPrint("Error: $e");
      debugPrint("Stacktrace: $stack");
      _showSocialError(e.toString());
    } finally {
      isFacebookLoading.value = false;
      debugPrint(
        "=================== Facebook Login Finished ===================",
      );
    }
  }
}
