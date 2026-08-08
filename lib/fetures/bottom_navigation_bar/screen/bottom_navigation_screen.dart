// import 'package:digital_event/core/constans/app_images.dart';
// import 'package:digital_event/core/route/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controller/bottom_navigation_controller.dart';
//
// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   BottomNavBar({super.key, this.selectedIndex = 0});
//   final controller = Get.put(BottomNavigationController());
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.currentIndex.value = selectedIndex;
//     });
//     return Obx(() {
//       bool isHome = selectedIndex == 0;
//       return Container(
//         height: 70.h,
//         margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 25.h),
//         decoration: BoxDecoration(
//           color: Colors.grey.withValues(alpha: 0.2),
//           borderRadius: BorderRadius.circular(999.r),
//           boxShadow: [
//             if (isHome) ...[
//               BoxShadow(
//                 color: const Color(0xFF8F8F8F).withValues(alpha: 0.1),
//                 blurRadius: 1,
//                 spreadRadius: 2,
//                 offset: const Offset(-1, 0),
//               ),
//               BoxShadow(
//                 color: Colors.white.withValues(alpha: 0.9),
//                 offset: const Offset(-2, -2),
//                 blurRadius: 2,
//               ),
//             ] else ...[
//               BoxShadow(
//                 color: Colors.white.withValues(alpha: 0.9),
//                 blurRadius: 15,
//                 spreadRadius: 2,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(width: 5.w),
//             _buildNavItem(0, AppImages.homeIcon, "Home"),
//             _buildNavItem(1, AppImages.favoriteIcon, "Favourites"),
//             _buildNavItem(2, AppImages.tripPlan, "Trip Plan"),
//             _buildNavItem(3, AppImages.profileIcon, "Profile"),
//             SizedBox(width: 5.w),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _buildNavItem(int index, String imagePath, String label) {
//     final Color selectedColor = const Color(0xFFF2A900);
//     final Color unselectedColor = const Color(0xFF0F4C5C);
//     return Expanded(
//       child: GestureDetector(
//         onTap: () async {
//           if (controller.currentIndex.value == index) return;
//           controller.changeIndex(index);
//           switch (index) {
//             case 0: Get.toNamed(AppRoutes.homeScreen); break;
//             case 1: Get.toNamed(AppRoutes.favoriteScreen); break;
//             case 2: Get.toNamed(AppRoutes.tripPlanScreen); break;
//             case 3: Get.toNamed(AppRoutes.profileScreen); break;
//           }
//           // switch (index) {
//           //   case 0: Get.offAllNamed(AppRoutes.homeScreen); break;
//           //   case 1: Get.offAllNamed(AppRoutes.favoriteScreen); break;
//           //   case 2: Get.offAllNamed(AppRoutes.tripPlanScreen); break;
//           //   case 3: Get.offAllNamed(AppRoutes.profileScreen); break;
//           // }
//           // controller.changeIndex(selectedIndex);
//         },
//         child: Obx(() {
//           bool isSelected = controller.currentIndex.value == index;
//
//         return  Center(
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               height: 56.h,
//               width: 76.w,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: isSelected ? const Color(0xFF0F4C5C) : Colors
//                     .transparent,
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset(
//                     imagePath,
//                     height: 20.h,
//                     width: 20.w,
//                     color: isSelected ? selectedColor : unselectedColor,
//                   ),
//                   SizedBox(height: 2.h),
//                   Text(
//                     label,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: GoogleFonts.montserrat(
//                       fontSize: 9.sp,
//                       fontWeight: isSelected ? FontWeight.bold : FontWeight
//                           .w500,
//                       color: isSelected ? selectedColor : unselectedColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//         ),
//       ),
//     );
//   }
// }

import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/bottom_navigation_controller.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  BottomNavBar({super.key, this.selectedIndex = 0});

  final controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int currentIndex = controller.currentIndex.value;
      bool isHome = selectedIndex == 0;

      return Container(
        height: 70.h,
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 25.h),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(999.r),
          boxShadow: [
            if (isHome) ...[
              BoxShadow(
                color: const Color(0xFF8F8F8F).withValues(alpha: 0.1),
                blurRadius: 1,
                spreadRadius: 2,
                offset: const Offset(-1, 0),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.9),
                offset: const Offset(-2, -2),
                blurRadius: 2,
              ),
            ] else ...[
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.9),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 5.w),
            _buildNavItem(0, AppImages.homeIcon, "Home", currentIndex),
            _buildNavItem(1, AppImages.favoriteIcon, "Favourites", currentIndex),
            _buildNavItem(2, AppImages.tripPlan, "Trip Plan", currentIndex),
            _buildNavItem(3, AppImages.profileIcon, "Profile", currentIndex),
            SizedBox(width: 5.w),
          ],
        ),
      );
    });
  }

  Widget _buildNavItem(int index, String imagePath, String label, int activeIndex) {
    bool isSelected = activeIndex == index;
    final Color selectedColor = const Color(0xFFF2A900);
    final Color unselectedColor = const Color(0xFF0F4C5C);

    return Expanded(
      child: GestureDetector(
        onTap: () async {
          if (controller.currentIndex.value == index) return;
          controller.changeIndex(index);

          switch (index) {
            case 0: await Get.toNamed(AppRoutes.homeScreen); break;
            case 1: await Get.toNamed(AppRoutes.favoriteScreen); break;
            case 2: await Get.toNamed(AppRoutes.tripPlanScreen); break;
            case 3: await Get.toNamed(AppRoutes.profileScreen); break;
          }

          controller.currentIndex.value = selectedIndex;
          controller.currentIndex.refresh();
        },
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 56.h,
            width: 76.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0F4C5C) : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  imagePath,
                  height: 20.h,
                  width: 20.w,
                  color: isSelected ? selectedColor : unselectedColor,
                ),
                SizedBox(height: 2.h),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 9.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? selectedColor : unselectedColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}