import 'package:clickless_graph/plot/model/plot_graph_line_type.dart';
import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_shape.dart';
import 'package:clickless_graph/plot/model/plot_graph_trend_line.dart';
import 'package:clickless_graph/plot/model/plot_graph_type.dart';
import 'package:flutter/foundation.dart';

@immutable
final class PlotGraphPointGroup {
  const PlotGraphPointGroup({
    required this.points,
    this.trendLine,
    this.legend,
    this.type = PlotGraphType.line,
    this.lineType = PlotGraphLineType.solid,
    this.pointShape = PlotGraphPointShape.circle,
    this.zIndex = 0,
  });

  final List<PlotGraphPoint> points;
  final PlotGraphTrendLine? trendLine;
  final String? legend;
  final PlotGraphType type;
  final PlotGraphLineType lineType;
  final PlotGraphPointShape pointShape;
  final int zIndex;
}
