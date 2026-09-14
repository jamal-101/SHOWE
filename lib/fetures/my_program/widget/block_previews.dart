import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_event/core/utils/api_enpoint.dart';
import 'package:digital_event/core/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gal/gal.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher.dart';

import '../model/single_proram_model.dart';
import '../utils/programme_image.dart';
import '../utils/programme_map.dart';
import 'programme_media.dart';
import 'reader_block_theme.dart';

Widget renderBlockPreview({
  required Blocks block,
  String? heroTag,
  Data? programme,
  Pages? page,
}) {
  final data = block.data ?? BlockData();
  switch (block.type) {
    case 'hero':
      return HeroPreview(data: data, heroTag: heroTag);
    case 'welcome':
      return WelcomePreview(data: data);
    case 'schedule':
      return SchedulePreview(data: data);
    case 'accessibility':
      return AccessibilityPreview(data: data);
    case 'behind_scenes':
      return BehindScenesPreview(data: data);
    case 'sponsor_thanks':
      return SponsorThanksPreview(data: data);
    case 'refreshments':
      return RefreshmentsPreview(data: data);
    case 'cast_grid':
      return CastGridPreview(data: data);
    case 'cast_spotlight':
      return CastSpotlightPreview(data: data);
    case 'narrative_text':
      return NarrativeTextPreview(data: data, align: block.layout?.align);
    case 'image_story':
      return ImageStoryPreview(data: data);
    case 'poll':
      return PollPreview(data: data);
    case 'review':
      return ReviewPreview(data: data, programme: programme);
    case 'merchandise':
      return MerchandisePreview(data: data);
    case 'future_shows':
      return FutureShowsPreview(data: data);
    case 'donation':
      return DonationPreview(data: data);
    case 'offers':
      return OffersPreview(data: data);
    case 'ads':
      return AdsPreview(data: data);
    case 'memory_capture':
      return MemoryCapturePreview(data: data);
    case 'recap':
      return RecapPreview(data: data, programme: programme, page: page);
    case 'recommendations':
      return RecommendationsPreview(data: data);
    case 'push_notification':
      return PushNotificationPreview(data: data);
    case 'map':
      return MapPreview(data: data);
    case 'directions':
      return DirectionsPreview(data: data);
    default:
      return const SizedBox.shrink();
  }
}

List<dynamic> _extractList(dynamic raw) {
  if (raw == null) return [];
  if (raw is List) return raw;
  if (raw is Map) {
    final d = raw['data'];
    if (d is List) return d;
  }
  return [];
}

// ───────────────────────── Module 1 ─────────────────────────

class HeroPreview extends StatelessWidget {
  final BlockData data;
  final String? heroTag;
  const HeroPreview({super.key, required this.data, this.heroTag});

  double _height(BuildContext context) {
    switch (data.height) {
      case 'short':
        return 160;
      case 'tall':
        return 320;
      case 'full':
        return MediaQuery.of(context).size.height;
      case 'medium':
      default:
        return 224;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasCover = data.coverImage != null && data.coverImage!.trim().isNotEmpty;
    final coverUrl = getProgrammeImageUrl(data.coverImage);
    final isVideo = isProgrammeVideoUrl(coverUrl);

    if (hasCover && isVideo) {
      return _HeroVideoPreview(
        data: data,
        heroTag: heroTag,
        maxHeight: _height(context),
        useNaturalHeight: data.height == 'full',
      );
    }

    final h = _height(context);

    Widget media = hasCover
        ? ProgrammeMedia(
      src: data.coverImage,
      fit: BoxFit.cover,
      width: double.infinity,
      height: h,
      autoPlay: true,
      showMuteChip: true,
      allowFullscreen: true,
    )
        : Container(
      width: double.infinity,
      height: h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF014B52), Color(0xFF01363C)],
        ),
      ),
    );

    if (heroTag != null && heroTag!.isNotEmpty && hasCover) {
      media = Hero(tag: heroTag!, child: media);
    }

    return SizedBox(
      height: h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          media,
          if (data.overlay == true)
            IgnorePointer(
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xB3000000),
                      Color(0x33000000),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: IgnorePointer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.title != null)
                    Text(
                      data.title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        letterSpacing: -0.3,
                        shadows: [Shadow(blurRadius: 10, color: Colors.black54)],
                      ),
                    ),
                  if (data.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      data.subtitle!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Hero video uses natural aspect ratio so the next block sits directly below.
class _HeroVideoPreview extends StatefulWidget {
  final BlockData data;
  final String? heroTag;
  final double maxHeight;
  final bool useNaturalHeight;

  const _HeroVideoPreview({
    required this.data,
    required this.heroTag,
    required this.maxHeight,
    required this.useNaturalHeight,
  });

  @override
  State<_HeroVideoPreview> createState() => _HeroVideoPreviewState();
}

class _HeroVideoPreviewState extends State<_HeroVideoPreview> {
  double? _aspectRatio;

  double _heightForWidth(double width) {
    if (_aspectRatio == null || _aspectRatio! <= 0) {
      return widget.maxHeight.clamp(220, 520);
    }
    final natural = width / _aspectRatio!;
    if (widget.useNaturalHeight) return natural;
    return natural.clamp(160, widget.maxHeight);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final h = _heightForWidth(width);

    Widget media = ColoredBox(
      color: Colors.black,
      child: ProgrammeMedia(
        src: widget.data.coverImage,
        fit: BoxFit.contain,
        width: double.infinity,
        height: h,
        autoPlay: true,
        showMuteChip: true,
        allowFullscreen: true,
        onAspectRatioReady: (ratio) {
          if (!mounted || ratio <= 0) return;
          if (_aspectRatio != ratio) {
            setState(() => _aspectRatio = ratio);
          }
        },
      ),
    );

    if (widget.heroTag != null && widget.heroTag!.isNotEmpty) {
      media = Hero(tag: widget.heroTag!, child: media);
    }

    return SizedBox(
      height: h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          media,
          if (widget.data.overlay == true)
            IgnorePointer(
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xB3000000),
                      Color(0x33000000),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: IgnorePointer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.data.title != null)
                    Text(
                      widget.data.title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        letterSpacing: -0.3,
                        shadows: [Shadow(blurRadius: 10, color: Colors.black54)],
                      ),
                    ),
                  if (widget.data.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.data.subtitle!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomePreview extends StatelessWidget {
  final BlockData data;
  const WelcomePreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    final ink = t?.title ?? const Color(0xFF1A1A1A);
    final muted = t?.inkMuted ?? const Color(0xFF6B6560);
    final primary = t?.primary ?? const Color(0xFF014B52);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data.heading != null)
          Text(
            data.heading!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: ink,
              height: 1.2,
            ),
          ),
        if (data.body != null) ...[
          const SizedBox(height: 12),
          Text(
            data.body!,
            style: TextStyle(fontSize: 14, height: 1.55, color: muted),
          ),
        ],
        if (data.signature != null && data.signature!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            '— ${data.signature}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: primary,
            ),
          ),
        ],
      ],
    );
  }
}

class SchedulePreview extends StatelessWidget {
  final BlockData data;
  const SchedulePreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    final ink = t?.ink ?? const Color(0xFF1A1A1A);
    final timeColor = t?.title ?? t?.eyebrow ?? const Color(0xFF19BFD6);
    final faint = t?.inkFaint ?? const Color(0xFF9A948C);
    final line = t?.line ?? const Color(0xFFE5E0D8);
    final items = data.items ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(data.title ?? 'Schedule', context: context),
        const SizedBox(height: 12),
        ...items.asMap().entries.map((e) {
          final item = e.value;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                top: e.key == 0 ? BorderSide.none : BorderSide(color: line),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    item.time ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: timeColor,
                        fontFeatures: const [FontFeature.tabularFigures()]
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.label ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ink,
                          height: 1.25,
                        ),
                      ),
                      if (item.note != null && item.note!.isNotEmpty)
                        Text(
                          item.note!,
                          style: TextStyle(fontSize: 12, color: faint),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class AccessibilityPreview extends StatelessWidget {
  final BlockData data;
  const AccessibilityPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    final ink = t?.ink ?? const Color(0xFF1A1A1A);
    final muted = t?.inkMuted ?? const Color(0xFF6B6560);
    final primary = t?.primary ?? const Color(0xFF014B52);
    final features = data.features ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(data.title ?? 'Accessibility'),
        const SizedBox(height: 12),
        ...features.map((f) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.accessible, size: 15, color: primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        f.label ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: ink,
                        ),
                      ),
                      if (f.description != null && f.description!.isNotEmpty)
                        Text(
                          f.description!,
                          style: TextStyle(fontSize: 12, color: muted),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class BehindScenesPreview extends StatelessWidget {
  final BlockData data;
  const BehindScenesPreview({super.key, required this.data});

  void _openFullscreen(BuildContext context, String src) {
    final url = getProgrammeImageUrl(src);
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.95),
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.pop(ctx),
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: isProgrammeVideoUrl(url)
                    ? ProgrammeMedia(src: src, fit: BoxFit.contain)
                    : CachedNetworkImage(imageUrl: url, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: MediaQuery.of(ctx).padding.top + 12,
              right: 16,
              child: IconButton(
                onPressed: () => Navigator.pop(ctx),
                icon: const Icon(Icons.close, color: Colors.white),
                style: IconButton.styleFrom(backgroundColor: Colors.white24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = data.images ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(data.title ?? 'Behind the scenes'),
        if (data.body != null) ...[
          SizedBox(height: 8.h),
          Text(data.body!, style: TextStyle(fontSize: 14.sp, color: Colors.black54, height: 1.5)),
        ],
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
          ),
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () => _openFullscreen(context, images[i]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: ProgrammeMedia(src: images[i], fit: BoxFit.cover),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SponsorThanksPreview extends StatelessWidget {
  final BlockData data;
  const SponsorThanksPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final sponsors = data.sponsors ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(data.title ?? 'Sponsors'),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sponsors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 1.4,
          ),
          itemBuilder: (context, i) {
            final s = sponsors[i];
            return GestureDetector(
              onTap: () => openExternalUrl(s.url),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFE5E0D8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (s.logo != null && s.logo!.isNotEmpty)
                      SizedBox(
                        height: 32.h,
                        child: ProgrammeMedia(src: s.logo, fit: BoxFit.contain),
                      )
                    else
                      Icon(Icons.favorite, size: 14.sp, color: const Color(0xFFF5A800)),
                    SizedBox(height: 6.h),
                    Text(
                      s.name ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class RefreshmentsPreview extends StatelessWidget {
  final BlockData data;
  const RefreshmentsPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFE9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E0D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: Color(0xFFF5A800),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.coffee, size: 16.sp, color: Colors.black87),
          ),
          SizedBox(height: 12.h),
          Text(
            data.title ?? '',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
          ),
          if (data.description != null) ...[
            SizedBox(height: 6.h),
            Text(data.description!, style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
          ],
          if (data.ctaLabel != null) ...[
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => openExternalUrl(data.ctaUrl),
              child: Row(
                children: [
                  Text(
                    data.ctaLabel!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                      color: const Color(0xFF014B52),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.arrow_forward, size: 14.sp, color: const Color(0xFF014B52)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ───────────────────────── Module 2 ─────────────────────────

class CastGridPreview extends StatefulWidget {
  final BlockData data;
  const CastGridPreview({super.key, required this.data});

  @override
  State<CastGridPreview> createState() => _CastGridPreviewState();
}

class _CastGridPreviewState extends State<CastGridPreview> {
  String? openId;

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    final ink = t?.ink ?? const Color(0xFF1A1A1A);
    final muted = t?.inkMuted ?? const Color(0xFF6B6560);
    final faint = t?.inkFaint ?? const Color(0xFF9A948C);
    final cardBg = t?.surfaceSunken ?? const Color(0xFFF2EFE9);
    final line = t?.line ?? const Color(0xFFE5E0D8);
    final primary = t?.primary ?? const Color(0xFF014B52);
    final members = widget.data.members ?? [];
    final cols = widget.data.columns == 3 ? 3 : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(widget.data.title ?? 'Cast'),
        if (widget.data.description != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.data.description!,
            style: TextStyle(fontSize: 12.5, color: muted),
          ),
        ],
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: members.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: openId != null ? 0.55 : 0.72,
          ),
          itemBuilder: (context, i) {
            final m = members[i];
            final isOpen = openId == m.id;
            return GestureDetector(
              onTap: () => setState(() => openId = isOpen ? null : m.id),
              child: Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: line),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (m.image != null)
                      AspectRatio(
                        aspectRatio: 1,
                        child: ProgrammeMedia(src: m.image, fit: BoxFit.cover),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m.name ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: ink,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            m.role ?? '',
                            style: TextStyle(fontSize: 11, color: faint),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (isOpen && m.bio != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              m.bio!,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: muted,
                                height: 1.35,
                              ),
                            ),
                          ],
                          if (isOpen && m.linkUrl != null) ...[
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => openExternalUrl(m.linkUrl),
                              child: Text(
                                m.linkLabel ?? 'Visit',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: primary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CastSpotlightPreview extends StatelessWidget {
  final BlockData data;
  const CastSpotlightPreview({super.key, required this.data});

  void _openFullscreen(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.95),
      builder: (ctx) => _CastSpotlightFullscreen(
        data: data,
        accent: t?.accent ?? const Color(0xFFF5A800),
        titleColor: t?.title ?? const Color(0xFFF9F8F4),
        cardBg: t?.cardBg ?? const Color(0xFF28251D),
        inkMuted: t?.inkMuted ?? const Color(0xFF9A948C),
        primary: t?.primary ?? const Color(0xFF014B52),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    final line = t?.line ?? const Color(0xFFE5E0D8);
    final cardBg = t?.cardBg ?? Colors.white;
    final accent = t?.accent ?? const Color(0xFFF5A800);
    final titleColor = t?.title ?? const Color(0xFF1A1A1A);
    final inkMuted = t?.inkMuted ?? const Color(0xFF6B6560);
    final primary = t?.primary ?? const Color(0xFF014B52);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.image != null)
            GestureDetector(
              onTap: () => _openFullscreen(context),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ProgrammeMedia(
                  src: data.image,
                  fit: BoxFit.cover,
                  allowFullscreen: false,
                  deferGestures: true,
                ),
              ),
            ),
          Container(
            width: double.infinity,
            color: cardBg,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.role != null)
                  Text(
                    data.role!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                      color: accent,
                    ),
                  ),
                if (data.name != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    data.name!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                ],
                if (data.bio != null) ...[
                  SizedBox(height: 8.h),
                  Text(
                    data.bio!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: inkMuted,
                      height: 1.5,
                    ),
                  ),
                ],
                if (data.linkUrl != null) ...[
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () => openExternalUrl(data.linkUrl),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        data.linkLabel ?? 'Visit',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CastSpotlightFullscreen extends StatelessWidget {
  final BlockData data;
  final Color accent;
  final Color titleColor;
  final Color cardBg;
  final Color inkMuted;
  final Color primary;

  const _CastSpotlightFullscreen({
    required this.data,
    required this.accent,
    required this.titleColor,
    required this.cardBg,
    required this.inkMuted,
    required this.primary,
  });

  Widget _footer() {
    return Container(
      width: double.infinity,
      color: cardBg,
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.role != null)
            Text(
              data.role!.toUpperCase(),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                color: accent,
              ),
            ),
          if (data.name != null) ...[
            SizedBox(height: 4.h),
            Text(
              data.name!,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
          ],
          if (data.bio != null) ...[
            SizedBox(height: 8.h),
            Text(
              data.bio!,
              style: TextStyle(
                fontSize: 13.sp,
                color: inkMuted,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final url = getProgrammeImageUrl(data.image);
    final isVideo = isProgrammeVideoUrl(url);

    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            if (isVideo)
              FullscreenVideoPlayer(
                url: url,
                footer: _footer(),
              )
            else
              Column(
                children: [
                  Expanded(
                    child: InteractiveViewer(
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  _footer(),
                ],
              ),
            Positioned(
              top: 8,
              left: 8,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
                style: IconButton.styleFrom(backgroundColor: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Module 3 ─────────────────────────

class NarrativeTextPreview extends StatelessWidget {
  final BlockData data;
  final String? align;
  const NarrativeTextPreview({super.key, required this.data, this.align});

  TextAlign get _textAlign {
    switch (align) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  CrossAxisAlignment get _cross {
    switch (align) {
      case 'center':
        return CrossAxisAlignment.center;
      case 'right':
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    final title = t?.title ?? const Color(0xFF1A1A1A);
    final muted = t?.inkMuted ?? const Color(0xFF6B6560);

    return Column(
      crossAxisAlignment: _cross,
      children: [
        if (data.eyebrow != null) ...[
          eyebrowLabel(data.eyebrow!),
          const SizedBox(height: 8),
        ],
        if (data.heading != null)
          Text(
            data.heading!,
            textAlign: _textAlign,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.2,
              color: title,
            ),
          ),
        if (data.body != null) ...[
          const SizedBox(height: 8),
          Text(
            data.body!,
            textAlign: _textAlign,
            style: TextStyle(fontSize: 14, color: muted, height: 1.55),
          ),
        ],
      ],
    );
  }
}

class ImageStoryPreview extends StatelessWidget {
  final BlockData data;
  const ImageStoryPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final pos = data.imagePosition ?? 'top';
    final image = data.image != null
        ? ProgrammeMedia(
      src: data.image,
      fit: BoxFit.cover,
      borderRadius: BorderRadius.circular(8.r),
      width: pos == 'top' ? double.infinity : 96.w,
      height: pos == 'top' ? null : 96.w,
    )
        : null;

    final text = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.caption != null) eyebrowLabel(data.caption!),
          if (data.body != null) ...[
            SizedBox(height: 6.h),
            Text(data.body!, style: TextStyle(fontSize: 13.5.sp, color: Colors.black54, height: 1.5)),
          ],
        ],
      ),
    );

    if (pos == 'top') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null) AspectRatio(aspectRatio: 16 / 9, child: image),
          SizedBox(height: 12.h),
          if (data.caption != null) eyebrowLabel(data.caption!),
          if (data.body != null)
            Text(data.body!, style: TextStyle(fontSize: 13.5.sp, color: Colors.black54, height: 1.5)),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pos == 'right'
          ? [text, SizedBox(width: 12.w), ?image]
          : [?image, SizedBox(width: 12.w), text],
    );
  }
}

// ───────────────────────── Module 4 ─────────────────────────

class PollPreview extends StatefulWidget {
  final BlockData data;
  const PollPreview({super.key, required this.data});

  @override
  State<PollPreview> createState() => _PollPreviewState();
}

// Live results for a poll, from GET /programmes/polls/<id>/answers —
// mirrors the web's PollAnswerApiItem.
class _PollAnswerItem {
  final String? answerId;
  final String? answer;
  final int count;
  final double? percentage;

  _PollAnswerItem({this.answerId, this.answer, required this.count, this.percentage});

  factory _PollAnswerItem.fromJson(Map<String, dynamic> json) {
    return _PollAnswerItem(
      answerId: json['answer_id']?.toString(),
      answer: json['answer']?.toString(),
      count: (json['count'] is num) ? (json['count'] as num).toInt() : 0,
      percentage: (json['percentage'] is num) ? (json['percentage'] as num).toDouble() : null,
    );
  }
}

_PollAnswerItem? _matchPollAnswer(List<_PollAnswerItem>? liveAnswers, {String? optionId, String? optionLabel}) {
  if (liveAnswers == null) return null;
  for (final a in liveAnswers) {
    if (a.answerId != null && a.answerId == optionId) return a;
  }
  for (final a in liveAnswers) {
    if (a.answer != null && optionLabel != null && a.answer!.toLowerCase() == optionLabel.toLowerCase()) {
      return a;
    }
  }
  return null;
}

class _PollPreviewState extends State<PollPreview> {
  String? voted;
  bool submitting = false;
  String? errorText;
  List<_PollAnswerItem>? answers;
  bool loadingAnswers = false;

  String get _voteStorageKey => 'poll_voted_${widget.data.id}';

  @override
  void initState() {
    super.initState();
    _restoreVoteAndMaybeFetch();
  }

  Future<void> _restoreVoteAndMaybeFetch() async {
    final pollId = widget.data.id;
    if (pollId == null) return;

    // Mirrors the web: remember which option this device already voted
    // for, so results still show after leaving and reopening the reader.
    final prefs = await SharedPreferences.getInstance();
    final storedVote = prefs.getString(_voteStorageKey);
    if (storedVote != null && mounted) {
      setState(() => voted = storedVote);
    }

    if (storedVote != null || widget.data.showResultsLive == true) {
      await _fetchAnswers();
    }
  }

  Future<void> _fetchAnswers() async {
    final pollId = widget.data.id;
    if (pollId == null || !mounted) return;
    setState(() => loadingAnswers = true);

    final res = await ApiService.get(ApiEndPoint.pollAnswers(pollId));
    if (!mounted) return;

    if (res.isSuccess) {
      final raw = res.data['data'];
      if (raw is List) {
        setState(() {
          answers = raw
              .whereType<Map>()
              .map((e) => _PollAnswerItem.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        });
      }
    }
    setState(() => loadingAnswers = false);
  }

  Future<void> _submitVote(Options o, int optionIndex) async {
    if (submitting || voted != null) return;

    // Optimistic UI: select immediately, roll back if the request fails.
    setState(() {
      voted = o.id;
      submitting = true;
      errorText = null;
    });

    final res = await ApiService.post(
      ApiEndPoint.answerPoll,
      body: {
        "poll_id": widget.data.id,
        "answer": o.label,
        "answer_id": o.id,
      },
    );

    if (!mounted) return;

    if (res.isSuccess) {
      if (o.id != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_voteStorageKey, o.id!);
      }
      setState(() => submitting = false);
      // Pull the real, up-to-date counts from the server instead of
      // guessing locally — this is what makes the result persist correctly
      // the next time this reader page is opened.
      await _fetchAnswers();
    } else {
      // Vote failed on the backend — undo the optimistic selection.
      setState(() {
        voted = null;
        submitting = false;
        errorText = res.message;
      });
    }
  }

  _PollAnswerItem? _matchAnswer(List<_PollAnswerItem>? liveAnswers, Options option) {
    return _matchPollAnswer(liveAnswers, optionId: option.id, optionLabel: option.label);
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.data.options ?? [];
    final staticResults = widget.data.results ?? [];
    // Prefer the live counts fetched from /polls/<id>/answers; fall back to
    // the static snapshot the programme loaded with if we don't have them
    // yet (e.g. still loading, or results aren't public for this poll).
    final liveAnswers = answers;
    final total = liveAnswers != null
        ? liveAnswers.fold<int>(0, (a, r) => a + r.count)
        : staticResults.fold<int>(0, (a, r) => a + (r.count ?? 0));

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFE9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E0D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.question ?? '',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            gridDelegate: aSliverGrid(2),
            itemBuilder: (context, i) {
              final o = options[i];
              final selected = voted == o.id;
              return GestureDetector(
                onTap: () => _submitVote(o, i),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFF014B52) : Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: selected ? const Color(0xFF014B52) : const Color(0xFFE5E0D8),
                    ),
                  ),
                  child: selected && submitting
                      ? SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                      : Text(
                    '${o.emoji ?? ''} ${o.label ?? ''}'.trim(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: selected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            },
          ),
          if (errorText != null) ...[
            SizedBox(height: 12.h),
            Text(
              errorText!,
              style: TextStyle(fontSize: 12.5.sp, color: Colors.red.shade700, fontWeight: FontWeight.w600),
            ),
          ],
          if (voted != null && !submitting && errorText == null && widget.data.thankYouMessage != null) ...[
            SizedBox(height: 12.h),
            Text(
              widget.data.thankYouMessage!,
              style: TextStyle(fontSize: 12.5.sp, color: Colors.green.shade700, fontWeight: FontWeight.w600),
            ),
          ],
          if (widget.data.showResultsLive == true || voted != null) ...[
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RESULTS',
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700, color: Colors.black45, letterSpacing: 0.5),
                ),
                if (loadingAnswers)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 10.w,
                        height: 10.w,
                        child: const CircularProgressIndicator(strokeWidth: 1.5, color: Colors.black45),
                      ),
                      SizedBox(width: 4.w),
                      Text('Loading...', style: TextStyle(fontSize: 10.sp, color: Colors.black45)),
                    ],
                  )
                else
                  Text(
                    '$total ${total == 1 ? 'vote' : 'votes'}',
                    style: TextStyle(fontSize: 10.sp, color: Colors.black45),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            ...options.asMap().entries.map((e) {
              final option = e.value;
              // Match the same way the web does: by answer_id first, then
              // by label, and only fall back to the initial static snapshot
              // if we don't have live answers at all yet.
              final _PollAnswerItem? match = _matchAnswer(liveAnswers, option);
              final int count = match?.count ?? (e.key < staticResults.length ? (staticResults[e.key].count ?? 0) : 0);
              final pct = total > 0 ? (count / total * 100).round() : 0;
              final width = (pct < 8 ? 8 : pct) / 100;
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(option.label ?? '', style: TextStyle(fontSize: 11.sp, color: Colors.black54)),
                        Text('$count', style: TextStyle(fontSize: 11.sp, color: Colors.black54)),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: width,
                        minHeight: 8.h,
                        backgroundColor: Colors.white,
                        color: const Color(0xFF014B52),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount aSliverGrid(int n) =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: n,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 2.6,
      );
}

class ReviewPreview extends StatefulWidget {
  final BlockData data;
  final Data? programme;
  const ReviewPreview({super.key, required this.data, this.programme});

  @override
  State<ReviewPreview> createState() => _ReviewPreviewState();
}

class _ReviewPreviewState extends State<ReviewPreview> {
  int chars = 0;
  bool submitted = false;
  bool submitting = false;
  String? errorText;
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _submitThought() async {
    final thought = controller.text.trim();
    final programmeId = widget.programme?.id;

    if (thought.isEmpty || submitting) return;
    if (programmeId == null) {
      setState(() => errorText = "Couldn't find this programme, please reopen it and try again.");
      return;
    }

    setState(() {
      submitting = true;
      errorText = null;
    });

    final res = await ApiService.post(
      ApiEndPoint.submitUserThought,
      body: {
        "proggrame": programmeId,
        "thought": thought,
      },
    );

    if (!mounted) return;

    if (res.isSuccess) {
      setState(() {
        submitting = false;
        submitted = true;
      });
    } else {
      setState(() {
        submitting = false;
        errorText = res.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    // Pull the colour the admin dashboard assigned for this block
    // (title_color / text_color), instead of falling back to the
    // default (black) text colour which disappears on a dark page.
    final headingColor = t?.title ?? t?.ink ?? const Color(0xFFF5A800);
    final counterColor = t?.inkFaint ?? Colors.black38;
    final max = widget.data.maxChars ?? 500;
    if (submitted) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
        ),
        child: Text(
          'Thanks for your review! ✓',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green.shade700, fontSize: 13.sp),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.data.prompt ?? 'Leave a review',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: headingColor),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          maxLines: 3,
          maxLength: max,
          enabled: !submitting,
          onChanged: (v) => setState(() => chars = v.length),
          decoration: InputDecoration(
            hintText: widget.data.placeholder ?? 'Write your thoughts...',
            counterText: '',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF014B52)),
            ),
          ),
        ),
        Text('$chars / $max', style: TextStyle(fontSize: 11.sp, color: counterColor)),
        if (errorText != null) ...[
          SizedBox(height: 8.h),
          Text(
            errorText!,
            style: TextStyle(fontSize: 12.sp, color: Colors.red.shade700, fontWeight: FontWeight.w600),
          ),
        ],
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 40.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF014B52),
              disabledBackgroundColor: const Color(0xFF014B52).withValues(alpha: 0.4),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            ),
            onPressed: (controller.text.trim().isEmpty || submitting) ? null : _submitThought,
            child: submitting
                ? SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
                : Text(
              widget.data.submitLabel ?? 'Submit',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13.sp),
            ),
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Module 5 ─────────────────────────

class MerchandisePreview extends StatelessWidget {
  final BlockData data;
  const MerchandisePreview({super.key, required this.data});

  List<MerchItem> get _items => data.merchItems ?? const [];

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    final line = t?.line ?? const Color(0xFFE5E0D8);
    final cardBg = t?.surfaceRaised ?? const Color(0xFFFBFAF7);
    final ink = t?.ink ?? const Color(0xFF1A1A1A);
    final primary = t?.primary ?? const Color(0xFF014B52);
    final items = _items;

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(data.title ?? 'Merchandise'),
        SizedBox(height: 12.h),
        ...items.map((it) {
          return GestureDetector(
            onTap: () => openExternalUrl(it.url),
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: line),
              ),
              child: Row(
                children: [
                  if (it.image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: ProgrammeMedia(
                        src: it.image,
                        width: 56.w,
                        height: 56.w,
                        allowFullscreen: false,
                      ),
                    ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          it.name ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                            color: ink,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          it.price ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13.sp,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
                    child: Icon(Icons.shopping_bag, size: 14.sp, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class FutureShowsPreview extends StatelessWidget {
  final BlockData data;
  const FutureShowsPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final shows = data.shows ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(data.title ?? 'Coming up'),
        SizedBox(height: 12.h),
        ...shows.map((s) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFE5E0D8)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (s.image != null)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ProgrammeMedia(src: s.image, fit: BoxFit.cover),
                  ),
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.name ?? '', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
                      if (s.date != null)
                        Text(s.date!, style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class DonationPreview extends StatefulWidget {
  final BlockData data;
  const DonationPreview({super.key, required this.data});

  @override
  State<DonationPreview> createState() => _DonationPreviewState();
}

class _DonationPreviewState extends State<DonationPreview> {
  int? selected;

  @override
  Widget build(BuildContext context) {
    final amounts = widget.data.presetAmounts ?? [];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E0D8)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.data.image != null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ProgrammeMedia(src: widget.data.image, fit: BoxFit.cover),
            ),
          Container(
            width: double.infinity,
            color: const Color(0xFFF2EFE9),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.data.image == null)
                  Icon(Icons.favorite, color: const Color(0xFFF5A800), size: 18.sp),
                Text(widget.data.title ?? '', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
                if (widget.data.body != null) ...[
                  SizedBox(height: 6.h),
                  Text(widget.data.body!, style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
                ],
                SizedBox(height: 12.h),
                Row(
                  children: amounts.map((amt) {
                    final sel = selected == amt;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: GestureDetector(
                          onTap: () => setState(() => selected = amt),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: sel ? const Color(0xFF014B52) : Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: sel ? const Color(0xFF014B52) : const Color(0xFFE5E0D8),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '£$amt',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13.sp,
                                color: sel ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 40.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5A800),
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                    ),
                    onPressed: () {
                      var url = widget.data.ctaUrl ?? '';
                      if (selected != null && url.isNotEmpty) {
                        url = url.contains('?') ? '$url&amount=$selected' : '$url?amount=$selected';
                      }
                      openExternalUrl(url);
                    },
                    child: Text(
                      '${widget.data.ctaLabel ?? 'Donate'}${selected != null ? ' — £$selected' : ''}',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OffersPreview extends StatelessWidget {
  final BlockData data;
  const OffersPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final offers = data.offers ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(data.title ?? 'Offers'),
        SizedBox(height: 12.h),
        ...offers.map((o) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF5A800).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFF5A800).withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(o.title ?? '', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
                if (o.description != null)
                  Text(o.description!, style: TextStyle(fontSize: 12.5.sp, color: Colors.black54)),
                if (o.code != null) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      o.code!,
                      style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w800, fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }
}

class AdsPreview extends StatefulWidget {
  final BlockData data;
  const AdsPreview({super.key, required this.data});

  @override
  State<AdsPreview> createState() => _AdsPreviewState();
}

class _AdsPreviewState extends State<AdsPreview> {
  List<Map<String, dynamic>> ads = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ids = widget.data.selectedItems ?? [];
    if (ids.isEmpty) {
      setState(() => ads = []);
      return;
    }
    final res = await ApiService.post('/ads/bulk-gets', body: {'ids': ids});
    final list = _extractList(res.isSuccess ? res.data : null);
    if (!mounted) return;
    setState(() {
      ads = list.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
    });
  }

  Future<void> _onTap(Map<String, dynamic> ad) async {
    final id = (ad['_id'] ?? ad['id'] ?? '').toString();
    final redirect = (ad['redirect_url'] ??
        ad['redirectUrl'] ??
        ad['link'] ??
        ad['url'] ??
        ad['website'] ??
        '#')
        .toString();
    try {
      if (id.isNotEmpty) await ApiService.get('/ads/$id');
    } catch (_) {}
    await openExternalUrl(redirect);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(widget.data.title ?? 'Sponsored'),
        SizedBox(height: 12.h),
        if (ads.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFE5E0D8), style: BorderStyle.solid),
            ),
            child: Text('Select ads to display', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 13.sp)),
          )
        else
          ...ads.map((ad) {
            final image = ad['image'] ?? ad['imageUrl'] ?? ad['cover_image'];
            return GestureDetector(
              onTap: () => _onTap(ad),
              child: Container(
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFE5E0D8)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (image != null)
                      Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ProgrammeMedia(src: image.toString(), fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              color: Colors.black54,
                              child: Text('SPONSORED', style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.w800, letterSpacing: 1)),
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${ad['title'] ?? ''}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
                          if (ad['description'] != null)
                            Text('${ad['description']}', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
                          SizedBox(height: 8.h),
                          Text('Learn more →', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w800, color: const Color(0xFF014B52))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}

// ───────────────────────── Module 6 ─────────────────────────

class MemoryCapturePreview extends StatefulWidget {
  final BlockData data;
  const MemoryCapturePreview({super.key, required this.data});

  @override
  State<MemoryCapturePreview> createState() => _MemoryCapturePreviewState();
}

class _MemoryCapturePreviewState extends State<MemoryCapturePreview> {
  final textCtrl = TextEditingController();
  final cardKey = GlobalKey();
  XFile? imageFile;
  Uint8List? generatedBytes;
  bool generating = false;

  @override
  void dispose() {
    textCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) setState(() => imageFile = file);
  }

  Future<void> _generate() async {
    setState(() => generating = true);
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      final boundary = cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      if (bytes != null) {
        setState(() => generatedBytes = bytes.buffer.asUint8List());
      }
    } finally {
      if (mounted) setState(() => generating = false);
    }
  }

  bool saving = false;

  Future<void> _save() async {
    if (generatedBytes == null || saving) return;
    setState(() => saving = true);

    try {
      // Ask for photo-library permission if we don't already have it.
      bool hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        hasAccess = await Gal.requestAccess();
      }
      if (!hasAccess) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please allow photo access to save your memory card.'),
          ),
        );
        return;
      }

      // Save the composed memory card (photo + your line + branding) as one
      // image directly into the device's photo gallery — not the raw photo
      // the user uploaded, but the finished card generated in _generate().
      await Gal.putImageBytes(
        generatedBytes!,
        name: 'showe-memory-${DateTime.now().millisecondsSinceEpoch}',
        album: 'ShowE Memories',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved to your photo gallery!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save memory: $e')),
      );
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  bool get hasContent => textCtrl.text.trim().isNotEmpty || imageFile != null;

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    final line = t?.line ?? const Color(0xFFE5E0D8);
    final cardBg = t?.cardBg ?? const Color(0xFF28251D);
    final cardText = t?.cardText ?? const Color(0xFFF9F8F4);
    final accent = t?.accent ?? const Color(0xFFF5A800);
    final primary = t?.primary ?? const Color(0xFF014B52);
    final sunken = t?.surfaceSunken ?? const Color(0xFF1E1C18);
    final inkMuted = t?.inkMuted ?? const Color(0xFF9A948C);
    final inkFaint = t?.inkFaint ?? const Color(0xFF6B6560);

    if (generatedBytes != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE5E0D8)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              color: const Color(0xFF014B52),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MEMORY CREATED!', style: TextStyle(color: const Color(0xFFF5A800), fontSize: 11.sp, fontWeight: FontWeight.w800, letterSpacing: 1)),
                  Text(widget.data.successMessage ?? 'Your memory card is ready.', style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.memory(generatedBytes!),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    height: 44.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF014B52)),
                      onPressed: saving ? null : _save,
                      icon: saving
                          ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                          : const Icon(Icons.download, color: Colors.white),
                      label: Text(
                        saving ? 'Saving...' : 'Save Memory',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      generatedBytes = null;
                      textCtrl.clear();
                      imageFile = null;
                    }),
                    child: const Text('Create Another'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // This is an off-screen render target used only to snapshot the
        // final "memory card" image (see _generate()) — it must NOT take
        // up real layout space. Transform.translate only shifts where a
        // widget is PAINTED; the Column below still reserved its full
        // height as if it were visible, which is exactly what was pushing
        // everything else down and leaving a big empty gap on the page.
        // SizedBox(0,0) + OverflowBox lets it render at full size for the
        // screenshot while reporting zero size to the layout above it.
        SizedBox(
          width: 0,
          height: 0,
          child: OverflowBox(
            alignment: Alignment.topLeft,
            minWidth: 0,
            minHeight: 0,
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.01,
                child: RepaintBoundary(
                  key: cardKey,
                  child: _MemoryCardVisual(
                    text: textCtrl.text.isEmpty
                        ? (widget.data.placeholder ?? '')
                        : textCtrl.text,
                    imagePath: imageFile?.path,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: line),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primary, Color.lerp(primary, Colors.black, 0.25)!],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, size: 12.sp, color: accent),
                        SizedBox(width: 6.w),
                        Text(
                          'MEMORY CAPTURE',
                          style: TextStyle(
                            color: accent,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.data.title ?? '',
                      style: TextStyle(
                        color: cardText,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    if (widget.data.prompt != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        widget.data.prompt!,
                        style: TextStyle(
                          color: cardText.withValues(alpha: 0.65),
                          fontSize: 12.sp,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: cardBg,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    if (widget.data.allowImage == true) ...[
                      GestureDetector(
                        onTap: _pickImage,
                        child: imageFile != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Image.file(
                              File(imageFile!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : Container(
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: 140.h),
                          decoration: BoxDecoration(
                            color: sunken,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: line,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 56.w,
                                height: 56.w,
                                decoration: BoxDecoration(
                                  color: cardBg,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: line),
                                ),
                                child: Icon(
                                  Icons.photo_camera_outlined,
                                  color: inkMuted,
                                  size: 24.sp,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'Add your photo',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  color: inkMuted,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Tap to choose from your gallery',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: inkFaint,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    if (widget.data.allowText == true) ...[
                      TextField(
                        controller: textCtrl,
                        maxLines: 3,
                        style: TextStyle(color: const Color(0xFF1A1A1A), fontSize: 13.sp),
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: widget.data.placeholder ?? 'Write your memory...',
                          hintStyle: TextStyle(color: inkFaint),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(12.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: line),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: line),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: primary, width: 1.5),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    if (widget.data.allowText == true ||
                        widget.data.allowImage == true)
                      SizedBox(
                        width: double.infinity,
                        height: 44.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: hasContent
                                ? primary
                                : sunken,
                            foregroundColor: hasContent
                                ? Colors.white
                                : inkFaint,
                            disabledBackgroundColor: sunken,
                            disabledForegroundColor: inkFaint,
                            elevation: hasContent ? 2 : 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999.r),
                              side: hasContent
                                  ? BorderSide.none
                                  : BorderSide(color: line),
                            ),
                          ),
                          onPressed: hasContent && !generating ? _generate : null,
                          child: generating
                              ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.auto_awesome, size: 14.sp),
                              SizedBox(width: 6.w),
                              Text(
                                widget.data.submitLabel ?? 'Create my memory',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (widget.data.privacyNote != null) ...[
                      SizedBox(height: 10.h),
                      Text(
                        widget.data.privacyNote!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.sp, color: inkFaint),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MemoryCardVisual extends StatelessWidget {
  final String text;
  final String? imagePath;
  const _MemoryCardVisual({required this.text, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF012D31), Color(0xFF011A1D), Color(0xFF010E10)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 40, height: 3, color: const Color(0xFFF5A800)),
          const SizedBox(height: 12),
          const Text('MY SHOWE MEMORY', style: TextStyle(color: Color(0xFFF5A800), fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 11)),
          const SizedBox(height: 16),
          if (imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(imagePath!), height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
          const SizedBox(height: 20),
          Text('"$text"', style: const TextStyle(color: Color(0xFFFBFAF7), fontSize: 16, height: 1.4, fontStyle: FontStyle.italic)),
          const SizedBox(height: 24),
          const Text('Showe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('Captured at the event', style: TextStyle(color: Colors.white38, fontSize: 11)),
        ],
      ),
    );
  }
}

// ───────────────────────── Module 7–10 ─────────────────────────

class RecapPreview extends StatefulWidget {
  final BlockData data;
  final Data? programme;
  final Pages? page;
  const RecapPreview({super.key, required this.data, this.programme, this.page});

  @override
  State<RecapPreview> createState() => _RecapPreviewState();
}

class _RecapPreviewState extends State<RecapPreview> {
  // pollId -> its live answers from GET /programmes/polls/<id>/answers
  Map<String, List<_PollAnswerItem>> answersByPoll = {};
  bool loading = false;

  bool get isReleased {
    final published = widget.programme?.publishedAt;
    if (published == null) return false;
    final publishedAt = DateTime.tryParse(published);
    if (publishedAt == null) return false;
    final hours = widget.data.releaseAfterHours ?? 0;
    final unlock = publishedAt.add(Duration(hours: hours));
    return DateTime.now().isAfter(unlock);
  }

  List<Blocks> get scopedPolls {
    final all = widget.programme?.pages
        ?.expand((p) => p.blocks ?? <Blocks>[])
        .where((b) => b.type == 'poll')
        .toList() ??
        [];
    final pagePolls = widget.page?.blocks?.where((b) => b.type == 'poll').toList() ?? [];
    final ids = widget.data.pollIdsToInclude ?? [];
    if (ids.isEmpty) return pagePolls;
    return all.where((b) => ids.contains(b.id) || ids.contains(b.data?.id)).toList();
  }

  @override
  void initState() {
    super.initState();
    if (isReleased) _fetchAllAnswers();
  }

  Future<void> _fetchAllAnswers() async {
    final polls = scopedPolls;
    if (polls.isEmpty || !mounted) return;
    setState(() => loading = true);

    // Same live-results endpoint the poll block itself uses — the recap
    // is just a rollup of those same polls, so it must read from the same
    // source instead of the static (always-zero) snapshot in the JSON.
    await Future.wait(polls.map((poll) async {
      final pollId = poll.data?.id ?? poll.id;
      if (pollId == null) return;
      final res = await ApiService.get(ApiEndPoint.pollAnswers(pollId));
      if (!res.isSuccess || !mounted) return;
      final raw = res.data['data'];
      if (raw is List) {
        answersByPoll[pollId] = raw
            .whereType<Map>()
            .map((e) => _PollAnswerItem.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }));

    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final polls = scopedPolls;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF014B52), Color(0xFF012D31)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          eyebrowLabel('Recap', color: const Color(0xFFF5A800)),
          SizedBox(height: 8.h),
          Text(data.title ?? '', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.sp)),
          if (data.description != null)
            Text(data.description!, style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.notifications, size: 12.sp, color: const Color(0xFFF5A800)),
              SizedBox(width: 6.w),
              Text(
                'Available ${data.releaseAfterHours ?? 0}h after the event',
                style: TextStyle(color: const Color(0xFFF5A800), fontSize: 11.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white10),
            ),
            child: !isReleased
                ? Text(
              'Poll results will unlock after ${data.releaseAfterHours ?? 0} hours.',
              style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            )
                : polls.isEmpty
                ? Text('No polls selected for this recap yet.', style: TextStyle(color: Colors.white70, fontSize: 12.sp))
                : loading
                ? Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 14.w,
                    height: 14.w,
                    child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white70),
                  ),
                  SizedBox(width: 8.w),
                  Text('Loading results...', style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                ],
              ),
            )
                : Column(
              children: polls.map((poll) {
                final opts = poll.data?.options ?? [];
                final staticResults = poll.data?.results ?? [];
                final pollId = poll.data?.id ?? poll.id;
                final liveAnswers = answersByPoll[pollId];
                final total = liveAnswers != null
                    ? liveAnswers.fold<int>(0, (a, r) => a + r.count)
                    : staticResults.fold<int>(0, (a, r) => a + (r.count ?? 0));
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('POLL RESULT', style: TextStyle(color: Colors.white38, fontSize: 10.sp, fontWeight: FontWeight.w800, letterSpacing: 1)),
                      Text(poll.data?.question ?? '', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13.sp)),
                      ...opts.asMap().entries.map((e) {
                        final option = e.value;
                        final match = _matchPollAnswer(liveAnswers, optionId: option.id, optionLabel: option.label);
                        final count = match?.count ?? (e.key < staticResults.length ? (staticResults[e.key].count ?? 0) : 0);
                        final pct = total > 0 ? (count / total * 100).round() : 0;
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(option.label ?? '', style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                                  Text('$count${total > 0 ? ' ($pct%)' : ''}', style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(99),
                                child: LinearProgressIndicator(
                                  value: (pct < 6 ? 6 : pct) / 100,
                                  minHeight: 8.h,
                                  backgroundColor: Colors.white10,
                                  color: const Color(0xFFF5A800),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendationsPreview extends StatefulWidget {
  final BlockData data;
  const RecommendationsPreview({super.key, required this.data});

  @override
  State<RecommendationsPreview> createState() => _RecommendationsPreviewState();
}

class _RecommendationsPreviewState extends State<RecommendationsPreview> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ids = widget.data.selectedItems ?? [];
    if (ids.isEmpty) {
      setState(() => items = []);
      return;
    }
    final res = await ApiService.post('/recommendations/bulk-gets', body: {'ids': ids});
    final list = _extractList(res.isSuccess ? res.data : null);
    if (!mounted) return;
    setState(() {
      items = list.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
    });
  }

  (IconData, String, Color) _meta(String? category) {
    final cat = (category ?? '').toLowerCase().trim();
    if (cat.contains('restaurant') || cat == 'restrudants') {
      return (Icons.restaurant, 'Restaurant', Colors.orange);
    }
    if (cat.contains('hotel')) {
      return (Icons.hotel, 'Hotel', Colors.indigo);
    }
    return (Icons.local_bar, 'Bar', Colors.purple);
  }

  Future<void> _onTap(Map<String, dynamic> rec) async {
    final id = (rec['_id'] ?? rec['id'] ?? '').toString();
    final url = (rec['website'] ?? rec['url'] ?? '#').toString();
    try {
      if (id.isNotEmpty) await ApiService.get('/recommendations/$id');
    } catch (_) {}
    await openExternalUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(widget.data.title ?? 'Recommendations'),
        SizedBox(height: 12.h),
        if (items.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFE5E0D8)),
            ),
            child: Text('Select items to display', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 13.sp)),
          )
        else
          ...items.map((rec) {
            final meta = _meta(rec['category']?.toString());
            return GestureDetector(
              onTap: () => _onTap(rec),
              child: Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFE5E0D8)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: ProgrammeMedia(
                        src: rec['image']?.toString(),
                        width: 56.w,
                        height: 56.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text('${rec['name'] ?? ''}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: meta.$3.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6.r),
                                  border: Border.all(color: meta.$3.withValues(alpha: 0.2)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(meta.$1, size: 10.sp, color: meta.$3),
                                    SizedBox(width: 3.w),
                                    Text(meta.$2, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w800, color: meta.$3)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text('${rec['category'] ?? ''}'.toUpperCase(), style: TextStyle(fontSize: 10.sp, color: Colors.black38)),
                          Row(
                            children: [
                              if (widget.data.showRating == true) ...[
                                Icon(Icons.star, size: 12.sp, color: const Color(0xFFF5A800)),
                                Text(' ${rec['rating'] ?? ''}', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600)),
                              ],
                              if (widget.data.showDistance == true)
                                Text(' · ${rec['distance'] ?? ''}', style: TextStyle(fontSize: 11.sp, color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}

class PushNotificationPreview extends StatelessWidget {
  final BlockData data;
  const PushNotificationPreview({super.key, required this.data});

  String get triggerLabel {
    switch (data.trigger) {
      case 'immediate':
        return 'Immediate';
      case 'scheduled':
        if (data.scheduledAt != null) {
          final dt = DateTime.tryParse(data.scheduledAt!);
          if (dt != null) {
            final h = dt.hour.toString().padLeft(2, '0');
            final m = dt.minute.toString().padLeft(2, '0');
            return 'Scheduled for $h:$m';
          }
        }
        return 'Scheduled';
      case 'pre_event':
        return '${data.offsetMinutes ?? 0}m before event';
      case 'post_event':
        return '${data.offsetMinutes ?? 0}m after event';
      default:
        return data.trigger ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E0D8)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 16.w,
                height: 16.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: const Color(0xFF014B52), borderRadius: BorderRadius.circular(3.r)),
                child: Text('S', style: TextStyle(color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.w800)),
              ),
              SizedBox(width: 6.w),
              Text('SHOWE · $triggerLabel', style: TextStyle(fontSize: 10.sp, color: Colors.black38)),
            ],
          ),
          SizedBox(height: 6.h),
          Text(data.title ?? '', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
          if (data.message != null)
            Text(data.message!, style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
        ],
      ),
    );
  }
}

class MapPreview extends StatelessWidget {
  final BlockData data;
  const MapPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final t = ReaderBlockTheme.maybeOf(context);
    final line = t?.line ?? const Color(0xFFE5E0D8);
    final sunken = t?.surfaceSunken ?? const Color(0xFFF2EFE9);
    final ink = t?.ink ?? const Color(0xFF1A1A1A);
    final inkFaint = t?.inkFaint ?? const Color(0xFF9A948C);
    final inkMuted = t?.inkMuted ?? const Color(0xFF6B6560);
    final primary = t?.primary ?? const Color(0xFF014B52);

    final hasCoords = data.lat != null && data.lng != null;
    final lat = data.lat ?? 51.3873;
    final lng = data.lng ?? -2.3669;
    final address = data.address ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(data.title ?? 'Map'),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: line),
            color: sunken,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (hasCoords)
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, lng),
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('venue'),
                            position: LatLng(lat, lng),
                            infoWindow: InfoWindow(
                              title: address.split(',').first,
                              snippet: address,
                            ),
                          ),
                        },
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                      )
                    else if (address.trim().isNotEmpty)
                      _AddressMapPreview(
                        address: address.trim(),
                        title: data.title ?? 'Map',
                      )
                    else
                      Center(
                        child: Icon(Icons.location_on, color: primary, size: 28.sp),
                      ),
                    Positioned(
                      left: 8.w,
                      right: 8.w,
                      bottom: 8.h,
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: sunken.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address.isNotEmpty
                                  ? address.split(',').first
                                  : 'Venue location',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: ink,
                              ),
                            ),
                            Text(
                              address.isNotEmpty
                                  ? address
                                  : 'Add an address to preview the map.',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: inkFaint,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        if (data.showParking == true)
                          _chip(Icons.local_parking, 'Parking available', Colors.green),
                        if (data.showAccessibilityRoute == true)
                          _chip(Icons.accessible, 'Accessibility route shown', primary),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.check_circle, size: 13.sp, color: Colors.green.shade700),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            hasCoords
                                ? 'Preview anchored at ${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}'
                                : 'Preview is using the address only. Add coordinates for a more precise embed.',
                            style: TextStyle(fontSize: 11.sp, color: inkMuted),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: color),
          SizedBox(width: 6.w),
          Text(text, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}

/// Address-only map: geocode → native GoogleMap, else Google embed WebView.
class _AddressMapPreview extends StatefulWidget {
  final String address;
  final String title;

  const _AddressMapPreview({required this.address, required this.title});

  @override
  State<_AddressMapPreview> createState() => _AddressMapPreviewState();
}

class _AddressMapPreviewState extends State<_AddressMapPreview> {
  LatLng? _coords;
  File? _snapshot;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _resolve();
  }

  Future<void> _resolve() async {
    final cachedSnap = await ProgrammeMapCache.getSnapshotFile(widget.address);
    final cachedCoords = await ProgrammeMapCache.getCachedCoords(widget.address);

    if (cachedSnap != null) {
      if (!mounted) return;
      setState(() {
        _snapshot = cachedSnap;
        _coords = cachedCoords;
        _loading = false;
      });
      ProgrammeMapCache.prefetchAddress(widget.address);
      return;
    }

    final coords = await ProgrammeMapCache.resolveCoords(widget.address);
    File? snap;
    if (coords != null) {
      snap = await ProgrammeMapCache.downloadSnapshot(widget.address, coords);
    }

    if (!mounted) return;
    setState(() {
      _coords = coords ?? cachedCoords;
      _snapshot = snap;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        color: const Color(0xFFF2EFE9),
        alignment: Alignment.center,
        child: const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (_snapshot != null) {
      return GestureDetector(
        onTap: () => openExternalUrl(googleMapsSearchUrl(widget.address)),
        child: Image.file(
          _snapshot!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, __, ___) => _liveMapFallback(),
        ),
      );
    }

    return _liveMapFallback();
  }

  Widget _liveMapFallback() {
    if (_coords != null) {
      final pos = _coords!;
      return GoogleMap(
        initialCameraPosition: CameraPosition(target: pos, zoom: 15),
        markers: {
          Marker(
            markerId: const MarkerId('venue'),
            position: pos,
            infoWindow: InfoWindow(
              title: widget.address.split(',').first,
              snippet: widget.address,
            ),
          ),
        },
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        onTap: (_) => openExternalUrl(googleMapsSearchUrl(widget.address)),
      );
    }

    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri(googleMapsEmbedUrl(widget.address)),
      ),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        transparentBackground: false,
        underPageBackgroundColor: const Color(0xFFF2EFE9),
        useHybridComposition: true,
        supportZoom: false,
        disableHorizontalScroll: true,
        disableVerticalScroll: true,
      ),
    );
  }
}

class DirectionsPreview extends StatelessWidget {
  final BlockData data;
  const DirectionsPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eyebrowLabel(data.title ?? 'Getting here'),
        SizedBox(height: 12.h),
        if (data.byTrain != null) _card('BY TRAIN', data.byTrain!),
        if (data.byCar != null) _card('BY CAR', data.byCar!),
        if (data.byBus != null) _card('BY BUS', data.byBus!),
        if (data.parkingInfo != null) _card('PARKING', data.parkingInfo!),
      ],
    );
  }

  Widget _card(String label, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFE9),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w800, letterSpacing: 1)),
          SizedBox(height: 4.h),
          Text(value, style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
        ],
      ),
    );
  }
}