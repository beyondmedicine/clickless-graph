import 'dart:math';

import 'package:clickless_graph/common/util/canvas_extension.dart';
import 'package:clickless_graph/common/util/get_max_text_size.dart';
import 'package:clickless_graph/common/util/get_text_size.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_axis.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_data.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_indicator_line.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_point_group.dart';
import 'package:clickless_graph/polygon/theme/polygon_graph_theme.dart';
import 'package:flutter/material.dart';

final class PolygonGraphPainter extends CustomPainter {
  PolygonGraphPainter({
    required this.data,
    required this.theme,
    required this.textDirection,
  });

  final PolygonGraphData data;
  final PolygonGraphTheme theme;
  final TextDirection textDirection;

  late final double radius;
  late final Offset center;

  @override
  bool shouldRepaint(covariant PolygonGraphPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.theme != theme ||
        oldDelegate.textDirection != textDirection;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = theme.backgroundColor,
    );

    if (data.axes.length < 3) {
      return;
    }

    // 레이아웃 초깃값 계산
    _initializeLayout(size);

    if (radius < 0.1) {
      return;
    }

    // 축 라인 그리기
    for (final axis in data.axes) {
      _drawAxisLine(canvas, axis);
    }

    // 눈금 라인 그리기
    for (final markingLine in data.markingLines) {
      _drawMarkingLine(canvas, markingLine);
    }

    // 테두리 그리기
    _drawBorder(canvas);

    // 눈금 라인 라벨 그리기
    for (final markingLine in data.markingLines) {
      _drawMarkingLabel(canvas, markingLine);
    }

    // 포인트 그룹 그리기
    for (final group in [
      ...data.pointGroups,
    ]..sort((a, b) => a.zIndex - b.zIndex)) {
      _drawPointGroup(canvas, group);
    }

    // 축 라벨 그리기
    for (final x in data.axes.indexed) {
      _drawAxisLabel(canvas, x.$2, x.$1);
    }
  }

  void _initializeLayout(Size size) {
    final maxAxisLabelSize = getMaxTextSize(
      data.axes.map((axis) => axis.label),
      theme.axisLabelTextStyle,
    );

    center = Offset(size.width / 2, size.height / 2);

    radius = max(
      0,
      // 축 라벨이 그려질 위치 고려
      min(
        size.width / 2 -
            maxAxisLabelSize.width / 2 +
            theme.verticeAndAxisLabelCenterGap,
        size.height / 2 -
            maxAxisLabelSize.height / 2 +
            theme.verticeAndAxisLabelCenterGap,
      ),
    );
  }

  void _drawAxisLine(Canvas canvas, PolygonGraphAxis axis) {
    final paint = Paint()
      ..color = theme.axisLineColor
      ..strokeWidth = theme.axisLineWidth
      ..style = PaintingStyle.stroke;

    final angle = pi - 2 * pi / data.axes.length;

    final axisLength =
        radius - theme.cornerRadius * (1 / cos(angle / 2) - 1 / sin(angle / 2));

    for (var i = 0; i < data.axes.length; i += 1) {
      final offset = _getOffset(axisIndex: i, radius: axisLength);
      canvas.drawLine(center, offset, paint);
    }
  }

  void _drawMarkingLine(Canvas canvas, PolygonGraphMarkingLine line) {
    final paint = Paint()
      ..color = theme.markingLineColor
      ..strokeWidth = theme.markingLineWidth
      ..style = PaintingStyle.stroke;

    for (final markingLine in [
      ...data.markingLines,
    ]..sort((a, b) => a.value.compareTo(b.value))) {
      if (!markingLine.showLine) {
        continue;
      }

      final vertices = data.axes.indexed
          .map(
            (x) => _getOffset(
              axisIndex: x.$1,
              radius: _mapValueToRadius(markingLine.value),
            ),
          )
          .toList();

      canvas.drawPath(
        _getPolygonPath(vertices, cornerRadius: theme.cornerRadius),
        paint,
      );
    }
  }

  void _drawBorder(Canvas canvas) {
    final paint = Paint()
      ..color = theme.borderColor
      ..strokeWidth = theme.borderWidth
      ..style = PaintingStyle.stroke;

    final vertices = data.axes.indexed
        .map((x) => _getOffset(axisIndex: x.$1, radius: radius))
        .toList();

    canvas.drawPath(
      _getPolygonPath(vertices, cornerRadius: theme.cornerRadius),
      paint,
    );
  }

  void _drawMarkingLabel(Canvas canvas, PolygonGraphMarkingLine line) {
    final label = line.label;

    if (label == null) {
      return;
    }

    final textSize = getTextSize(
      label,
      theme.markingLabelTextStyle,
      textDirection: textDirection,
    );

    final position =
        center +
        Offset(
          0,
          radius *
              cos(pi / data.axes.length) *
              line.value /
              (data.max - data.min),
        );

    canvas.drawRect(
      Rect.fromLTRB(
        position.dx - textSize.width / 2 - theme.markingLabelPadding,
        position.dy - textSize.height / 2 - theme.markingLabelPadding,
        position.dx + textSize.width / 2 + theme.markingLabelPadding,
        position.dy + textSize.height / 2 + theme.markingLabelPadding,
      ),
      Paint()
        ..color = theme.backgroundColor
        ..style = PaintingStyle.fill,
    );

    canvas.drawText(
      label,
      theme.markingLabelTextStyle,
      Offset(
        position.dx - textSize.width / 2,
        position.dy - textSize.height / 2,
      ),
      textDirection: textDirection,
    );
  }

  void _drawPointGroup(Canvas canvas, PolygonGraphPointGroup group) {
    final vertices = group.values.indexed.map((x) {
      final value = x.$2;

      return value != null
          ? _getOffset(axisIndex: x.$1, radius: _mapValueToRadius(value))
          : null;
    }).toList();

    // 그래프 내부 색칠
    canvas.drawPath(
      _getPolygonPath(
        vertices
            .map((vertice) => vertice ?? center)
            .whereType<Offset>()
            .toList(),
      ),
      Paint()
        ..color = group.fillColor
        ..style = PaintingStyle.fill,
    );

    // 그래프 외곽선
    canvas.drawPath(
      _getPolygonPath(
        vertices
            .map((vertice) => vertice ?? center)
            .whereType<Offset>()
            .toList(),
      ),
      Paint()
        ..color = group.pointColor
        ..strokeWidth = theme.pointGroupLineWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke,
    );

    final pointPaint = Paint()..color = group.pointColor;

    for (final point in vertices.whereType<Offset>()) {
      canvas.drawCircle(point, theme.pointSize / 2, pointPaint);
    }
  }

  void _drawAxisLabel(Canvas canvas, PolygonGraphAxis axis, int axisIndex) {
    final label = axis.label;

    final textSize = getTextSize(
      label,
      theme.axisLabelTextStyle,
      textDirection: textDirection,
    );

    final textCenter = _getOffset(
      axisIndex: axisIndex,
      radius: radius + theme.verticeAndAxisLabelCenterGap,
    );

    final offset = Offset(
      textCenter.dx - textSize.width / 2,
      textCenter.dy - textSize.height / 2,
    );

    canvas.drawText(
      label,
      theme.axisLabelTextStyle,
      offset,
      textDirection: textDirection,
    );

    canvas.drawLine(
      Offset(offset.dx, offset.dy + textSize.height),
      Offset(offset.dx + textSize.width, offset.dy + textSize.height),
      Paint()
        ..color = theme.axisLabelTextStyle.color ?? Colors.transparent
        ..strokeWidth = 1,
    );
  }

  Path _getPolygonPath(List<Offset> vertices, {double cornerRadius = 0}) {
    final path = Path()..moveTo(vertices.first.dx, vertices.first.dy);

    if (vertices.length < 3 || cornerRadius <= 0) {
      for (final vertex in vertices.skip(1)) {
        path.lineTo(vertex.dx, vertex.dy);
      }

      return path..close();
    }

    final corners = vertices.indexed.map((x) {
      final previous = vertices[(x.$1 + vertices.length - 1) % vertices.length];
      final next = vertices[(x.$1 + 1) % vertices.length];

      final fromPrevious = previous - x.$2;
      final toNext = next - x.$2;

      final previousDistance = fromPrevious.distance;
      final nextDistance = toNext.distance;

      final resolvedRadius = min(
        theme.cornerRadius,
        min(previousDistance, nextDistance) / 2,
      );

      final start = x.$2 + fromPrevious * resolvedRadius / previousDistance;
      final end = x.$2 + toNext * resolvedRadius / nextDistance;

      return (start: start, control: x.$2, end: end);
    }).toList();

    path
      ..reset()
      ..moveTo(corners.first.start.dx, corners.first.start.dy);

    for (final corner in corners) {
      path
        ..lineTo(corner.start.dx, corner.start.dy)
        ..quadraticBezierTo(
          corner.control.dx,
          corner.control.dy,
          corner.end.dx,
          corner.end.dy,
        );
    }

    return path..close();
  }

  Offset _getOffset({required int axisIndex, required double radius}) {
    final index = axisIndex % data.axes.length;
    final n = data.axes.length;
    final theta = -(n.isEven ? pi / 2 - pi / n : pi / 2) + pi * 2 * index / n;

    return Offset(
      center.dx + radius * cos(theta),
      center.dy + radius * sin(theta),
    );
  }

  double _mapValueToRadius(num value) {
    return (value - data.min) / (data.max - data.min) * radius;
  }
}
