import 'package:clickless_graph/plot/model/plot_graph_axis.dart';

extension GraphAxisExtension on PlotGraphAxis {
  bool get hasMarkingLabel => markers.any((marker) => marker.label != null);
}
