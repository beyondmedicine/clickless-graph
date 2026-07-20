import 'package:clickless_graph/polygon/model/polygon_graph_axis.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_data.dart';
import 'package:clickless_graph/polygon/theme/polygon_graph_theme.dart';
import 'package:clickless_graph/polygon/util/polygon_graph_layout.dart';
import 'package:clickless_graph/polygon/widget/polygon_graph_painter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

final class PolygonGraph<T> extends StatelessWidget {
  const PolygonGraph({
    super.key,
    required this.data,
    this.theme = const PolygonGraphTheme(),
    this.axisLabelTouchPadding = const EdgeInsets.all(8),
    this.onAxisLabelTapDown,
    this.onAxisLabelTapUp,
    this.onAxisLabelTapCancel,
    this.onAxisLabelEnter,
    this.onAxisLabelHover,
    this.onAxisLabelExit,
  });

  final PolygonGraphData<T> data;
  final PolygonGraphTheme theme;
  final EdgeInsets axisLabelTouchPadding;

  final void Function(
    PointerDownEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onAxisLabelTapDown;

  final void Function(
    PointerUpEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onAxisLabelTapUp;

  final void Function(
    PointerCancelEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onAxisLabelTapCancel;

  final void Function(
    PointerEnterEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onAxisLabelEnter;

  final void Function(
    PointerHoverEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onAxisLabelHover;

  final void Function(
    PointerExitEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onAxisLabelExit;

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
                      onAxisLabelTapUp != null ||
                      onAxisLabelTapCancel != null ||
                      onAxisLabelEnter != null ||
                      onAxisLabelHover != null ||
                      onAxisLabelExit != null) &&
                  data.axes.length >= 3 &&
                  layout.radius >= 0.1)
                for (final x in data.axes.indexed)
                  _AxisLabelInteractionArea(
                    axis: x.$2,
                    axisIndex: x.$1,
                    layout: layout,
                    padding: axisLabelTouchPadding,
                    onTapDown: onAxisLabelTapDown,
                    onTapUp: onAxisLabelTapUp,
                    onTapCancel: onAxisLabelTapCancel,
                    onEnter: onAxisLabelEnter,
                    onHover: onAxisLabelHover,
                    onExit: onAxisLabelExit,
                  ),
            ],
          ),
        );
      },
    );
  }
}

final class _AxisLabelInteractionArea<T> extends StatelessWidget {
  const _AxisLabelInteractionArea({
    required this.axis,
    required this.axisIndex,
    required this.layout,
    required this.padding,
    required this.onTapDown,
    required this.onTapUp,
    required this.onTapCancel,
    required this.onEnter,
    required this.onHover,
    required this.onExit,
  });

  final PolygonGraphAxis<T> axis;
  final int axisIndex;
  final PolygonGraphLayout layout;
  final EdgeInsets padding;

  final void Function(
    PointerDownEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onTapDown;

  final void Function(
    PointerUpEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onTapUp;

  final void Function(
    PointerCancelEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onTapCancel;

  final void Function(
    PointerEnterEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onEnter;

  final void Function(
    PointerHoverEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onHover;

  final void Function(
    PointerExitEvent event,
    PolygonGraphAxis<T> axis,
    Offset offset,
  )?
  onExit;

  @override
  Widget build(BuildContext context) {
    final touchRect = layout.getAxisLabelTouchRect(axisIndex, padding: padding);

    return Positioned.fromRect(
      rect: touchRect,
      child: MouseRegion(
        opaque: false,
        onEnter: (event) =>
            onEnter?.call(event, axis, touchRect.topLeft + event.localPosition),
        onHover: (event) =>
            onHover?.call(event, axis, touchRect.topLeft + event.localPosition),
        onExit: (event) =>
            onExit?.call(event, axis, touchRect.topLeft + event.localPosition),
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (event) => onTapDown?.call(
            event,
            axis,
            touchRect.topLeft + event.localPosition,
          ),
          onPointerUp: (event) => onTapUp?.call(
            event,
            axis,
            touchRect.topLeft + event.localPosition,
          ),
          onPointerCancel: (event) => onTapCancel?.call(
            event,
            axis,
            touchRect.topLeft + event.localPosition,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
