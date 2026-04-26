import 'dart:math';
import 'package:clickless_graph/common/util/get_text_size.dart';
import 'package:flutter/material.dart';

Size getMaxTextSize(Iterable<String> texts, TextStyle style) =>
    texts.fold(const Size(0, 0), (acc, text) {
      final size = getTextSize(text, style);

      return Size(max(acc.width, size.width), max(acc.height, size.height));
    });
