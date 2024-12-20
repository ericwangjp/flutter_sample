import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

class BrunoPieChartWidget extends StatefulWidget {
  const BrunoPieChartWidget({Key? key}) : super(key: key);

  @override
  State<BrunoPieChartWidget> createState() => _BrunoPieChartWidgetState();
}

class _BrunoPieChartWidgetState extends State<BrunoPieChartWidget> {
  List<BrnDoughnutDataItem> dataList = [
    BrnDoughnutDataItem(value: 2, title: '销售一', color: Colors.orange),
    BrnDoughnutDataItem(value: 3, title: '销售二', color: Colors.purple),
    BrnDoughnutDataItem(value: 2, title: '销售三', color: Colors.blue),
    BrnDoughnutDataItem(value: 2, title: '销售四', color: Colors.teal),
    BrnDoughnutDataItem(value: 1, title: '销售五', color: Colors.deepOrange),
  ];
  BrnDoughnutDataItem? selectedItem;
  int count = 0;

  @override
  void initState() {
    count = dataList.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BrnDoughnutChart(
          padding: const EdgeInsets.all(40),
          width: 220,
          height: 220,
          ringWidth: 40,
          data: dataList,
          selectedItem: selectedItem,
          showTitleWhenSelected: false,
          selectCallback: (BrnDoughnutDataItem? selectedItem) {
            setState(() {
              this.selectedItem = selectedItem;
            });
          },
        ),
        DoughnutChartLegend(
            data: dataList, legendStyle: BrnDoughnutChartLegendStyle.wrap),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('数据个数'),
            ),
            Expanded(
              child: Slider(
                  value: count.toDouble(),
                  divisions: 10,
                  onChanged: (data) {
                    setState(() {
                      count = data.toInt();
                      dataList.clear();
                      for (int i = 0; i < count; i++) {
                        dataList.add(BrnDoughnutDataItem(
                            title: '示例',
                            value: Random.secure()
                                .nextInt(5)
                                .clamp(1, 5)
                                .toDouble(),
                            color: getColorWithIndex(i)));
                      }
                    });
                  },
                  onChangeStart: (data) {},
                  onChangeEnd: (data) {},
                  min: 1,
                  max: 10,
                  label: '$count',
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}}';
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Color getColorWithIndex(int i) {
    switch (i) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.pink;
      case 2:
        return Colors.green;
      case 3:
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}
