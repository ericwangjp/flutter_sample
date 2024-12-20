import 'package:flutter/material.dart';
import 'package:flutter_echart/flutter_echart.dart';

class EChartPieWidget extends StatefulWidget {
  const EChartPieWidget({Key? key}) : super(key: key);

  @override
  State<EChartPieWidget> createState() => _EChartPieWidgetState();
}

class _EChartPieWidgetState extends State<EChartPieWidget> {
  final List<EChartPieBean> _dataList = [
    EChartPieBean(title: "生活费", number: 200, color: Colors.lightBlueAccent),
    EChartPieBean(title: "游玩费", number: 200, color: Colors.deepOrangeAccent),
    EChartPieBean(title: "交通费", number: 400, color: Colors.green),
    EChartPieBean(title: "贷款费", number: 300, color: Colors.amber),
    EChartPieBean(title: "电话费", number: 200, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 300,
        child: buildPieChatWidget());
  }

  PieChatWidget buildPieChatWidget() {
    return PieChatWidget(
      dataList: _dataList,
      //是否输出日志
      isLog: true,
      //是否需要背景
      isBackground: true,
      //是否画直线
      isLineText: true,
      //背景
      bgColor: Colors.white,
      //是否显示最前面的内容
      isFrontgText: true,
      //默认选择放大的块
      initSelect: 1,
      //初次显示以动画方式展开
      openType: OpenType.ANI,
      //旋转类型
      loopType: LoopType.DOWN_LOOP,
      //点击回调
      clickCallBack: (int value) {
        print("当前点击显示 $value");
      },
    );
  }
}
