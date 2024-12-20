import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/ChartSampleData.dart';

class SyncPieChart extends StatefulWidget {
  const SyncPieChart({Key? key}) : super(key: key);

  @override
  State<SyncPieChart> createState() => _SyncPieChartState();
}

class _SyncPieChartState extends State<SyncPieChart> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SfCircularChart(
            title: ChartTitle(text: 'Sales by sales person'),
            legend: Legend(
                isVisible: false, overflowMode: LegendItemOverflowMode.wrap),
            // tooltipBehavior: _tooltip,
            series: <DoughnutSeries<_PieData, String>>[
          DoughnutSeries<_PieData, String>(
              radius: '80%',
              explode: true,
              explodeAll: true,
              explodeIndex: 0,
              explodeOffset: '15%',
              strokeWidth: 4,
              strokeColor:Colors.white,
              dataSource: [
                _PieData('一月', 10, '1'),
                _PieData('二月', 30, '2'),
                _PieData('三月', 20, '3'),
                _PieData('四月', 10, '4'),
                _PieData('五月', 30, '5'),
              ],
              xValueMapper: (_PieData data, _) => data.xData,
              yValueMapper: (_PieData data, _) => data.yData,
              dataLabelMapper: (_PieData data, _) => '${data.xData}:${data.text}',
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  connectorLineSettings: ConnectorLineSettings(
                    color: Colors.green,
                    width: 1.5,
                    length: '15%',
                    type: ConnectorType.line,
                  ))),
        ])

        // child: SfCircularChart(
        //   /// It used to set the annotation on circular chart.
        //   annotations: <CircularChartAnnotation>[
        //     CircularChartAnnotation(
        //         height: '100%',
        //         width: '100%',
        //         widget: PhysicalModel(
        //           shape: BoxShape.circle,
        //           elevation: 10,
        //           color: const Color.fromRGBO(230, 230, 230, 1),
        //           child: Container(),
        //         )),
        //     CircularChartAnnotation(
        //         widget: const Text('62%',
        //             style: TextStyle(
        //                 color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 25)))
        //   ],
        //   title: ChartTitle(
        //       text: 'Progress of a task',
        //       textStyle: const TextStyle(fontSize: 20)),
        //   series: _getElevationDoughnutSeries(),
        // ),

        // child: SfCircularChart(
        //   annotations: <CircularChartAnnotation>[
        //     CircularChartAnnotation(
        //         widget: const Text('90%',
        //             style: TextStyle(color: Colors.grey, fontSize: 25)))
        //   ],
        //   title: ChartTitle(
        //       text: 'Work progress', textStyle: const TextStyle(fontSize: 20)),
        //   series: _getDoughnutCustomizationSeries(),
        // ),

        // child: SfCircularChart(
        //   legend: Legend(
        //       isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        //   title: ChartTitle(text: 'Software development cycle'),
        //   series: _getRoundedDoughnutSeries(),
        // ),

        );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getElevationDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: <ChartSampleData>[
            ChartSampleData(
                x: 'A',
                y: 62,
                pointColor: const Color.fromRGBO(0, 220, 252, 1)),
            ChartSampleData(
                x: 'B',
                y: 38,
                pointColor: const Color.fromRGBO(230, 230, 230, 1))
          ],
          animationDuration: 0,
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor)
    ];
  }

  List<DoughnutSeries<ChartSampleData, String>>
      _getDoughnutCustomizationSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(
              x: 'A', y: 10, pointColor: const Color.fromRGBO(255, 4, 0, 1)),
          ChartSampleData(
              x: 'B', y: 10, pointColor: const Color.fromRGBO(255, 15, 0, 1)),
          ChartSampleData(
              x: 'C', y: 10, pointColor: const Color.fromRGBO(255, 31, 0, 1)),
          ChartSampleData(
              x: 'D', y: 10, pointColor: const Color.fromRGBO(255, 60, 0, 1)),
          ChartSampleData(
              x: 'E', y: 10, pointColor: const Color.fromRGBO(255, 90, 0, 1)),
          ChartSampleData(
              x: 'F', y: 10, pointColor: const Color.fromRGBO(255, 115, 0, 1)),
          ChartSampleData(
              x: 'G', y: 10, pointColor: const Color.fromRGBO(255, 135, 0, 1)),
          ChartSampleData(
              x: 'H', y: 10, pointColor: const Color.fromRGBO(255, 155, 0, 1)),
          ChartSampleData(
              x: 'I', y: 10, pointColor: const Color.fromRGBO(255, 175, 0, 1)),
          ChartSampleData(
              x: 'J', y: 10, pointColor: const Color.fromRGBO(255, 188, 0, 1)),
          ChartSampleData(
              x: 'K', y: 10, pointColor: const Color.fromRGBO(255, 188, 0, 1)),
          ChartSampleData(
              x: 'L', y: 10, pointColor: const Color.fromRGBO(251, 188, 2, 1)),
          ChartSampleData(
              x: 'M', y: 10, pointColor: const Color.fromRGBO(245, 188, 6, 1)),
          ChartSampleData(
              x: 'N', y: 10, pointColor: const Color.fromRGBO(233, 188, 12, 1)),
          ChartSampleData(
              x: 'O', y: 10, pointColor: const Color.fromRGBO(220, 187, 19, 1)),
          ChartSampleData(
              x: 'P', y: 10, pointColor: const Color.fromRGBO(208, 187, 26, 1)),
          ChartSampleData(
              x: 'Q', y: 10, pointColor: const Color.fromRGBO(193, 187, 34, 1)),
          ChartSampleData(
              x: 'R', y: 10, pointColor: const Color.fromRGBO(177, 186, 43, 1)),
          ChartSampleData(
              x: 'S',
              y: 10,
              pointColor: const Color.fromRGBO(230, 230, 230, 1)),
          ChartSampleData(
              x: 'T', y: 10, pointColor: const Color.fromRGBO(230, 230, 230, 1))
        ],
        radius: '100%',
        strokeColor: Colors.amber,
        strokeWidth: 2,
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,

        /// The property used to apply the color for each douchnut series.
        pointColorMapper: (ChartSampleData data, _) => data.pointColor,
        dataLabelMapper: (ChartSampleData data, _) => data.x as String,
      ),
    ];
  }

  List<DoughnutSeries<ChartSampleData, String>> _getRoundedDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'Planning', y: 10),
          ChartSampleData(x: 'Analysis', y: 10),
          ChartSampleData(x: 'Design', y: 10),
          ChartSampleData(x: 'Development', y: 10),
          ChartSampleData(x: 'Testing & Integration', y: 10),
          ChartSampleData(x: 'Maintainance', y: 10)
        ],
        animationDuration: 0,
        cornerStyle: CornerStyle.bothCurve,
        radius: '80%',
        innerRadius: '60%',
        xValueMapper: (ChartSampleData data, _) => data.x as String,
        yValueMapper: (ChartSampleData data, _) => data.y,
      ),
    ];
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);

  final String xData;
  final num yData;
  final String? text;
}
