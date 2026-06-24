import 'package:clickless_graph/plot/model/plot_graph_point_label_type.dart';
import 'package:flutter/foundation.dart';

@immutable
final class PlotGraphPointLabel {
  const PlotGraphPointLabel({required this.text, required this.type});

  final String text;
  final PlotGraphPointLabelType type;
}
