import 'package:digital_event/core/constans/app_images.dart';
import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
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
    return Obx(() {
      bool isHome = selectedIndex == 0;
      return Container(
        height: 64.h,
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 25.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(999.r),
            boxShadow: [
            if (isHome) ...[
              BoxShadow(
                color: Color(0xFF8F8F8F1A).withValues(alpha: 0.1),
                blurRadius: 1,
                spreadRadius: 2,
                offset:  Offset(-1,-0),
              ),
              // BoxShadow(
              //   color: Colors.white.withValues(alpha: 0.05),
              //   blurRadius: 10,
              //   offset: const Offset(0, -4),
              // ),
              // BoxShadow(
              //   color: Colors.black.withValues(alpha: 0.2),
              //   offset: Offset(4, 8),
              //   blurRadius: 12,
              //   spreadRadius: 1,
              // ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.9),
                offset: Offset(-2, -2),
                blurRadius: 2,
              ),
            ] else ...[
              BoxShadow(
                // color: Colors.black.withValues(alpha: 0.05),
                color: Colors.white.withValues(alpha: 0.9),
                blurRadius: 15,
                spreadRadius: 2,
                offset:  Offset(0, 5),
              ),
            ],
          ],
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withValues(alpha: 0.05),
          //     blurRadius: 15,
          //     spreadRadius: 2,
          //     offset: const Offset(0, 5),
          //   ),
          // ],
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
      );
    }
    );
  }

  Widget _buildNavItem(int index, String imagePath, String label) {
    bool isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
        switch (index) {
          case 0:
            Get.toNamed(AppRoutes.homeScreen);
            break;
          case 1:
            Get.toNamed(AppRoutes.favoriteScreen);
            break;
          case 2:
            Get.toNamed(AppRoutes.tripPlanScreen);
            break;
          case 3:
            Get.toNamed(AppRoutes.profileScreen);
            break;
          default:
            break;
        }
      },
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


// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../core/constans/app_images.dart';
// import '../../../core/route/app_routes.dart';
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
//         height: isHome ? 70.h : 64.h,
//         margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 25.h),
//         padding: EdgeInsets.symmetric(horizontal: 15.w),
//         decoration: BoxDecoration(
//           color : Color(0xFF8F8F8F1A).withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(999.r),
//           border: isHome
//               ? Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1.5)
//               : null,
//           boxShadow: [
//             if (isHome) ...[
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.4),
//                 blurRadius: 20,
//                 spreadRadius: 2,
//                 offset:  Offset(0,10),
//               ),
//               // BoxShadow(
//               //   color: Colors.white.withValues(alpha: 0.05),
//               //   blurRadius: 10,
//               //   offset: const Offset(0, -4),
//               // ),
//               // BoxShadow(
//               //   color: Colors.black.withValues(alpha: 0.2),
//               //   offset: Offset(4, 8),
//               //   blurRadius: 12,
//               //   spreadRadius: 1,
//               // ),
//               BoxShadow(
//                 color: Colors.white.withValues(alpha: 0.5),
//                 offset: Offset(-3, -3),
//                 blurRadius: 2,
//               ),
//             ] else ...[
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.05),
//                 blurRadius: 15,
//                 spreadRadius: 2,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildNavItem(0, AppImages.homeIcon, "Home", isHome),
//             _buildNavItem(1, AppImages.favoriteIcon, "Favourites", isHome),
//             _buildNavItem(2, AppImages.tripPlan, "Trip Plan", isHome),
//             _buildNavItem(3, AppImages.profileIcon, "Profile", isHome),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _buildNavItem(int index, String imagePath, String label, bool isHomeTheme) {
//     bool isSelected = controller.currentIndex.value == index;
//
//     Color selectedColor = const Color(0xFFF2A900);
//     Color unselectedColor = isHomeTheme ? Colors.white.withValues(alpha: 0.5) : Color(0xFF0F4C5C);
//
//     return GestureDetector(
//       onTap: () {
//         controller.changeIndex(index);
//         switch (index) {
//           case 0: Get.toNamed(AppRoutes.homeScreen); break;
//           case 1: Get.toNamed(AppRoutes.favoriteScreen); break;
//           case 2: Get.toNamed(AppRoutes.tripPlanScreen); break;
//           case 3: Get.toNamed(AppRoutes.profileScreen); break;
//         }
//       },
//       child: Container(
//         color: Colors.transparent,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               imagePath,
//               height: 24.h,
//               width: 24.w,
//               color: isSelected ? selectedColor : unselectedColor,
//             ),
//             SizedBox(height: 4.h),
//             Text(
//               label,
//               style: GoogleFonts.montserrat(
//                 fontSize: 10.sp,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                 color: isSelected ? selectedColor : unselectedColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }