import 'package:flutter/widgets.dart';

@immutable
final class PolygonGraphAxis<T> {
  const PolygonGraphAxis({required this.label, required this.info});

  final String label;
  final T info;
}
