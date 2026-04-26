import 'package:flutter/foundation.dart';

@immutable
final class PlotGraphAxisMarking {
  const PlotGraphAxisMarking({
    required this.value,
    this.label,
    this.showLine = false,
  });

  final num value;
  final String? label;
  final bool showLine;
}
