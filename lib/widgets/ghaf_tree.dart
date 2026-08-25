import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class GhafTreeVisual extends StatelessWidget {
  const GhafTreeVisual({super.key, required this.levelIndex, this.size = 200});

  final int levelIndex;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GhafTreePainter(levelIndex: levelIndex, sparkColor: context.appColors.dana),
      ),
    );
  }
}

class _GhafTreePainter extends CustomPainter {
  _GhafTreePainter({required this.levelIndex, required this.sparkColor});

  final int levelIndex;
  final Color sparkColor;

  static const _trunkColor = Color(0xFF6B5238);
  static const _canopyDark = Color(0xFF2E5E4E);
  static const _canopyLight = Color(0xFF4A806C);

  static const _sparkOffsets = [
    Offset(-0.30, -0.10),
    Offset(0.24, -0.24),
    Offset(0.02, -0.34),
    Offset(-0.14, 0.06),
    Offset(0.32, 0.04),
    Offset(-0.34, 0.16),
    Offset(0.16, 0.22),
    Offset(-0.02, -0.02),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final groundY = h * 0.92;
    final trunkHeight = h * (0.14 + levelIndex * 0.035);
    final canopyRadius = w * (0.13 + levelIndex * 0.075);
    final canopyCenterY = groundY - trunkHeight - canopyRadius * 0.55;

    final groundPaint = Paint()
      ..color = _trunkColor.withValues(alpha: 0.25)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.2, groundY), Offset(w * 0.8, groundY), groundPaint);

    final trunkPaint = Paint()
      ..color = _trunkColor
      ..strokeWidth = 4 + levelIndex.toDouble()
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w / 2, groundY), Offset(w / 2, groundY - trunkHeight), trunkPaint);

    final darkPaint = Paint()..color = _canopyDark.withValues(alpha: 0.92);
    final lightPaint = Paint()..color = _canopyLight.withValues(alpha: 0.92);

    canvas.drawCircle(Offset(w / 2, canopyCenterY), canopyRadius, darkPaint);
    canvas.drawCircle(
      Offset(w / 2 - canopyRadius * 0.45, canopyCenterY + canopyRadius * 0.25),
      canopyRadius * 0.75,
      lightPaint,
    );
    canvas.drawCircle(
      Offset(w / 2 + canopyRadius * 0.45, canopyCenterY + canopyRadius * 0.2),
      canopyRadius * 0.7,
      lightPaint,
    );

    final sparkPaint = Paint()..color = sparkColor;
    final sparkCount = levelIndex * 2;
    for (var i = 0; i < sparkCount && i < _sparkOffsets.length; i++) {
      final offset = _sparkOffsets[i];
      canvas.drawCircle(
        Offset(w / 2 + offset.dx * canopyRadius * 2, canopyCenterY + offset.dy * canopyRadius * 2),
        3.2,
        sparkPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GhafTreePainter oldDelegate) => oldDelegate.levelIndex != levelIndex;
}
