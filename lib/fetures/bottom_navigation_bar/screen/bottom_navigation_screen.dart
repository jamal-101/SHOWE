import 'package:digital_event/core/constans/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/bottom_navigation_controller.dart';

class BottomNavBar extends StatelessWidget {

  final int selectedIndex;
  BottomNavBar({super.key, this.selectedIndex = 0});
  final controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.currentIndex.value = selectedIndex;
    });
    return Obx(
      () => Container(
        height: 64.h,
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 25.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          // color: const Color(0x8F8F8F1A).withValues(alpha: 0.1),
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(999.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, AppImages.homeIcon, "Home"),
            _buildNavItem(1, AppImages.favoriteIcon, "Favourites"),
            _buildNavItem(2, AppImages.tripPlan, "Trip Plan"),
            _buildNavItem(3, AppImages.profileIcon, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String imagePath, String label) {
    bool isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 24.h,
              width: 24.w,
              color: isSelected
                  ? const Color(0xFFF2A900)
                  : const Color(0xFF0F4C5C),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFFF2A900)
                    : const Color(0xFF0F4C5C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
