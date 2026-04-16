import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/constans/app_images.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxList<Map<String, String>> onboardingData = [
    {
      'title': "Be part of the moment",
      'description': "Your digital companion for events, performances and experiences.",
      'image': AppImages.secondOnboardingImage,
    },
    {
      'title': "Scan to step into the story",
      'description': "Simply scan a QR code at the event or on your email to unlock your event program in seconds",
      'image': AppImages.firstOnboardingImage,
    },
  ].obs;
  void nextPage() {
    if (currentIndex.value < onboardingData.length - 1) {
      currentIndex.value += 1;
    }
  }
}