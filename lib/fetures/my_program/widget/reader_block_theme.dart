import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../model/single_proram_model.dart';
import '../utils/programme_colors.dart';

/// Theme tokens for one reader block — mirrors React CSS vars
/// (`--btext`, `--btitle`, `--beyebrow`, `--bcardbg`, `--bcardtext`).
class ReaderBlockTheme extends InheritedWidget {
  final Color ink;
  final Color inkMuted;
  final Color inkFaint;
  final Color title;
  final Color eyebrow;
  final Color cardBg;
  final Color cardText;
  final Color line;
  final Color primary;
  final Color accent;
  final Color surfaceRaised;
  final Color surfaceSunken;
  final bool isDarkBg;

  const ReaderBlockTheme({
    super.key,
    required this.ink,
    required this.inkMuted,
    required this.inkFaint,
    required this.title,
    required this.eyebrow,
    required this.cardBg,
    required this.cardText,
    required this.line,
    required this.primary,
    required this.accent,
    required this.surfaceRaised,
    required this.surfaceSunken,
    required this.isDarkBg,
    required super.child,
  });

  static ReaderBlockTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ReaderBlockTheme>();
  }

  // factory ReaderBlockTheme.fromLayout(Layout? layout, {required Widget child}) {
  factory ReaderBlockTheme.fromLayout(Layout? layout, {Pages? page, required Widget child}) {
    final resolvedBg = resolveLayoutBackground(layout);
    final cardHint = parseProgrammeHex(layout?.cardBackground);
    final isDark = resolvedBg.alpha > 0
        ? resolvedBg.computeLuminance() < 0.35
        : (cardHint != null && cardHint.computeLuminance() < 0.35) ||
            layout?.background == 'primary' ||
            layout?.background == 'dark' ||
            layout?.background == 'accent';

    // final ink = parseProgrammeHex(layout?.textColor) ??
    //     (isDark ? const Color(0xFFFBFAF7) : const Color(0xFF1A1A1A));
    // final title = parseProgrammeHex(layout?.titleColor) ?? ink;
    // final eyebrow = parseProgrammeHex(layout?.eyebrowColor) ??
    //     (isDark ? const Color(0xFFF5A800) : const Color(0xFF6B6560));
    // final cardBg = parseProgrammeHex(layout?.cardBackground) ??
    //     (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white);
    // final cardText = parseProgrammeHex(layout?.cardTextColor) ?? ink;




    final effectiveBg = (resolvedBg.alpha == 0 && page != null)
        ? resolvePageSurface(page)
        : resolvedBg;


    final bg = effectiveBg.alpha > 0
        ? effectiveBg
        : (isDark ? const Color(0xFF05171A) : const Color(0xFFFBFAF7));

    const lightInk = Color(0xFFFBFAF7);
    const darkInk = Color(0xFF1A1A1A);
    final autoInk = isDark ? lightInk : darkInk;

    final ink = ensureContrast(parseProgrammeHex(layout?.textColor), bg, autoInk, min: 4.5);
    final title = ensureContrast(parseProgrammeHex(layout?.titleColor), bg, ink, min: 4.5);
    final eyebrow = ensureContrast(
      parseProgrammeHex(layout?.eyebrowColor),
      bg,
      isDark ? const Color(0xFFF5A800) : const Color(0xFF6B6560),
      min: 3.0,
    );

    final cardBg = parseProgrammeHex(layout?.cardBackground) ??
        (isDark ? Colors.white.withValues(alpha: 0.08) : Colors.white);
    final cardText = ensureContrast(parseProgrammeHex(layout?.cardTextColor), cardBg,
        cardBg.computeLuminance() < 0.35 ? lightInk : darkInk, min: 4.5);



    return ReaderBlockTheme(
      ink: ink,
      inkMuted: isDark ? ink.withValues(alpha: 0.75) : const Color(0xFF6B6560),
      inkFaint: isDark ? ink.withValues(alpha: 0.45) : const Color(0xFF9A948C),
      title: title,
      eyebrow: eyebrow,
      cardBg: cardBg,
      cardText: cardText,
      line: isDark ? Colors.white.withValues(alpha: 0.12) : const Color(0xFFE5E0D8),
      primary: const Color(0xFF014B52),
      accent: const Color(0xFFF5A800),
      surfaceRaised: isDark
          ? Colors.white.withValues(alpha: 0.06)
          : const Color(0xFFFBFAF7),
      surfaceSunken:
          isDark ? Colors.black.withValues(alpha: 0.2) : const Color(0xFFF2EFE9),
      isDarkBg: isDark,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(ReaderBlockTheme oldWidget) {
    return ink != oldWidget.ink ||
        title != oldWidget.title ||
        eyebrow != oldWidget.eyebrow ||
        cardBg != oldWidget.cardBg ||
        isDarkBg != oldWidget.isDarkBg;
  }
}


double contrastRatio(Color a, Color b) {
  final l1 = a.computeLuminance();
  final l2 = b.computeLuminance();
  final hi = math.max(l1, l2);
  final lo = math.min(l1, l2);
  return (hi + 0.05) / (lo + 0.05);
}

/// fg jodi bg-er sathe porjapto contrast na dey, fallback use hobe.
Color ensureContrast(Color? fg, Color bg, Color fallback, {double min = 3.5}) {
  if (fg == null) return fallback;
  return contrastRatio(fg, bg) >= min ? fg : fallback;
}
