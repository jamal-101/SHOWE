import 'package:flutter/material.dart';

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
    final title = isLocked ? 'This programme is locked' : 'This programme isn’t here';
    final description = isLocked
        ? 'You don’t have access to this programme yet. Purchase it to unlock the full experience.'
        : 'The programme you’re looking for may have been removed or the link is incorrect.';

    return Scaffold(
      backgroundColor: const Color(0xFF030E10),
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF5A800).withOpacity(0.1),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Emblem
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Icon(
                      isLocked ? Icons.lock_outline : Icons.menu_book,
                      size: 44,
                      color: const Color(0xFFF5A800),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Eyebrow Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Text(
                      eyebrow.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFFF5A800),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white60, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  // Action Buttons
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5A800),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.local_library, color: Colors.black),
                    label: Text(
                      isLocked ? 'Get this programme' : 'Browse programmes',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      side: const BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white70),
                    label: const Text('Go back', style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}