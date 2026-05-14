import 'dart:ui';

import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/Theatre_Controller.dart';
import '../model/theatre_model.dart';
import 'bookCard.dart';

class DiagonalBooksSection extends StatefulWidget {
  const DiagonalBooksSection({super.key});

  @override
  State<DiagonalBooksSection> createState() => _DiagonalBooksSectionState();
}

class _DiagonalBooksSectionState extends State<DiagonalBooksSection> {
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.32)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!;
        });
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TheatreController c = Get.find();
    final screenWidth = MediaQuery.of(context).size.width;

    final double w = screenWidth * 0.28;
    final double h = w * 2.15;

    return Obx(() {
      final items = c.currentItems;

      return SizedBox(
        height: 600.h,
        child: PageView.builder(
          controller: _pageController,
          itemCount: items.length,
          clipBehavior: Clip.none,
          itemBuilder: (context, index) {
            double relativePosition = index - _currentPage;
            double xOffset = relativePosition * (screenWidth * 0.02);
            double yOffset = 160.h + (relativePosition * -120.h);
            double scale = (1 - (relativePosition.abs() * 0.12)).clamp(0.8, 1.0);
            double opacity = (1 - (relativePosition.abs() * 0.4)).clamp(0.4, 1.0);

            return Transform.translate(
              offset: Offset(xOffset, yOffset),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: SizedBox(
                    width: w,
                    height: h + 160.h, // card + নিচে title/desc এর জায়গা
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // ── BookCard — top এ ───────────────────────
                        Positioned(
                          top: 10,
                          left: 0,
                          child: BookCard(
                            item: items[index],
                            width: w,
                            height: h,
                            onTap: () => Get.toNamed(
                              AppRoutes.programDetailsScreen,
                              arguments: items[index],
                            ),
                          ),
                        ),

                        // ── Title + Description — card এর নিচে ────
                        // background line এর উপর বসবে
                        Positioned(
                          top: h + 75.h,   // card এর ঠিক নিচে
                          left: 45,
                          right: -60.w,    // card width এর বাইরেও extend করবে
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Title
                              Text(
                                items[index].title,
                                style: TextStyle(
                                  color: const Color(0xFFE5A000),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10.h),
                              // Description
                              Text(
                                items[index].description,
                                style: TextStyle(
                                  color: const Color(0xFFCCCCCC),
                                  fontSize: 10.sp,
                                  height: 1.5,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

// ══════════════════════════════════════════════════════════════════════
// Golden dot → vertical line → title → description
// image এ red mark 1 = title, red mark 2 = description
// ══════════════════════════════════════════════════════════════════════
class _DiagonalInfoTile extends StatelessWidget {
  final TheatreItem item;
  const _DiagonalInfoTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Red mark 1 — title
        Text(
          item.title,
          style: TextStyle(
            color: const Color(0xFFE5A000),
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        // Red mark 2 — description
        Text(
          item.description,
          style: TextStyle(
            color: const Color(0xFFCCCCCC),
            fontSize: 10.sp,
            height: 1.5,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}