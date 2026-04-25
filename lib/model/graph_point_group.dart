import 'package:clickless_graph/model/graph_line_type.dart';
import 'package:clickless_graph/model/graph_point.dart';
import 'package:clickless_graph/model/graph_point_shape.dart';
import 'package:clickless_graph/model/graph_trend_line.dart';
import 'package:clickless_graph/model/graph_type.dart';
import 'package:flutter/foundation.dart';

@immutable
final class GraphPointGroup {
  const GraphPointGroup({
    required this.points,
    this.trendLine,
    this.legend,
    this.type = GraphType.line,
    this.lineType = GraphLineType.solid,
    this.pointShape = GraphPointShape.circle,
    this.zIndex = 0,
  });

  final List<GraphPoint> points;
  final GraphTrendLine? trendLine;
  final String? legend;
  final GraphType type;
  final GraphLineType lineType;
  final GraphPointShape pointShape;
  final int zIndex;
}
