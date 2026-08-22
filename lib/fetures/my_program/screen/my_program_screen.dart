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
      body:
      GetBuilder<TheatreController>(
         builder: (controller) {
           return Stack(
             fit: StackFit.expand,
             children: [
               AnimatedSwitcher(
                 duration: const Duration(milliseconds: 10),
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
  final TheatreController controller = Get.find<TheatreController>();

  _AppBarWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 10,
        left: 14,
        right: 14,
      ),
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
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Obx(
                    () {
                  final String currentTitle = controller.categories.isNotEmpty
                      ? controller.categories[controller.selectedCategoryIndex.value].name
                      : 'Theatre';

                  return Text(
                    currentTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 34),
        ],
      ),
    );
  }
}