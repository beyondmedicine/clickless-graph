import 'package:clickless_graph/polygon/model/polygon_graph_data.dart';
import 'package:clickless_graph/polygon/theme/polygon_graph_theme.dart';
import 'package:clickless_graph/polygon/widget/polygon_graph_painter.dart';
import 'package:flutter/material.dart';

final class PolygonGraph extends StatelessWidget {
  const PolygonGraph({
    super.key,
    required this.data,
    this.theme = const PolygonGraphTheme(),
  });

  final PolygonGraphData data;
  final PolygonGraphTheme theme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textDirection =
            Directionality.maybeOf(context) ?? TextDirection.ltr;

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: RepaintBoundary(
            child: CustomPaint(
              painter: PolygonGraphPainter(
                data: data,
                theme: theme,
                textDirection: textDirection,
              ),
            ),
          ),
        );
      },
    );
  }
}
