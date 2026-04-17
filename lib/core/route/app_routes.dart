import 'package:digital_event/fetures/authentication/profile_information/profile_information_screen.dart';
import 'package:digital_event/fetures/authentication/screen/auth_success_screen.dart';
import 'package:digital_event/fetures/authentication/screen/forgot_password_screen.dart';
import 'package:digital_event/fetures/authentication/screen/set_new_password_screen.dart';
import 'package:digital_event/fetures/authentication/screen/sing_up_or_login_screen.dart';
import 'package:digital_event/fetures/authentication/screen/verify_otp_screen.dart';
import 'package:digital_event/fetures/favorites/screen/favorite_screen.dart';
import 'package:digital_event/fetures/home/screen/event_screen.dart';
import 'package:digital_event/fetures/home/screen/home_screen.dart';
import 'package:digital_event/fetures/my_program/screen/my_program_screen.dart';
import 'package:digital_event/fetures/notification/screen/notification_screen.dart';
import 'package:digital_event/fetures/onboarding/screen/onboarding_screen.dart';
import 'package:digital_event/fetures/profile/screen/change_password_screen.dart';
import 'package:digital_event/fetures/profile/screen/delet_verification_screen.dart';
import 'package:digital_event/fetures/profile/screen/help_center_screen.dart';
import 'package:digital_event/fetures/profile/screen/notification_setting_screen.dart';
import 'package:digital_event/fetures/profile/screen/privacy_policy_screen.dart';
import 'package:digital_event/fetures/profile/screen/profile_information_screen.dart';
import 'package:digital_event/fetures/profile/screen/profile_screen.dart';
import 'package:digital_event/fetures/profile/screen/security_screen.dart';
import 'package:digital_event/fetures/profile/screen/terms_condition_screen.dart';
import 'package:digital_event/fetures/scan/controller/scan_controller.dart';
import 'package:digital_event/fetures/scan/screen/library_screen.dart';
import 'package:digital_event/fetures/scan/screen/program_details_screen.dart';
import 'package:digital_event/fetures/splash/controller/splash_controller.dart';
import 'package:digital_event/fetures/splash/screen/splash_screen.dart';
import 'package:digital_event/fetures/trip_plan/screen/trip_plan_screen.dart';
import 'package:digital_event/fetures/wallet/screen/wallet_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../fetures/authentication/profile_information/face_recognition_screen.dart';
import '../../fetures/my_event/screen/my_event_screen.dart';
import '../../fetures/trip_plan/controller/trip_plan_controller.dart';

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
  static const String favoriteScreen = '/favoriteScreen';
  static const String tripPlanScreen = '/tripPlanScreen';
  static const String walletScreen = '/walletScreen';
  static const String myEventScreen = '/myEventScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String profileScreen  = '/profileScreen';
  static const String updateProfileInformationScreen = '/updateProfileInformationScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String notificationSettingScreen = '/notificationSettingScreen';
  static const String securityScreen = '/securityScreen';
  static const String helpCenterScreen = '/helpCenterScreen';
  static const String termsConditionScreen = '/termsConditionScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String deleteVerificationScreen = '/deleteVerificationScreen';
  static const String myProgramScreen = '/myProgramScreen';
  static const String libraryScreen = '/libraryScreen';
  static const String programDetailsScreen = '/programDetailsScreen';
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
    GetPage(
      name: AppRoutes.favoriteScreen,
      page: () => FavoriteScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.tripPlanScreen,
      page: () => TripPlanScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.walletScreen,
      page: () => WalletScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.myEventScreen,
      page: () => MyEventScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => NotificationScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.updateProfileInformationScreen,
      page: () => UpdateProfileInformationScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.notificationSettingScreen,
      page: () => NotificationSettingScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.securityScreen,
      page: () => SecurityScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.helpCenterScreen,
      page: () => HelpCenterScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.termsConditionScreen,
      page: () => TermsConditionScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.privacyPolicyScreen,
      page: () => PrivacyPolicyScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.deleteVerificationScreen,
      page: () => DeleteVerificationScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.myProgramScreen,
      page: () => MyProgramScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.libraryScreen,
      page: () => LibraryScreen(),
      binding: BindingsBuilder(() {
        // Get.lazyPut<TripPlanController>(() => TripPlanController());
      }),
    ),
    GetPage(
      name: AppRoutes.programDetailsScreen,
      page: () => ProgramDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.put<ScanController>(ScanController());
      }),
    ),
  ];
}
