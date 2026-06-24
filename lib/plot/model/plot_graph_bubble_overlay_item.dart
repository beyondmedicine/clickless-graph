import 'package:clickless_graph/plot/model/plot_graph_point_shape.dart';
import 'package:flutter/material.dart';

@immutable
final class PlotGraphBubbleOverlayItem {
  const PlotGraphBubbleOverlayItem({required this.markerShape, required this.markerColor, required this.legend, required this.data});

  final PlotGraphPointShape? markerShape;
  final Color? markerColor;
  final String? legend;
  final String data;
}
