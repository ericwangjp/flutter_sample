import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/circle_gradient_progress_indicator.dart';

class CustomGaugeChart extends StatefulWidget {
  const CustomGaugeChart({Key? key}) : super(key: key);

  @override
  State<CustomGaugeChart> createState() => _CustomGaugeChartState();
}

class _CustomGaugeChartState extends State<CustomGaugeChart> {
  double progress = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          CircleGradientProgressIndicator(
            colors: const [Colors.blue, Colors.green, Colors.yellow],
            radius: 100.0,
            strokeWidth: 20.0,
            gapWidth: 4,
            animationDuration: 1000,
            totalAngle: pi,
            strokeCapRound: true,
            backgroundColor: Colors.white,
            progressAngle: progress,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  progress = Random().nextDouble();
                });
              },
              child: const Text('刷新'))
        ],
      ),
    );
  }
}
