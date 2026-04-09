import 'package:digital_event/fetures/authentication/profile_information/profile_information_screen.dart';
import 'package:digital_event/fetures/authentication/screen/auth_success_screen.dart';
import 'package:digital_event/fetures/authentication/screen/forgot_password_screen.dart';
import 'package:digital_event/fetures/authentication/screen/set_new_password_screen.dart';
import 'package:digital_event/fetures/authentication/screen/sing_up_or_login_screen.dart';
import 'package:digital_event/fetures/authentication/screen/verify_otp_screen.dart';
import 'package:digital_event/fetures/home/screen/event_screen.dart';
import 'package:digital_event/fetures/home/screen/home_screen.dart';
import 'package:digital_event/fetures/onboarding/screen/onboarding_screen.dart';
import 'package:digital_event/fetures/splash/controller/splash_controller.dart';
import 'package:digital_event/fetures/splash/screen/splash_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../fetures/authentication/profile_information/face_recognition_screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen";
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String singUpLoginScreen = '/singUpLoginScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String verifyOtpScreen = '/verifyOtpScreen';
  static const String setNewPass = '/SetNewPassword';
  static const String authSuccessScreen = '/AuthSuccessScreen';
  static const String profileInformationScreen = '/profileInformationScreen';
  static const String setFaceRecognition = '/setFaceRecognition';
  static const String homeScreen = '/homeScreen';
  static const String eventScreen = '/EventScreen';
  static List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.onBoardingScreen,
      page: () => OnboardingScreen(),
      binding: BindingsBuilder((){
        // Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: AppRoutes.singUpLoginScreen,
      page: () => SingUpOrLoginScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.verifyOtpScreen,
      page: () => VerifyOtpScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.setNewPass,
      page: () => SetNewPasswordScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.authSuccessScreen,
      page: () => AuthSuccessScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.profileInformationScreen,
      page: () => ProfileInformationScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.setFaceRecognition,
      page: () => FaceRecognitionScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.eventScreen,
      page: () => EventScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
  ];
}
