import 'package:flutter/material.dart';

@immutable
final class PolygonGraphMarkingLine {
  const PolygonGraphMarkingLine({
    required this.value,
    this.showLine = true,
    this.label,
  });

  final num value;
  final bool showLine;
  final String? label;
}
