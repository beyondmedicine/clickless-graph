import 'package:clickless_graph/plot/model/plot_graph_axis_marking.dart';
import 'package:flutter/foundation.dart';

@immutable
class PlotGraphAxis {
  const PlotGraphAxis({
    required this.min,
    required this.max,
    this.markers = const [],
    this.label,
    this.showLine = false,
  });

  final num min;
  final num max;
  final List<PlotGraphAxisMarking> markers;
  final String? label;
  final bool showLine;
}
