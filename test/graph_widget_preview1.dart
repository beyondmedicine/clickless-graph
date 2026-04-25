import 'package:clickless_graph/model/graph_axis.dart';
import 'package:clickless_graph/model/graph_axis_marking.dart';
import 'package:clickless_graph/model/graph_data.dart';
import 'package:clickless_graph/model/graph_line_type.dart';
import 'package:clickless_graph/model/graph_point.dart';
import 'package:clickless_graph/model/graph_point_group.dart';
import 'package:clickless_graph/model/graph_point_shape.dart';
import 'package:clickless_graph/model/graph_type.dart';
import 'package:clickless_graph/widget/graph_widget.dart';
import 'package:clickless_graph/widget/graph_widget_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const GraphWidgetPreview1App());
}

final class GraphWidgetPreview1App extends StatelessWidget {
  const GraphWidgetPreview1App({super.key});

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

const _sampleData = MultiVerticalAxisGraphData(
  xAxis: HorizontalGraphAxis(
    min: 1,
    max: 7,
    markers: [
      GraphAxisMarking(value: 1, label: '1일'),
      GraphAxisMarking(value: 2, label: '2일'),
      GraphAxisMarking(value: 3, label: '3일'),
      GraphAxisMarking(value: 4, label: '4일'),
      GraphAxisMarking(value: 5, label: '5일'),
      GraphAxisMarking(value: 6, label: '6일'),
      GraphAxisMarking(value: 7, label: '7일'),
    ],
  ),
  y1Axis: VerticalGraphAxis(
    min: 0,
    max: 10,
    markers: [
      GraphAxisMarking(value: 10, label: '10'),
      GraphAxisMarking(value: 5, label: '5'),
      GraphAxisMarking(value: 0, label: '0'),
    ],
    groups: [
      GraphPointGroup(
        legend: '통증',
        type: GraphType.line,
        points: [
          GraphPoint(x: 1, y: 10, color: Color(0xffff4545)),
          GraphPoint(x: 2, y: 9, color: Color(0xffff4545)),
          GraphPoint(x: 3, y: 7, color: Color(0xffff4545)),
          GraphPoint(x: 7, y: 2, color: Color(0xffff4545)),
        ],
        zIndex: 11,
      ),
      GraphPointGroup(
        legend: '스트레스',
        type: GraphType.line,
        lineType: GraphLineType.dashed,
        pointShape: GraphPointShape.triangle,
        points: [
          GraphPoint(x: 1, y: 9, color: Color(0xffffb800)),
          GraphPoint(x: 2, y: 8, color: Color(0xffffb800)),
          GraphPoint(x: 3, y: 6, color: Color(0xffffb800)),
          GraphPoint(x: 7, y: 1, color: Color(0xffffb800)),
        ],
        zIndex: 12,
      ),
    ],
    label: '(점)',
  ),
  y2Axis: VerticalGraphAxis(
    min: 0,
    max: 12,
    markers: [
      GraphAxisMarking(value: 12, label: '12'),
      GraphAxisMarking(value: 6, label: '6'),
      GraphAxisMarking(value: 0, label: '0'),
    ],
    groups: [
      GraphPointGroup(
        legend: '수면',
        type: GraphType.bar,
        points: [
          GraphPoint(x: 1, y: 1, color: Color(0xff16ad7e)),
          GraphPoint(x: 2, y: 2, color: Color(0xff16ad7e)),
          GraphPoint(x: 3, y: 5, color: Color(0xff16ad7e)),
          GraphPoint(x: 4, y: null, color: Color(0xff16ad7e)),
          GraphPoint(x: 5, y: null, color: Color(0xff16ad7e)),
          GraphPoint(x: 6, y: null, color: Color(0xff16ad7e)),
          GraphPoint(x: 7, y: 12, color: Color(0xff16ad7e)),
        ],
        zIndex: 6,
      ),
    ],
    label: '(시간)',
  ),
);
