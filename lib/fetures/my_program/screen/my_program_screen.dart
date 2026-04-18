import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Theatre_Controller.dart';
import '../widget/category_tabs_widget.dart';
import '../widget/diagonalBooksSection.dart';


class MyProgramScreen extends StatelessWidget {
  const MyProgramScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(TheatreController());
    return Scaffold(
      backgroundColor: Color(0xFF082A33),
      body: GetBuilder<TheatreController>(
         builder: (controller) {
           return Stack(
             fit: StackFit.expand,
             children: [
               AnimatedSwitcher(
                 duration: const Duration(milliseconds: 100),
                 child: Image.asset(
                   controller.currentBackground,
                   key: ValueKey(controller.currentBackground),
                   fit: BoxFit.cover,
                   width: double.infinity,
                   height: double.infinity,
                 ),
               ),
               SafeArea(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     _AppBarWidget(),
                     const SizedBox(height: 16),
                      CategoryTabsWidget(),
                     const SizedBox(height: 24),
                     const Expanded(
                       child: SingleChildScrollView(
                         child: DiagonalBooksSection(),
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           );
         }
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 17,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Theatre',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 34),
        ],
      ),
    );
  }
}