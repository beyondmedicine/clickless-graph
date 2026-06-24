import 'dart:ui';
import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:flutter/foundation.dart';

@immutable
final class PlotGraphTapDownNearestPointInfo {
  const PlotGraphTapDownNearestPointInfo({
    required this.offset,
    required this.point,
    required this.group,
  });

  final Offset offset;
  final PlotGraphPoint point;
  final PlotGraphPointGroup group;
}
