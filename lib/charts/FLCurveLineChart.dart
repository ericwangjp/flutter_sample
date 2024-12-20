import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FLCurveLineChart extends StatefulWidget {
  const FLCurveLineChart({Key? key}) : super(key: key);

  @override
  State<FLCurveLineChart> createState() => _FLCurveLineChartState();
}

class _FLCurveLineChartState extends State<FLCurveLineChart> {
  List<Color> gradientColors = [
    const Color(0xFF44E09D),
    const Color(0xFF81F2C3),
    Colors.white
  ];

  List<FlSpot> get allSpots => const [
        FlSpot(1, 3),
        FlSpot(2, 2),
        FlSpot(3, 0),
        FlSpot(4, 5),
        FlSpot(5, 3.1),
        FlSpot(6, 4.3),
        FlSpot(7, 4),
      ];

  List<int> showIndexes = [];

  // int touchedIndex = 0;
  // bool touchingGraph = true;

  @override
  void initState() {
    showIndexes.clear();
    showIndexes.add(allSpots.length - 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        show: true,
        showingIndicators: showIndexes,
        spots: allSpots,
        isCurved: true,
        color: const Color(0xFF13D081),
        // gradient: LinearGradient(
        //   colors: gradientColors,
        // ),
        preventCurveOverShooting: true,
        preventCurveOvershootingThreshold: 1,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ),
    ];
    return LineChart(LineChartData(
      // minX: 0,
      // maxX: 12,
      // minY: 0,
      // maxY: 6,
      // baselineX: 5,
      lineBarsData: lineBarsData,
      showingTooltipIndicators: showIndexes
          .map((index) => ShowingTooltipIndicators([
                LineBarSpot(
                  lineBarsData[0],
                  lineBarsData.indexOf(lineBarsData[0]),
                  lineBarsData[0].spots[index],
                ),
              ]))
          .toList(),
      lineTouchData: LineTouchData(
          handleBuiltInTouches: false,
          // enabled: false,
          // longPressDuration: Duration.zero,
          touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                // LineTooltipItem
                return touchedSpots
                    .map((e) => null
                        // LineTooltipItem(
                        //     e.y.toString(),
                        //     const TextStyle(
                        //         color: Colors.black87,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w700))
                        )
                    .toList();
              },
              tooltipBgColor: const Color(0xFF13D081),
              tooltipRoundedRadius: 20,
              tooltipPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
              fitInsideHorizontally: true),
          // 选中点线宽设置
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes
                .map((e) => TouchedSpotIndicatorData(
                    FlLine(
                      color: const Color(0xFF13D081),
                      strokeWidth: 30,
                      // dashArray: [
                      //   6,
                      //   2,
                      // ]
                    ),
                    FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          // FlDotPainter
                          return FlDotCirclePainter(
                              color: const Color(0xFF13D081),
                              radius: 5,
                              strokeWidth: 3,
                              strokeColor: Colors.white);
                        })))
                .toList();
          },
          touchCallback:
              (FlTouchEvent event, LineTouchResponse? touchResponse) {
            debugPrint('监听到事件类型:$event- ${touchResponse == null}');
            if (touchResponse == null || touchResponse.lineBarSpots == null) {
              return;
            }
            if (event is FlTapUpEvent || event is FlPanEndEvent) {
              debugPrint('点击位置:${touchResponse.lineBarSpots!.first.spotIndex}');
              int touchedIndex = touchResponse.lineBarSpots!.first.spotIndex;
              setState(() {
                if (showIndexes.contains(touchedIndex)) {
                  showIndexes.clear();
                } else {
                  showIndexes = [touchedIndex];
                }
              });
            }
          }),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xffEEEEEE),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
              color: const Color(0xffEEEEEE),
              strokeWidth: 1,
              dashArray: [
                6,
                2,
              ]);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              // reservedSize: 30,
              interval: 1,
              getTitlesWidget: topTitleWidgets),
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
            interval: _getYAxisInterval(),
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 40,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
    ));
  }

  double? _getXAxisInterval() {
    double dataInterval = 1;
    if (allSpots.isNotEmpty) {
      dataInterval = allSpots.last.x - allSpots.first.x;
    }
    return dataInterval / 2 + 1;
  }

  double? _getYAxisInterval() {
    double dataInterval = 1;
    if (allSpots.isNotEmpty) {
      var smallestValue = allSpots
          .reduce((current, next) => current.y < next.y ? current : next);
      var largestValue = allSpots
          .reduce((current, next) => current.y > next.y ? current : next);
      dataInterval = largestValue.y - smallestValue.y;
    }
    return dataInterval / 2 + 1;
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    int curIndex = allSpots.indexWhere((element) => element.x == value);
    int selectedIndex = -1;
    if (showIndexes.isNotEmpty) {
      selectedIndex = showIndexes[0];
    }
    var style = TextStyle(
      color: curIndex == selectedIndex ? Colors.green : Colors.black54,
      fontWeight: FontWeight.w700,
      fontSize: 12,
    );
    Widget text = Text(
      '${allSpots.firstWhere((element) => element.x == value).y}',
      style: style,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int curIndex = allSpots.indexWhere((element) => element.x == value);
    int selectedIndex = -1;
    if (showIndexes.isNotEmpty) {
      selectedIndex = showIndexes[0];
    }
    var style = TextStyle(
      color: Colors.black87,
      fontWeight: curIndex == selectedIndex ? FontWeight.w700 :FontWeight.w400,
      fontSize: 12,
    );
    Widget text = Text(
      '${value.toInt()}月',
      style: style,
    );
    // switch (value.toInt()) {
    //   case 0:
    //     text = Text('1.1', style: style);
    //     break;
    //   case 3:
    //     text = Text('1.7', style: style);
    //     break;
    //   case 5:
    //     text = Text('1.15', style: style);
    //     break;
    //   case 7:
    //     text = Text('1.21', style: style);
    //     break;
    //   case 11:
    //     text = Text('1.31', style: style);
    //     break;
    //   default:
    //     text = Text('', style: style);
    //     break;
    // }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: Colors.black.withOpacity(0.3),
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );
    return Text('$value', style: style, textAlign: TextAlign.left);
  }
}
