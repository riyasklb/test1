import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class LineVisualizer extends CustomPainter {
  final List<int> waveData;
  final double height;
  final double width;
  final Color color;
  final double strokeWidth;
  final Paint wavePaint;
  Float32List points;
  Rect rect;

  LineVisualizer({
    required this.waveData,
    required this.height,
    required this.width,
    required this.color,
    this.strokeWidth = 0.005, required int sessionId,
  })  : wavePaint = Paint()
          ..color = color.withOpacity(1.0)
          ..style = PaintingStyle.stroke,
        points = Float32List(waveData.length * 4),
        rect = Rect.fromLTWH(0, 0, width, height);

  @override
  void paint(Canvas canvas, Size size) {
    if (waveData.isNotEmpty) {
      wavePaint.strokeWidth = height * strokeWidth;
      rect = Rect.fromLTWH(0, 0, width, height / 3);
      for (int i = 0; i < waveData.length - 1; i++) {
        points[i * 4] = rect.width * i / (waveData.length - 1);
        points[i * 4 + 1] = rect.height / 2 +
            ((waveData[i] + 128)) * (rect.height / 3) / 128;
        points[i * 4 + 2] = rect.width * (i + 1) / (waveData.length - 1);
        points[i * 4 + 3] = rect.height / 2 +
            ((waveData[i + 1] + 128)) * (rect.height / 3) / 128;
      }
      canvas.drawRawPoints(PointMode.lines, points, wavePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
