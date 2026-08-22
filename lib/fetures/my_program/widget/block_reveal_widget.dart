import 'package:flutter/material.dart';
import '../model/single_proram_model.dart';

/// Reveal-on-scroll animation for reader blocks (React `useReveal`).
class BlockRevealWidget extends StatefulWidget {
  final BlockAnimation? animation;
  final Widget child;

  const BlockRevealWidget({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  State<BlockRevealWidget> createState() => _BlockRevealWidgetState();
}

class _BlockRevealWidgetState extends State<BlockRevealWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;
  late final Animation<double> _scale;
  bool _started = false;

  String get _type => widget.animation?.type ?? 'none';
  int get _durationMs => widget.animation?.durationMs ?? 500;
  int get _delayMs => widget.animation?.delayMs ?? 0;

  bool get _skipReveal => _type == 'none' || _type == 'tap_expand';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _durationMs.clamp(100, 3000)),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: const Cubic(0.16, 1, 0.3, 1),
    );

    _opacity = Tween<double>(begin: _skipReveal ? 1 : 0, end: 1).animate(curve);
    _offset = Tween<Offset>(
      begin: _initialOffset(),
      end: Offset.zero,
    ).animate(curve);
    _scale = Tween<double>(
      begin: _type == 'scale_in' ? 0.96 : 1,
      end: 1,
    ).animate(curve);

    if (_skipReveal) {
      _controller.value = 1;
      _started = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _tryReveal());
    }
  }

  Offset _initialOffset() {
    switch (_type) {
      case 'slide_up':
        return const Offset(0, 0.08);
      case 'slide_in_right':
        return const Offset(0.08, 0);
      case 'parallax':
        return const Offset(0, 0.12);
      case 'fade_in':
      default:
        return Offset.zero;
    }
  }

  void _tryReveal() {
    if (!mounted || _started) return;
    _started = true;
    Future.delayed(Duration(milliseconds: _delayMs.clamp(0, 5000)), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: ScaleTransition(
          scale: _scale,
          child: widget.child,
        ),
      ),
    );
  }
}
