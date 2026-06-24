import 'package:clickless_graph/plot/model/plot_graph_point_shape.dart';
import 'package:flutter/material.dart';

extension CanvasPaintExtension on Canvas {
  void drawPoint({
    required Offset center,
    required double size,
    required Color color,
    required PlotGraphPointShape shape,
  }) {
    final paint = Paint()..color = color;

    switch (shape) {
      case PlotGraphPointShape.circle:
        drawCircle(center, size / 2, paint);

      case PlotGraphPointShape.triangle:
        final path = Path()
          ..moveTo(center.dx, center.dy - size / 2)
          ..lineTo(center.dx - size / 2, center.dy + size / 2)
          ..lineTo(center.dx + size / 2, center.dy + size / 2)
          ..close();

        drawPath(path, paint);

      case PlotGraphPointShape.square:
        drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: center, width: size, height: size),
            Radius.circular(size * 0.2),
          ),
          paint,
        );
    }
  }
}
