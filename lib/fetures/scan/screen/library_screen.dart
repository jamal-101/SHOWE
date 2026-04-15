import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/global_widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/route/app_routes.dart';
import '../controller/scan_controller.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F4C5C), size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Programmes",
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F4C5C),
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        AppImages.programImages,
                        width: double.infinity,
                        height: 250.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0.h,
                      right: 18.w,
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.programDetailsScreen);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child:Image.asset(AppImages.scanIcon,height: 20.h,width: 20.w,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leadership & Development",
                        style: GoogleFonts.montserrat(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F4C5C),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "Description",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          color: Color(0xFF494949),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Leadership & Development (L&D) is a strategic, ongoing process aimed at enhancing an individual's ability to lead, influence, and drive positive results within an organization.",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF676767),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: controller.isPurchased
                    ? _buildDownloadButton()
                    : CommonButton(title: 'Buy Now', onTap: (){}),
              ),
              SizedBox(height: 60.h),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDownloadButton() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Center(
        child: Text(
          "Download",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
      ),
    );
  }
}
