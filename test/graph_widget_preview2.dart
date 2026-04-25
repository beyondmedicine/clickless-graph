import 'package:clickless_graph/model/graph_axis.dart';
import 'package:clickless_graph/model/graph_axis_marking.dart';
import 'package:clickless_graph/model/graph_data.dart';
import 'package:clickless_graph/model/graph_point.dart';
import 'package:clickless_graph/model/graph_point_group.dart';
import 'package:clickless_graph/model/graph_trend_line.dart';
import 'package:clickless_graph/model/graph_type.dart';
import 'package:clickless_graph/widget/graph_widget.dart';
import 'package:clickless_graph/widget/graph_widget_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const GraphWidgetPreview2App());
}

final class GraphWidgetPreview2App extends StatelessWidget {
  const GraphWidgetPreview2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: GraphWidget(
              data: _sampleData,
              theme: GraphWidgetTheme().copyWith(backgroundColor: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

const _red = Color(0xffff4545);
const _yellow = Color(0xffffb800);
const _blue = Color(0xff29a9ff);
const _green = Color(0xFF16AD7E);

const _sampleData = SingleVerticalAxisGraphData(
  xAxis: HorizontalGraphAxis(
    min: 0,
    max: 6,
    markers: [
      GraphAxisMarking(value: 0, label: '기초'),
      GraphAxisMarking(value: 1, label: '1주 차'),
      GraphAxisMarking(value: 2, label: '2주 차'),
      GraphAxisMarking(value: 3, label: '3주 차'),
      GraphAxisMarking(value: 4, label: '4주 차'),
      GraphAxisMarking(value: 5, label: '5주 차'),
      GraphAxisMarking(value: 6, label: '6주 차'),
    ],
  ),
  yAxis: VerticalGraphAxis(
    min: 0,
    max: 12,
    markers: [
      GraphAxisMarking(value: 12, label: '12'),
      GraphAxisMarking(value: 10, label: '10'),
      GraphAxisMarking(value: 8, label: '8'),
      GraphAxisMarking(value: 6, label: '6'),
      GraphAxisMarking(value: 4, label: '4'),
      GraphAxisMarking(value: 2, label: '2'),
      GraphAxisMarking(value: 0, label: '0'),
    ],
    groups: [
      GraphPointGroup(
        type: GraphType.line,
        trendLine: GraphTrendLine(
          start: GraphPoint(x: 0, y: 84, color: _red),
          end: GraphPoint(x: 6, y: 0, color: _blue),
        ),
        points: [],
        zIndex: 0,
      ),
      GraphPointGroup(
        type: GraphType.line,
        points: [
          GraphPoint(x: 0, y: 12, color: _red, label: '12점'),
          GraphPoint(x: 1, y: 11, color: _red, label: '11점'),
          GraphPoint(x: 2, y: 7, color: _yellow, label: '7점'),
          GraphPoint(x: 3, y: 6, color: _yellow, label: '6점'),
          GraphPoint(x: 4, y: 5, color: _green, label: '5점'),
          GraphPoint(x: 5, y: 1, color: _blue, label: '1점'),
          GraphPoint(x: 6, y: 0, color: _blue, label: '0점'),
        ],
        zIndex: 3,
      ),
    ],
  ),
);
