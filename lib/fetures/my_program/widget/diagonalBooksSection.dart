import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/Theatre_Controller.dart';
import 'bookCard.dart';

class DiagonalBooksSection extends StatefulWidget {
  const DiagonalBooksSection({super.key});

  @override
  State<DiagonalBooksSection> createState() => _DiagonalBooksSectionState();
}

class _DiagonalBooksSectionState extends State<DiagonalBooksSection> {
  late PageController _pageController;
  double _currentPage = 0.0;

  final int _loopCount = 10000000;

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController(
  //     viewportFraction: 0.32,
  //     initialPage: _loopCount ~/ 2,
  //   )..addListener(() {
  //     setState(() {
  //       _currentPage = _pageController.page!;
  //     });
  //   });
  // }


  @override
  void initState() {
    super.initState();
    final int initialPage = (_loopCount ~/ 2);

    _pageController = PageController(
      viewportFraction: 0.32,
      initialPage: initialPage,
    )..addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!;
        });
      }
    });
    _currentPage = initialPage.toDouble();
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

      final items = c.programmeList;
      if (items.isEmpty) return const SizedBox.shrink();


      return SizedBox(
        height: 600.h,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _loopCount,
          clipBehavior: Clip.none,
          itemBuilder: (context, index) {
            final int actualIndex = index % items.length;
            final item = items[actualIndex];
            double relativePosition = index - _currentPage;
            if (relativePosition.abs() > 2) return const SizedBox.shrink();
            double bookTop;
            double infoTop;
            double infoLeft;
            if (relativePosition < -0.5) {
              bookTop = -20.h;
              infoTop = h + 78.h;
              infoLeft = 40.w;
            } else if (relativePosition.abs() <= 0.5) {
              bookTop = -0.h;
              infoTop = h + 78.h;
              infoLeft = 46.w;
            } else {
              bookTop = 10.h;
              infoTop = h + 105.h;
              infoLeft = 30.w;
            }
            double xOffset = relativePosition * (screenWidth * 0.02);
            double yOffset = 160.h + (relativePosition * -120.h);
            double scale = (1 - (relativePosition.abs() * 0.12)).clamp(0.8, 1.0);
            double opacity = (1 - (relativePosition.abs() * 0.15)).clamp(0.85, 1.0);

            return Transform.translate(
              offset: Offset(xOffset, yOffset),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: SizedBox(
                    width: w,
                    height: h + 250.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: bookTop,
                          left: 0,
                          child: BookCard(
                            item: items[actualIndex],
                            width: w,
                            height: h,
                            // index: index,
                            // onTap: () => Get.toNamed(
                            //   AppRoutes.programDetailsScreen,
                            //   arguments: items[actualIndex],
                            // ),
                            // onTap: () => Get.toNamed(AppRoutes.programDetailsScreen, arguments: item),
                            onTap: () {
                              // if (item.sId != null) {
                              //   c.openReaderUrl(item.sId);
                              // }
                              if (item.sId != null) {
                                c.openReaderUrl(context, item.sId, title: item.title);
                              }
                              // if (item.sId != null) {
                              //   c.openReaderUrl(context, item.sId, title: item.title);
                              // }
                            },

                          ),
                        ),

                        Positioned(
                          top: infoTop,
                          left: infoLeft,
                          right: -80.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                // items[actualIndex].title,
                                item.title ?? "No Title",
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
                              Text(
                                // items[actualIndex].description,
                                item.description ?? "",
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
