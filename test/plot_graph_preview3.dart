import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis_marking.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_indicator_line.dart';
import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:clickless_graph/plot/model/plot_graph_type.dart';
import 'package:clickless_graph/plot/widget/plot_graph.dart';
import 'package:clickless_graph/plot/widget/plot_graph_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PlotGraphPreview3App());
}

final class PlotGraphPreview3App extends StatelessWidget {
  const PlotGraphPreview3App({super.key});

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

const _blue = Color(0xff29a9ff);

const _sampleData = SingleVerticalAxisPlotGraphData(
  xAxis: HorizontalPlotGraphAxis(
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
  ),
  yAxis: VerticalPlotGraphAxis(
    min: 0,
    max: 10,
    markers: [
      PlotGraphAxisMarking(value: 10, label: '10'),
      PlotGraphAxisMarking(value: 8, label: '8'),
      PlotGraphAxisMarking(value: 6, label: '6'),
      PlotGraphAxisMarking(value: 4, label: '4'),
      PlotGraphAxisMarking(value: 2, label: '2'),
      PlotGraphAxisMarking(value: 0, label: '0'),
    ],
    groups: [
      PlotGraphPointGroup(
        type: PlotGraphType.bar,
        points: [
          PlotGraphPoint(x: 0, y: 9, color: _blue, label: '9점'),
          PlotGraphPoint(x: 1, y: 8, color: _blue, label: '8점'),
          PlotGraphPoint(x: 2, y: 7, color: _blue, label: '7점'),
          PlotGraphPoint(x: 3, y: 5, color: _blue, label: '5점'),
          PlotGraphPoint(x: 4, y: 4, color: _blue, label: '4점'),
          PlotGraphPoint(x: 5, y: 2, color: _blue, label: '2점'),
          PlotGraphPoint(x: 6, y: 1, color: _blue, label: '1점'),
        ],
        zIndex: 11,
      ),
    ],
    indicatorLines: [PlotGraphIndicatorLine(value: 7.32, label: '평균')],
    showLine: true,
  ),
);
