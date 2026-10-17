// import 'package:camera/camera.dart';
// import 'package:digital_event/core/common_text/common_text.dart';
// import 'package:digital_event/core/constans/app_colors.dart';
// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:digital_event/core/route/app_routes.dart';
// import 'package:digital_event/fetures/authentication/profile_information/profile_information_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../screen/rounded_rect_border_painter.dart';
//
// class FaceRecognitionLoginScreen extends StatelessWidget {
//   const FaceRecognitionLoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileInformationController>(
//       init: ProfileInformationController(),
//       builder: (controller) {
//         bool isBusy = controller.isScanningLogin;
//
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.appBackgroundColor,
//             elevation: 0,
//             leading: IconButton(
//               icon: const Icon(
//                 Icons.arrow_back_ios,
//                 color: Color(0xFF0F4C5C),
//                 size: 20,
//               ),
//               onPressed: isBusy ? null : () => Get.back(),
//             ),
//             title: Text(
//               "Set Face Recognition Login",
//               style: GoogleFonts.montserrat(
//                 color: const Color(0xFF0F4C5C),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20.sp,
//               ),
//             ),
//             centerTitle: true,
//           ),
//             bottomNavigationBar: SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 10.h),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: InkWell(
//                         onTap: isBusy
//                             ? null
//                             : () {
//                           Get.toNamed(AppRoutes.singUpLoginScreen);
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           height: 48.h,
//                           decoration: BoxDecoration(
//                             color: isBusy ? Colors.grey.shade200 : Colors.white,
//                             borderRadius: BorderRadius.circular(30.r),
//                             border: Border.all(
//                               color: isBusy ? Colors.grey.shade300 : const Color(0xFFF7BD56),
//                               width: 1.w,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Skip",
//                               style: GoogleFonts.montserrat(
//                                 color: isBusy ? Colors.grey.shade400 : const Color(0xFFF7BD56),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16.sp,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12.w),
//                     Expanded(
//                       child: InkWell(
//                         onTap: isBusy
//                             ? null
//                             : () {
//                           controller.startFaceLogin();
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           height: 48.h,
//                           decoration: BoxDecoration(
//                             color: isBusy
//                                 ? const Color(0xFF0F4C5C).withValues(alpha: 0.4)
//                                 : const Color(0xFF0F4C5C),
//                             borderRadius: BorderRadius.circular(30.r),
//                           ),
//                           child: Center(
//                            child:  Text(
//                               "Continue",
//                               style: GoogleFonts.montserrat(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16.sp,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 20.h),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 40.w),
//                     child: CommonText(
//                       text:
//                       'Add a face recognition to make your account more secure',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.grey.shade600,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30.h),
//                   Center(
//                     child: !controller.isScanningLogin
//                         ? Image.asset(
//                       AppImages.faceRecognition,
//                       height: 294.h,
//                       width: 294.w,
//                     )
//                       //   : Container(
//                       // height: 380.h,
//                       // width: 300.w,
//                       // decoration: BoxDecoration(
//                       //   borderRadius: BorderRadius.circular(20.r),
//                       //   border: Border.all(
//                       //     color: Color(0xFFF7BD56),
//                       //     width: 2,
//                       //   ),
//                       // ),
//                         : TweenAnimationBuilder<double>(
//                       tween: Tween<double>(begin: 0.0, end: 1.0),
//                       duration: const Duration(seconds: 3),
//                       builder: (context, progressValue, child) {
//                         return CustomPaint(
//                           painter: RoundedRectBorderPainter(
//                             progress: progressValue,
//                             color: const Color(0xFFF7BD56),
//                             strokeWidth: 3.0,
//                             radius: 20.r,
//                           ),
//                           child: Container(
//                             height: 410.h,
//                             width: 300.w,
//                             child: child,
//                           ),
//                         );
//                       },
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(18.r),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           fit: StackFit.expand,
//                           children: [
//                             controller.isCameraInitialized &&
//                                 controller.cameraController != null
//                                 ? CameraPreview(
//                                 controller.cameraController!)
//                                 : const Center(
//                               child: CircularProgressIndicator(
//                                 color: Color(0xFFF7BD56),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 20.h,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     "Verifying...",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Please keep your face still",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12.sp,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:camera/camera.dart';
import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:digital_event/fetures/authentication/profile_information/profile_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screen/rounded_rect_border_painter.dart';

class FaceRecognitionLoginScreen extends StatelessWidget {
  const FaceRecognitionLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileInformationController>(
      init: ProfileInformationController(),
      builder: (controller) {
        bool isBusy = controller.isScanningLogin;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF0F4C5C),
                size: 20,
              ),
              onPressed: isBusy ? null : () => Get.back(),
            ),
            title: Text(
              "Set Face Recognition Login",
              style: GoogleFonts.montserrat(
                color: const Color(0xFF0F4C5C),
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: isBusy
                          ? null
                          : () {
                        Get.toNamed(AppRoutes.singUpLoginScreen);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: isBusy ? Colors.grey.shade200 : Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: isBusy
                                ? Colors.grey.shade300
                                : const Color(0xFFF7BD56),
                            width: 1.w,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Skip",
                            style: GoogleFonts.montserrat(
                              color: isBusy
                                  ? Colors.grey.shade400
                                  : const Color(0xFFF7BD56),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: InkWell(
                      onTap: isBusy
                          ? null
                          : () {
                        controller.startFaceLogin();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: isBusy
                              ? const Color(0xFF0F4C5C).withValues(alpha: 0.4)
                              : const Color(0xFF0F4C5C),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: CommonText(
                      text:
                      'Add a face recognition to make your account more secure',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: !controller.isScanningLogin
                        ? Image.asset(
                      AppImages.faceRecognition,
                      height: 294.h,
                      width: 294.w,
                    )
                        : Obx(() {
                      return CustomPaint(
                        painter: RoundedRectBorderPainter(
                          progress: controller.borderProgress.value,
                          color: const Color(0xFFF7BD56),
                          strokeWidth: 5.0,
                          radius: 20.r,
                        ),
                        child: SizedBox(
                          height: 410.h,
                          width: 300.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.r),
                            child: Stack(
                              alignment: Alignment.center,
                              fit: StackFit.expand,
                              children: [
                                if (controller.isCameraInitialized &&
                                    controller.cameraController != null &&
                                    controller.cameraController!.value.isInitialized)
                                  Builder(
                                    builder: (context) {
                                      var camera = controller.cameraController!.value;
                                      var scale = controller.isScanningLogin ? 1.3 : 1.0;
                                      return Transform.scale(
                                        scale: scale,
                                        child: Center(
                                          child: AspectRatio(
                                            aspectRatio: 1 / camera.aspectRatio,
                                            child: CameraPreview(
                                              controller.cameraController!,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                else
                                  const SizedBox.shrink(),
                                Positioned(
                                  bottom: 20.h,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Verifying...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Please keep your face still",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),


                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}