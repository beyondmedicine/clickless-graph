import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/widget/plot_graph_painter.dart';
import 'package:clickless_graph/plot/theme/plot_graph_theme.dart';
import 'package:flutter/material.dart';

final class PlotGraph extends StatelessWidget {
  const PlotGraph({
    super.key,
    required this.data,
    this.theme = const PlotGraphTheme(),
  });

  final PlotGraphData data;
  final PlotGraphTheme theme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: RepaintBoundary(
            child: CustomPaint(
              painter: PlotGraphPainter(
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
