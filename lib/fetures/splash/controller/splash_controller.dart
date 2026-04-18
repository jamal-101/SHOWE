import 'package:digital_event/core/route/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 6), () {
      Get.offNamed(AppRoutes.onBoardingScreen);
    });
  }
}
