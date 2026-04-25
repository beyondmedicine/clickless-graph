import 'dart:ui';
import 'package:flutter/foundation.dart';

@immutable
final class GraphPoint {
  const GraphPoint({
    required this.x,
    required this.y,
    required this.color,
    this.label,
  });

  final num x;
  final num? y;
  final Color color;
  final String? label;
}
