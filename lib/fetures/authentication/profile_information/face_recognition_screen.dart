// import 'package:digital_event/core/common_text/common_text.dart';
// import 'package:digital_event/core/constans/app_colors.dart';
// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:digital_event/core/global_widget/common_button.dart';
// import 'package:digital_event/core/route/app_routes.dart';
// import 'package:digital_event/fetures/authentication/profile_information/profile_information_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class FaceRecognitionScreen extends StatelessWidget {
//   const FaceRecognitionScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileInformationController>(
//       init: ProfileInformationController(),
//       builder: (controller) {
//         return Scaffold(
//
//           appBar: AppBar(
//             backgroundColor: AppColors.appBackgroundColor,
//             elevation: 0,
//             leading: IconButton(
//               icon: const Icon(
//                 Icons.arrow_back_ios,
//                 color: Color(0xFF0F4C5C),
//                 size: 20,
//               ),
//               onPressed: () => Get.back(),
//             ),
//             title: Text(
//               "Set Face Recognition",
//               style: GoogleFonts.montserrat(
//                 color: const Color(0xFF0F4C5C),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20.sp,
//               ),
//             ),
//             centerTitle: true,
//           ),
//           bottomNavigationBar: Padding(
//             padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       Get.toNamed(AppRoutes.homeScreen);
//                     },
//                     child: Container(
//                       height: 48.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30.r),
//                         border: Border.all(color: const Color(0xFFF7BD56), width: 1.w),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Skip",
//                           style: GoogleFonts.montserrat(
//                             color: const Color(0xFFF7BD56),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(child: CommonButton(title: "Continue", onTap: () {
//                   controller.startScanning();
//                 })),
//               ],
//             ),
//           ),
//           body: Column(
//             children: [
//               SizedBox(height: 40.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 40.w),
//                 child: CommonText(
//                   text: 'Add a face recognition to make your account more secure',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey.shade600,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40.h),
//               Center(
//                 child: !controller.isScanning
//                     ? Image.asset(
//                   AppImages.faceRecognition,
//                   height: 294.h,
//                   width: 294.w,
//                 )
//                     : Container(
//                   height: 350.h,
//                   width: 300.w,
//                   decoration: BoxDecoration(
//                     image: const DecorationImage(
//                       image: AssetImage(AppImages.scanFace),
//                       fit: BoxFit.cover,
//                     ),
//                     border: Border.all(
//                       color: const Color(0xFF0F4C5C).withValues(alpha: 0.5),
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text("100%", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                       Text("Verifying your face...", style: TextStyle(color: Colors.white, fontSize: 12.sp)),
//                       SizedBox(height: 20.h),
//                     ],
//                   ),
//                 ),
//               ),
//               const Spacer(),
//             ],
//           ),
//
//         );
//       },
//     );
//   }
// }


import 'package:camera/camera.dart';
import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_colors.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:digital_event/fetures/authentication/profile_information/profile_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FaceRecognitionScreen extends StatelessWidget {
  const FaceRecognitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileInformationController>(
      init: ProfileInformationController(),
      builder: (controller) {
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
              onPressed: () => Get.back(),
            ),
            title: Text(
              "Set Face Recognition",
              style: GoogleFonts.montserrat(
                color: const Color(0xFF0F4C5C),
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.homeScreen);
                    },
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(color: const Color(0xFFF7BD56), width: 1.w),
                      ),
                      child: Center(
                        child: Text(
                          "Skip",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFFF7BD56),
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
                  child: CommonButton(
                    title: "Continue",
                    onTap: () {
                      if (!controller.isScanning) {
                        controller.startScanning();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: CommonText(
                  text: 'Add a face recognition to make your account more secure',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: !controller.isScanning
                    ? Image.asset(
                  AppImages.faceRecognition,
                  height: 294.h,
                  width: 294.w,
                )
                    : Container(
                  height: 380.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: const Color(0xFFF7BD56),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.r),
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        if (controller.isCameraInitialized &&
                            controller.cameraController != null)
                          Builder(
                            builder: (context) {
                              var camera = controller.cameraController!.value;
                              var scale = controller.isScanning ? 1.3 : 1.0;
                              return Transform.scale(
                                scale: scale,
                                child: Center(
                                  child: AspectRatio(
                                    aspectRatio: 1 / camera.aspectRatio,
                                    child: CameraPreview(controller.cameraController!),
                                  ),
                                ),
                              );
                            },
                          ),
                        Positioned(
                          bottom: 20.h,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "100%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Verifying your face...",
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
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}