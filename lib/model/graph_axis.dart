import 'package:clickless_graph/model/graph_axis_marking.dart';
import 'package:clickless_graph/model/graph_indicator_line.dart';
import 'package:clickless_graph/model/graph_point_group.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class GraphAxis {
  const GraphAxis({
    required this.min,
    required this.max,
    required this.showLine,
    this.markers = const [],
  });

  final num min;
  final num max;
  final List<GraphAxisMarking> markers;
  final bool showLine;
}

@immutable
final class HorizontalGraphAxis extends GraphAxis {
  const HorizontalGraphAxis({
    required super.min,
    required super.max,
    super.markers,
    super.showLine = true,
  });
}

@immutable
final class VerticalGraphAxis extends GraphAxis {
  const VerticalGraphAxis({
    required super.min,
    required super.max,
    required this.groups,
    super.markers,
    super.showLine = false,
    this.label,
    this.indicatorLines = const [],
  });

  final String? label;
  final List<GraphPointGroup> groups;
  final List<GraphIndicatorLine> indicatorLines;
}
