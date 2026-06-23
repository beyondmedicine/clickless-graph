import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_legend_position.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:clickless_graph/plot/util/canvas_paint_extension.dart';
import 'package:clickless_graph/plot/util/graph_data_extension.dart';
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
    final title = data.title;

    return Column(
      children: [
        if (data.hasTitle ||
            data.hasLegend &&
                data.legendPosition == PlotGraphLegendPosition.topRight)
          Padding(
            padding: EdgeInsets.only(bottom: theme.titleLineAndTopOfGraphGap),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null)
                  Expanded(
                    flex: 2,
                    child: Text(title, style: theme.titleTextStyle),
                  )
                else
                  SizedBox.shrink(),
                if (data.hasLegend &&
                    data.legendPosition == PlotGraphLegendPosition.topRight)
                  Expanded(
                    flex: 1,
                    child: _PlotGraphLegendView(data: data, theme: theme),
                  )
                else
                  SizedBox.shrink(),
              ],
            ),
          ),
        Expanded(
          child: LayoutBuilder(
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
          ),
        ),
        if (data.hasLegend &&
            data.legendPosition == PlotGraphLegendPosition.bottomCenter)
          Padding(
            padding: EdgeInsets.only(top: theme.legendAndBottomOfGraphGap),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _PlotGraphLegendView(data: data, theme: theme),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

final class _PlotGraphLegendView extends StatelessWidget {
  const _PlotGraphLegendView({required this.data, required this.theme});

  final PlotGraphData data;
  final PlotGraphTheme theme;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: theme.legendItemsGap,
      children: data.groups
          .map((group) {
            final legend = group.legend;

            return legend == null
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: theme.legendPointAndLegendLabelGap,
                    children: [
                      SizedBox(
                        width: theme.pointSize,
                        height: theme.pointSize,
                        child: CustomPaint(
                          painter: _PlotGraphLegendViewPointPainter(
                            pointGroup: group,
                            theme: theme,
                          ),
                        ),
                      ),
                      Flexible(child: Text(legend, style: theme.legendTextStyle)),
                    ],
                  );
          })
          .whereType<Widget>()
          .toList(),
    );
  }
}

final class _PlotGraphLegendViewPointPainter extends CustomPainter {
  _PlotGraphLegendViewPointPainter({
    required this.pointGroup,
    required this.theme,
  });

  final PlotGraphPointGroup pointGroup;
  final PlotGraphTheme theme;

  @override
  void paint(Canvas canvas, Size size) {
    final color = _legendColor(pointGroup);
    final size = theme.pointSize;

    canvas.drawPoint(
      center: Offset(size / 2, size / 2),
      size: size,
      color: color,
      shape: pointGroup.pointShape,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is! _PlotGraphLegendViewPointPainter ||
      pointGroup != oldDelegate.pointGroup;

  Color _legendColor(PlotGraphPointGroup group) {
    for (final point in group.points) {
      if (point.y != null) {
        return point.color;
      }
    }

    return group.points.isEmpty
        ? theme.disabledColor
        : group.points.first.color;
  }
}
