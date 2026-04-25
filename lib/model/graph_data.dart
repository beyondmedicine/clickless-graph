import 'package:clickless_graph/model/graph_axis.dart';
import 'package:flutter/material.dart';

@immutable
sealed class GraphData {
  const GraphData({required this.xAxis});

  final HorizontalGraphAxis xAxis;
}

@immutable
final class SingleVerticalAxisGraphData extends GraphData {
  const SingleVerticalAxisGraphData({
    required super.xAxis,
    required this.yAxis,
  });

  final VerticalGraphAxis yAxis;
}

@immutable
final class MultiVerticalAxisGraphData extends GraphData {
  const MultiVerticalAxisGraphData({
    required super.xAxis,
    required this.y1Axis,
    required this.y2Axis,
  });

  final VerticalGraphAxis y1Axis;
  final VerticalGraphAxis y2Axis;
}
