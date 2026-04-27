import 'package:flutter/widgets.dart';

@immutable
final class PolygonGraphAxis {
  const PolygonGraphAxis({required this.label, this.clickOverlayBuilder});

  final String label;
  final WidgetBuilder? clickOverlayBuilder;
}
