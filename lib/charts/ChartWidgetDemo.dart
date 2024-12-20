import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:flutter_sample/charts/custom_gauge_chart.dart';

import '../bezier_chart_demo/main.dart';
import '../good_flutter_chart_demo/example_page.dart';
import '../googlechart/main.dart';
import 'BrunoLineChart.dart';
import 'BrunoPieChart.dart';
import 'DLineChart.dart';
import 'DPieChart.dart';
import 'FLCurveLineChart.dart';
import 'LineChart.dart';
import 'PieChartWidget.dart';
import 'SyncPieChart.dart';
import 'TransitionLineChart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "图表组件",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 图表组件"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomGaugeChart(),
            const AspectRatio(
                aspectRatio: 1.70,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: FLCurveLineChart(),
                )),
            const Text('基于 fl_chart 实现'),
            const LineChartWidget(),
            const PieChartWidget(),
            const TransitionLineChartWidget(),
            const Text('基于 d_chart 实现'),
            const DLineChartWidget(),
            const DPieChartWidget(),
            const Text('基于 bruno 实现'),
            const BrunoLineChartWidget(),
            const BrunoPieChartWidget(),
            // const Text('基于 echart 实现'),
            // const EChartPieWidget(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const GalleryApp();
                }));
              },
              child: const Text('基于 google charts 实现'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Example();
                }));
              },
              child: const Text('基于 flutter_charts 实现'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BezierChartDemoPage();
                }));
              },
              child: const Text('基于 bezier_charts 实现'),
            ),
            const Text('基于 syncfusion_flutter_charts 实现'),
            const SyncPieChart(),
          ],
        ),
      ),
    );
  }

// Widget sample1(BuildContext context) {
//   return Center(
//     child: Container(
//       color: Colors.red,
//       height: MediaQuery.of(context).size.height / 2,
//       width: MediaQuery.of(context).size.width * 0.9,
//       child: BezierChart(
//         bezierChartScale: BezierChartScale.CUSTOM,
//         xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
//         series: const [
//           BezierLine(
//             data: const [
//               DataPoint<double>(value: 10, xAxis: 0),
//               DataPoint<double>(value: 130, xAxis: 5),
//               DataPoint<double>(value: 50, xAxis: 10),
//               DataPoint<double>(value: 150, xAxis: 15),
//               DataPoint<double>(value: 75, xAxis: 20),
//               DataPoint<double>(value: 0, xAxis: 25),
//               DataPoint<double>(value: 5, xAxis: 30),
//               DataPoint<double>(value: 45, xAxis: 35),
//             ],
//           ),
//         ],
//         config: BezierChartConfig(
//           verticalIndicatorStrokeWidth: 3.0,
//           verticalIndicatorColor: Colors.black26,
//           showVerticalIndicator: true,
//           backgroundColor: Colors.red,
//           snap: false,
//         ),
//       ),
//     ),
//   );
// }

// Widget sample2(BuildContext context) {
//   return Center(
//     child: Container(
//       color: Colors.red,
//       height: MediaQuery.of(context).size.height / 2,
//       width: MediaQuery.of(context).size.width,
//       child: BezierChart(
//         bezierChartScale: BezierChartScale.CUSTOM,
//         xAxisCustomValues: const [0, 3, 10, 15, 20, 25, 30, 35],
//         series: const [
//           BezierLine(
//             label: "Custom 1",
//             data: const [
//               DataPoint<double>(value: 10, xAxis: 0),
//               DataPoint<double>(value: 130, xAxis: 5),
//               DataPoint<double>(value: 50, xAxis: 10),
//               DataPoint<double>(value: 150, xAxis: 15),
//               DataPoint<double>(value: 75, xAxis: 20),
//               DataPoint<double>(value: 0, xAxis: 25),
//               DataPoint<double>(value: 5, xAxis: 30),
//               DataPoint<double>(value: 45, xAxis: 35),
//             ],
//           ),
//           BezierLine(
//             lineColor: Colors.blue,
//             lineStrokeWidth: 2.0,
//             label: "Custom 2",
//             data: const [
//               DataPoint<double>(value: 5, xAxis: 0),
//               DataPoint<double>(value: 50, xAxis: 5),
//               DataPoint<double>(value: 30, xAxis: 10),
//               DataPoint<double>(value: 30, xAxis: 15),
//               DataPoint<double>(value: 50, xAxis: 20),
//               DataPoint<double>(value: 40, xAxis: 25),
//               DataPoint<double>(value: 10, xAxis: 30),
//               DataPoint<double>(value: 30, xAxis: 35),
//             ],
//           ),
//           BezierLine(
//             lineColor: Colors.black,
//             lineStrokeWidth: 2.0,
//             label: "Custom 3",
//             data: const [
//               DataPoint<double>(value: 5, xAxis: 0),
//               DataPoint<double>(value: 10, xAxis: 5),
//               DataPoint<double>(value: 35, xAxis: 10),
//               DataPoint<double>(value: 40, xAxis: 15),
//               DataPoint<double>(value: 40, xAxis: 20),
//               DataPoint<double>(value: 40, xAxis: 25),
//               DataPoint<double>(value: 9, xAxis: 30),
//               DataPoint<double>(value: 11, xAxis: 35),
//             ],
//           ),
//         ],
//         config: BezierChartConfig(
//           verticalIndicatorStrokeWidth: 2.0,
//           verticalIndicatorColor: Colors.black12,
//           showVerticalIndicator: true,
//           contentWidth: MediaQuery.of(context).size.width * 2,
//           backgroundColor: Colors.red,
//         ),
//       ),
//     ),
//   );
// }
}
