import 'package:flutter/material.dart';

@immutable
final class PolygonGraphTheme {
  const PolygonGraphTheme({
    this.backgroundColor = Colors.white,
    this.axisLineColor = const Color(0xFFDEE4EA),
    this.markingLineColor = const Color(0xFFDEE4EA),
    this.borderColor = const Color(0xFFDEE4EA),
    this.pointGroupLineWidth = 1.5,
    this.borderWidth = 1.5,
    this.axisLineWidth = 0.5,
    this.markingLineWidth = 0.5,
    this.cornerRadius = 4,
    this.pointSize = 6,
    this.markingLabelPadding = 4,
    this.verticeAndAxisLabelCenterGap = 12,
    this.axisLabelTextStyle = defaultAxisLabelTextStyle,
    this.markingLabelTextStyle = defaultMarkingLabelTextStyle,
  });

  final Color backgroundColor;
  final Color axisLineColor;
  final Color markingLineColor;
  final Color borderColor;

  final double pointGroupLineWidth;
  final double borderWidth;
  final double axisLineWidth;
  final double markingLineWidth;
  final double pointSize;
  final double cornerRadius;

  final double markingLabelPadding;
  final double verticeAndAxisLabelCenterGap;

  final TextStyle axisLabelTextStyle;
  final TextStyle markingLabelTextStyle;
  
  static const TextStyle defaultAxisLabelTextStyle = TextStyle(
    color: Color(0xFF8D9BA8),
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.24,
    height: 1.4,
  );
  static const TextStyle defaultMarkingLabelTextStyle = TextStyle(
    color: Color(0xFF8D9BA8),
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.24,
    height: 1.4,
  );

  PolygonGraphTheme copyWith({
    Color? backgroundColor,
    Color? axisLineColor,
    Color? markingLineColor,
    Color? borderColor,
    double? pointGroupLineWidth,
    double? borderWidth,
    double? axisLineWidth,
    double? markingLineWidth,
    double? cornerRadius,
    double? markingLabelPadding,
    double? pointSize,
    double? verticeAndAxisLabelCenterGap,
    TextStyle? axisLabelTextStyle,
    TextStyle? markingLabelTextStyle,
  }) => PolygonGraphTheme(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    axisLineColor: axisLineColor ?? this.axisLineColor,
    markingLineColor: markingLineColor ?? this.markingLineColor,
    borderColor: borderColor ?? this.borderColor,
    pointGroupLineWidth: pointGroupLineWidth ?? this.pointGroupLineWidth,
    borderWidth: borderWidth ?? this.borderWidth,
    axisLineWidth: axisLineWidth ?? this.axisLineWidth,
    markingLineWidth: markingLineWidth ?? this.markingLineWidth,
    cornerRadius: cornerRadius ?? this.cornerRadius,
    pointSize: pointSize ?? this.pointSize,
    markingLabelPadding: markingLabelPadding ?? this.markingLabelPadding,
    verticeAndAxisLabelCenterGap:
        verticeAndAxisLabelCenterGap ?? this.verticeAndAxisLabelCenterGap,
    axisLabelTextStyle: axisLabelTextStyle ?? this.axisLabelTextStyle,
    markingLabelTextStyle: markingLabelTextStyle ?? this.markingLabelTextStyle,
  );

  @override
  bool operator ==(Object other) =>
      (identical(this, other)) ||
      other is PolygonGraphTheme &&
          other.backgroundColor == backgroundColor &&
          other.axisLineColor == axisLineColor &&
          other.markingLineColor == markingLineColor &&
          other.borderColor == borderColor &&
          other.pointGroupLineWidth == pointGroupLineWidth &&
          other.borderWidth == borderWidth &&
          other.axisLineWidth == axisLineWidth &&
          other.markingLineWidth == markingLineWidth &&
          other.cornerRadius == cornerRadius &&
          other.pointSize == pointSize &&
          other.markingLabelPadding == markingLabelPadding &&
          other.verticeAndAxisLabelCenterGap == verticeAndAxisLabelCenterGap &&
          other.axisLabelTextStyle == axisLabelTextStyle &&
          other.markingLabelTextStyle == markingLabelTextStyle;

  @override
  int get hashCode => Object.hashAll([
    backgroundColor,
    axisLineColor,
    markingLineColor,
    borderColor,
    pointGroupLineWidth,
    borderWidth,
    axisLineWidth,
    markingLineWidth,
    cornerRadius,
    pointSize,
    markingLabelPadding,
    verticeAndAxisLabelCenterGap,
    axisLabelTextStyle,
    markingLabelTextStyle,
  ]);
}
