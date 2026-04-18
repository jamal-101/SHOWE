import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/constans/app_images.dart';


class OnboardingController extends GetxController {
  int currentIndex = 0;
  double dragOffset = 0.0;

  List<Map<String, String>> onboardingData = [
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
  ];

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      currentIndex += 1;
      update();
    }
  }

  // void onDragUpdate(DragUpdateDetails details, double maxWidth) {
  //   double threshold = maxWidth * 0.5;
  //   dragOffset += details.delta.dx;
  //
  //   if (dragOffset < 0) dragOffset = 0;
  //   if (dragOffset > maxWidth - 60.w) dragOffset = maxWidth - 60.w;
  //
  //   if (dragOffset >= threshold) {
  //     dragOffset = 0;
  //     Get.offAllNamed(AppRoutes.singUpLoginScreen);
  //   }
  //   update();
  // }
  //
  // void onDragEnd() {
  //   dragOffset = 0.0;
  //   update();
  // }
}