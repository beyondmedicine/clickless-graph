import 'package:clickless_graph/polygon/model/polygon_graph_axis.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_indicator_line.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_point_group.dart';
import 'package:flutter/material.dart';

@immutable
final class PolygonGraphData {
  const PolygonGraphData({
    required this.min,
    required this.max,
    required this.axes,
    required this.pointGroups,
    this.markingLines = const [],
  });

  final num min;
  final num max;
  final List<PolygonGraphAxis> axes;
  final List<PolygonGraphPointGroup> pointGroups;
  final List<PolygonGraphMarkingLine> markingLines;
}
