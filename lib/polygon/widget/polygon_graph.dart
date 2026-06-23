import 'package:clickless_graph/polygon/model/polygon_graph_axis.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_data.dart';
import 'package:clickless_graph/polygon/theme/polygon_graph_theme.dart';
import 'package:clickless_graph/polygon/util/polygon_graph_layout.dart';
import 'package:clickless_graph/polygon/widget/polygon_graph_painter.dart';
import 'package:flutter/material.dart';

final class PolygonGraph extends StatelessWidget {
  const PolygonGraph({
    super.key,
    required this.data,
    this.theme = const PolygonGraphTheme(),
    this.axisLabelTouchPadding = const EdgeInsets.all(8),
    this.onAxisLabelTapDown,
    this.onAxisLabelTapUp,
    this.onAxisLabelTapCancel,
  });

  final PolygonGraphData data;
  final PolygonGraphTheme theme;
  final EdgeInsets axisLabelTouchPadding;

  final void Function(
    TapDownDetails details,
    PolygonGraphAxis axis,
    Offset offset,
  )?
  onAxisLabelTapDown;

  final void Function(TapUpDetails details)? onAxisLabelTapUp;
  final void Function()? onAxisLabelTapCancel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textDirection =
            Directionality.maybeOf(context) ?? TextDirection.ltr;

        final size = Size(constraints.maxWidth, constraints.maxHeight);

        final layout = PolygonGraphLayout(
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
                  painter: PolygonGraphPainter(
                    data: data,
                    theme: theme,
                    textDirection: textDirection,
                  ),
                ),
              ),
              if ((onAxisLabelTapDown != null ||
                      onAxisLabelTapCancel != null) &&
                  data.axes.length >= 3 &&
                  layout.radius >= 0.1)
                for (final x in data.axes.indexed)
                  _AxisLabelTouchArea(
                    axis: x.$2,
                    axisIndex: x.$1,
                    layout: layout,
                    padding: axisLabelTouchPadding,
                    onTapDown: onAxisLabelTapDown,
                    onTapUp: onAxisLabelTapUp,
                    onTapCancel: onAxisLabelTapCancel,
                  ),
            ],
          ),
        );
      },
    );
  }
}

final class _AxisLabelTouchArea extends StatelessWidget {
  const _AxisLabelTouchArea({
    required this.axis,
    required this.axisIndex,
    required this.layout,
    required this.padding,
    required this.onTapDown,
    required this.onTapUp,
    required this.onTapCancel,
  });

  final PolygonGraphAxis axis;
  final int axisIndex;
  final PolygonGraphLayout layout;
  final EdgeInsets padding;

  final void Function(
    TapDownDetails details,
    PolygonGraphAxis axis,
    Offset offset,
  )?
  onTapDown;

  final void Function(TapUpDetails details)? onTapUp;
  final VoidCallback? onTapCancel;

  @override
  Widget build(BuildContext context) {
    final touchRect = layout.getAxisLabelTouchRect(axisIndex, padding: padding);

    return Positioned.fromRect(
      rect: touchRect,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (details) => onTapDown?.call(
          details,
          axis,
          touchRect.topLeft + details.localPosition,
        ),
        onTapUp: onTapUp,
        onTapCancel: onTapCancel,
        child: const SizedBox.expand(),
      ),
    );
  }
}
