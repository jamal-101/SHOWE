import 'package:digital_event/fetures/authentication/screen/forgot_password_screen.dart';
import 'package:digital_event/fetures/authentication/screen/sing_up_or_login_screen.dart';
import 'package:digital_event/fetures/authentication/screen/verify_otp_screen.dart';
import 'package:digital_event/fetures/onboarding/screen/onboarding_screen.dart';
import 'package:digital_event/fetures/splash/controller/splash_controller.dart';
import 'package:digital_event/fetures/splash/screen/splash_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen";
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String singUpLoginScreen = '/singUpLoginScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String verifyOtpScreen = '/verifyOtpScreen';
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
  ];
}
