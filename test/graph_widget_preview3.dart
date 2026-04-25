import 'package:clickless_graph/model/graph_axis.dart';
import 'package:clickless_graph/model/graph_axis_marking.dart';
import 'package:clickless_graph/model/graph_data.dart';
import 'package:clickless_graph/model/graph_indicator_line.dart';
import 'package:clickless_graph/model/graph_point.dart';
import 'package:clickless_graph/model/graph_point_group.dart';
import 'package:clickless_graph/model/graph_type.dart';
import 'package:clickless_graph/widget/graph_widget.dart';
import 'package:clickless_graph/widget/graph_widget_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const GraphWidgetPreview3App());
}

final class GraphWidgetPreview3App extends StatelessWidget {
  const GraphWidgetPreview3App({super.key});

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

const _blue = Color(0xff29a9ff);

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
    max: 10,
    markers: [
      GraphAxisMarking(value: 10, label: '10'),
      GraphAxisMarking(value: 8, label: '8'),
      GraphAxisMarking(value: 6, label: '6'),
      GraphAxisMarking(value: 4, label: '4'),
      GraphAxisMarking(value: 2, label: '2'),
      GraphAxisMarking(value: 0, label: '0'),
    ],
    groups: [
      GraphPointGroup(
        type: GraphType.bar,
        points: [
          GraphPoint(x: 0, y: 9, color: _blue, label: '9점'),
          GraphPoint(x: 1, y: 8, color: _blue, label: '8점'),
          GraphPoint(x: 2, y: 7, color: _blue, label: '7점'),
          GraphPoint(x: 3, y: 5, color: _blue, label: '5점'),
          GraphPoint(x: 4, y: 4, color: _blue, label: '4점'),
          GraphPoint(x: 5, y: 2, color: _blue, label: '2점'),
          GraphPoint(x: 6, y: 1, color: _blue, label: '1점'),
        ],
        zIndex: 11,
      ),
    ],
    indicatorLines: [GraphIndicatorLine(value: 7.32, label: '평균')],
    showLine: true,
  ),
);
