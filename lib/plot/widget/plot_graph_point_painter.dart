import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:clickless_graph/plot/theme/plot_graph_theme.dart';
import 'package:clickless_graph/plot/util/canvas_paint_extension.dart';
import 'package:flutter/material.dart';

final class PlotGraphPointPainter extends CustomPainter {
  PlotGraphPointPainter({required this.pointGroup, required this.theme});

  final PlotGraphPointGroup pointGroup;
  final PlotGraphTheme theme;

  @override
  void paint(Canvas canvas, Size size) {
    final color = _legendColor(pointGroup);
    final size = theme.pointSize;

    canvas.drawPoint(
      center: Offset(size / 2, size / 2),
      size: size,
      color: color,
      shape: pointGroup.pointShape,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is! PlotGraphPointPainter ||
      pointGroup != oldDelegate.pointGroup;

  Color _legendColor(PlotGraphPointGroup group) {
    for (final point in group.points) {
      if (point.y != null) {
        return point.color;
      }
    }

    return group.points.isEmpty
        ? theme.disabledColor
        : group.points.first.color;
  }
}
