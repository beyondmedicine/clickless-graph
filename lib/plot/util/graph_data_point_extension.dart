import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_label_type.dart';

extension GraphDataPointExtension on PlotGraphPoint {
  String? get pointLabel => _getLabel(PlotGraphPointLabelType.point);
  String? get overlayLabel => _getLabel(PlotGraphPointLabelType.overlay);

  String? _getLabel(PlotGraphPointLabelType type) =>
      labels.where((label) => label.type == type).firstOrNull?.text;
}
