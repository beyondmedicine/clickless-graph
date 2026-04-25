import 'package:flutter/foundation.dart';

@immutable
final class GraphAxisMarking {
  const GraphAxisMarking({
    required this.value,
    this.label,
    this.showLine = false,
  });

  final num value;
  final String? label;
  final bool showLine;
}
