import 'package:flutter/material.dart';

Size getTextSize(
  String text,
  TextStyle style, {
  TextDirection textDirection = TextDirection.ltr,
}) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
  )..layout();

  return painter.size;
}
