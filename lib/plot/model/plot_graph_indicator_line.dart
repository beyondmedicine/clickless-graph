import 'package:flutter/foundation.dart';

@immutable
final class PlotGraphIndicatorLine {
  const PlotGraphIndicatorLine({required this.value, this.label});

  final num value;
  final String? label;
}
