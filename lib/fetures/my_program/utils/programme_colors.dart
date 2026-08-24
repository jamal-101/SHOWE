import 'package:flutter/material.dart';

import '../model/single_proram_model.dart';

/// Resolves dashboard/layout colors the same way React `ReaderBlock` does.
Color? parseProgrammeHex(String? value) {
  if (value == null || value.trim().isEmpty) return null;
  var hex = value.trim();
  if (hex.startsWith('#')) hex = hex.substring(1);
  if (hex.length == 6) return Color(int.parse('FF$hex', radix: 16));
  if (hex.length == 8) return Color(int.parse(hex, radix: 16));
  return null;
}

Color resolveLayoutBackground(Layout? layout) {
  if (layout == null || layout.background == null) return Colors.transparent;
  switch (layout.background) {
    case 'sunken':
      return const Color(0xFFF2EFE9);
    case 'surface':
      return const Color(0xFFFBFAF7);
    case 'primary':
      return const Color(0xFF014B52);
    case 'accent':
      return const Color(0xFFF5A800);
    case 'dark':
      return Colors.black;
    case 'none':
    case 'transparent':
      return Colors.transparent;
    case 'custom':
      return parseProgrammeHex(layout.backgroundCustom) ?? Colors.transparent;
    default:
      // Dashboard may send a raw hex as `background`
      return parseProgrammeHex(layout.background) ?? Colors.transparent;
  }
}

/// Page chrome color: first solid block bg from the current page (dashboard-driven).
/// Falls back to design-token surface-raised only when every block is transparent.
Color resolvePageSurface(Pages? page, {Color fallback = const Color(0xFFFBFAF7)}) {
  final blocks = page?.blocks ?? const <Blocks>[];
  for (final block in blocks) {
    final bg = resolveLayoutBackground(block.layout);
    if (bg.alpha > 0) return bg;
  }
  // Prefer first block card / text surface hints if present
  for (final block in blocks) {
    final card = parseProgrammeHex(block.layout?.cardBackground);
    if (card != null && card.alpha > 0) return card;
  }
  return fallback;
}
