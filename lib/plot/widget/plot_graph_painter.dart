import 'dart:math';
import 'package:clickless_graph/common/util/canvas_extension.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_indicator_line.dart';
import 'package:clickless_graph/plot/model/plot_graph_line_type.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_shape.dart';
import 'package:clickless_graph/plot/model/plot_graph_trend_line.dart';
import 'package:clickless_graph/plot/model/plot_graph_type.dart';
import 'package:clickless_graph/plot/util/graph_axis_extension.dart';
import 'package:clickless_graph/plot/util/graph_data_extension.dart';
import 'package:clickless_graph/common/util/get_max_text_size.dart';
import 'package:clickless_graph/common/util/get_text_size.dart';
import 'package:clickless_graph/plot/theme/plot_graph_theme.dart';
import 'package:flutter/material.dart';

final class PlotGraphPainter extends CustomPainter {
  const PlotGraphPainter({
    required this.data,
    required this.theme,
    required this.textDirection,
  });

  final PlotGraphData data;
  final PlotGraphTheme theme;
  final TextDirection textDirection;

  @override
  bool shouldRepaint(covariant PlotGraphPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.theme != theme ||
        oldDelegate.textDirection != textDirection;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = theme.backgroundColor);

    // 그래프가 그려질 영역의 크기 산정
    final plotArea = _getPlotArea(size);

    // 축 라벨 그리기
    _drawAxisLabels(canvas, size);

    // 세로축 눈금 그리기
    _drawYAxisMarkings(canvas, size, plotArea);

    // 가로축 눈금 그리기
    _drawXAxisMarking(canvas, plotArea);

    // 추세선 그리기
    for (final group in data.groups) {
      for (final trendLine in group.trendLines) {
        final axis = data.getAxisFromBinding(group.axisBinding);

        if (axis != null) {
          _drawTrendLine(canvas, plotArea, axis, trendLine);
        }
      }
    }

    // 보조선 그리기
    for (final group in data.groups) {
      for (final indicatorLine in group.indicatorLines) {
        final axis = data.getAxisFromBinding(group.axisBinding);

        if (axis != null) {
          _drawYAxisIndicatorLine(canvas, plotArea, axis, indicatorLine);
        }
      }
    }

    final barGroupCount = data.groups
        .where((group) => group.type == PlotGraphType.bar)
        .length;

    var barGroupIndex = 0;

    // 그래프 데이터 그리기
    for (final group in [...data.groups]..sort((a, b) => a.zIndex - b.zIndex)) {
      final axis = data.getAxisFromBinding(group.axisBinding);

      if (axis == null) {
        continue;
      }

      switch (group.type) {
        case PlotGraphType.bar:
          _drawBarPointGroup(
            canvas: canvas,
            plot: plotArea,
            axis: axis,
            group: group,
            barGroupCount: barGroupCount,
            barGroupIndex: barGroupIndex++,
          );
        case PlotGraphType.line:
          _drawLinePointGroup(
            canvas: canvas,
            plot: plotArea,
            axis: axis,
            group: group,
          );
      }
    }

    // 그래프 축 라인 그리기
    _drawAxisLines(canvas, plotArea);

    // 범례 그리기
    if (data.hasLegend) {
      _drawLegend(canvas, plotArea);
    }
  }

  Rect _getPlotArea(Size size) {
    final leftYAxis = data.leftYAxis;
    final rightYAxis = data.rightYAxis;

    final double leftSpace = leftYAxis.hasMarkingLabel
        ? getMaxTextSize(
                leftYAxis.markers
                    .map((marker) => marker.label)
                    .whereType<String>(),
                theme.axisMarkingLabelTextStyle,
              ).width +
              theme.axisMarkingLabelAndVerticalAxisGap
        : 0;

    final double rightSpace = rightYAxis != null && rightYAxis.hasMarkingLabel
        ? getMaxTextSize(
                rightYAxis.markers
                    .map((marker) => marker.label)
                    .whereType<String>(),
                theme.axisMarkingLabelTextStyle,
              ).width +
              theme.axisMarkingLabelAndVerticalAxisGap
        : 0;

    final double spaceDerivedFromVerticalAxisLabels = <double>[
      // 보조 라인 라벨 고려
      getMaxTextSize(
            data.allIndicatorLines
                .map((indicatorLine) => indicatorLine.label)
                .whereType<String>(),
            theme.indicatorLineLabelTextStyle,
          ).height /
          2,
      // 왼쪽 세로 축 눈금 라벨 고려
      leftYAxis.hasMarkingLabel
          ? getMaxTextSize(
                  leftYAxis.markers
                      .map((marker) => marker.label)
                      .whereType<String>(),
                  theme.axisMarkingLabelTextStyle,
                ).height /
                2
          : 0,
      // 오른쪽 세로 축 눈금 라벨 고려
      rightYAxis != null && rightYAxis.hasMarkingLabel
          ? getMaxTextSize(
                  rightYAxis.markers
                      .map((marker) => marker.label)
                      .whereType<String>(),
                  theme.axisMarkingLabelTextStyle,
                ).height /
                2
          : 0,
    ].fold(0.0, (acc, value) => max(acc, value));

    final double topSpace = <double>[
      // 세로축 라벨 고려
      data.hasVerticalAxisLabel
          ? getMaxTextSize(
                  data.yAxes.map((axis) => axis.label).whereType<String>(),
                  theme.verticalAxisLabelTextStyle,
                ).height +
                theme.verticalAxisLabelAndTopOfGraphGap
          : 0,
      // 데이터 포인트 라벨 고려
      data.hasPointLabel
          ? getMaxTextSize(
                  data.allPoints
                      .map((point) => point.label)
                      .whereType<String>(),
                  theme.pointLabelTextStyle,
                ).height +
                theme.pointLabelAndPointGap
          : 0,
      spaceDerivedFromVerticalAxisLabels,
    ].fold(0.0, (acc, value) => max(acc, value));

    final double bottomSpace = <double>[
      (
          // 가로축 눈금 라벨 고려
          data.hasHorizontalAxisMarkingLabel
              ? getMaxTextSize(
                      data.xAxis.markers
                          .map((marker) => marker.label)
                          .whereType<String>(),
                      theme.axisMarkingLabelTextStyle,
                    ).height +
                    theme.axisMarkingLabelAndHorizontalAxisGap
              : 0) +
          (
          // 범례 고려
          data.hasLegend
              ? getMaxTextSize(
                      data.groups
                          .map((group) => group.legend)
                          .whereType<String>(),
                      theme.legendTextStyle,
                    ).height +
                    theme.legendAndBottomOfGraphGap
              : 0),
      spaceDerivedFromVerticalAxisLabels,
    ].fold(0.0, (acc, value) => max(acc, value));

    return Rect.fromLTRB(
      leftSpace,
      topSpace,
      size.width - rightSpace,
      size.height - bottomSpace,
    );
  }

  void _drawAxisLabels(Canvas canvas, Size size) {
    final leftYAxisLabel = data.leftYAxis.label;
    final rightYAxisLabel = data.rightYAxis?.label;

    if (leftYAxisLabel != null) {
      canvas.drawText(
        leftYAxisLabel,
        theme.axisMarkingLabelTextStyle,
        Offset.zero,
      );
    }

    if (rightYAxisLabel != null) {
      canvas.drawText(
        rightYAxisLabel,
        theme.axisMarkingLabelTextStyle,
        Offset(size.width, 0),
        textAlign: TextAlign.right,
      );
    }
  }

  void _drawYAxisMarkings(Canvas canvas, Size size, Rect plot) {
    final leftYAxis = data.leftYAxis;
    final rightYAxis = data.rightYAxis;

    final gridPaint = Paint()
      ..color = theme.axisMarkingLineColor
      ..strokeWidth = theme.markingLineWidth;

    for (final marker in leftYAxis.markers) {
      final label = marker.label;
      final y = _mapY(marker.value, leftYAxis, plot);

      if (marker.showLine) {
        canvas.drawLine(Offset(plot.left, y), Offset(plot.right, y), gridPaint);
      }

      if (label != null) {
        canvas.drawText(
          label,
          theme.axisMarkingLabelTextStyle,
          Offset(
            0,
            y - getTextSize(label, theme.axisMarkingLabelTextStyle).height / 2,
          ),
        );
      }
    }

    if (rightYAxis != null) {
      for (final marker in rightYAxis.markers) {
        final label = marker.label;
        final y = _mapY(marker.value, rightYAxis, plot);

        canvas.drawLine(Offset(plot.left, y), Offset(plot.right, y), gridPaint);

        if (label != null) {
          canvas.drawText(
            label,
            theme.axisMarkingLabelTextStyle,
            Offset(
              size.width,
              y -
                  getTextSize(label, theme.axisMarkingLabelTextStyle).height /
                      2,
            ),
            textAlign: TextAlign.right,
          );
        }
      }
    }
  }

  void _drawXAxisMarking(Canvas canvas, Rect plot) {
    final markingPaint = Paint()
      ..color = theme.axisMarkingLineColor
      ..strokeWidth = 1;

    for (final marker in data.xAxis.markers) {
      final label = marker.label;
      final x = _mapX(marker.value, plot);

      if (marker.showLine) {
        canvas.drawLine(
          Offset(x, plot.top),
          Offset(x, plot.bottom),
          markingPaint,
        );
      }

      if (label != null) {
        final width = _getSlotWidth(plot);

        canvas.drawText(
          label,
          theme.axisMarkingLabelTextStyle,
          Offset(
            x - width / 2,
            plot.bottom + theme.axisMarkingLabelAndHorizontalAxisGap,
          ),
          textAlign: TextAlign.center,
          width: width,
        );
      }
    }
  }

  void _drawYAxisIndicatorLine(
    Canvas canvas,
    Rect plot,
    PlotGraphAxis axis,
    PlotGraphIndicatorLine line,
  ) {
    final y = _mapY(line.value, axis, plot);

    canvas.drawDashedLine(
      Offset(plot.left, y),
      Offset(plot.right, y),
      color: theme.indicatorLineColor,
      strokeWidth: 1,
      dashWidth: 4,
      gapWidth: 2,
    );

    final label = line.label;
    
    if (label != null) {
      canvas.drawText(
        label,
        theme.indicatorLineLabelTextStyle,
        Offset(
          plot.right - 4,
          y - getTextSize(label, theme.axisMarkingLabelTextStyle).height / 2,
        ),
        textAlign: TextAlign.center,
      );
    }
  }

  void _drawBarPointGroup({
    required Canvas canvas,
    required Rect plot,
    required PlotGraphAxis axis,
    required PlotGraphPointGroup group,
    required int barGroupCount,
    required int barGroupIndex,
  }) {
    final groupOffset = -2 * (barGroupCount - 1 - barGroupIndex * 2);

    for (final point in group.points) {
      final label = point.label;
      final value = point.y;

      final x = _mapX(point.x, plot) + groupOffset;
      final y = value != null ? _mapY(value, axis, plot) : null;
      final baseline = _mapY(axis.min, axis, plot);

      final color = value == null ? theme.disabledColor : point.color;

      final rect = RRect.fromRectAndCorners(
        Rect.fromLTWH(
          x - theme.barWidth / 2,
          y ?? baseline - 6,
          theme.barWidth,
          y != null ? baseline - y : 6,
        ),
        topLeft: const Radius.circular(4),
        topRight: const Radius.circular(4),
      );

      canvas.drawRRect(rect, Paint()..color = color);

      if (label != null) {
        final textSize = getTextSize(label, theme.pointLabelTextStyle);

        canvas.drawText(
          label,
          theme.pointLabelTextStyle,
          Offset(
            x - textSize.width / 2,
            (y ?? baseline - 6) - theme.pointLabelAndPointGap - textSize.height,
          ),
          color: color,
          textAlign: TextAlign.center,
        );
      }
    }
  }

  void _drawLinePointGroup({
    required Canvas canvas,
    required Rect plot,
    required PlotGraphAxis axis,
    required PlotGraphPointGroup group,
  }) {
    final points = [...group.points]..sort((a, b) => a.x.compareTo(b.x));

    for (var i = 0; i < points.length - 1; i += 1) {
      final y1 = points[i].y;
      final y2 = points[i + 1].y;

      if (y1 == null || y2 == null) {
        continue;
      }

      final start = Offset(_mapX(points[i].x, plot), _mapY(y1, axis, plot));
      final end = Offset(_mapX(points[i + 1].x, plot), _mapY(y2, axis, plot));

      final color = points[i + 1].color;

      switch (group.lineType) {
        case PlotGraphLineType.dashed:
          canvas.drawDashedLine(
            start,
            end,
            color: color,
            strokeWidth: 1.5,
            dashWidth: 4,
            gapWidth: 2,
          );

        case PlotGraphLineType.solid:
          canvas.drawLine(
            start,
            end,
            Paint()
              ..color = color
              ..strokeWidth = 1.5
              ..strokeCap = StrokeCap.round,
          );
      }
    }

    for (final point in points) {
      final label = point.label;
      final y = point.y;

      if (y == null) {
        continue;
      }

      final center = Offset(_mapX(point.x, plot), _mapY(y, axis, plot));

      _drawPoint(canvas, center, color: point.color, shape: group.pointShape);

      if (label != null) {
        final textSize = getTextSize(label, theme.pointLabelTextStyle);

        canvas.drawText(
          label,
          theme.pointLabelTextStyle,
          Offset(
            center.dx - textSize.width / 2,
            center.dy -
                theme.pointSize / 2 -
                theme.pointLabelAndPointGap -
                textSize.height,
          ),
          color: point.color,
          textAlign: TextAlign.center,
        );
      }
    }
  }

  void _drawTrendLine(
    Canvas canvas,
    Rect plot,
    PlotGraphAxis axis,
    PlotGraphTrendLine trendLine,
  ) {
    final startY = trendLine.start.y;
    final endY = trendLine.end.y;

    if (startY == null || endY == null) {
      return;
    }

    canvas.drawDashedLine(
      Offset(_mapX(trendLine.start.x, plot), _mapY(startY, axis, plot)),
      Offset(_mapX(trendLine.end.x, plot), _mapY(endY, axis, plot)),
      color: theme.trendLineColor,
      strokeWidth: 1,
      dashWidth: 3,
      gapWidth: 2,
    );
  }

  void _drawPoint(
    Canvas canvas,
    Offset center, {
    required Color color,
    required PlotGraphPointShape shape,
  }) {
    final paint = Paint()..color = color;

    switch (shape) {
      case PlotGraphPointShape.circle:
        canvas.drawCircle(center, theme.pointSize / 2, paint);

      case PlotGraphPointShape.triangle:
        final path = Path()
          ..moveTo(center.dx, center.dy - theme.pointSize / 2)
          ..lineTo(
            center.dx - theme.pointSize / 2,
            center.dy + theme.pointSize / 2,
          )
          ..lineTo(
            center.dx + theme.pointSize / 2,
            center.dy + theme.pointSize / 2,
          )
          ..close();

        canvas.drawPath(path, paint);
    }
  }

  void _drawAxisLines(Canvas canvas, Rect plot) {
    final width = theme.axisLineWidth;

    final axisLinePaint = Paint()
      ..color = theme.axisLineColor
      ..strokeWidth = width;

    final leftYAxis = data.leftYAxis;
    final rightYAxis = data.rightYAxis;

    if (data.xAxis.showLine) {
      final axisPaint = Paint()
        ..color = theme.axisLineColor
        ..strokeWidth = theme.axisLineWidth;

      canvas.drawLine(
        plot.bottomLeft + Offset(width / 2, -width / 2),
        plot.bottomRight + Offset(-width / 2, -width / 2),
        axisPaint,
      );
    }

    if (leftYAxis.showLine) {
      canvas.drawLine(
        plot.topLeft + Offset(width / 2, width / 2),
        plot.bottomLeft + Offset(width / 2, -width / 2),
        axisLinePaint,
      );
    }

    if (rightYAxis?.showLine ?? false) {
      canvas.drawLine(
        plot.topRight + Offset(-width / 2, width / 2),
        plot.bottomRight + Offset(-width / 2, -width / 2),
        axisLinePaint,
      );
    }
  }

  void _drawLegend(Canvas canvas, Rect plot) {
    final legendGroups = data.groups
        .where((group) => group.legend != null)
        .toList();

    if (legendGroups.isEmpty) {
      return;
    }

    final itemWidths = <double>[];

    for (final group in legendGroups) {
      final legend = group.legend;

      itemWidths.add(
        theme.pointSize +
            (legend != null
                ? theme.legendPointAndLegendLabelGap +
                      getTextSize(legend, theme.legendTextStyle).width
                : 0),
      );
    }

    final totalWidth =
        itemWidths.fold(0.0, (sum, width) => sum + width) +
        theme.legendItemsGap * max(0, legendGroups.length - 1);

    var x = plot.center.dx - totalWidth / 2;

    final y =
        plot.bottom +
        (data.hasHorizontalAxisMarkingLabel
            ? getMaxTextSize(
                    data.xAxis.markers
                        .map((marker) => marker.label)
                        .whereType<String>(),
                    theme.axisMarkingLabelTextStyle,
                  ).height +
                  theme.axisMarkingLabelAndHorizontalAxisGap
            : 0) +
        theme.legendAndBottomOfGraphGap;

    for (var i = 0; i < legendGroups.length; i += 1) {
      final group = legendGroups[i];
      final color = _legendColor(group);
      final iconCenter = Offset(x + 3, y + 8.5);
      final legend = group.legend;

      if (group.type == PlotGraphType.bar) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: iconCenter, width: 6, height: 6),
            const Radius.circular(1.5),
          ),
          Paint()..color = color,
        );
      } else {
        _drawPoint(canvas, iconCenter, color: color, shape: group.pointShape);
      }

      if (legend != null) {
        canvas.drawText(
          legend,
          theme.legendTextStyle,
          Offset(x + theme.pointSize + theme.legendPointAndLegendLabelGap, y),
        );
      }

      x += itemWidths[i] + theme.legendItemsGap;
    }
  }

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

  double _mapX(num value, Rect plot) {
    if (data.xAxis.markers.isNotEmpty) {
      final sortedMarkers = [...data.xAxis.markers]
        ..sort((a, b) => a.value.compareTo(b.value));
      final step = plot.width / sortedMarkers.length;
      if (sortedMarkers.length == 1) {
        return plot.center.dx;
      }

      for (var i = 0; i < sortedMarkers.length; i += 1) {
        if ((sortedMarkers[i].value.toDouble() - value.toDouble()).abs() <
            0.001) {
          return plot.left + step * (i + 0.5);
        }
      }

      final min = sortedMarkers.first.value.toDouble();
      final max = sortedMarkers.last.value.toDouble();
      if (max == min) {
        return plot.center.dx;
      }
      final normalized = ((value.toDouble() - min) / (max - min)).clamp(
        0.0,
        1.0,
      );
      return plot.left + step / 2 + (plot.width - step) * normalized;
    }

    final min = data.xAxis.min.toDouble();
    final max = data.xAxis.max.toDouble();
    if (max == min) {
      return plot.center.dx;
    }
    final normalized = ((value.toDouble() - min) / (max - min)).clamp(0.0, 1.0);
    return plot.left + plot.width * normalized;
  }

  double _mapY(num value, PlotGraphAxis axis, Rect plot) {
    final min = axis.min.toDouble();
    final max = axis.max.toDouble();

    if (max == min) {
      return plot.center.dy;
    }

    final normalized = ((value.toDouble() - min) / (max - min)).clamp(0.0, 1.0);
    return plot.bottom - plot.height * normalized;
  }

  // TODO: 해당 로직은 x축의 눈금이 등차수열이 아닐 경우를 대비하지 못함
  double _getSlotWidth(Rect plot) => data.xAxis.markers.isNotEmpty
      ? plot.width / data.xAxis.markers.length
      : plot.width;

  static String _formatNumber(num value) {
    final asDouble = value.toDouble();

    return (asDouble - asDouble.roundToDouble()).abs() < 0.001
        ? asDouble.round().toString()
        : asDouble.toStringAsFixed(1);
  }
}
