import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/constans/app_images.dart';
import '../../../core/route/app_routes.dart';

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


  var dragOffset = 0.0.obs;
  final double maxDragDistance = 250.0;

  void onDragUpdate(DragUpdateDetails details) {
    dragOffset.value += details.delta.dx;
    if (dragOffset.value < 0) dragOffset.value = 0;
    if (dragOffset.value > maxDragDistance) {
      dragOffset.value = maxDragDistance;
      Get.offAllNamed(AppRoutes.singUpLoginScreen);
    }
  }

  void onDragEnd() {
    if (dragOffset.value < maxDragDistance) {
      dragOffset.value = 0;
    }
  }
}