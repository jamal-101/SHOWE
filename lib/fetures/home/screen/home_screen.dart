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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
              SizedBox(height: 30.h),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: 0.9,
                children: [
                  _buildHomeCard(
                    onTap: () => Get.put(ScanController()).pickImageAndNavigate(),
                    title: "Scan\nQR",
                    imagePath: AppImages.scanQar,
                    bgColor: const Color(0xFFF2A900),
                    textColor: const Color(0xFF0F4C5C),
                  ),
                  _buildHomeCard(
                    onTap: () => Get.toNamed(AppRoutes.myProgramScreen),
                    title: "My\nProgrammes",
                    imagePath: AppImages.programImage,
                    bgColor: const Color(0xFF0F4C5C),
                    textColor: const Color(0xFFF7BD56),
                  ),
                  _buildHomeCard(
                    onTap: () => Get.toNamed(AppRoutes.eventScreen),
                    title: "Discover\nEvents",
                    imagePath: AppImages.discoverEvent,
                    bgColor: const Color(0xFFF2A900),
                    textColor: const Color(0xFF0F4C5C),
                  ),
                  _buildHomeCard(
                    onTap: () => Get.toNamed(AppRoutes.walletScreen),
                    title: "My\nWallet",
                    imagePath: AppImages.myWalletImage,
                    bgColor: const Color(0xFF0F4C5C),
                    textColor: const Color(0xFFF7BD56),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
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
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
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
        constraints: BoxConstraints(minHeight: 130.h),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFE5A11F),
              Color(0xFF0F4C5C),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              right: 25.w,
              child: ShaderMask(
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
                  "02",
                  style: GoogleFonts.montserrat(
                    fontSize: 110.sp,
                    fontWeight: FontWeight.bold,
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "My\nEvents",
                    style: GoogleFonts.montserrat(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F4C5C),
                    ),
                  ),
                  Image.asset(
                    AppImages.myEventImage,
                    height: 30.h,
                    width: 30.w,
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
