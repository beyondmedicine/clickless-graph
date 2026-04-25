import 'package:flutter/foundation.dart';

@immutable
final class GraphIndicatorLine {
  const GraphIndicatorLine({required this.value, this.label});

  final num value;
  final String? label;
}
