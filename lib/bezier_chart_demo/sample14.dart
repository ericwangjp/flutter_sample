import 'package:flutter/material.dart';
import 'package:flutter_sample/bezier_chart/bezier_chart.dart';
import 'package:intl/intl.dart' as intl;

class Sample14 extends StatefulWidget {
  @override
  _Sample14State createState() => _Sample14State();
}

class _Sample14State extends State<Sample14> {
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
    fromDate = DateTime(2019, 09, 1);
    toDate = DateTime(2019, 09, 30);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic date range"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.today),
              onPressed: () {
                setState(() {
                  fromDate = DateTime(2019, 07, 20);
                });
              }),
          IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                setState(() {
                  fromDate = DateTime(2019, 08, 1);
                });
              }),
        ],
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white10,
                Colors.white38,
                Colors.white54,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          // height: MediaQuery.of(context).size.height,
          height: 375,
          width: MediaQuery.of(context).size.width,
          child: BezierChart(
            fromDate: fromDate,
            bezierChartScale: BezierChartScale.WEEKLY,
            toDate: toDate,
            onIndicatorVisible: (val) {
              print("Indicator Visible :$val");
            },
            onDateTimeSelected: (datetime) {
              print("selected datetime: $datetime");
            },
            selectedDate: toDate,
            //this is optional
            footerDateTimeBuilder:
                (DateTime value, BezierChartScale? scaleType) {
              final newFormat = intl.DateFormat('MM.dd');
              return newFormat.format(value);
            },
            bubbleLabelDateTimeBuilder:
                (DateTime value, BezierChartScale? scaleType) {
              final newFormat = intl.DateFormat('EEE d');
              return "${newFormat.format(value)}\n";
            },
            series: [
              BezierLine(
                // label: "Duty",
                lineColor: Colors.green,
                dataPointFillColor: Colors.white,
                dataPointStrokeColor: Colors.green,
                onMissingValue: (dateTime) {
                  return 0;
                },
                data: <DataPoint<DateTime>>[
                  DataPoint<DateTime>(
                      value: 3235.9, xAxis: DateTime(2019, 9, 14)),
                  DataPoint<DateTime>(
                      value: 0, xAxis: DateTime(2019, 9, 20)),
                  DataPoint<DateTime>(
                      value: 2340.5, xAxis: DateTime(2019, 9, 25)),
                  DataPoint<DateTime>(
                      value: 2115.21, xAxis: DateTime(2019, 9, 26)),
                  DataPoint<DateTime>(
                      value: 3120.5, xAxis: DateTime(2019, 9, 27)),
                  DataPoint<DateTime>(
                      value: 3235.9, xAxis: DateTime(2019, 9, 30)),
                ],
              ),
            ],
            config: BezierChartConfig(
                updatePositionOnTap: true,
                contentWidth: 10,
                bubbleIndicatorValueFormat:
                    intl.NumberFormat("###,##0.00", "en_US"),
                verticalIndicatorStrokeWidth: 1.0,
                verticalIndicatorColor: Colors.green,
                showVerticalIndicator: true,
                verticalIndicatorFixedPosition: false,
                backgroundColor: Colors.transparent,
                footerHeight: 40.0,
                selectedPointStrokeWidth: 4,
                showDataPoints: false,
                bubbleIndicatorColor: Colors.green,
                yAxisTextStyle: TextStyle(color: Colors.black38),
                xAxisTextStyle: TextStyle(color: Colors.black),
                areaGradientColors: [
                  Colors.orange.withOpacity(0.8),
                  Colors.green.withOpacity(0.5)
                ],
                displayYAxis: true),
          ),

          // child: BezierChart(
          //   bezierChartScale: BezierChartScale.CUSTOM,
          //   selectedValue: 45,
          //   xAxisCustomValues: const [
          //     0,
          //     5,
          //     10,
          //     15,
          //     20,
          //     25,
          //     30,
          //     35,
          //     40,
          //     45,
          //     50,
          //     55,
          //     60,
          //     65,
          //     70
          //   ],
          //   series: const [
          //     BezierLine(
          //       data: [
          //         DataPoint<double>(value: 10, xAxis: 0),
          //         DataPoint<double>(value: 130, xAxis: 5),
          //         DataPoint<double>(value: 50, xAxis: 10),
          //         DataPoint<double>(value: 150, xAxis: 15),
          //         DataPoint<double>(value: 75, xAxis: 20),
          //         DataPoint<double>(value: 0, xAxis: 25),
          //         DataPoint<double>(value: 5, xAxis: 30),
          //         DataPoint<double>(value: 45, xAxis: 35),
          //         DataPoint<double>(value: 25, xAxis: 40),
          //         DataPoint<double>(value: 90, xAxis: 45),
          //         DataPoint<double>(value: 40, xAxis: 50),
          //         DataPoint<double>(value: 100, xAxis: 55),
          //         DataPoint<double>(value: 65, xAxis: 60),
          //         DataPoint<double>(value: 55, xAxis: 65),
          //         DataPoint<double>(value: 85, xAxis: 70),
          //       ],
          //       lineColor: Colors.green,
          //       label: ''
          //     ),
          //   ],
          //   config: BezierChartConfig(
          //       updatePositionOnTap: true,
          //       verticalIndicatorStrokeWidth: 1.0,
          //       verticalIndicatorColor: Colors.black26,
          //       showVerticalIndicator: true,
          //       backgroundColor: Colors.transparent,
          //       verticalIndicatorFixedPosition: false,
          //       displayYAxis: true,
          //       snap: true,
          //       bubbleIndicatorColor: Colors.green,
          //       areaGradientColors: [
          //         Colors.orange.withOpacity(0.8),
          //         Colors.green.withOpacity(0.5)
          //       ],
          //       // pinchZoom: true,
          //       contentWidth: 1000,
          //       stepsYAxis: 30,
          //       yAxisTextStyle: TextStyle(color: Colors.black38),
          //       xAxisTextStyle: TextStyle(color: Colors.black)),
          // ),
        ),
      ),
    );
  }
}
