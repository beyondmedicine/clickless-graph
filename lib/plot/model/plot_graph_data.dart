import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:flutter/material.dart';

@immutable
sealed class PlotGraphData {
  const PlotGraphData({required this.xAxis});

  final HorizontalPlotGraphAxis xAxis;
}

@immutable
final class SingleVerticalAxisPlotGraphData extends PlotGraphData {
  const SingleVerticalAxisPlotGraphData({
    required super.xAxis,
    required this.yAxis,
  });

  final VerticalPlotGraphAxis yAxis;
}

@immutable
final class MultiVerticalAxisPlotGraphData extends PlotGraphData {
  const MultiVerticalAxisPlotGraphData({
    required super.xAxis,
    required this.y1Axis,
    required this.y2Axis,
  });

  final VerticalPlotGraphAxis y1Axis;
  final VerticalPlotGraphAxis y2Axis;
}
