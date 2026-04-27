import 'package:flutter/material.dart';

final class PlotGraphTheme {
  const PlotGraphTheme({
    this.backgroundColor = Colors.white,
    this.axisLineColor = const Color(0xFFDEE4EA),
    this.disabledColor = const Color(0xFFC5D0DA),
    this.axisMarkingLineColor = const Color(0xFFC5D0DA),
    this.indicatorLineColor = const Color(0xFFC5D0DA),
    this.trendLineColor = const Color(0xFFC5D0DA),
    this.axisLineWidth = 1.5,
    this.markingLineWidth = 0.5,
    this.pointSize = 6,
    this.barWidth = 20,
    this.axisMarkingLabelAndVerticalAxisGap = 4,
    this.axisMarkingLabelAndHorizontalAxisGap = 5,
    this.verticalAxisLabelAndTopOfGraphGap = 16,
    this.pointLabelAndPointGap = 6,
    this.legendAndBottomOfGraphGap = 16,
    this.legendItemsGap = 16,
    this.legendPointAndLegendLabelGap = 6,
    this.axisMarkingLabelTextStyle = const TextStyle(
      color: Color(0xFF8D9BA8),
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
      height: 1.4,
    ),
    this.verticalAxisLabelTextStyle = const TextStyle(
      color: Color(0xFF8D9BA8),
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
      height: 1.4,
    ),
    this.pointLabelTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
      height: 1.4,
    ),
    this.indicatorLineLabelTextStyle = const TextStyle(
      color: Color(0xFF8D9BA8),
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
      height: 1.4,
    ),
    this.legendTextStyle = const TextStyle(
      color: Color(0xFF8D9BA8),
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.24,
      height: 1.4,
    ),
  });

  final Color backgroundColor;
  final Color axisLineColor;
  final Color disabledColor;
  final Color axisMarkingLineColor;
  final Color indicatorLineColor;
  final Color trendLineColor;

  final double axisLineWidth;
  final double markingLineWidth;
  final double pointSize;
  final double barWidth;

  final double axisMarkingLabelAndVerticalAxisGap;
  final double axisMarkingLabelAndHorizontalAxisGap;
  final double verticalAxisLabelAndTopOfGraphGap;
  final double pointLabelAndPointGap;
  final double legendAndBottomOfGraphGap;
  final double legendItemsGap;
  final double legendPointAndLegendLabelGap;

  final TextStyle axisMarkingLabelTextStyle;
  final TextStyle verticalAxisLabelTextStyle;
  final TextStyle pointLabelTextStyle;
  final TextStyle indicatorLineLabelTextStyle;
  final TextStyle legendTextStyle;

  PlotGraphTheme copyWith({
    Color? backgroundColor,
    Color? axisLineColor,
    Color? disabledColor,
    Color? axisMarkingLineColor,
    Color? indicatorLineColor,
    Color? trendLineColor,
    double? axisLineWidth,
    double? gridLineWidth,
    double? pointSize,
    double? barWidth,
    double? axisMarkingLabelAndVerticalAxisGap,
    double? axisMarkingLabelAndHorizontalAxisGap,
    double? verticalAxisLabelAndTopOfGraphGap,
    double? pointLabelAndPointGap,
    double? legendAndBottomOfGraphGap,
    double? legendItemsGap,
    double? legendPointAndLegendLabelGap,
    TextStyle? axisMarkerLabelTextStyle,
    TextStyle? verticalAxisLabelTextStyle,
    TextStyle? pointLabelTextStyle,
    TextStyle? indicatorLineLabelTextStyle,
    TextStyle? legendTextStyle,
  }) => PlotGraphTheme(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    axisLineColor: axisLineColor ?? this.axisLineColor,
    disabledColor: disabledColor ?? this.disabledColor,
    axisMarkingLineColor: axisMarkingLineColor ?? this.axisMarkingLineColor,
    indicatorLineColor: indicatorLineColor ?? this.indicatorLineColor,
    trendLineColor: trendLineColor ?? this.trendLineColor,
    axisLineWidth: axisLineWidth ?? this.axisLineWidth,
    markingLineWidth: gridLineWidth ?? this.markingLineWidth,
    pointSize: pointSize ?? this.pointSize,
    barWidth: barWidth ?? this.barWidth,
    axisMarkingLabelAndVerticalAxisGap:
        axisMarkingLabelAndVerticalAxisGap ??
        this.axisMarkingLabelAndVerticalAxisGap,
    axisMarkingLabelAndHorizontalAxisGap:
        axisMarkingLabelAndHorizontalAxisGap ??
        this.axisMarkingLabelAndHorizontalAxisGap,
    verticalAxisLabelAndTopOfGraphGap:
        verticalAxisLabelAndTopOfGraphGap ??
        this.verticalAxisLabelAndTopOfGraphGap,
    pointLabelAndPointGap: pointLabelAndPointGap ?? this.pointLabelAndPointGap,
    legendAndBottomOfGraphGap:
        legendAndBottomOfGraphGap ?? this.legendAndBottomOfGraphGap,
    legendItemsGap: legendItemsGap ?? this.legendItemsGap,
    legendPointAndLegendLabelGap:
        legendPointAndLegendLabelGap ?? this.legendPointAndLegendLabelGap,
    axisMarkingLabelTextStyle:
        axisMarkerLabelTextStyle ?? this.axisMarkingLabelTextStyle,
    verticalAxisLabelTextStyle:
        verticalAxisLabelTextStyle ?? this.verticalAxisLabelTextStyle,
    pointLabelTextStyle: pointLabelTextStyle ?? this.pointLabelTextStyle,
    indicatorLineLabelTextStyle:
        indicatorLineLabelTextStyle ?? this.indicatorLineLabelTextStyle,
    legendTextStyle: legendTextStyle ?? this.legendTextStyle,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlotGraphTheme &&
          backgroundColor == other.backgroundColor &&
          axisLineColor == other.axisLineColor &&
          disabledColor == other.disabledColor &&
          axisMarkingLineColor == other.axisMarkingLineColor &&
          indicatorLineColor == other.indicatorLineColor &&
          trendLineColor == other.trendLineColor &&
          axisLineWidth == other.axisLineWidth &&
          markingLineWidth == other.markingLineWidth &&
          pointSize == other.pointSize &&
          barWidth == other.barWidth &&
          axisMarkingLabelAndVerticalAxisGap ==
              other.axisMarkingLabelAndVerticalAxisGap &&
          axisMarkingLabelAndHorizontalAxisGap ==
              other.axisMarkingLabelAndHorizontalAxisGap &&
          verticalAxisLabelAndTopOfGraphGap ==
              other.verticalAxisLabelAndTopOfGraphGap &&
          pointLabelAndPointGap == other.pointLabelAndPointGap &&
          legendAndBottomOfGraphGap == other.legendAndBottomOfGraphGap &&
          legendItemsGap == other.legendItemsGap &&
          legendPointAndLegendLabelGap == other.legendPointAndLegendLabelGap &&
          axisMarkingLabelTextStyle == other.axisMarkingLabelTextStyle &&
          verticalAxisLabelTextStyle == other.verticalAxisLabelTextStyle &&
          pointLabelTextStyle == other.pointLabelTextStyle &&
          indicatorLineLabelTextStyle == other.indicatorLineLabelTextStyle &&
          legendTextStyle == other.legendTextStyle;

  @override
  int get hashCode => Object.hashAll([
    backgroundColor,
    axisLineColor,
    disabledColor,
    axisMarkingLineColor,
    indicatorLineColor,
    trendLineColor,
    axisLineWidth,
    markingLineWidth,
    pointSize,
    barWidth,
    axisMarkingLabelAndVerticalAxisGap,
    axisMarkingLabelAndHorizontalAxisGap,
    verticalAxisLabelAndTopOfGraphGap,
    pointLabelAndPointGap,
    legendAndBottomOfGraphGap,
    legendItemsGap,
    legendPointAndLegendLabelGap,
    axisMarkingLabelTextStyle,
    verticalAxisLabelTextStyle,
    pointLabelTextStyle,
    indicatorLineLabelTextStyle,
    legendTextStyle,
  ]);
}
