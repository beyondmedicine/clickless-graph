import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_legend_position.dart';
import 'package:clickless_graph/plot/model/plot_graph_tap_down_info.dart';
import 'package:clickless_graph/plot/util/graph_data_extension.dart';
import 'package:clickless_graph/plot/util/plot_graph_layout.dart';
import 'package:clickless_graph/plot/widget/plot_graph_painter.dart';
import 'package:clickless_graph/plot/theme/plot_graph_theme.dart';
import 'package:clickless_graph/plot/widget/plot_graph_point_painter.dart';
import 'package:flutter/material.dart';

final class PlotGraph extends StatelessWidget {
  const PlotGraph({
    super.key,
    required this.data,
    this.theme = const PlotGraphTheme(),
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  });

  final PlotGraphData data;
  final PlotGraphTheme theme;

  final void Function(TapDownDetails details, PlotGraphTapDownInfo info)?
  onTapDown;

  final void Function(TapUpDetails details)? onTapUp;
  final VoidCallback? onTapCancel;

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
                    child: _PlotGraphLegendView(
                      data: data,
                      theme: theme,
                      alignment: WrapAlignment.end,
                    ),
                  )
                else
                  SizedBox.shrink(),
              ],
            ),
          ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final textDirection =
                  Directionality.maybeOf(context) ?? TextDirection.ltr;
              final size = Size(constraints.maxWidth, constraints.maxHeight);
              final layout = PlotGraphLayout(
                size: size,
                data: data,
                theme: theme,
                textDirection: textDirection,
              );

              return SizedBox(
                width: size.width,
                height: size.height,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    RepaintBoundary(
                      child: CustomPaint(
                        painter: PlotGraphPainter(
                          data: data,
                          theme: theme,
                          textDirection: textDirection,
                        ),
                      ),
                    ),
                    if (onTapDown != null ||
                        onTapUp != null ||
                        onTapCancel != null)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTapDown: onTapDown == null
                            ? null
                            : (details) => onTapDown?.call(
                                details,
                                layout.getTapDownInfo(details.localPosition),
                              ),
                        onTapUp: onTapUp,
                        onTapCancel: onTapCancel,
                        child: const SizedBox.expand(),
                      ),
                  ],
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
                  child: _PlotGraphLegendView(
                    data: data,
                    theme: theme,
                    alignment: WrapAlignment.center,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

final class _PlotGraphLegendView extends StatelessWidget {
  const _PlotGraphLegendView({
    required this.data,
    required this.theme,
    required this.alignment,
  });

  final PlotGraphData data;
  final PlotGraphTheme theme;
  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
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
                          painter: PlotGraphPointPainter(
                            pointGroup: group,
                            theme: theme,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(legend, style: theme.legendTextStyle),
                      ),
                    ],
                  );
          })
          .whereType<Widget>()
          .toList(),
    );
  }
}
