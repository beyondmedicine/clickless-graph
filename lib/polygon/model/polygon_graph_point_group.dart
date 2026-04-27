import 'package:flutter/material.dart';

@immutable
final class PolygonGraphPointGroup {
  const PolygonGraphPointGroup({
    required this.values,
    required this.pointColor,
    this.fillColor = Colors.transparent,
    this.zIndex = 0,
    this.legend,
  });

  final List<num?> values;
  final Color pointColor;
  final Color fillColor;
  final int zIndex;
  final String? legend;
}
