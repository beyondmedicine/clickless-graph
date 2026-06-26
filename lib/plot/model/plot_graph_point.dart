import 'dart:ui';
import 'package:clickless_graph/plot/model/plot_graph_point_label.dart';
import 'package:flutter/foundation.dart';

@immutable
final class PlotGraphPoint {
  const PlotGraphPoint({
    required this.x,
    required this.y,
    required this.color,
    this.labels = const [],
  });

  final num x;
  final num? y;
  final Color color;
  final List<PlotGraphPointLabel> labels;
}
