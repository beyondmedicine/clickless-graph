import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis_binding.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_indicator_line.dart';
import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:clickless_graph/plot/util/graph_axis_extension.dart';

extension GraphDataExtension on PlotGraphData {
  List<PlotGraphAxis> get yAxes =>
      [leftYAxis, rightYAxis].whereType<PlotGraphAxis>().toList();

  List<PlotGraphPoint> get allPoints =>
      groups.expand((group) => group.points).toList();

  List<PlotGraphIndicatorLine> get allIndicatorLines =>
      groups.expand((group) => group.indicatorLines).toList();

  PlotGraphAxis? getAxisFromBinding(PlotGraphAxisBinding binding) =>
      switch (binding) {
        PlotGraphAxisBinding.left => leftYAxis,
        PlotGraphAxisBinding.right => rightYAxis,
      };

  bool get hasLegend => groups.any((group) => group.legend != null);

  bool get hasVerticalAxisLabel => yAxes.any((axis) => axis.label != null);

  bool get hasHorizontalAxisMarkingLabel => xAxis.hasMarkingLabel;

  bool get hasPointLabel => allPoints.any((point) => point.label != null);
}
