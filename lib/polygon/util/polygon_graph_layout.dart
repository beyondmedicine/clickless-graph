import 'dart:math';

import 'package:clickless_graph/common/util/get_text_size.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_axis.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_data.dart';
import 'package:clickless_graph/polygon/theme/polygon_graph_theme.dart';
import 'package:flutter/material.dart';

final class PolygonGraphLayout {
  PolygonGraphLayout({
    required this.size,
    required this.data,
    required this.theme,
    required this.textDirection,
  });

  final Size size;
  final PolygonGraphData data;
  final PolygonGraphTheme theme;
  final TextDirection textDirection;

  late final Offset center = Offset(size.width / 2, size.height / 2);

  late final double radius = max(
    0,
    min(
      size.width / 2 -
          maxAxisLabelSize.width / 2 +
          theme.verticeAndAxisLabelCenterGap,
      size.height / 2 -
          maxAxisLabelSize.height / 2 +
          theme.verticeAndAxisLabelCenterGap,
    ),
  );

  late final Size maxAxisLabelSize = data.axes.fold(Size.zero, (acc, axis) {
    final size = _getAxisLabelSize(axis);

    return Size(max(acc.width, size.width), max(acc.height, size.height));
  });

  Rect getAxisLabelRect(int axisIndex) {
    final axis = data.axes[axisIndex];
    final textSize = _getAxisLabelSize(axis);
    final textCenter = getOffset(
      axisIndex: axisIndex,
      radius: radius + theme.verticeAndAxisLabelCenterGap,
    );

    return Rect.fromCenter(
      center: textCenter,
      width: textSize.width,
      height: textSize.height,
    );
  }

  Rect getAxisLabelTouchRect(
    int axisIndex, {
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    final rect = getAxisLabelRect(axisIndex);

    return Rect.fromLTRB(
      rect.left - padding.left,
      rect.top - padding.top,
      rect.right + padding.right,
      rect.bottom + padding.bottom,
    );
  }

  Offset getOffset({required int axisIndex, required double radius}) {
    final index = axisIndex % data.axes.length;
    final n = data.axes.length;
    final theta = -(n.isEven ? pi / 2 - pi / n : pi / 2) + pi * 2 * index / n;

    return Offset(
      center.dx + radius * cos(theta),
      center.dy + radius * sin(theta),
    );
  }

  Size _getAxisLabelSize(PolygonGraphAxis axis) {
    return getTextSize(
      axis.label,
      theme.axisLabelTextStyle,
      textDirection: textDirection,
    );
  }
}
