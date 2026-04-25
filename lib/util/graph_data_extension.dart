import 'package:clickless_graph/model/graph_axis.dart';
import 'package:clickless_graph/model/graph_data.dart';
import 'package:clickless_graph/model/graph_point.dart';
import 'package:clickless_graph/model/graph_point_group.dart';
import 'package:clickless_graph/util/graph_axis_extension.dart';

extension GraphDataExtension on GraphData {
  VerticalGraphAxis get leftAxis => switch (this) {
    final SingleVerticalAxisGraphData singleVerticalAxisGraphData =>
      singleVerticalAxisGraphData.yAxis,
    final MultiVerticalAxisGraphData multiVerticalAxisGraphData =>
      multiVerticalAxisGraphData.y1Axis,
  };

  VerticalGraphAxis? get rightAxis => switch (this) {
    final SingleVerticalAxisGraphData _ => null,
    final MultiVerticalAxisGraphData multiVerticalAxisGraphData =>
      multiVerticalAxisGraphData.y2Axis,
  };

  List<VerticalGraphAxis> get yAxes =>
      [leftAxis, rightAxis].whereType<VerticalGraphAxis>().toList();

  List<GraphPointGroup> get allPointGroups =>
      yAxes.expand((axis) => axis.groups).toList();

  List<GraphPoint> get allPoints => yAxes
      .expand((axis) => axis.groups)
      .expand((group) => group.points)
      .toList();

  bool get hasLegend => allPointGroups.any((group) => group.legend != null);

  bool get hasVerticalAxisLabel => yAxes.any((axis) => axis.label != null);

  bool get hasHorizontalAxisMarkingLabel => xAxis.hasMarkingLabel;

  bool get hasPointLabel => allPoints.any((point) => point.label != null);
}
