import 'package:clickless_graph/plot/model/plot_graph_bubble_overlay_item.dart';
import 'package:clickless_graph/plot/model/plot_graph_bubble_overlay_tail_position.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_legend_position.dart';
import 'package:clickless_graph/plot/util/plot_graph_pointer_info.dart';
import 'package:clickless_graph/plot/theme/plot_graph_bubble_overlay_theme.dart';
import 'package:clickless_graph/plot/util/graph_data_extension.dart';
import 'package:clickless_graph/plot/util/graph_data_point_extension.dart';
import 'package:clickless_graph/plot/util/plot_graph_layout.dart';
import 'package:clickless_graph/plot/widget/plot_graph_bubble_overlay.dart';
import 'package:clickless_graph/plot/widget/plot_graph_painter.dart';
import 'package:clickless_graph/plot/theme/plot_graph_theme.dart';
import 'package:clickless_graph/plot/widget/plot_graph_point_painter.dart';
import 'package:flutter/material.dart';

final class PlotGraph extends StatefulWidget {
  const PlotGraph({
    super.key,
    required this.data,
    this.theme = const PlotGraphTheme(),
    this.bubbleOverlayTheme = const PlotGraphBubbleOverlayTheme(),
    this.showBubbleOverlay = false,
  });

  final PlotGraphData data;
  final PlotGraphTheme theme;
  final PlotGraphBubbleOverlayTheme bubbleOverlayTheme;
  final bool showBubbleOverlay;

  @override
  State<PlotGraph> createState() => _PlotGraphState();
}

final class _PlotGraphState extends State<PlotGraph> {
  PlotGraphPointerInfo? _tapDownInfo;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final theme = widget.theme;
    final title = data.title;
    final tapDownInfo = _tapDownInfo;

    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            if (data.hasTitle ||
                data.hasLegend &&
                    data.legendPosition == PlotGraphLegendPosition.topRight)
              Padding(
                padding: EdgeInsets.only(
                  bottom: theme.titleLineAndTopOfGraphGap,
                ),
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

                  final size = Size(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  );

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
                        if (widget.showBubbleOverlay)
                          MouseRegion(
                            onExit: (event) => _hideBubbleOverlay(),
                            child: Listener(
                              behavior: HitTestBehavior.opaque,
                              onPointerHover: (event) =>
                                  _showBubbleOverlay(event, layout),
                              onPointerDown: (event) =>
                                  _showBubbleOverlay(event, layout),
                              onPointerMove: (event) =>
                                  _showBubbleOverlay(event, layout),
                              onPointerUp: (event) => _hideBubbleOverlay(),
                              onPointerCancel: (event) => _hideBubbleOverlay(),
                              child: const SizedBox.expand(),
                            ),
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
        ),
        if (tapDownInfo != null && tapDownInfo.nearestPoints.isNotEmpty)
          IgnorePointer(
            child: _PlotGraphBubbleOverlayPositioner(
              info: tapDownInfo,
              theme: widget.bubbleOverlayTheme,
            ),
          ),
      ],
    );
  }

  void _showBubbleOverlay(PointerEvent event, PlotGraphLayout layout) =>
      setState(() => _tapDownInfo = layout.getTapDownInfo(event.localPosition));

  void _hideBubbleOverlay() => setState(() => _tapDownInfo = null);
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

final class _PlotGraphBubbleOverlayPositioner extends StatelessWidget {
  const _PlotGraphBubbleOverlayPositioner({
    required this.info,
    required this.theme,
  });

  final PlotGraphPointerInfo info;
  final PlotGraphBubbleOverlayTheme theme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final anchor = _getAnchorOffset();
        final tailPosition = _getTailPosition(anchor, constraints.biggest);

        return CustomSingleChildLayout(
          delegate: _PlotGraphBubbleOverlayLayoutDelegate(
            anchor: anchor,
            tailPosition: tailPosition,
            theme: theme,
          ),
          child: PlotGraphBubbleOverlay(
            items: info.nearestPoints
                .map((point) {
                  final overlayLabel = point.point.overlayLabel;

                  return overlayLabel != null &&
                          point.point.x == info.nearestXAxisMarking?.value
                      ? PlotGraphBubbleOverlayItem(
                          markerShape: point.group.pointShape,
                          markerColor: point.point.color,
                          legend: point.group.legend,
                          data: overlayLabel,
                        )
                      : null;
                })
                .whereType<PlotGraphBubbleOverlayItem>()
                .toList(),
            tailPoisition: tailPosition,
            theme: theme,
          ),
        );
      },
    );
  }

  Offset _getAnchorOffset() {
    return Offset(info.nearestXAxisMarkingXOffset ?? 0, 0);
  }

  PlotGraphBubbleOverlayTailPosition _getTailPosition(
    Offset anchor,
    Size size,
  ) {
    final isLeft = anchor.dx < size.width * 0.33;
    final isRight = anchor.dx > size.width * 0.67;

    return isLeft
        ? PlotGraphBubbleOverlayTailPosition.bottomLeft
        : isRight
        ? PlotGraphBubbleOverlayTailPosition.bottomRight
        : PlotGraphBubbleOverlayTailPosition.bottomCenter;
  }
}

final class _PlotGraphBubbleOverlayLayoutDelegate
    extends SingleChildLayoutDelegate {
  const _PlotGraphBubbleOverlayLayoutDelegate({
    required this.anchor,
    required this.tailPosition,
    required this.theme,
  });

  final Offset anchor;
  final PlotGraphBubbleOverlayTailPosition tailPosition;
  final PlotGraphBubbleOverlayTheme theme;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final left = (anchor.dx - _tailCenterX(childSize.width)).clamp(
      0.0,
      (size.width - childSize.width).clamp(0.0, double.infinity),
    );

    final top = (size.height / 4 - childSize.height / 2).clamp(
      0.0,
      (size.height - childSize.height).clamp(0.0, double.infinity),
    );

    return Offset(left, top);
  }

  double _tailCenterX(double width) {
    switch (tailPosition) {
      case PlotGraphBubbleOverlayTailPosition.topLeft:
      case PlotGraphBubbleOverlayTailPosition.bottomLeft:
        return theme.tailCenterXOffsetFromNearEnd;

      case PlotGraphBubbleOverlayTailPosition.topCenter:
      case PlotGraphBubbleOverlayTailPosition.bottomCenter:
        return width / 2;

      case PlotGraphBubbleOverlayTailPosition.topRight:
      case PlotGraphBubbleOverlayTailPosition.bottomRight:
        return width - theme.tailCenterXOffsetFromNearEnd;
    }
  }

  @override
  bool shouldRelayout(
    covariant _PlotGraphBubbleOverlayLayoutDelegate oldDelegate,
  ) => anchor != oldDelegate.anchor || tailPosition != oldDelegate.tailPosition;
}
