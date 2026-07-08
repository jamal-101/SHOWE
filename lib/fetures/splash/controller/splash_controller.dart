import 'package:digital_event/core/route/app_routes.dart';
import 'package:get/get.dart';
import '../../../core/storage/local_storage.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () async {
      await LocalStorage.getAllPrefData();
      bool isLoggedIn = LocalStorage.isLogIn;
      String token = LocalStorage.token;
      if (isLoggedIn && token.isNotEmpty) {
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        Get.offAllNamed(AppRoutes.onBoardingScreen);
      }
    });
  }
}