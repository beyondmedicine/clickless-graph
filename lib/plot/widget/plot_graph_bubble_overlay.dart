import 'package:clickless_graph/plot/model/plot_graph_bubble_overlay_item.dart';
import 'package:clickless_graph/plot/model/plot_graph_bubble_overlay_tail_position.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_shape.dart';
import 'package:clickless_graph/plot/theme/plot_graph_bubble_overlay_theme.dart';
import 'package:clickless_graph/plot/util/canvas_paint_extension.dart';
import 'package:flutter/material.dart';

final class PlotGraphBubbleOverlay extends StatelessWidget {
  const PlotGraphBubbleOverlay({
    super.key,
    required this.items,
    this.tailPoisition = PlotGraphBubbleOverlayTailPosition.bottomCenter,
    this.theme = const PlotGraphBubbleOverlayTheme(),
  });

  final List<PlotGraphBubbleOverlayItem> items;
  final PlotGraphBubbleOverlayTailPosition tailPoisition;
  final PlotGraphBubbleOverlayTheme theme;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PlotGraphBubbleBackgroundPainter(
        tailPosition: tailPoisition,
        theme: theme,
      ),
      child: Padding(
        padding: _contentPadding,
        child: IntrinsicWidth(child: _buildItemGrid()),
      ),
    );
  }

  EdgeInsetsGeometry get _contentPadding {
    switch (tailPoisition) {
      case PlotGraphBubbleOverlayTailPosition.topLeft:
      case PlotGraphBubbleOverlayTailPosition.topCenter:
      case PlotGraphBubbleOverlayTailPosition.topRight:
        return theme.padding.add(EdgeInsets.only(top: theme.tailHeight));

      case PlotGraphBubbleOverlayTailPosition.bottomLeft:
      case PlotGraphBubbleOverlayTailPosition.bottomCenter:
      case PlotGraphBubbleOverlayTailPosition.bottomRight:
        return theme.padding.add(EdgeInsets.only(bottom: theme.tailHeight));
    }
  }

  Widget _buildItemGrid() {
    final hasMarker = _hasMarker;
    final hasLegend = _hasLegend;

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FixedColumnWidth(hasMarker ? theme.markerSize : 0),
        1: FixedColumnWidth(hasMarker ? theme.legendMarkerAndLegendTextGap : 0),
        2: const IntrinsicColumnWidth(),
        3: FixedColumnWidth(hasLegend ? theme.legendAndDataTextGap : 0),
        4: const IntrinsicColumnWidth(),
      },
      children: [
        for (var index = 0; index < items.length; index += 1)
          _buildItemRow(items[index], addTopGap: index > 0),
      ],
    );
  }

  bool get _hasMarker =>
      items.any((item) => item.markerShape != null && item.markerColor != null);

  bool get _hasLegend => items.any((item) => item.legend != null);

  TableRow _buildItemRow(
    PlotGraphBubbleOverlayItem item, {
    required bool addTopGap,
  }) {
    final markerShape = item.markerShape;
    final markerColor = item.markerColor;
    final legend = item.legend;

    return TableRow(
      children: [
        _buildGridCell(
          addTopGap: addTopGap,
          child: markerShape != null && markerColor != null
              ? SizedBox.square(
                  dimension: theme.markerSize,
                  child: CustomPaint(
                    painter: _PlotGraphBubbleMarkerPainter(
                      color: markerColor,
                      shape: markerShape,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        _buildGridCell(addTopGap: addTopGap, child: const SizedBox.shrink()),
        _buildGridCell(
          addTopGap: addTopGap,
          child: legend != null
              ? Text(legend, style: theme.legendTextStyle)
              : const SizedBox.shrink(),
        ),
        _buildGridCell(addTopGap: addTopGap, child: const SizedBox.shrink()),
        _buildGridCell(
          addTopGap: addTopGap,
          child: Text(
            item.data,
            style: theme.dataTextStyle,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildGridCell({required bool addTopGap, required Widget child}) {
    if (!addTopGap) {
      return child;
    }

    return Padding(
      padding: EdgeInsets.only(top: theme.itemsGap),
      child: child,
    );
  }
}

final class _PlotGraphBubbleMarkerPainter extends CustomPainter {
  const _PlotGraphBubbleMarkerPainter({
    required this.color,
    required this.shape,
  });

  final Color color;
  final PlotGraphPointShape shape;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPoint(
      center: Offset(size.width / 2, size.height / 2),
      size: size.shortestSide,
      color: color,
      shape: shape,
    );
  }

  @override
  bool shouldRepaint(covariant _PlotGraphBubbleMarkerPainter oldDelegate) =>
      color != oldDelegate.color || shape != oldDelegate.shape;
}

final class _PlotGraphBubbleBackgroundPainter extends CustomPainter {
  const _PlotGraphBubbleBackgroundPainter({
    required this.theme,
    required this.tailPosition,
  });

  final PlotGraphBubbleOverlayTheme theme;
  final PlotGraphBubbleOverlayTailPosition tailPosition;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = theme.backgroupdColor;
    final path = _createBubblePath(size);

    canvas.drawPath(path, paint);
  }

  Path _createBubblePath(Size size) {
    final bodyTop = _hasTopTail ? theme.tailHeight : 0.0;
    final bodyBottom = size.height - (_hasBottomTail ? theme.tailHeight : 0.0);

    final body = RRect.fromLTRBAndCorners(
      0,
      bodyTop,
      size.width,
      bodyBottom,
      topLeft: Radius.circular(theme.radius),
      topRight: Radius.circular(theme.radius),
      bottomLeft: Radius.circular(theme.radius),
      bottomRight: Radius.circular(theme.radius),
    );

    final path = Path()..addRRect(body);
    final tailHalfWidth = theme.tailWidth / 2;
    final tailCenterX = switch (tailPosition) {
      PlotGraphBubbleOverlayTailPosition.topCenter ||
      PlotGraphBubbleOverlayTailPosition.bottomCenter => size.width / 2,
      PlotGraphBubbleOverlayTailPosition.topLeft ||
      PlotGraphBubbleOverlayTailPosition.bottomLeft =>
        theme.tailCenterXOffsetFromNearEnd,
      PlotGraphBubbleOverlayTailPosition.topRight ||
      PlotGraphBubbleOverlayTailPosition.bottomRight =>
        size.width - theme.tailCenterXOffsetFromNearEnd,
    };

    if (_hasTopTail) {
      _appendRoundedTail(
        path,
        baseY: bodyTop,
        tipY: 0,
        tailCenterX: tailCenterX,
        tailHalfWidth: tailHalfWidth,
      );
    } else {
      _appendRoundedTail(
        path,
        baseY: bodyBottom,
        tipY: size.height,
        tailCenterX: tailCenterX,
        tailHalfWidth: tailHalfWidth,
      );
    }

    return path;
  }

  void _appendRoundedTail(
    Path path, {
    required double baseY,
    required double tipY,
    required double tailCenterX,
    required double tailHalfWidth,
  }) {
    final curveControlY = baseY + (tipY - baseY) * 0.35;
    final curveDistance = tailHalfWidth * 0.55;

    path
      ..moveTo(tailCenterX - tailHalfWidth, baseY)
      ..quadraticBezierTo(
        tailCenterX - curveDistance,
        curveControlY,
        tailCenterX,
        tipY,
      )
      ..quadraticBezierTo(
        tailCenterX + curveDistance,
        curveControlY,
        tailCenterX + tailHalfWidth,
        baseY,
      )
      ..close();
  }

  bool get _hasTopTail {
    switch (tailPosition) {
      case PlotGraphBubbleOverlayTailPosition.topLeft:
      case PlotGraphBubbleOverlayTailPosition.topCenter:
      case PlotGraphBubbleOverlayTailPosition.topRight:
        return true;

      case PlotGraphBubbleOverlayTailPosition.bottomLeft:
      case PlotGraphBubbleOverlayTailPosition.bottomCenter:
      case PlotGraphBubbleOverlayTailPosition.bottomRight:
        return false;
    }
  }

  bool get _hasBottomTail => !_hasTopTail;

  @override
  bool shouldRepaint(covariant _PlotGraphBubbleBackgroundPainter oldDelegate) =>
      tailPosition != oldDelegate.tailPosition;
}
