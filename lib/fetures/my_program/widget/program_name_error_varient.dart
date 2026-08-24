import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ProgrammeErrorVariant { notFound, unauthorized }

class ProgrammeNotFoundPage extends StatelessWidget {
  final ProgrammeErrorVariant variant;

  const ProgrammeNotFoundPage({
    super.key,
    this.variant = ProgrammeErrorVariant.notFound,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLocked = variant == ProgrammeErrorVariant.unauthorized;

    final eyebrow = isLocked ? 'Locked Programme' : 'Programme Reader';
    final title =
        isLocked ? 'This programme is locked' : 'This programme isn’t here';
    final description = isLocked
        ? 'You don’t have access to this programme yet. Purchase it to unlock the full interactive experience—rich media, artist profiles and behind-the-scenes content.'
        : 'The programme you’re looking for may have been removed, unpublished, or the link is incorrect. Explore our library to find your next experience.';

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.8),
            radius: 1.2,
            colors: [Color(0xFF0A2A30), Color(0xFF05171A), Color(0xFF030E10)],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF5A800).withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF014B52).withValues(alpha: 0.35),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 112,
                            height: 112,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: Icon(
                              isLocked ? Icons.lock_outline : Icons.menu_book,
                              size: 44,
                              color: const Color(0xFFF5A800),
                            ),
                          ),
                          Positioned(
                            top: -8,
                            right: -8,
                            child: Container(
                              width: 36,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5A800),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFF5A800)
                                        .withValues(alpha: 0.35),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                              child: isLocked
                                  ? const Icon(Icons.lock,
                                      size: 15, color: Color(0xFF06181B))
                                  : const Text(
                                      '?',
                                      style: TextStyle(
                                        color: Color(0xFF06181B),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.03),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Text(
                          eyebrow.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFFF5A800),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF5A800),
                            foregroundColor: const Color(0xFF06181B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            // Stay on / return to programmes catalogue.
                          },
                          icon: const Icon(Icons.local_library),
                          label: Text(
                            isLocked
                                ? 'Get this programme'
                                : 'Browse programmes',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white24),
                            foregroundColor: Colors.white70,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Go back'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton.icon(
                        onPressed: () {
                          Get.until((route) => route.isFirst);
                        },
                        icon: const Icon(Icons.explore,
                            size: 16, color: Colors.white38),
                        label: const Text(
                          'Or explore events',
                          style: TextStyle(color: Colors.white38),
                        ),
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
