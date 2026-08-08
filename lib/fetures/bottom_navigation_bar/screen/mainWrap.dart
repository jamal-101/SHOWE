// // lib/fetures/bottom_navigation_bar/screen/main_wrapper_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/bottom_navigation_controller.dart';
// import 'bottom_navigation_screen.dart'; // আপনার সেই BottomNavBar উইজেট
//
// class MainWrapperScreen extends StatelessWidget {
//   const MainWrapperScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(BottomNavigationController());
//
//     return Scaffold(
//       // বডিতে ডাইনামিকালি স্ক্রিন পরিবর্তন হবে
//       body: Obx(() => controller.screens[controller.currentIndex.value]),
//
//       // এখানে মাত্র একবার বটম নেভ বার থাকবে
//       bottomNavigationBar: Obx(() => BottomNavBar(selectedIndex: controller.currentIndex.value)),
//     );
//   }
// }