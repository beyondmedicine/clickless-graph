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

  void drawText(
    String text,
    TextStyle style,
    Offset offset, {
    Color? color,
    TextAlign textAlign = TextAlign.left,
    TextDirection textDirection = TextDirection.ltr,
    double? width,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: style.copyWith(color: color ?? style.color),
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: text.contains('\n') ? null : 1,
    )..layout(maxWidth: width ?? double.infinity);

    final paintOffset = switch (textAlign) {
      TextAlign.center => Offset(
        offset.dx + ((width ?? painter.width) - painter.width) / 2,
        offset.dy,
      ),
      TextAlign.right || TextAlign.end => Offset(
        offset.dx + ((width ?? 0) - painter.width),
        offset.dy,
      ),
      _ => offset,
    };

    painter.paint(this, paintOffset);
  }
}
