import 'package:clickless_graph/plot/model/plot_graph_axis.dart';
import 'package:clickless_graph/plot/model/plot_graph_axis_marking.dart';
import 'package:clickless_graph/plot/model/plot_graph_data.dart';
import 'package:clickless_graph/plot/model/plot_graph_point.dart';
import 'package:clickless_graph/plot/model/plot_graph_point_group.dart';
import 'package:clickless_graph/plot/model/plot_graph_type.dart';
import 'package:clickless_graph/plot/widget/plot_graph.dart';
import 'package:clickless_graph/plot/theme/plot_graph_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PlotGraphPreview4App());
}

final class PlotGraphPreview4App extends StatelessWidget {
  const PlotGraphPreview4App({super.key});

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
              theme: PlotGraphTheme().copyWith(
                backgroundColor: Colors.white,
                disabledColor: _green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const _red = Color(0xffff4545);
const _yellow = Color(0xffffb800);
const _green = Color(0xFF16AD7E);

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
    max: 2,
    markers: [
      PlotGraphAxisMarking(value: 2, label: '있음'),
      PlotGraphAxisMarking(value: 1, label: '가끔'),
      PlotGraphAxisMarking(value: 0, label: '없음'),
    ],
    groups: [
      PlotGraphPointGroup(
        type: PlotGraphType.bar,
        points: [
          PlotGraphPoint(x: 0, y: 2, color: _red, label: '있음'),
          PlotGraphPoint(x: 1, y: 2, color: _red, label: '있음'),
          PlotGraphPoint(x: 2, y: 2, color: _red, label: '있음'),
          PlotGraphPoint(x: 3, y: 1, color: _yellow, label: '가끔'),
          PlotGraphPoint(x: 4, y: 1, color: _yellow, label: '가끔'),
          PlotGraphPoint(x: 5, y: 1, color: _yellow, label: '가끔'),
          PlotGraphPoint(x: 6, y: null, color: _green, label: '없음'),
        ],
      ),
    ],
  ),
);
