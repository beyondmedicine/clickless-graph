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

const _blue = Color(0xFF29A9FF);
const _gray = Color(0xFFB8C7D4);

const _sampleData = PolygonGraphData(
  min: 0,
  max: 10,
  axes: [
    PolygonGraphAxis(label: '관자놀이'),
    PolygonGraphAxis(label: '관절강'),
    PolygonGraphAxis(label: '목 근육'),
    PolygonGraphAxis(label: '저작근 하부'),
    PolygonGraphAxis(label: '저작근 중심'),
    PolygonGraphAxis(label: '이마 근육'),
  ],
  markingLines: [
    PolygonGraphMarkingLine(value: 0, label: '0', showLine: false),
    PolygonGraphMarkingLine(value: 5, label: '5'),
    PolygonGraphMarkingLine(value: 10, label: '10'),
  ],
  pointGroups: [
    PolygonGraphPointGroup(
      legend: '기준',
      values: [4, 5, 7, 8, 9, 4],
      pointColor: _gray,
      fillColor: Color(0x1FB8C7D4),
      zIndex: 0,
    ),
    PolygonGraphPointGroup(
      legend: '현재',
      values: [8, 7, 5, 4, 3, 9],
      pointColor: _blue,
      fillColor: Color(0x2629A9FF),
      zIndex: 2,
    ),
  ],
);
