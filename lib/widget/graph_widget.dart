import 'package:clickless_graph/model/graph_data.dart';
import 'package:clickless_graph/widget/graph_painter.dart';
import 'package:clickless_graph/widget/graph_widget_theme.dart';
import 'package:flutter/material.dart';

final class GraphWidget extends StatelessWidget {
  const GraphWidget({
    super.key,
    required this.data,
    this.theme = const GraphWidgetTheme(),
  });

  final GraphData data;
  final GraphWidgetTheme theme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: RepaintBoundary(
            child: CustomPaint(
              painter: GraphPainter(
                data: data,
                theme: theme,
                textDirection:
                    Directionality.maybeOf(context) ?? TextDirection.ltr,
              ),
            ),
          ),
        );
      },
    );
  }
}
