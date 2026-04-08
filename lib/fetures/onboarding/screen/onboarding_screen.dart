import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/onboarding_controller.dart';



class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());
  OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        var currentData = controller.onboardingData[controller.currentIndex.value];
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(currentData['image']!, fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          currentData['title']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.museoModerno(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F4C5C),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          currentData['description']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      bool isLastPage = controller.currentIndex.value == controller.onboardingData.length - 1;
                      return _buildAnimatedButton(isLastPage);
                    }),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
  Widget _buildAnimatedButton(bool isLastPage) {
    return InkWell(
      onTap: () {
        if (isLastPage) {
          Get.offAllNamed(AppRoutes.singUpLoginScreen);
        } else {
          controller.nextPage();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: isLastPage ? 8.w : 24.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF2A900),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: isLastPage
            ? _buildGetStartedLayout()
            : _buildNextLayout(),
      ),
    );
  }
  Widget _buildNextLayout() {
    return Center(
      child: Text(
        "Next",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
  Widget _buildGetStartedLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 48.w,
          height: 48.h,
          decoration: const BoxDecoration(
            color: Color(0xFFFBF5E9),
            shape: BoxShape.circle,
          ),
          child:Padding(
            padding: const EdgeInsets.all(14),
            child: Image.asset(AppImages.playVideo,fit: BoxFit.contain),
          ),
        ),
        Text(
          "Get Started",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Row(
          children: const [
            Icon(Icons.arrow_forward_ios, color: Color(0xFFFBF5E9), size: 16),
            Icon(Icons.arrow_forward_ios, color: Color(0xFFFBF5E9), size: 16),
            Icon(Icons.arrow_forward_ios, color: Color(0xFFFBF5E9), size: 16),
          ],
        ),
      ],
    );
  }
}


