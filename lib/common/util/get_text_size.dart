import 'package:flutter/material.dart';

Size getTextSize(
  String text,
  TextStyle style, {
  TextDirection textDirection = TextDirection.ltr,
  TextAlign textAlign = TextAlign.center,
}) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
    textAlign: textAlign,
  )..layout();

  return painter.size;
}
