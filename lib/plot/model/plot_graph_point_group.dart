import 'package:clickless_graph/plot/model/plot_graph_axis_binding.dart';
import 'package:clickless_graph/plot/model/plot_graph_indicator_line.dart';
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
    this.trendLines = const [],
    this.indicatorLines = const [],
    this.axisBinding = PlotGraphAxisBinding.left,
    this.legend,
    this.type = PlotGraphType.line,
    this.lineType = PlotGraphLineType.solid,
    this.pointShape = PlotGraphPointShape.circle,
    this.zIndex = 0,
  });

  final List<PlotGraphPoint> points;
  final List<PlotGraphTrendLine> trendLines;
  final List<PlotGraphIndicatorLine> indicatorLines;
  final PlotGraphAxisBinding axisBinding;
  final String? legend;
  final PlotGraphType type;
  final PlotGraphLineType lineType;
  final PlotGraphPointShape pointShape;
  final int zIndex;
}
