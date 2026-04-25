import 'dart:math';

import 'package:flutter/material.dart';

extension CanvasExtension on Canvas {
  void drawDashedLine(
    Offset start,
    Offset end, {
    required Color color,
    required double strokeWidth,
    required double dashWidth,
    required double gapWidth,
  }) {
    final delta = end - start;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final distance = delta.distance;

    if (distance == 0) {
      return;
    }

    final direction = delta / distance;

    var current = 0.0;

    while (current < distance) {
      final next = min(current + dashWidth, distance);

      drawLine(start + direction * current, start + direction * next, paint);

      current = next + gapWidth;
    }
  }
}
