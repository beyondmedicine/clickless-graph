import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:flutter/material.dart';

@immutable
final class PlotGraphData {
  const PlotGraphData({
    required this.xAxis,
    required this.leftYAxis,
    this.rightYAxis,
    required this.groups,
  });

  final PlotGraphAxis xAxis;
  final PlotGraphAxis leftYAxis;
  final PlotGraphAxis? rightYAxis;
  final List<PlotGraphPointGroup> groups;
}
