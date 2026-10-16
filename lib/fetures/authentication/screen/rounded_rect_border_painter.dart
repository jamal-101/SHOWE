import 'package:flutter/cupertino.dart';

class RoundedRectBorderPainter extends CustomPainter {
  final double progress; // 0.0 থেকে 1.0 পর্যন্ত
  final Color color;
  final double strokeWidth;
  final double radius;

  RoundedRectBorderPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final path = Path()..addRRect(rRect);

    // বর্ডারের পাথ ট্র্যাক করে প্রোগ্রেস অনুযায়ী ড্র করা
    final pathMetrics = path.computeMetrics();
    for (var metric in pathMetrics) {
      final extractPath = metric.extractPath(0.0, metric.length * progress);
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant RoundedRectBorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}