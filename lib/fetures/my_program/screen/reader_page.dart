import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/single_proram_model.dart';
import '../utils/dwell_time_tracker.dart';
import '../utils/programme_colors.dart';
import '../widget/program_name_error_varient.dart';
import '../widget/reader_block_widget.dart';

/// Mobile-first programme reader — mirrors React `ReaderPage`.
/// Page shell colour comes from dashboard block layouts (dynamic per page).
class ReaderPage extends StatefulWidget {
  final single_programm_model programme;
  final String heroTag;

  const ReaderPage({super.key, required this.programme, required this.heroTag});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  DwellTimeTracker? _dwell;

  Data? get _doc => widget.programme.data;
  List<Pages> get _pages => _doc?.pages ?? [];

  Color get _pageSurface {
    if (_pages.isEmpty) return const Color(0xFFFBFAF7);
    return resolvePageSurface(
      _pages[_currentPageIndex.clamp(0, _pages.length - 1)],
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    final id = _doc?.id;
    if (id != null && id.isNotEmpty && _pages.isNotEmpty) {
      _dwell = DwellTimeTracker(id, type: 'Programmes')..start();
    }
  }

  @override
  void dispose() {
    _dwell?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    if (_pages.isEmpty) return;
    final target = index.clamp(0, _pages.length - 1);
    _pageController.animateToPage(
      target,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = _pages;
    final totalPages = pages.length;
    final surface = _pageSurface;

    if (pages.isEmpty) {
      final msg = (widget.programme.message ?? '').toLowerCase();
      final unauthorized =
          msg.contains('jwt') ||
          msg.contains('unauthorized') ||
          msg.contains('token') ||
          msg.contains('locked');
      return ProgrammeNotFoundPage(
        variant: unauthorized
            ? ProgrammeErrorVariant.unauthorized
            : ProgrammeErrorVariant.notFound,
      );
    }

    return Scaffold(
      backgroundColor: surface,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: totalPages,
                onPageChanged: (i) => setState(() => _currentPageIndex = i),
                itemBuilder: (context, index) {
                  final page = pages[index];
                  final blocks = page.blocks ?? [];
                  final pageBg = resolvePageSurface(page);

                  if (blocks.isEmpty) {
                    return ColoredBox(color: pageBg, child: const _EmptyPage());
                  }

                  return ColoredBox(
                    color: pageBg,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        bottom: totalPages > 1 ? 72 : 24,
                      ),
                      itemCount: blocks.length,
                      itemBuilder: (context, bIndex) {
                        return ReaderBlockWidget(
                          block: blocks[bIndex],
                          heroTag: (index == 0 && bIndex == 0)
                              ? widget.heroTag
                              : null,
                          programme: _doc,
                          page: page,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: -12,
              left: 10,
              child: _BackChip(onTap: () => Navigator.maybePop(context)),
            ),
            if (totalPages > 1)
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: _PageNav(
                    current: _currentPageIndex + 1,
                    total: totalPages,
                    onPrev: _currentPageIndex > 0
                        ? () => _goToPage(_currentPageIndex - 1)
                        : null,
                    onNext: _currentPageIndex < totalPages - 1
                        ? () => _goToPage(_currentPageIndex + 1)
                        : null,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _EmptyPage extends StatelessWidget {
  const _EmptyPage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book_outlined, size: 28, color: Color(0xFF9A948C)),
          SizedBox(height: 12),
          Text(
            'This page is empty.',
            style: TextStyle(color: Color(0xFF6B6560), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _BackChip extends StatelessWidget {
  final VoidCallback onTap;
  const _BackChip({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 19),
        ),
      ),
    );
  }
}

class _PageNav extends StatelessWidget {
  final int current;
  final int total;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _PageNav({
    required this.current,
    required this.total,
    this.onPrev,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NavIcon(icon: Icons.chevron_left, onTap: onPrev),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '$current / $total',
              style: const TextStyle(
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.w600,
                fontSize: 12,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
          _NavIcon(icon: Icons.chevron_right, onTap: onNext),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _NavIcon({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: enabled ? 1 : 0.3,
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(icon, size: 18, color: const Color(0xFF1A1A1A)),
        ),
      ),
    );
  }
}
