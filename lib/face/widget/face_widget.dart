import 'dart:math';

import 'package:clickless_graph/face/model/face_side.dart';
import 'package:clickless_graph/face/model/face_marker.dart';
import 'package:clickless_graph/face/widget/face_painter.dart';
import 'package:flutter/material.dart';

final class FaceWidget<T> extends StatelessWidget {
  const FaceWidget({
    required this.side,
    required this.markers,
    required this.markerBuilder,
    this.color = const Color(0xFF232C35),
    this.strokeWidth = 1.5,
    super.key,
  });

  final FaceSide side;
  final Color color;
  final double strokeWidth;
  final List<FaceMarker<T>> markers;
  final Widget Function(BuildContext context, FaceMarker<T> marker)
  markerBuilder;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight);

        return Stack(
          fit: StackFit.expand,
          children: [
            Transform.flip(
              flipX: side == FaceSide.right,
              child: CustomPaint(
                size: Size(size, size),
                painter: FacePainter(color: color, strokeWidth: strokeWidth),
              ),
            ),
            ...markers
                .where((marker) => marker.side == side)
                .map(
                  (marker) => Align(
                    alignment: Alignment(
                      -1 + marker.position.x * 2,
                      -1 + marker.position.y * 2,
                    ),
                    child: markerBuilder(context, marker),
                  ),
                ),
          ],
        );
      },
    ),
  );
}
