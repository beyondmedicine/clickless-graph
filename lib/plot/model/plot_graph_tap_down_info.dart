import 'dart:ui';

import 'package:clickless_graph/plot/model/plot_graph_axis_marking.dart';
import 'package:clickless_graph/plot/model/plot_graph_tap_down_nearest_point_info.dart';
import 'package:flutter/foundation.dart';

@immutable
final class PlotGraphTapDownInfo {
  const PlotGraphTapDownInfo({
    required this.offset,
    required this.nearestXAxisMarking,
    required this.nearestXAxisMarkingXOffset,
    required this.nearestLeftYAxisMarking,
    required this.nearestLeftYAxisMarkingYOffset,
    required this.nearestRightYAxisMarking,
    required this.nearestRightYAxisMarkingYOffset,
    required this.nearestPoints,
  });

  final Offset offset;
  final PlotGraphAxisMarking? nearestXAxisMarking;
  final double? nearestXAxisMarkingXOffset;
  final PlotGraphAxisMarking? nearestLeftYAxisMarking;
  final double? nearestLeftYAxisMarkingYOffset;
  final PlotGraphAxisMarking? nearestRightYAxisMarking;
  final double? nearestRightYAxisMarkingYOffset;
  final List<PlotGraphTapDownNearestPointInfo> nearestPoints;
}
