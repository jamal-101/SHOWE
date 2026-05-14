import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bottom_navigation_bar/screen/bottom_navigation_screen.dart';
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
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
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
      child: Container(
        height: height,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: 10.h),
            Image.asset(
              imagePath,
              height: 35.h,
              width: 35.w,
              color: textColor,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyEventsCard() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.myEventScreen);
      },
      child: Container(
        width: double.infinity,
        height: 180.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
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
              ShaderMask(
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
                  "03",
                  style: GoogleFonts.museoModerno(
                    fontSize: 120.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                    color: Colors.white,
                  ),
                ),
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
