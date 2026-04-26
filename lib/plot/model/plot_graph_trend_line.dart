import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:flutter/foundation.dart';

@immutable
final class PlotGraphTrendLine {
  const PlotGraphTrendLine({required this.start, required this.end});

  final PlotGraphPoint start;
  final PlotGraphPoint end;
}
