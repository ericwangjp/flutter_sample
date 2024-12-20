import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TransitionLineChartWidget extends StatefulWidget {
  const TransitionLineChartWidget({Key? key}) : super(key: key);

  @override
  State<TransitionLineChartWidget> createState() =>
      _TransitionLineChartWidgetState();
}

class _TransitionLineChartWidgetState extends State<TransitionLineChartWidget> {
  var baselineX = 0.0;
  var baselineY = 0.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: Slider(
                    value: baselineY,
                    onChanged: (newValue) {
                      setState(() {
                        baselineY = newValue;
                      });
                    },
                    min: -10,
                    max: 10,
                  ),
                ),
                SizedBox(
                  width: 320,
                  child: Chart(baselineX, (20 - (baselineY + 10)) - 10),
                )
              ],
            ),
          ),
          SizedBox(
            child: Slider(
              value: baselineX,
              onChanged: (newValue) {
                setState(() {
                  baselineX = newValue;
                });
              },
              min: -10,
              max: 10,
            ),
          )
        ],
      ),
    );
  }
}

class Chart extends StatelessWidget {
  final double baselineX;
  final double baselineY;

  const Chart(this.baselineX, this.baselineY) : super();

  TextStyle getHorizontalTextStyle(context, value) {
    if ((value - baselineX).abs() <= 0.1) {
      return const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    } else {
      return const TextStyle(color: Colors.white60, fontSize: 14);
    }
  }

  TextStyle getVerticalTextStyle(context, value) {
    if ((value - baselineY).abs() <= 0.1) {
      return const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    } else {
      return const TextStyle(color: Colors.white60, fontSize: 14);
    }
  }

  FlLine getHorizontalVerticalLine(double value) {
    if ((value - baselineY).abs() <= 0.1) {
      return FlLine(
        color: Colors.white70,
        strokeWidth: 1,
        dashArray: [8, 4],
      );
    } else {
      return FlLine(
        color: Colors.blueGrey,
        strokeWidth: 0.4,
        dashArray: [8, 4],
      );
    }
  }

  FlLine getVerticalVerticalLine(double value) {
    if ((value - baselineX).abs() <= 0.1) {
      return FlLine(
        color: Colors.white70,
        strokeWidth: 1,
        dashArray: [8, 4],
      );
    } else {
      return FlLine(
        color: Colors.blueGrey,
        strokeWidth: 0.4,
        dashArray: [8, 4],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [],
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                '左边标题',
                style: getVerticalTextStyle(context, value),
              );
            },
            reservedSize: 40,
          )),
          topTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                '顶部标题',
                style: getHorizontalTextStyle(context, value),
              );
            },
          )),
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                '右边标题',
                style: getVerticalTextStyle(context, value),
              );
            },
            reservedSize: 40,
          )),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                '底部标题',
                style: getHorizontalTextStyle(context, value),
              );
            },
          )),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: getHorizontalVerticalLine,
          getDrawingVerticalLine: getVerticalVerticalLine,
        ),
        minY: -10,
        maxY: 10,
        baselineY: baselineY,
        minX: -10,
        maxX: 10,
        baselineX: baselineX,
      ),
      swapAnimationDuration: Duration.zero,
    );
  }
}
