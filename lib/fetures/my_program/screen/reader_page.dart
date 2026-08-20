import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/single_proram_model.dart';
import '../widget/program_name_error_varient.dart';
import '../widget/reader_block_widget.dart';

class ReaderPage extends StatefulWidget {
  final single_programm_model programme;
  final String heroTag;

  const ReaderPage({
    super.key,
    required this.programme,
    required this.heroTag,
  });

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    final pages = widget.programme.data?.pages ?? [];
    if (pages.isEmpty) return;
    final target = index.clamp(0, pages.length - 1);
    _pageController.animateToPage(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = widget.programme.data?.pages ?? [];
    final totalPages = pages.length;

    if (pages.isEmpty) {
      return const ProgrammeNotFoundPage(variant: ProgrammeErrorVariant.notFound);
    }

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: totalPages,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      final blocks = page.blocks ?? [];

                      if (blocks.isEmpty) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.menu_book, size: 32, color: Colors.white38),
                              SizedBox(height: 8),
                              Text("This page is empty.", style: TextStyle(color: Colors.white54)),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.only(top: 60.h),
                        itemCount: blocks.length,
                        itemBuilder: (context, bIndex) {
                          final block = blocks[bIndex];
                          final String? currentHeroTag = (index == 0 && bIndex == 0)
                              ? widget.heroTag
                              : null;
                          return ReaderBlockWidget(
                            block: block,
                            heroTag: (index == 0 && bIndex == 0) ? widget.heroTag : null,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10.h,
              left: 12.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF232B36),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ),

            if (totalPages > 1)
              Positioned(
                bottom: 20.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left, color: Colors.black),
                          onPressed: _currentPageIndex > 0 ? () => _goToPage(_currentPageIndex - 1) : null,
                        ),
                        Text(
                          "${_currentPageIndex + 1} / $totalPages",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: Colors.black),
                          onPressed: _currentPageIndex < totalPages - 1 ? () => _goToPage(_currentPageIndex + 1) : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}



