import 'package:flutter/material.dart';

class EventBannerIllustration extends StatelessWidget {
  const EventBannerIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 3.1,
        child: CustomPaint(
          painter: _EventBannerPainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _EventBannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Soft sage background
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFE7EFE0),
    );

    // Decorative pastel circles
    canvas.drawCircle(
      Offset(w * 0.22, h * 0.92),
      h * 0.62,
      Paint()..color = const Color(0xFFEBDCC2).withValues(alpha: 0.72),
    );
    canvas.drawCircle(
      Offset(w * 0.78, h * 0.22),
      h * 0.68,
      Paint()..color = const Color(0xFFDCE8CA).withValues(alpha: 0.85),
    );

    // Subtle horizon curve
    final curvePath = Path()
      ..moveTo(0, h * 0.80)
      ..quadraticBezierTo(w * 0.5, h * 0.58, w, h * 0.78);
    canvas.drawPath(
      curvePath,
      Paint()
        ..color = const Color(0xFFC8D9BD)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );

    final stroke = Paint()
      ..color = const Color(0xFF4E6B47)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Center calendar card
    final calW = h * 0.84;
    final calH = h * 0.62;
    final calLeft = (w - calW) / 2;
    final calTop = h * 0.22;
    final calRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(calLeft, calTop, calW, calH),
      const Radius.circular(8),
    );

    canvas.drawRRect(calRect, Paint()..color = const Color(0xFFFDFBF5));
    // Calendar top header bar
    canvas.save();
    canvas.clipRRect(calRect);
    canvas.drawRect(
      Rect.fromLTWH(calLeft, calTop, calW, calH * 0.24),
      Paint()..color = const Color(0xFFB4CFA0),
    );
    canvas.restore();
    canvas.drawRRect(calRect, stroke);

    // Calendar header divider
    canvas.drawLine(
      Offset(calLeft, calTop + calH * 0.24),
      Offset(calLeft + calW, calTop + calH * 0.24),
      stroke,
    );

    // Calendar rings
    for (final dx in [0.24, 0.5, 0.76]) {
      canvas.drawLine(
        Offset(calLeft + calW * dx, calTop - 5),
        Offset(calLeft + calW * dx, calTop + 5),
        stroke,
      );
    }

    // Small list lines on left side of calendar
    for (final dy in [0.46, 0.64, 0.80]) {
      canvas.drawLine(
        Offset(calLeft + calW * 0.14, calTop + calH * dy),
        Offset(calLeft + calW * 0.34, calTop + calH * dy),
        Paint()
          ..color = const Color(0xFF93AD88)
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round,
      );
    }

    // Leaf icon in center-right of calendar
    final leafCenter = Offset(calLeft + calW * 0.64, calTop + calH * 0.62);
    final leafPath = Path()
      ..moveTo(leafCenter.dx - 11, leafCenter.dy + 10)
      ..quadraticBezierTo(
        leafCenter.dx - 12,
        leafCenter.dy - 10,
        leafCenter.dx + 12,
        leafCenter.dy - 12,
      )
      ..quadraticBezierTo(
        leafCenter.dx + 10,
        leafCenter.dy + 10,
        leafCenter.dx - 11,
        leafCenter.dy + 10,
      );
    canvas.drawPath(leafPath, Paint()..color = const Color(0xFF8DB674));
    canvas.drawPath(leafPath, stroke);
    canvas.drawLine(
      Offset(leafCenter.dx - 11, leafCenter.dy + 10),
      Offset(leafCenter.dx + 7, leafCenter.dy - 7),
      stroke,
    );

    // Location pin at top-right of calendar
    final pinCenter = Offset(calLeft + calW + 10, calTop + 6);
    canvas.drawCircle(
      pinCenter,
      9,
      Paint()..color = const Color(0xFFFDFBF5),
    );
    canvas.drawCircle(pinCenter, 9, stroke);
    canvas.drawCircle(
      pinCenter,
      3,
      Paint()..color = const Color(0xFF4E6B47),
    );

    // Left community figure (sage green)
    _drawPerson(
      canvas,
      Offset(calLeft - 22, calTop + calH * 0.56),
      const Color(0xFF9EC088),
      stroke,
    );

    // Right community figure (warm sand)
    _drawPerson(
      canvas,
      Offset(calLeft + calW + 22, calTop + calH * 0.60),
      const Color(0xFFD7BC8A),
      stroke,
    );
  }

  void _drawPerson(
    Canvas canvas,
    Offset center,
    Color fillColor,
    Paint stroke,
  ) {
    final fill = Paint()..color = fillColor;
    // Head
    canvas.drawCircle(Offset(center.dx, center.dy - 14), 7, fill);
    canvas.drawCircle(Offset(center.dx, center.dy - 14), 7, stroke);
    // Torso
    final bodyRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + 7),
        width: 22,
        height: 24,
      ),
      topLeft: const Radius.circular(11),
      topRight: const Radius.circular(11),
      bottomLeft: const Radius.circular(4),
      bottomRight: const Radius.circular(4),
    );
    canvas.drawRRect(bodyRect, fill);
    canvas.drawRRect(bodyRect, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
