import 'package:flutter/foundation.dart';

@immutable
final class GraphAxisMarking {
  const GraphAxisMarking({
    required this.label,
    required this.value,
    this.showLine = false,
  });

  final String label;
  final num value;
  final bool showLine;
}
