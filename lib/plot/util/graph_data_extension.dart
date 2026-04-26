import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:clickless_graph/plot/util/graph_axis_extension.dart';

extension GraphDataExtension on PlotGraphData {
  VerticalPlotGraphAxis get leftAxis => switch (this) {
    final SingleVerticalAxisPlotGraphData singleVerticalAxisGraphData =>
      singleVerticalAxisGraphData.yAxis,
    final MultiVerticalAxisPlotGraphData multiVerticalAxisGraphData =>
      multiVerticalAxisGraphData.y1Axis,
  };

  VerticalPlotGraphAxis? get rightAxis => switch (this) {
    final SingleVerticalAxisPlotGraphData _ => null,
    final MultiVerticalAxisPlotGraphData multiVerticalAxisGraphData =>
      multiVerticalAxisGraphData.y2Axis,
  };

  List<VerticalPlotGraphAxis> get yAxes =>
      [leftAxis, rightAxis].whereType<VerticalPlotGraphAxis>().toList();

  List<PlotGraphPointGroup> get allPointGroups =>
      yAxes.expand((axis) => axis.groups).toList();

  List<PlotGraphPoint> get allPoints => yAxes
      .expand((axis) => axis.groups)
      .expand((group) => group.points)
      .toList();

  bool get hasLegend => allPointGroups.any((group) => group.legend != null);

  bool get hasVerticalAxisLabel => yAxes.any((axis) => axis.label != null);

  bool get hasHorizontalAxisMarkingLabel => xAxis.hasMarkingLabel;

  bool get hasPointLabel => allPoints.any((point) => point.label != null);
}
