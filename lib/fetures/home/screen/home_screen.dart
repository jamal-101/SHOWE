import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bottom_navigation_bar/screen/bottom_navigation_screen.dart';
import '../../my_event/controller/my_event_controller.dart';
import '../../notification/controller/notification_controller.dart';
import '../../scan/controller/scan_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController = Get.put(
      NotificationController(),
    );
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
                    onTap: () {
                      Get.toNamed(AppRoutes.notificationScreen)?.then((_) {
                        notificationController.fetchNotifications();
                      });
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            AppImages.bellIcon,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        Obx(() {
                          int count = notificationController.unreadCount.value;
                          if (count <= 0) return const SizedBox.shrink();
                          return Positioned(
                            top: -2.h,
                            right: -2.w,
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18.w,
                                minHeight: 18.h,
                              ),
                              child: Center(
                                child: Text(
                                  count > 99 ? '99+' : '$count',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
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
                      onTap: () {
                        final scanCtrl = Get.put(ScanController());
                        scanCtrl.startQRScan(context);
                      },
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
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 10.r,
              spreadRadius: 1,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.12),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.20),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.18),
                      width: 5.w,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.museoModerno(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        height: 1.05,
                      ),
                    ),
                    Image.asset(
                      imagePath,
                      height: 38.h,
                      width: 38.w,
                      color: textColor,
                      fit: BoxFit.contain,
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


  Widget _buildMyEventsCard() {
    final MyEventController myEventController = Get.put(MyEventController());

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.myEventScreen);
      },
      child: Container(
        width: double.infinity,
        height: 180.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 12.r,
              spreadRadius: 1,
              offset: Offset(4.w, 6.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFE5A000),
                      Color(0xFF0F4C5C),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.18),
                      width: 6.w,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withValues(alpha: 0.35),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.30),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 15.w,
                top: 43.h,
                child: Obx(() {
                  int count = myEventController.totalTickets.value;
                  bool isInitialLoading = myEventController.isLoading.value &&
                      myEventController.ticketList.isEmpty;
                  String displayCount = isInitialLoading
                      ? "00"
                      : (count < 10 ? "0$count" : "$count");
                  return ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF0F4C5C),
                          Color(0xFFE5A000),
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      displayCount,
                      style: GoogleFonts.museoModerno(
                        fontSize: 110.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My\nEvents",
                      style: GoogleFonts.montserrat(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F4C5C),
                        height: 1.1,
                      ),
                    ),
                    Image.asset(
                      AppImages.myEventImage,
                      height: 38.h,
                      width: 38.w,
                      color: const Color(0xFF0F4C5C),
                      fit: BoxFit.contain,
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
