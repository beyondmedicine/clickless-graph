import 'package:clickless_graph/plot/model/plot_graph_axis_marking.dart';
import 'package:clickless_graph/plot/model/plot_graph_indicator_line.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class PlotGraphAxis {
  const PlotGraphAxis({
    required this.min,
    required this.max,
    required this.showLine,
    this.markers = const [],
  });

  final num min;
  final num max;
  final List<PlotGraphAxisMarking> markers;
  final bool showLine;
}

@immutable
final class HorizontalPlotGraphAxis extends PlotGraphAxis {
  const HorizontalPlotGraphAxis({
    required super.min,
    required super.max,
    super.markers,
    super.showLine = true,
  });
}

@immutable
final class VerticalPlotGraphAxis extends PlotGraphAxis {
  const VerticalPlotGraphAxis({
    required super.min,
    required super.max,
    required this.groups,
    super.markers,
    super.showLine = false,
    this.label,
    this.indicatorLines = const [],
  });

  final String? label;
  final List<PlotGraphPointGroup> groups;
  final List<PlotGraphIndicatorLine> indicatorLines;
}
