import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis_marking.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_legend_position.dart';
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
  runApp(const PlotGraphPreview5App());
}

final class PlotGraphPreview5App extends StatelessWidget {
  const PlotGraphPreview5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: PlotGraph(
              data: _sampleData,
              theme: PlotGraphTheme().copyWith(backgroundColor: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

const _red = Color(0xffff4545);
const _yellow = Color(0xffffb800);

const _sampleData = PlotGraphData(
  title: '통증 및 스트레스 추이',
  legendPosition: PlotGraphLegendPosition.topRight,
  xAxis: PlotGraphAxis(
    min: 0,
    max: 6,
    markers: [
      PlotGraphAxisMarking(value: 0, label: '기초'),
      PlotGraphAxisMarking(value: 1, label: '1주 차'),
      PlotGraphAxisMarking(value: 2, label: '2주 차'),
      PlotGraphAxisMarking(value: 3, label: '3주 차'),
      PlotGraphAxisMarking(value: 4, label: '4주 차'),
      PlotGraphAxisMarking(value: 5, label: '5주 차'),
      PlotGraphAxisMarking(value: 6, label: '6주 차'),
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
  ),
  groups: [
    PlotGraphPointGroup(
      legend: '통증',
      type: PlotGraphType.line,
      points: [
        PlotGraphPoint(
          x: 0,
          y: 10,
          color: _red,
          labels: [
            PlotGraphPointLabel(
              text: '10점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 1,
          y: 9,
          color: _red,
          labels: [
            PlotGraphPointLabel(
              text: '9점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 2,
          y: 7,
          color: _red,
          labels: [
            PlotGraphPointLabel(
              text: '7점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 3,
          y: 6,
          color: _red,
          labels: [
            PlotGraphPointLabel(
              text: '6점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 4,
          y: 5,
          color: _red,
          labels: [
            PlotGraphPointLabel(
              text: '5점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 5,
          y: 3,
          color: _red,
          labels: [
            PlotGraphPointLabel(
              text: '3점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 6,
          y: 2,
          color: _red,
          labels: [
            PlotGraphPointLabel(
              text: '2점',
              type: PlotGraphPointLabelType.point,
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
          x: 0,
          y: 8,
          color: _yellow,
          labels: [
            PlotGraphPointLabel(
              text: '8점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 1,
          y: 7,
          color: _yellow,
          labels: [
            PlotGraphPointLabel(
              text: '7점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 2,
          y: 5,
          color: _yellow,
          labels: [
            PlotGraphPointLabel(
              text: '5점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 3,
          y: 4,
          color: _yellow,
          labels: [
            PlotGraphPointLabel(
              text: '4점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 4,
          y: 3,
          color: _yellow,
          labels: [
            PlotGraphPointLabel(
              text: '3점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 5,
          y: 1,
          color: _yellow,
          labels: [
            PlotGraphPointLabel(
              text: '1점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
        PlotGraphPoint(
          x: 6,
          y: 0,
          color: _yellow,
          labels: [
            PlotGraphPointLabel(
              text: '0점',
              type: PlotGraphPointLabelType.point,
            ),
          ],
        ),
      ],
      zIndex: 12,
    ),
  ],
);
