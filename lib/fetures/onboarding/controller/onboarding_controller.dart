// import 'package:get/get.dart';
//
// import '../../../core/constans/app_string.dart';
//
//
//
// class OnboardingController extends GetxController {
//   RxInt currentIndex = 0.obs;
//
//   RxList<Map<String, String>> onboardingData = [
//     {
//       'title': AppString.onb1title,
//       'description': AppString.onb1Description,
//     },
//     {
//       'title': AppString.onb2title,
//       'description': AppString.onb2Description,
//     },
//   ].obs;
//
//   void nextPage() {
//     if (currentIndex.value < onboardingData.length - 1) {
//       currentIndex.value += 1;
//     }
//   }
//
//
//   void previousPage() {
//     if (currentIndex.value > 0) {
//       currentIndex.value--;
//     } else {
//       Get.back();
//     }
//   }
// }

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/constans/app_images.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxList<Map<String, String>> onboardingData = [
    {
      'title': "Exploring Upcoming And Nearby Events",
      'description': "Your digital companion for events, performances and experiences.",
      'image': AppImages.onBoarding1,
    },
    {
      'title': "Scan For Instant Access at Any Event",
      'description': "Simply scan a QR code at the event or on your email to unlock your event program in seconds",
      'image': AppImages.onBoarding2,
    },
  ].obs;
  void nextPage() {
    if (currentIndex.value < onboardingData.length - 1) {
      currentIndex.value += 1;
    }
  }
}