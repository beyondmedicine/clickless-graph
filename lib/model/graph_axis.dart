import 'package:clickless_graph/model/graph_axis_marking.dart';
import 'package:clickless_graph/model/graph_indicator_line.dart';
import 'package:clickless_graph/model/graph_point_group.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class GraphAxis {
  const GraphAxis({
    required this.min,
    required this.max,
    required this.showBorderLine,
    this.markers = const [],
    this.indicatorLines = const [],
  });

  final num min;
  final num max;
  final List<GraphAxisMarking> markers;
  final List<GraphIndicatorLine> indicatorLines;
  final bool showBorderLine;
}

@immutable
final class HorizontalGraphAxis extends GraphAxis {
  const HorizontalGraphAxis({
    required super.min,
    required super.max,
    super.markers,
    super.indicatorLines,
    super.showBorderLine = true,
  });
}

@immutable
final class VerticalGraphAxis extends GraphAxis {
  const VerticalGraphAxis({
    required super.min,
    required super.max,
    required this.groups,
    super.markers,
    super.indicatorLines,
    super.showBorderLine = false,
    this.label,
  });

  final String? label;
  final List<GraphPointGroup> groups;
}
