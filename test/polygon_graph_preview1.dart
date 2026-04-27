import 'package:clickless_graph/polygon/model/polygon_graph_axis.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_data.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_indicator_line.dart';
import 'package:clickless_graph/polygon/model/polygon_graph_point_group.dart';
import 'package:clickless_graph/polygon/widget/polygon_graph.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PolygonGraphPreview1App());
}

final class PolygonGraphPreview1App extends StatelessWidget {
  const PolygonGraphPreview1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: PolygonGraph(data: _sampleData),
          ),
        ),
      ),
    );
  }
}

const _red = Color(0xFFFF4545);
const _yellow = Color(0xFFFFB800);
const _green = Color(0xFF16AD7E);
const _blue = Color(0xFF29A9FF);

const _sampleData = PolygonGraphData(
  min: 0,
  max: 10,
  axes: [
    PolygonGraphAxis(label: '통증'),
    PolygonGraphAxis(label: '스트레스'),
    PolygonGraphAxis(label: '피로'),
    PolygonGraphAxis(label: '수면'),
    PolygonGraphAxis(label: '활동'),
  ],
  markingLines: [
    PolygonGraphMarkingLine(value: 2, label: '낮음'),
    PolygonGraphMarkingLine(value: 4),
    PolygonGraphMarkingLine(value: 6, label: '보통'),
    PolygonGraphMarkingLine(value: 8),
    PolygonGraphMarkingLine(value: 10, label: '높음'),
  ],
  pointGroups: [
    PolygonGraphPointGroup(
      legend: '현재',
      values: [8, 7, 6, 4, 5],
      pointColor: _red,
      fillColor: Color(0x26FF4545),
      zIndex: 2,
    ),
    PolygonGraphPointGroup(
      legend: '목표',
      values: [3, 3, 3, 8, null],
      pointColor: _green,
      fillColor: Color(0x1F16AD7E),
      zIndex: 0,
    ),
  ],
);
