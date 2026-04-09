import 'package:digital_event/core/common_text/common_text.dart';
import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bottom_navigation_bar/screen/bottom_navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      body: SafeArea(
        child: Padding(
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
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(AppImages.bellIcon),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              SizedBox(
                height: 450.h,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  childAspectRatio: 0.85,
                  children: [
                    _buildHomeCard(
                      onTap: (){

                      },
                      title: "Scan\nQR",
                      imagePath: AppImages.scanQar,
                      bgColor: const Color(0xFFF2A900),
                      textColor: const Color(0xFF0F4C5C),
                    ),
                    _buildHomeCard(
                      onTap: (){},
                      title: "My\nProgrammes",
                      imagePath: AppImages.programImage,
                      bgColor: const Color(0xFF0F4C5C),
                      textColor: const Color(0xFFF7BD56),
                    ),
                    _buildHomeCard(
                      onTap: (){
                        Get.toNamed(AppRoutes.eventScreen);
                      },
                      title: "Discover\nEvents",
                      imagePath: AppImages.discoverEvent,
                      bgColor: const Color(0xFFF2A900),
                      textColor: const Color(0xFF0F4C5C),
                    ),
                    _buildHomeCard(
                      onTap: (){},
                      title: "My\nWallet",
                      imagePath: AppImages.myWalletImage,
                      bgColor: const Color(0xFF0F4C5C),
                      textColor: const Color(0xFFF7BD56),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              _buildMyEventsCard(),
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
    return Container(
      width: double.infinity,
      height: 160.h,
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
        children: [
          Positioned(
            right: 20.w,
            bottom: -10.h,
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
                  fontSize: 140.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
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
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F4C5C),
                  ),
                ),
                Image.asset(AppImages.myEventImage,height: 30.h,width: 30.w,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
