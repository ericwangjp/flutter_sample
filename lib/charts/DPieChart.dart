import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class DPieChartWidget extends StatefulWidget {
  const DPieChartWidget({Key? key}) : super(key: key);

  @override
  State<DPieChartWidget> createState() => _DPieChartWidgetState();
}

class _DPieChartWidgetState extends State<DPieChartWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartPie(
        animate: true,
        data: const [
          {'domain': 'Flutter', 'measure': 28},
          {'domain': 'React Native', 'measure': 27},
          {'domain': 'Ionic', 'measure': 30},
          {'domain': 'Cordova', 'measure': 15},
        ],
        fillColor: (pieData, index) {
          switch (index) {
            case 0:
              return const Color(0xff0293ee);
            case 1:
              return const Color(0xfff8b250);
            case 2:
              return const Color(0xff13d38e);
            default:
              return Colors.purple;
          }
        },
        donutWidth: 35,
        // labelColor: Colors.white,
        // showLabelLine: true,
        pieLabel: (pieData,index){
          switch (index){
            case 0:
              return '不推荐：24个\n50%';
            case 1:
              return '推荐：12个\n25%';
            case 2:
              return '正常：12个\n25%';
          }
          return '展示标签';
        },
      ),
    );
  }
}
