import 'package:clickless_graph/model/graph_axis.dart';

extension GraphAxisExtension on GraphAxis {
  bool get hasMarkingLabel => markers.any((marker) => marker.label != null);
}
