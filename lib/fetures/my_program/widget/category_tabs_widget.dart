import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Theatre_Controller.dart';

class CategoryTabsWidget extends StatelessWidget {
  const  CategoryTabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TheatreController c = Get.find();

    return SizedBox(
      height: 36,
      child: Obx(() => ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: c.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final selected = c.selectedCategoryIndex.value == i;
          return GestureDetector(
            onTap: () => c.selectCategory(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFF5A623) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? const Color(0xFFF5A623)
                      : Colors.white.withAlpha(80),
                  width: 1.2,
                ),
              ),
              child: Text(
                c.categories[i].name,
                style: TextStyle(
                  color: selected ? Colors.black87 : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}