import 'package:clickless_graph/face/model/face_side.dart';
import 'package:flutter/foundation.dart';

@immutable
final class FaceMarker<T> {
  const FaceMarker({
    required this.side,
    required this.position,
    required this.value,
  });

  final FaceSide side;
  /// 0 ≤ x ≤ 1, 0 ≤ y ≤ 1
  final ({double x, double y}) position;
  final T value;
}
