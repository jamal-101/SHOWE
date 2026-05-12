import 'package:digital_event/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Theatre_Controller.dart';
import 'bookCard.dart';
import 'infoTile.dart';

class DiagonalBooksSection extends StatefulWidget {
  const DiagonalBooksSection({super.key});

  @override
  State<DiagonalBooksSection> createState() => _DiagonalBooksSectionState();
}

class _DiagonalBooksSectionState extends State<DiagonalBooksSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  int _direction = 0;
  bool _isAnimating = false;

  // List<String> _prevKeys = [];
  // List<String> _currKeys = [];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // void _swipe(int dir, VoidCallback onMidpoint) {
  //   if (_isAnimating) return;
  //   final c = Get.find<TheatreController>();
  //   _prevKeys = [c.leftItem.title, c.middleItem.title, c.rightItem.title];
  //   _direction = dir;
  //   _isAnimating = true;
  //
  //   _ctrl.forward(from: 0).then((_) {
  //     onMidpoint();
  //     _currKeys = [c.leftItem.title, c.middleItem.title, c.rightItem.title];
  //     _ctrl.reset();
  //     setState(() => _isAnimating = false);
  //   });
  // }


  void _swipe(int dir, VoidCallback onMidpoint) {
    if (_isAnimating) return;

    setState(() {
      _direction = dir;
      _isAnimating = true;
    });
    onMidpoint();
    _ctrl.forward(from: 0).then((_) {
      _ctrl.reset();
      if (mounted) {
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TheatreController c = Get.find();
    final screenWidth = MediaQuery.of(context).size.width;

    final double w = screenWidth * 0.30;
    final double h = w * 2.15;
    final double totalHeight = h + 300;
    final slots = [
      Offset(screenWidth * 0.02, 260),
      Offset(screenWidth * 0.35, 145),
      Offset(screenWidth * 0.67, 40),
    ];

    final Offset enterFrom = _direction >= 0
        ? Offset(screenWidth * 1.1, -h * 0.5)
        : Offset(-w * 1.2, h * 1.2);

    final Offset exitTo = _direction >= 0
        ? Offset(-w * 1.2, h * 1.2)
        : Offset(screenWidth * 1.1, -h * 0.5);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (_isAnimating) return;
        if ((details.primaryVelocity ?? 0) < -200) {
          _swipe(1, () => c.onSwipeLeft());
        } else if ((details.primaryVelocity ?? 0) > 200) {
          _swipe(-1, () => c.onSwipePrev());
        }
      },
      child: Obx(() {
        final items = [c.leftItem, c.middleItem, c.rightItem];
        return AnimatedBuilder(
          animation: _anim,
          builder: (context, _) {
            final t = _anim.value;
            return SizedBox(
              width: screenWidth,
              height: totalHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ...List.generate(3, (i) {
                    final double left = _isAnimating
                        ? slots[i].dx + (exitTo.dx - slots[i].dx) * t
                        : slots[i].dx;
                    final double top = _isAnimating
                        ? slots[i].dy + (exitTo.dy - slots[i].dy) * t
                        : slots[i].dy;
                    final double opacity = _isAnimating ? (1 - t).clamp(0, 1) : 1.0;

                    return Positioned(
                      left: left,
                      top: top,
                      child: Opacity(
                        opacity: opacity,
                        child: BookCard(
                          key: ValueKey('curr_${items[i].title}'),
                          item: items[i],
                          width: w,
                          height: h,
                          // onTap: () => c.onItemTap(items[i]),
                          onTap: (){
                            Get.toNamed(AppRoutes.programDetailsScreen);
                          },
                        ),
                      ),
                    );
                  }),
                  if (_isAnimating)
                    ...List.generate(3, (i) {
                      final double left =
                          enterFrom.dx + (slots[i].dx - enterFrom.dx) * t;
                      final double top =
                          enterFrom.dy + (slots[i].dy - enterFrom.dy) * t;
                      final double opacity = t.clamp(0, 1);
                      final TheatreController cc = Get.find();
                      final nextItems = [cc.leftItem, cc.middleItem, cc.rightItem];
                      return Positioned(
                        left: left,
                        top: top,
                        child: Opacity(
                          opacity: opacity,
                          child: BookCard(
                            key: ValueKey('next_${nextItems[i].title}_$i'),
                            item: nextItems[i],
                            width: w,
                            height: h,
                            onTap: () {
                              Get.toNamed(AppRoutes.programDetailsScreen,arguments: items[i]);
                            },
                          ),
                        ),
                      );
                    }),

                  ...List.generate(3, (i) {
                    final infoOffsets = [
                      Offset(45, 340 + h),
                      Offset(193, 225 + h),
                      Offset(325, 120 + h),
                    ];
                    final double left = _isAnimating
                        ? infoOffsets[i].dx + (exitTo.dx - slots[i].dx) * t * 0.3
                        : infoOffsets[i].dx;
                    final double top = _isAnimating
                        ? infoOffsets[i].dy + (exitTo.dy - slots[i].dy) * t * 0.3
                        : infoOffsets[i].dy;
                    final opacity = _isAnimating ? (1 - t * 2).clamp(0.0, 1.0) : 1.0;
                    return Positioned(
                      left: left,
                      top: top,
                      width: w - 4,
                      child: Opacity(
                        opacity: opacity,
                        child: InfoTile(
                          key: ValueKey('info_${items[i].title}'),
                          item: items[i],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}