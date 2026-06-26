import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis_binding.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis_marking.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_line_type.dart';
import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_label.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_label_type.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_shape.dart';
import 'package:clickless_graph/plot/model/plot_graph_type.dart';
import 'package:clickless_graph/plot/theme/plot_graph_theme.dart';
import 'package:clickless_graph/plot/widget/plot_graph.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PlotGraphPreview1App());
}

final class PlotGraphPreview1App extends StatelessWidget {
  const PlotGraphPreview1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: const _PlotGraphPreview1(),
          ),
        ),
      ),
    );
  }
}

final class _PlotGraphPreview1 extends StatelessWidget {
  const _PlotGraphPreview1();

  @override
  Widget build(BuildContext context) {
    return PlotGraph(
      data: _sampleData,
      theme: const PlotGraphTheme().copyWith(backgroundColor: Colors.white),
      showBubbleOverlay: true,
    );
  }
}

const _sampleData = PlotGraphData(
  xAxis: PlotGraphAxis(
    min: 1,
    max: 7,
    markers: [
      PlotGraphAxisMarking(value: 1, label: '1일'),
      PlotGraphAxisMarking(value: 2, label: '2일'),
      PlotGraphAxisMarking(value: 3, label: '3일'),
      PlotGraphAxisMarking(value: 4, label: '4일'),
      PlotGraphAxisMarking(value: 5, label: '5일'),
      PlotGraphAxisMarking(value: 6, label: '6일'),
      PlotGraphAxisMarking(value: 7, label: '7일'),
    ],
    showLine: true,
  ),
  leftYAxis: PlotGraphAxis(
    min: 0,
    max: 10,
    markers: [
      PlotGraphAxisMarking(value: 10, label: '10', showLine: true),
      PlotGraphAxisMarking(value: 5, label: '5', showLine: true),
      PlotGraphAxisMarking(value: 0, label: '0', showLine: true),
    ],
    label: '(점)',
  ),
  rightYAxis: PlotGraphAxis(
    min: 0,
    max: 12,
    markers: [
      PlotGraphAxisMarking(value: 12, label: '12'),
      PlotGraphAxisMarking(value: 6, label: '6'),
      PlotGraphAxisMarking(value: 0, label: '0'),
    ],
    label: '(시간)',
  ),
  groups: [
    PlotGraphPointGroup(
      legend: '통증',
      type: PlotGraphType.line,
      points: [
        PlotGraphPoint(
          x: 1,
          y: 10,
          color: Color(0xffff4545),
          labels: [
            PlotGraphPointLabel(
              text: '10점',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 2,
          y: 9,
          color: Color(0xffff4545),
          labels: [
            PlotGraphPointLabel(
              text: '9잠',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 3,
          y: 7,
          color: Color(0xffff4545),
          labels: [
            PlotGraphPointLabel(
              text: '7점',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 4,
          y: null,
          color: Color(0xffff4545),
          labels: [
            PlotGraphPointLabel(
              text: '기록 없음',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 5,
          y: null,
          color: Color(0xffff4545),
          labels: [
            PlotGraphPointLabel(
              text: '기록 없음',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 6,
          y: null,
          color: Color(0xffff4545),
          labels: [
            PlotGraphPointLabel(
              text: '기록 없음',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 7,
          y: 2,
          color: Color(0xffff4545),
          labels: [
            PlotGraphPointLabel(
              text: '2점',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
      ],
      zIndex: 11,
    ),
    PlotGraphPointGroup(
      legend: '스트레스',
      type: PlotGraphType.line,
      lineType: PlotGraphLineType.dashed,
      pointShape: PlotGraphPointShape.triangle,
      points: [
        PlotGraphPoint(
          x: 1,
          y: 9,
          color: Color(0xffffb800),
          labels: [
            PlotGraphPointLabel(
              text: '9점',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 2,
          y: 8,
          color: Color(0xffffb800),
          labels: [
            PlotGraphPointLabel(
              text: '8점',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 3,
          y: 6,
          color: Color(0xffffb800),
          labels: [
            PlotGraphPointLabel(
              text: '6점',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 4,
          y: null,
          color: Color(0xffffb800),
          labels: [
            PlotGraphPointLabel(
              text: '기록 없음',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 5,
          y: null,
          color: Color(0xffffb800),
          labels: [
            PlotGraphPointLabel(
              text: '기록 없음',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 6,
          y: null,
          color: Color(0xffffb800),
          labels: [
            PlotGraphPointLabel(
              text: '기록 없음',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 7,
          y: 1,
          color: Color(0xffffb800),
          labels: [
            PlotGraphPointLabel(
              text: '1점',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
      ],
      zIndex: 12,
    ),
    PlotGraphPointGroup(
      legend: '수면',
      axisBinding: PlotGraphAxisBinding.right,
      type: PlotGraphType.bar,
      points: [
        PlotGraphPoint(
          x: 1,
          y: 1,
          color: Color(0xff16ad7e),
          labels: [
            PlotGraphPointLabel(
              text: '1시간',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 2,
          y: 2,
          color: Color(0xff16ad7e),
          labels: [
            PlotGraphPointLabel(
              text: '2시간 1분',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 3,
          y: 5,
          color: Color(0xff16ad7e),
          labels: [
            PlotGraphPointLabel(
              text: '5시간 4분',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 4,
          y: null,
          color: Color(0xff16ad7e),
          labels: [
            PlotGraphPointLabel(
              text: '기록 없음',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 5,
          y: null,
          color: Color(0xff16ad7e),
          labels: [
            PlotGraphPointLabel(
              text: '기록 없음',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 6,
          y: null,
          color: Color(0xff16ad7e),
          labels: [
            PlotGraphPointLabel(
              text: '기록 없음',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 7,
          y: 12,
          color: Color(0xff16ad7e),
          labels: [
            PlotGraphPointLabel(
              text: '12시간 3분',
              type: PlotGraphPointLabelType.overlay,
            ),
          ],
        ),
      ],
      zIndex: 6,
    ),
  ],
);
