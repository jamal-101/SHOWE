// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:digital_event/core/route/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controller/onboarding_controller.dart';
//
// class OnboardingScreen extends StatelessWidget {
//   final OnboardingController controller = Get.put(OnboardingController());
//   OnboardingScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         var currentData =
//             controller.onboardingData[controller.currentIndex.value];
//         return Stack(
//           children: [
//             Positioned.fill(
//               child: Image.asset(currentData['image']!, fit: BoxFit.cover),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.35,
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40.r),
//                     topRight: Radius.circular(40.r),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         SizedBox(height: 40.h),
//                         Text(
//                           currentData['title']!,
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.museoModerno(
//                             fontSize: 24.sp,
//                             fontWeight: FontWeight.w600,
//                             color: const Color(0xFF0F4C5C),
//                           ),
//                         ),
//                         SizedBox(height: 15.h),
//                         Text(
//                           currentData['description']!,
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.montserrat(
//                             fontSize: 16.sp,
//                             color: Color(0xFF5B5A5A),
//                             fontWeight: FontWeight.w400,
//                             // height: 1.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Obx(() {
//                       bool isLastPage =
//                           controller.currentIndex.value ==
//                           controller.onboardingData.length - 1;
//                       return _buildAnimatedButton(isLastPage);
//                     }),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
//
//   Widget _buildAnimatedButton(bool isLastPage) {
//     return InkWell(
//       onTap: () {
//         if (isLastPage) {
//         } else {
//           controller.nextPage();
//         }
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         width: double.infinity,
//         height: 60.h,
//         padding: EdgeInsets.symmetric(horizontal: isLastPage ? 8.w : 24.w),
//         decoration: BoxDecoration(
//           color: const Color(0xFFF2A900),
//           borderRadius: BorderRadius.circular(50.r),
//         ),
//         child: isLastPage ? _buildGetStartedLayout() : _buildNextLayout(),
//       ),
//     );
//   }
//   Widget _buildNextLayout() {
//     return Center(
//       child: Text(
//         "Next",
//         style: TextStyle(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.w600,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGetStartedLayout() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double maxWidth = constraints.maxWidth;
//         return Container(
//           width: double.infinity,
//           height: 60.h,
//           decoration: BoxDecoration(
//             color: const Color(0xFFF2A900),
//             borderRadius: BorderRadius.circular(50.r),
//           ),
//           child: Stack(
//             children: [
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 20.w),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
//                       Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
//                       Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
//                     ],
//                   ),
//                 ),
//               ),
//               Obx(() => GestureDetector(
//                 onHorizontalDragUpdate: (details) =>
//                     controller.onDragUpdate(details, maxWidth),
//                 onHorizontalDragEnd: (details) =>
//                     controller.onDragEnd(),
//                 child: Transform.translate(
//                   offset: Offset(controller.dragOffset.value, 0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 50.w,
//                         height: 50.h,
//                         margin: EdgeInsets.all(5.w),
//                         decoration: const BoxDecoration(
//                           color: Color(0xFFFBF5E9),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Image.asset(AppImages.playVideo, fit: BoxFit.contain),
//                         ),
//                       ),
//                       SizedBox(width: 16.w),
//                       Text(
//                         "Get Started",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                           color: const Color(0xFFF7F4EF),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

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
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 30.h,
                  ),
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

  // Widget _buildGetStartedLayout(OnboardingController controller) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       double maxWidth = constraints.maxWidth;
  //       return Stack(
  //         children: [
  //           Align(
  //             alignment: Alignment.centerRight,
  //             child: Padding(
  //               padding: EdgeInsets.only(right: 20.w),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: const [
  //                   Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
  //                   Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
  //                   Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           GestureDetector(
  //             onHorizontalDragUpdate: (details) =>
  //                 controller.onDragUpdate(details, maxWidth),
  //             onHorizontalDragEnd: (details) =>
  //                 controller.onDragEnd(),
  //             child: Transform.translate(
  //               offset: Offset(controller.dragOffset, 0),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     width: 50.w,
  //                     height: 50.h,
  //                     margin: EdgeInsets.all(5.w),
  //                     decoration: const BoxDecoration(
  //                       color: Color(0xFFFBF5E9),
  //                       shape: BoxShape.circle,
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(12),
  //                       child: Image.asset(AppImages.playVideo, fit: BoxFit.contain),
  //                     ),
  //                   ),
  //                   SizedBox(width: 16.w),
  //                   Text(
  //                     "Get Started",
  //                     style: GoogleFonts.montserrat(
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.w600,
  //                       color: const Color(0xFFF7F4EF),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
          child: Image.asset(
            AppImages.playVideo,
            fit: BoxFit.contain,
          ),
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
                    Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
                    Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
                    Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
