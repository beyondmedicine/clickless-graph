import 'dart:math';

import 'package:clickless_graph/common/util/get_max_text_size.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis_marking.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:clickless_graph/plot/model/plot_graph_tap_down_info.dart';
import 'package:clickless_graph/plot/model/plot_graph_tap_down_nearest_point_info.dart';
import 'package:clickless_graph/plot/model/plot_graph_type.dart';
import 'package:clickless_graph/plot/theme/plot_graph_theme.dart';
import 'package:clickless_graph/plot/util/graph_axis_extension.dart';
import 'package:clickless_graph/plot/util/graph_data_extension.dart';
import 'package:flutter/material.dart';

final class PlotGraphLayout {
  PlotGraphLayout({
    required this.size,
    required this.data,
    required this.theme,
    required this.textDirection,
  });

  final Size size;
  final PlotGraphData data;
  final PlotGraphTheme theme;
  final TextDirection textDirection;

  late final Rect plotArea = _getPlotArea();

  late final List<PlotGraphPointGroup> sortedGroupsByZIndex = [...data.groups]
    ..sort((a, b) => a.zIndex - b.zIndex);

  late final List<PlotGraphPointGroup> barGroups = sortedGroupsByZIndex
      .where((group) => group.type == PlotGraphType.bar)
      .toList();

  double mapX(num value) {
    final plot = plotArea;

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

  double mapY(num value, PlotGraphAxis axis) {
    final plot = plotArea;
    final min = axis.min.toDouble();
    final max = axis.max.toDouble();

    if (max == min) {
      return plot.center.dy;
    }

    final normalized = ((value.toDouble() - min) / (max - min)).clamp(0.0, 1.0);

    return plot.bottom - plot.height * normalized;
  }

  double get slotWidth => data.xAxis.markers.isNotEmpty
      ? plotArea.width / data.xAxis.markers.length
      : plotArea.width;

  double getBarGroupOffset(PlotGraphPointGroup group) {
    final barGroupIndex = barGroups.indexOf(group);

    if (barGroupIndex < 0) {
      return 0;
    }

    return -2 * (barGroups.length - 1 - barGroupIndex * 2);
  }

  Offset? getPointOffset(PlotGraphPoint point, PlotGraphPointGroup group) {
    final axis = data.getAxisFromBinding(group.axisBinding);

    if (axis == null) {
      return null;
    }

    final y = point.y;
    final x =
        mapX(point.x) +
        (group.type == PlotGraphType.bar ? getBarGroupOffset(group) : 0);

    return switch (group.type) {
      PlotGraphType.bar => Offset(
        x,
        y != null ? mapY(y, axis) : mapY(axis.min, axis) - 6,
      ),
      PlotGraphType.line => y != null ? Offset(x, mapY(y, axis)) : null,
    };
  }

  PlotGraphTapDownInfo getTapDownInfo(Offset offset) {
    final nearestXAxisMarking = getNearestXAxisMarking(offset);
    final nearestLeftYAxisMarking = getNearestYAxisMarking(
      data.leftYAxis,
      offset,
    );

    final rightYAxis = data.rightYAxis;
    final nearestRightYAxisMarking = rightYAxis == null
        ? null
        : getNearestYAxisMarking(rightYAxis, offset);

    return PlotGraphTapDownInfo(
      offset: offset,
      nearestXAxisMarking: nearestXAxisMarking,
      nearestXAxisMarkingXOffset: nearestXAxisMarking == null
          ? null
          : mapX(nearestXAxisMarking.value),
      nearestLeftYAxisMarking: nearestLeftYAxisMarking,
      nearestLeftYAxisMarkingYOffset: nearestLeftYAxisMarking == null
          ? null
          : mapY(nearestLeftYAxisMarking.value, data.leftYAxis),
      nearestRightYAxisMarking: nearestRightYAxisMarking,
      nearestRightYAxisMarkingYOffset:
          rightYAxis != null && nearestRightYAxisMarking != null
          ? mapY(nearestRightYAxisMarking.value, rightYAxis)
          : null,
      nearestPoints: getNearestPoints(offset),
    );
  }

  PlotGraphAxisMarking? getNearestXAxisMarking(Offset offset) {
    return _getNearestMarking(
      data.xAxis.markers,
      (marking) => (mapX(marking.value) - offset.dx).abs(),
    );
  }

  PlotGraphAxisMarking? getNearestYAxisMarking(
    PlotGraphAxis axis,
    Offset offset,
  ) {
    return _getNearestMarking(
      axis.markers,
      (marking) => (mapY(marking.value, axis) - offset.dy).abs(),
    );
  }

  List<PlotGraphTapDownNearestPointInfo> getNearestPoints(Offset offset) {
    final candidates = <_NearestPointCandidate>[];

    for (final group in sortedGroupsByZIndex) {
      _NearestPointCandidate? nearestInGroup;

      for (final point in group.points) {
        final pointOffset = getPointOffset(point, group);

        if (pointOffset == null) {
          continue;
        }

        final candidate = _NearestPointCandidate(
          info: PlotGraphTapDownNearestPointInfo(
            offset: pointOffset,
            point: point,
            group: group,
          ),
          xDistance: (pointOffset.dx - offset.dx).abs(),
        );

        if (nearestInGroup == null ||
            candidate.xDistance < nearestInGroup.xDistance) {
          nearestInGroup = candidate;
        }
      }

      if (nearestInGroup != null) {
        candidates.add(nearestInGroup.copyWith(groupOrder: candidates.length));
      }
    }

    candidates.sort((a, b) {
      final xDistanceCompare = a.xDistance.compareTo(b.xDistance);

      return xDistanceCompare == 0
          ? a.groupOrder.compareTo(b.groupOrder)
          : xDistanceCompare;
    });

    return candidates
        .map((candidate) => candidate.info)
        .toList(growable: false);
  }

  Rect _getPlotArea() {
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
      getMaxTextSize(
            data.allIndicatorLines
                .map((indicatorLine) => indicatorLine.label)
                .whereType<String>(),
            theme.indicatorLineLabelTextStyle,
          ).height /
          2,
      leftYAxis.hasMarkingLabel
          ? getMaxTextSize(
                  leftYAxis.markers
                      .map((marker) => marker.label)
                      .whereType<String>(),
                  theme.axisMarkingLabelTextStyle,
                ).height /
                2
          : 0,
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
      data.hasVerticalAxisLabel
          ? getMaxTextSize(
                  data.yAxes.map((axis) => axis.label).whereType<String>(),
                  theme.verticalAxisLabelTextStyle,
                ).height +
                theme.verticalAxisLabelAndTopOfGraphGap
          : 0,
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
      (data.hasHorizontalAxisMarkingLabel
              ? getMaxTextSize(
                      data.xAxis.markers
                          .map((marker) => marker.label)
                          .whereType<String>(),
                      theme.axisMarkingLabelTextStyle,
                    ).height +
                    theme.axisMarkingLabelAndHorizontalAxisGap
              : 0) +
          spaceDerivedFromVerticalAxisLabels,
    ].fold(0.0, (acc, value) => max(acc, value));

    return Rect.fromLTRB(
      leftSpace,
      topSpace,
      size.width - rightSpace,
      size.height - bottomSpace,
    );
  }

  PlotGraphAxisMarking? _getNearestMarking(
    Iterable<PlotGraphAxisMarking> markings,
    double Function(PlotGraphAxisMarking marking) getDistance,
  ) {
    PlotGraphAxisMarking? nearest;
    double? nearestDistance;

    for (final marking in markings) {
      final distance = getDistance(marking);

      if (nearestDistance == null || distance < nearestDistance) {
        nearest = marking;
        nearestDistance = distance;
      }
    }

    return nearest;
  }
}

final class _NearestPointCandidate {
  const _NearestPointCandidate({
    required this.info,
    required this.xDistance,
    this.groupOrder = 0,
  });

  final PlotGraphTapDownNearestPointInfo info;
  final double xDistance;
  final int groupOrder;

  _NearestPointCandidate copyWith({int? groupOrder}) {
    return _NearestPointCandidate(
      info: info,
      xDistance: xDistance,
      groupOrder: groupOrder ?? this.groupOrder,
    );
  }
}
