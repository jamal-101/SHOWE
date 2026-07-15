import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bottom_navigation_bar/screen/bottom_navigation_screen.dart';
import '../../my_event/controller/my_event_controller.dart';
import '../../scan/controller/scan_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: 'Hi, Robert👋',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF676363),
                        ),
                        Text(
                          "Your events, brought\nto life",
                          style: GoogleFonts.montserrat(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F4C5C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.notificationScreen),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AppImages.bellIcon),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _buildHomeCard(
                      height: 273.h,
                      onTap: () =>
                          Get.put(ScanController()).pickImageAndNavigate(),
                      title: "Scan\nQR",
                      imagePath: AppImages.scanQar,
                      bgColor: const Color(0xFFF2A900),
                      textColor: const Color(0xFF0F4C5C),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildHomeCard(
                      height: 273.h,
                      onTap: () => Get.toNamed(AppRoutes.myProgramScreen),
                      title: "My\nProgrammes",
                      imagePath: AppImages.programImage,
                      bgColor: const Color(0xFF0F4C5C),
                      textColor: const Color(0xFFF7BD56),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: _buildHomeCard(
                      height: 199.h,
                      onTap: () => Get.toNamed(AppRoutes.eventScreen),
                      title: "Discover\nEvents",
                      imagePath: AppImages.discoverEvent,
                      bgColor: const Color(0xFFF2A900),
                      textColor: const Color(0xFF0F4C5C),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildHomeCard(
                      height: 199.h,
                      onTap: () => Get.toNamed(AppRoutes.walletScreen),
                      title: "My\nWallet",
                      imagePath: AppImages.myWalletImage,
                      bgColor: const Color(0xFF0F4C5C),
                      textColor: const Color(0xFFF7BD56),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _buildMyEventsCard(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildHomeCard({
  //   required VoidCallback onTap,
  //   required String title,
  //   required String imagePath,
  //   required Color bgColor,
  //   required Color textColor,
  //   double? height,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       height: height,
  //       padding: EdgeInsets.all(16.w),
  //       decoration: BoxDecoration(
  //         color: bgColor,
  //         borderRadius: BorderRadius.circular(16.r),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             title,
  //             style: GoogleFonts.montserrat(
  //               fontSize: 18.sp,
  //               fontWeight: FontWeight.bold,
  //               color: textColor,
  //             ),
  //           ),
  //           SizedBox(height: 10.h),
  //           Image.asset(
  //             imagePath,
  //             height: 35.h,
  //             width: 35.w,
  //             color: textColor,
  //             fit: BoxFit.contain,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildHomeCard({
    required VoidCallback onTap,
    required String title,
    required String imagePath,
    required Color bgColor,
    required Color textColor,
    double? height,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.2.w),
          boxShadow: [

            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              offset: Offset(4, 8),
              blurRadius: 12,
              spreadRadius: -5,
              // spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.5),
              offset: Offset(-3, -3),
              blurRadius: 8,
              spreadRadius: -5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                imagePath,
                height: 40.h,
                width: 40.w,
                color: textColor.withValues(alpha: 0.8),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildMyEventsCard() {
    final MyEventController myEventController = Get.put(MyEventController());
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.myEventScreen);
      },
      child: Container(
        width: double.infinity,
        height: 180.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              offset: Offset(7, 1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.7),
              offset: Offset(-3, -3),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.2.w),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFE5A11F), Color(0xFF0F4C5C)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 15.w,
              top: 25.h,
              child:
              Obx(() {
                if (myEventController.isLoading.value && myEventController.ticketList.isEmpty) {
                  return ShaderMask(
                    shaderCallback: (Rect bounds) => const LinearGradient(
                      colors: [Color(0xFFF2A900), Color(0xFF0F4C5C)],
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      "00",
                      style: GoogleFonts.museoModerno(
                        fontSize: 120.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.33,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                int count = myEventController.totalTickets.value;
                String displayCount = count < 10 ? "0$count" : "$count";
               return ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xFFF2A900),
                        Color(0xFF0F4C5C),
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    displayCount,
                    style: GoogleFonts.museoModerno(
                      fontSize: 120.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.33,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My\nEvents",
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F4C5C),
                      height: 1.1,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    AppImages.myEventImage,
                    height: 40.h,
                    width: 40.w,
                    color: const Color(0xFF0F4C5C),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
