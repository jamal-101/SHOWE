import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../utils/programme_image.dart';
import '../utils/programme_video_cache.dart';
import 'reader_block_theme.dart';

Future<void> openExternalUrl(String? url) async {
  if (url == null || url.isEmpty || url == '#') return;
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Widget eyebrowLabel(String text, {Color? color, BuildContext? context}) {
  return Builder(
    builder: (ctx) {
      final theme = ReaderBlockTheme.maybeOf(context ?? ctx);
      return Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
          color: color ?? theme?.eyebrow ?? const Color(0xFF6B6560),
        ),
      );
    },
  );
}

/// Opens hero / inline video in fullscreen with play controls.
void openProgrammeVideoFullscreen(
    BuildContext context, {
      required String? src,
      bool initialMuted = true,
    }) {
  final url = getProgrammeImageUrl(src);
  if (url.isEmpty || !isProgrammeVideoUrl(url)) return;
  showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.95),
    builder: (ctx) => _FullscreenVideoDialog(
      url: url,
      initialMuted: initialMuted,
    ),
  );
}

class ProgrammeMedia extends StatelessWidget {
  final String? src;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool showMuteChip;
  final bool allowFullscreen;
  /// When true, inline video ignores taps so a parent [GestureDetector] can handle them.
  final bool deferGestures;
  /// Hero cover videos autoplay muted (web `MediaRenderer` default).
  final bool autoPlay;
  final ValueChanged<double>? onAspectRatioReady;

  const ProgrammeMedia({
    super.key,
    required this.src,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.showMuteChip = true,
    this.allowFullscreen = true,
    this.deferGestures = false,
    this.autoPlay = false,
    this.onAspectRatioReady,
  });

  @override
  Widget build(BuildContext context) {
    final url = getProgrammeImageUrl(src);
    if (url.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: const Color(0xFFF2EFE9),
      );
    }

    if (isProgrammeVideoUrl(url)) {
      Widget video = _InlineVideo(
        url: url,
        fit: fit,
        showMuteChip: showMuteChip && !deferGestures,
        allowFullscreen: allowFullscreen,
        deferGestures: deferGestures,
        autoPlay: autoPlay,
        onAspectRatioReady: onAspectRatioReady,
      );
      if (borderRadius != null) {
        video = ClipRRect(borderRadius: borderRadius!, child: video);
      }
      return SizedBox(width: width, height: height, child: video);
    }

    Widget image = CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      placeholder: (_, __) => Container(color: const Color(0xFFF2EFE9)),
      errorWidget: (_, __, ___) => Container(
        color: const Color(0xFFF2EFE9),
        alignment: Alignment.center,
        child: const Icon(Icons.broken_image, color: Colors.black26),
      ),
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }
}

class _InlineVideo extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final bool showMuteChip;
  final bool allowFullscreen;
  final bool deferGestures;
  final bool autoPlay;
  final ValueChanged<double>? onAspectRatioReady;

  const _InlineVideo({
    required this.url,
    required this.fit,
    required this.showMuteChip,
    required this.allowFullscreen,
    required this.deferGestures,
    required this.autoPlay,
    this.onAspectRatioReady,
  });

  @override
  State<_InlineVideo> createState() => _InlineVideoState();
}

class _InlineVideoState extends State<_InlineVideo> {
  VideoPlayerController? _controller;
  bool _ready = false;
  bool _muted = true;
  bool _failed = false;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _onControllerUpdate() {
    if (!mounted || _controller == null) return;
    final nowPlaying = _controller!.value.isPlaying;
    if (nowPlaying != _playing) {
      setState(() => _playing = nowPlaying);
    }
  }

  Future<void> _init() async {
    VideoPlayerController controller;
    final cached = await ProgrammeVideoCache.getCachedFile(widget.url);
    if (cached != null) {
      controller = VideoPlayerController.file(cached);
    } else {
      controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      // Defer cache download so it does not compete with the video stream buffer.
      Future<void>.delayed(const Duration(seconds: 4), () {
        ProgrammeVideoCache.download(widget.url);
      });
    }
    _controller = controller;
    try {
      await controller.initialize();
      if (!mounted) return;
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.seekTo(Duration.zero);
      _playing = controller.value.isPlaying;
      controller.addListener(_onControllerUpdate);
      if (widget.autoPlay) {
        await controller.play();
        _playing = true;
      } else {
        await controller.pause();
        _playing = false;
      }
      widget.onAspectRatioReady?.call(controller.value.aspectRatio);
      setState(() {
        _ready = true;
        _muted = true;
      });
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerUpdate);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _toggleMute() async {
    final c = _controller;
    if (c == null || !_ready) return;
    setState(() => _muted = !_muted);
    await c.setVolume(_muted ? 0 : 1);
  }

  void _openFullscreen() {
    if (!widget.allowFullscreen || _controller == null || !_ready) return;
    openProgrammeVideoFullscreen(
      context,
      src: widget.url,
      initialMuted: _muted,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return GestureDetector(
        onTap: () async {
          setState(() {
            _failed = false;
            _ready = false;
          });
          _controller?.dispose();
          _controller = null;
          await _init();
        },
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, color: Colors.white38, size: 28),
              const SizedBox(height: 8),
              Text(
                'Video unavailable offline',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    if (!_ready || _controller == null) {
      return Container(
        color: Colors.black12,
        alignment: Alignment.center,
        child: const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white38),
        ),
      );
    }

    final c = _controller!;
    final playing = _playing;

    Widget videoLayer;
    if (widget.fit == BoxFit.contain) {
      videoLayer = Center(
        child: AspectRatio(
          aspectRatio: c.value.aspectRatio,
          child: VideoPlayer(c),
        ),
      );
    } else {
      videoLayer = FittedBox(
        fit: widget.fit,
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: c.value.size.width,
          height: c.value.size.height,
          child: VideoPlayer(c),
        ),
      );
    }

    Widget stack = RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: widget.deferGestures ? null : _openFullscreen,
            child: ColoredBox(
              color: widget.fit == BoxFit.contain ? Colors.black : Colors.transparent,
              child: videoLayer,
            ),
          ),
          if (!playing && !widget.autoPlay)
            Center(
              child: IgnorePointer(
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
                  ),
                  child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
                ),
              ),
            ),
          if (widget.showMuteChip)
            Positioned(
              right: 10,
              bottom: 10,
              child: Material(
                color: Colors.black.withValues(alpha: 0.55),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _toggleMute,
                  child: SizedBox(
                    width: 34,
                    height: 34,
                    child: Icon(
                      _muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    if (widget.deferGestures) {
      stack = IgnorePointer(child: stack);
    }

    return stack;
  }
}

/// Fullscreen video with play/pause + mute — used by hero and cast spotlight.
class FullscreenVideoPlayer extends StatefulWidget {
  final String url;
  final bool initialMuted;
  final bool autoPlay;
  final Widget? footer;

  const FullscreenVideoPlayer({
    super.key,
    required this.url,
    this.initialMuted = true,
    this.autoPlay = true,
    this.footer,
  });

  @override
  State<FullscreenVideoPlayer> createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  VideoPlayerController? _controller;
  bool _ready = false;
  late bool _muted;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _muted = widget.initialMuted;
    _init();
  }

  Future<void> _init() async {
    VideoPlayerController controller;
    final cached = await ProgrammeVideoCache.getCachedFile(widget.url);
    if (cached != null) {
      controller = VideoPlayerController.file(cached);
    } else {
      controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      Future<void>.delayed(const Duration(seconds: 4), () {
        ProgrammeVideoCache.download(widget.url);
      });
    }
    _controller = controller;
    try {
      await controller.initialize();
      if (!mounted) return;
      await controller.setLooping(true);
      await controller.setVolume(_muted ? 0 : 1);
      if (widget.autoPlay) {
        await controller.play();
        _playing = true;
      }
      setState(() => _ready = true);
    } catch (_) {}
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    final c = _controller;
    if (c == null || !_ready) return;
    if (c.value.isPlaying) {
      await c.pause();
      setState(() => _playing = false);
    } else {
      await c.play();
      setState(() => _playing = true);
    }
  }

  Future<void> _toggleMute() async {
    final c = _controller;
    if (c == null || !_ready) return;
    setState(() => _muted = !_muted);
    await c.setVolume(_muted ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    final footer = widget.footer;

    return Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (_ready && _controller != null)
                GestureDetector(
                  onTap: _togglePlay,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                )
              else
                const Center(
                  child: CircularProgressIndicator(color: Colors.white38),
                ),
              if (_ready && !_playing)
                Center(
                  child: IgnorePointer(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
                      ),
                      child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40),
                    ),
                  ),
                ),
              Positioned(
                right: 16,
                bottom: 16,
                child: IconButton(
                  onPressed: _toggleMute,
                  icon: Icon(
                    _muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(backgroundColor: Colors.black45),
                ),
              ),
            ],
          ),
        ),
        if (footer != null) footer,
      ],
    );
  }
}

class _FullscreenVideoDialog extends StatefulWidget {
  final String url;
  final bool initialMuted;

  const _FullscreenVideoDialog({
    required this.url,
    required this.initialMuted,
  });

  @override
  State<_FullscreenVideoDialog> createState() => _FullscreenVideoDialogState();
}

class _FullscreenVideoDialogState extends State<_FullscreenVideoDialog> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Restore the app's normal status-bar icon style too — switching UI
    // mode alone doesn't bring this back, so without this the status bar
    // could be left in whatever state the video player put it in.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FullscreenVideoPlayer(
            url: widget.url,
            initialMuted: widget.initialMuted,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.white),
              style: IconButton.styleFrom(backgroundColor: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}