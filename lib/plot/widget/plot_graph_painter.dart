import 'package:clickless_graph/common/util/canvas_extension.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_indicator_line.dart';
import 'package:clickless_graph/plot/model/plot_graph_line_type.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:clickless_graph/plot/model/plot_graph_trend_line.dart';
import 'package:clickless_graph/plot/model/plot_graph_type.dart';
import 'package:clickless_graph/plot/util/graph_data_extension.dart';
import 'package:clickless_graph/common/util/get_text_size.dart';
import 'package:clickless_graph/plot/theme/plot_graph_theme.dart';
import 'package:clickless_graph/plot/util/canvas_paint_extension.dart';
import 'package:clickless_graph/plot/util/graph_data_point_extension.dart';
import 'package:clickless_graph/plot/util/plot_graph_layout.dart';
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
    final layout = PlotGraphLayout(
      size: size,
      data: data,
      theme: theme,
      textDirection: textDirection,
    );

    final plotArea = layout.plotArea;

    // 축 라벨 그리기
    _drawAxisLabels(canvas, size);

    // 세로축 눈금 그리기
    _drawYAxisMarkings(canvas, size, layout);

    // 가로축 눈금 그리기
    _drawXAxisMarking(canvas, layout);

    // 추세선 그리기
    for (final group in data.groups) {
      for (final trendLine in group.trendLines) {
        final axis = data.getAxisFromBinding(group.axisBinding);

        if (axis != null) {
          _drawTrendLine(canvas, layout, axis, trendLine);
        }
      }
    }

    // 보조선 그리기
    for (final group in data.groups) {
      for (final indicatorLine in group.indicatorLines) {
        final axis = data.getAxisFromBinding(group.axisBinding);

        if (axis != null) {
          _drawYAxisIndicatorLine(canvas, layout, axis, indicatorLine);
        }
      }
    }

    // 그래프 데이터 그리기
    for (final group in layout.sortedGroupsByZIndex) {
      final axis = data.getAxisFromBinding(group.axisBinding);

      if (axis == null) {
        continue;
      }

      switch (group.type) {
        case PlotGraphType.bar:
          _drawBarPointGroup(
            canvas: canvas,
            layout: layout,
            axis: axis,
            group: group,
          );
        case PlotGraphType.line:
          _drawLinePointGroup(
            canvas: canvas,
            layout: layout,
            axis: axis,
            group: group,
          );
      }
    }

    // 그래프 축 라인 그리기
    _drawAxisLines(canvas, plotArea);
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

  void _drawYAxisMarkings(Canvas canvas, Size size, PlotGraphLayout layout) {
    final plot = layout.plotArea;
    final leftYAxis = data.leftYAxis;
    final rightYAxis = data.rightYAxis;

    final gridPaint = Paint()
      ..color = theme.axisMarkingLineColor
      ..strokeWidth = theme.markingLineWidth;

    for (final marker in leftYAxis.markers) {
      final label = marker.label;
      final y = layout.mapY(marker.value, leftYAxis);

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
        final y = layout.mapY(marker.value, rightYAxis);

        if (marker.showLine) {
          canvas.drawLine(
            Offset(plot.left, y),
            Offset(plot.right, y),
            gridPaint,
          );
        }

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

  void _drawXAxisMarking(Canvas canvas, PlotGraphLayout layout) {
    final plot = layout.plotArea;
    final markingPaint = Paint()
      ..color = theme.axisMarkingLineColor
      ..strokeWidth = 1;

    for (final marker in data.xAxis.markers) {
      final label = marker.label;
      final x = layout.mapX(marker.value);

      if (marker.showLine) {
        canvas.drawLine(
          Offset(x, plot.top),
          Offset(x, plot.bottom),
          markingPaint,
        );
      }

      if (label != null) {
        final width = layout.slotWidth;

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
    PlotGraphLayout layout,
    PlotGraphAxis axis,
    PlotGraphIndicatorLine line,
  ) {
    final plot = layout.plotArea;
    final y = layout.mapY(line.value, axis);

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
    required PlotGraphLayout layout,
    required PlotGraphAxis axis,
    required PlotGraphPointGroup group,
  }) {
    final groupOffset = layout.getBarGroupOffset(group);

    for (final point in group.points) {
      final label = point.pointLabel;
      final value = point.y;

      final x = layout.mapX(point.x) + groupOffset;
      final y = value != null ? layout.mapY(value, axis) : null;
      final baseline = layout.mapY(axis.min, axis);

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
    required PlotGraphLayout layout,
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

      final start = Offset(layout.mapX(points[i].x), layout.mapY(y1, axis));
      final end = Offset(layout.mapX(points[i + 1].x), layout.mapY(y2, axis));

      final color = points[i + 1].color;

      switch (group.lineType) {
        case PlotGraphLineType.dashed:
          canvas.drawDashedLine(
            start,
            end,
            color: color,
            strokeWidth: group.lineWidth,
            dashWidth: group.dashedLineLength,
            gapWidth: group.dashedLineGap,
          );

        case PlotGraphLineType.solid:
          canvas.drawLine(
            start,
            end,
            Paint()
              ..color = color
              ..strokeWidth = group.lineWidth
              ..strokeCap = StrokeCap.round,
          );
      }
    }

    for (final point in points) {
      final label = point.pointLabel;
      final y = point.y;

      if (y == null) {
        continue;
      }

      final center = Offset(layout.mapX(point.x), layout.mapY(y, axis));

      canvas.drawPoint(
        center: center,
        size: theme.pointSize,
        color: point.color,
        shape: group.pointShape,
      );

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
    PlotGraphLayout layout,
    PlotGraphAxis axis,
    PlotGraphTrendLine trendLine,
  ) {
    final startY = trendLine.start.y;
    final endY = trendLine.end.y;

    if (startY == null || endY == null) {
      return;
    }

    canvas.drawDashedLine(
      Offset(layout.mapX(trendLine.start.x), layout.mapY(startY, axis)),
      Offset(layout.mapX(trendLine.end.x), layout.mapY(endY, axis)),
      color: theme.trendLineColor,
      strokeWidth: 1,
      dashWidth: 3,
      gapWidth: 2,
    );
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
}
