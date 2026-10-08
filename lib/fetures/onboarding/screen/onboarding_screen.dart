import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../../core/constans/app_images.dart';
import '../../../core/route/app_routes.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      body: GetBuilder<OnboardingController>(
        init: OnboardingController(),
        builder: (controller) {
          var currentData = controller.onboardingData[controller.currentIndex];
          bool isLastPage =
              controller.currentIndex == controller.onboardingData.length - 1;
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(currentData['image']!, fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 24.w,
                  //   vertical: 30.h,
                  // ),
                  padding: EdgeInsets.only(
                    left: 24.w,
                    right: 24.w,
                    top: 30.h,
                    // 🔹 সিস্টেম নেভিগেশন বারের ওপর সুন্দরভাবে স্পেস রাখার জন্য ডায়নামিক প্যাডিং
                    bottom: bottomInset > 0 ? bottomInset + 10.h : 24.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 40.h),
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
                            style: GoogleFonts.montserrat(
                              fontSize: 16.sp,
                              color: const Color(0xFF5B5A5A),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      _buildAnimatedButton(isLastPage, controller),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedButton(
    bool isLastPage,
    OnboardingController controller,
  ) {
    return InkWell(
      onTap: () {
        if (!isLastPage) {
          controller.nextPage();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF2A900),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: isLastPage ? _buildGetStartedLayout() : _buildNextLayout(),
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
    return Container(
      decoration: BoxDecoration(),
      height: 55.h,
      child: SlideAction(
        onSubmit: () {
          Get.offAllNamed(AppRoutes.singUpLoginScreen);
          return null;
        },
        submittedIcon: const SizedBox.shrink(),
        height: 55.h,
        elevation: 0,
        borderRadius: 50.r,
        outerColor: const Color(0xFFF2A900),
        innerColor: const Color(0xFFFBF5E9),
        sliderButtonIcon: SizedBox(
          height: 25.h,
          width: 25.w,
          child: Image.asset(AppImages.playVideo, fit: BoxFit.contain),
        ),
        sliderButtonIconPadding: 10.w,
        child: Shimmer.fromColors(
          baseColor: Color(0xFFFEFEFEBF).withValues(alpha: 0.7),
          highlightColor: Color(0xFFFEFEFE),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 70.w),
              Text(
                "Get Started",
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFF7F4EF),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
