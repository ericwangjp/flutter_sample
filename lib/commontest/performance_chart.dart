import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter",
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
  List<Color> gradientColors = [const Color(0xFF43E09E), Colors.white24];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("业绩图表"),
      ),
      body: Column(
        children: [
          const Text('业绩趋势图表',textScaleFactor: 1.2,),
          AspectRatio(
            aspectRatio: 1.70,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 24,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child: LineChart(
                curveLineChartData,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black45);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('1', style: style);
        break;
      case 2:
        text = const Text('7', style: style);
        break;
      case 4:
        text = const Text('13', style: style);
        break;
      case 6:
        text = const Text('19', style: style);
        break;
      case 8:
        text = const Text('25', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black45);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0%';
        break;
      case 1:
        text = '50%';
        break;
      case 2:
        text = '100%';
        break;
      case 3:
        text = '150%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData get curveLineChartData => LineChartData(
        lineTouchData: LineTouchData(
          touchSpotThreshold: 50,
            touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots
                      .map((e) => LineTooltipItem(
                          e.y.toString(),
                          const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)))
                      .toList();
                },
                tooltipBgColor: Colors.black54,
                tooltipMargin: 10,
                tooltipPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                showOnTopOfTheChartBoxArea: true,
                fitInsideVertically: true,
                fitInsideHorizontally: true),
            getTouchedSpotIndicator:
                (LineChartBarData barData, List<int> spotIndexes) {
              return spotIndexes
                  .map((e) => TouchedSpotIndicatorData(
                      FlLine(
                        color: const Color(0xFF13D081),
                        strokeWidth: 2,
                      ),
                      FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            // FlDotPainter
                            return FlDotCirclePainter(
                                color: const Color(0xFF13D081),
                                radius: 5,
                                strokeWidth: 0,
                                strokeColor: Colors.white);
                          })))
                  .toList();
            }),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.black26,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.black45,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
              bottom: BorderSide(
            color: Colors.black38,
            width: 1.0,
            style: BorderStyle.solid,
          ),top: BorderSide(
            color: Colors.black38,
            width: 1.0,
            style: BorderStyle.solid,
          )),
        ),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 3,
        lineBarsData: [curveLineChartBarData, lineChartBarData],
      );

  LineChartBarData get curveLineChartBarData => LineChartBarData(
        spots: const [
          FlSpot(0, 1.2),
          FlSpot(2.6, 2),
          FlSpot(4.9, 2.5),
          FlSpot(6.8, 1.1),
          FlSpot(8, 2.4),
          FlSpot(9.5, 2.9),
          FlSpot(11, 1.4),
        ],
        isCurved: true,
        color: const Color(0xFF43E09E),
        // gradient: LinearGradient(
        //   colors: gradientColors,
        // ),
        barWidth: 2,
        isStrokeCapRound: true,
        isStrokeJoinRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      );

  LineChartBarData get lineChartBarData => LineChartBarData(
        isCurved: false,
        curveSmoothness: 0,
        color: const Color(0xFFFF9E1F),
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0, 0.1),
          // FlSpot(1.5, 1.5),
          // FlSpot(2, 2),
          // FlSpot(2.5, 2.5),
          // FlSpot(3, 3),
          FlSpot(11, 2.8),
        ],
      );
}
