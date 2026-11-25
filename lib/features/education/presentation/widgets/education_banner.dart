import 'package:flutter/material.dart';

class EducationBannerIllustration extends StatelessWidget {
  const EducationBannerIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 3.1,
        child: CustomPaint(
          painter: _EducationBannerPainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _EducationBannerPainter extends CustomPainter {
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

    final cx = w * 0.5;
    final bookTop = h * 0.42;
    final bookBottom = h * 0.84;
    final halfBookW = h * 0.48;

    // Open book left page
    final leftPage = Path()
      ..moveTo(cx, bookTop + 6)
      ..quadraticBezierTo(
        cx - halfBookW * 0.5,
        bookTop - 4,
        cx - halfBookW,
        bookTop + 2,
      )
      ..lineTo(cx - halfBookW, bookBottom - 4)
      ..quadraticBezierTo(
        cx - halfBookW * 0.5,
        bookBottom - 10,
        cx,
        bookBottom,
      )
      ..close();

    // Open book right page
    final rightPage = Path()
      ..moveTo(cx, bookTop + 6)
      ..quadraticBezierTo(
        cx + halfBookW * 0.5,
        bookTop - 4,
        cx + halfBookW,
        bookTop + 2,
      )
      ..lineTo(cx + halfBookW, bookBottom - 4)
      ..quadraticBezierTo(
        cx + halfBookW * 0.5,
        bookBottom - 10,
        cx,
        bookBottom,
      )
      ..close();

    canvas.drawPath(leftPage, Paint()..color = const Color(0xFFFDFBF5));
    canvas.drawPath(rightPage, Paint()..color = const Color(0xFFF6F9F0));
    canvas.drawPath(leftPage, stroke);
    canvas.drawPath(rightPage, stroke);

    // Page text lines
    final linePaint = Paint()
      ..color = const Color(0xFF93AD88)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    for (final factor in [0.30, 0.52, 0.72]) {
      final y = bookTop + (bookBottom - bookTop) * factor;
      canvas.drawLine(
        Offset(cx - halfBookW * 0.76, y),
        Offset(cx - halfBookW * 0.20, y),
        linePaint,
      );
      canvas.drawLine(
        Offset(cx + halfBookW * 0.20, y),
        Offset(cx + halfBookW * 0.76, y),
        linePaint,
      );
    }

    // Lightbulb above right page
    final bulbCenter = Offset(cx + halfBookW * 0.44, h * 0.24);
    canvas.drawCircle(
      bulbCenter,
      11,
      Paint()..color = const Color(0xFFEBD28B),
    );
    canvas.drawCircle(bulbCenter, 11, stroke);
    canvas.drawLine(
      Offset(bulbCenter.dx - 4, bulbCenter.dy + 13),
      Offset(bulbCenter.dx + 4, bulbCenter.dy + 13),
      stroke,
    );

    // Small rays around lightbulb
    for (final ray in [
      [Offset(0, -16), Offset(0, -21)],
      [Offset(-15, -8), Offset(-19, -11)],
      [Offset(15, -8), Offset(19, -11)],
    ]) {
      canvas.drawLine(
        bulbCenter + ray[0],
        bulbCenter + ray[1],
        Paint()
          ..color = const Color(0xFF8AA577)
          ..strokeWidth = 1.5
          ..strokeCap = StrokeCap.round,
      );
    }

    // Small leaf to the left of the book
    final leafCenter = Offset(cx - halfBookW - 18, h * 0.66);
    final leafPath = Path()
      ..moveTo(leafCenter.dx - 10, leafCenter.dy + 4)
      ..quadraticBezierTo(
        leafCenter.dx,
        leafCenter.dy - 10,
        leafCenter.dx + 10,
        leafCenter.dy - 2,
      )
      ..quadraticBezierTo(
        leafCenter.dx,
        leafCenter.dy + 10,
        leafCenter.dx - 10,
        leafCenter.dy + 4,
      );
    canvas.drawPath(leafPath, Paint()..color = const Color(0xFF8DB674));
    canvas.drawPath(leafPath, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
