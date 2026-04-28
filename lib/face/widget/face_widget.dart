import 'dart:math';

import 'package:clickless_graph/face/model/face_side.dart';
import 'package:clickless_graph/face/model/face_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final class FaceWidget<T> extends StatelessWidget {
  const FaceWidget({
    required this.side,
    required this.markers,
    required this.markerBuilder,
    super.key,
  });

  final FaceSide side;
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
              child: SvgPicture.asset(
                'assets/image/face_left.svg',
                package: 'clickless_graph',
                width: size,
                height: size,
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
