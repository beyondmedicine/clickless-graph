import 'package:flutter/material.dart';

final class PlotGraphBubbleOverlayTheme {
  const PlotGraphBubbleOverlayTheme({
    this.markerSize = 6,
    this.legendMarkerAndLegendTextGap = 6,
    this.legendAndDataTextGap = 8,
    this.itemsGap = 4,
    this.radius = 8,
    this.tailWidth = 16,
    this.tailHeight = 6,
    this.backgroupdColor = const Color(0xA310161C),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.dataTextStyle = defaultDataTextStyle,
    this.legendTextStyle = defaultLegendTextStyle,
  });

  final double markerSize;
  final double legendMarkerAndLegendTextGap;
  final double legendAndDataTextGap;
  final double itemsGap;

  final double radius;
  final double tailWidth;
  final double tailHeight;

  final Color backgroupdColor;

  final EdgeInsetsGeometry padding;
  final TextStyle dataTextStyle;
  final TextStyle legendTextStyle;

  static const defaultDataTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.4,
    letterSpacing: -0.24,
  );

  static const defaultLegendTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.4,
    letterSpacing: -0.24,
  );

  PlotGraphBubbleOverlayTheme copyWith({
    double? markerSize,
    double? legendMarkerAndLegendTextGap,
    double? legendAndDataTextGap,
    double? itemsGap,
    double? radius,
    double? tailWidth,
    double? tailHeight,
    EdgeInsetsGeometry? padding,
    TextStyle? dataTextStyle,
    TextStyle? legendTextStyle,
  }) => PlotGraphBubbleOverlayTheme(
    markerSize: markerSize ?? this.markerSize,
    legendMarkerAndLegendTextGap:
        legendMarkerAndLegendTextGap ?? this.legendMarkerAndLegendTextGap,
    legendAndDataTextGap: legendAndDataTextGap ?? this.legendAndDataTextGap,
    itemsGap: itemsGap ?? this.itemsGap,
    radius: radius ?? this.radius,
    tailWidth: tailWidth ?? this.tailWidth,
    tailHeight: tailHeight ?? this.tailHeight,
    padding: padding ?? this.padding,
    dataTextStyle: dataTextStyle ?? this.dataTextStyle,
    legendTextStyle: legendTextStyle ?? this.legendTextStyle,
  );

  double get tailCenterXOffsetFromNearEnd => radius + 3 + tailWidth / 2;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlotGraphBubbleOverlayTheme &&
          markerSize == other.markerSize &&
          legendMarkerAndLegendTextGap == other.legendMarkerAndLegendTextGap &&
          legendAndDataTextGap == other.legendAndDataTextGap &&
          itemsGap == other.itemsGap &&
          radius == other.radius &&
          tailWidth == other.tailWidth &&
          tailHeight == other.tailHeight &&
          padding == other.padding &&
          dataTextStyle == other.dataTextStyle &&
          legendTextStyle == other.legendTextStyle;

  @override
  int get hashCode => Object.hashAll([
    markerSize,
    legendMarkerAndLegendTextGap,
    legendAndDataTextGap,
    itemsGap,
    radius,
    tailWidth,
    tailHeight,
    padding,
    dataTextStyle,
    legendTextStyle,
  ]);
}
