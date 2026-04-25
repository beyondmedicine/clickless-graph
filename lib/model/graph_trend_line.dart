import 'package:clickless_graph/model/graph_point.dart';
import 'package:flutter/foundation.dart';

@immutable
final class GraphTrendLine {
  const GraphTrendLine({required this.start, required this.end});

  final GraphPoint start;
  final GraphPoint end;
}
