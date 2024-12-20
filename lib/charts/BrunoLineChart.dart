import 'dart:convert';
import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

import '../model/DBDataNodeModel.dart';

class BrunoLineChartWidget extends StatefulWidget {
  const BrunoLineChartWidget({Key? key}) : super(key: key);

  @override
  State<BrunoLineChartWidget> createState() => _BrunoLineChartWidgetState();
}

class _BrunoLineChartWidgetState extends State<BrunoLineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return _brokenLineDemo1(
        context,
        List.generate(20, (index) {
          return DBDataNodeModel.fromJson(json.decode(
              '{"name":"${index + 1}月","value":"${(Random.secure().nextDouble() * 10).toStringAsFixed(2)}"}'));
        }));
  }

  Widget _brokenLineDemo1(context, List<DBDataNodeModel> brokenData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        BrnBrokenLine(
          showPointDashLine: true,
          yHintLineOffset: 30,
          isTipWindowAutoDismiss: false,
          lines: [
            BrnPointsLine(
              isShowPointText: true,
              isShowXDial: true,
              lineWidth: 3,
              pointRadius: 4,
              isShowPoint: false,
              isCurve: true,
              points: _linePointsForDemo1(brokenData),
              shaderColors: [
                Colors.green.withOpacity(0.3),
                Colors.green.withOpacity(0.01)
              ],
              lineColor: Colors.green,
            )
          ],
          // size: Size(MediaQuery.of(context).size.width * 1 - 100 * 2,
          //     MediaQuery.of(context).size.height / 5 * 1.6 - 20 * 2),
          size: Size(brokenData.length * 30,
              MediaQuery.of(context).size.height / 5 * 1.8 - 20 * 2),
          xDialValues: _getXDialValuesForDemo1(brokenData),
          xDialMin: 0,
          xDialMax: _getXDialValuesForDemo1(brokenData).length.toDouble(),
          yDialValues: _getYDialValuesForDemo1(brokenData),
          yDialMin: _getMinValueForDemo1(brokenData),
          yDialMax: _getMaxValueForDemo1(brokenData),
          isHintLineSolid: false,
          isShowYDialText: true,
          isShowXDial: true,
          isShowXHintLine: false,
          isShowYHintLine: false,
        ),
      ],
    );
  }

  List<BrnPointData> _linePointsForDemo1(List<DBDataNodeModel> brokenData) {
    return brokenData
        .map((_) => BrnPointData(
            pointText: _.value,
            x: brokenData.indexOf(_).toDouble(),
            y: double.parse(_.value ?? '0'),
            lineTouchData: BrnLineTouchData(
                tipWindowSize: const Size(60, 40),
                onTouch: () {
                  return _.value;
                })))
        .toList();
  }

  List<BrnDialItem> _getYDialValuesForDemo1(List<DBDataNodeModel> brokenData) {
    double min = _getMinValueForDemo1(brokenData);
    double max = _getMaxValueForDemo1(brokenData);
    double dValue = (max - min) / 10;
    List<BrnDialItem> yDialValue = [];
    for (int index = 0; index <= 10; index++) {
      yDialValue.add(BrnDialItem(
        dialText: '${(min + index * dValue).ceil()}',
        dialTextStyle:
            const TextStyle(fontSize: 12.0, color: Color(0xFF999999)),
        value: (min + index * dValue).ceilToDouble(),
      ));
    }
    yDialValue.add(BrnDialItem(
      dialText: '4.5',
      dialTextStyle: const TextStyle(fontSize: 12.0, color: Color(0xFF999999)),
      value: 4.5,
    ));
    return yDialValue;
  }

  double _getMinValueForDemo1(List<DBDataNodeModel> brokenData) {
    double minValue = double.tryParse(brokenData[0].value ?? '0') ?? 0;
    for (DBDataNodeModel point in brokenData) {
      minValue = min(double.tryParse(point.value ?? '0') ?? 0, minValue);
    }
    return minValue;
  }

  double _getMaxValueForDemo1(List<DBDataNodeModel> brokenData) {
    double maxValue = double.tryParse(brokenData[0].value ?? '0') ?? 0;
    for (DBDataNodeModel point in brokenData) {
      maxValue = max(double.tryParse(point.value ?? '0') ?? 0, maxValue);
    }
    return maxValue;
  }

  List<BrnDialItem> _getXDialValuesForDemo1(List<DBDataNodeModel> brokenData) {
    List<BrnDialItem> xDialValue = [];
    for (int index = 0; index < brokenData.length; index++) {
      xDialValue.add(BrnDialItem(
        dialText: brokenData[index].name,
        dialTextStyle:
            const TextStyle(fontSize: 12.0, color: Color(0xFF999999)),
        value: index.toDouble(),
      ));
    }
    return xDialValue;
  }
}
