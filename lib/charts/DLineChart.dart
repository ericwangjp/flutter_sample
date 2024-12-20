import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class DLineChartWidget extends StatefulWidget {
  const DLineChartWidget({Key? key}) : super(key: key);

  @override
  State<DLineChartWidget> createState() => _DLineChartState();
}

class _DLineChartState extends State<DLineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartLine(
        data: const [
          {
            'id': 'Line',
            'data': [
              {'domain': 0, 'measure': 4.1},
              {'domain': 2, 'measure': 4},
              {'domain': 3, 'measure': 6},
              {'domain': 4, 'measure': 1},
              {'domain': 5, 'measure': 3},
              {'domain': 6, 'measure': 3.5},
            ],
          },
        ],
        lineColor: (lineData, index, id) => Colors.amber,
        includePoints: true,
        includeArea: true,
        animate: true,
        // areaColor: (lineData, index, id) {
        //   return Colors.red.shade500;
        // },
      ),
    );
  }
}
