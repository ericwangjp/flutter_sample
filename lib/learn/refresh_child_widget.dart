import 'package:flutter/material.dart';

class RefreshChildWidget extends StatefulWidget {
   RefreshChildWidget({Key? key, this.showText = 1}) : super(key: key){debugPrint('构造方法执行了');}

  final int showText;

  @override
  State<RefreshChildWidget> createState() => _RefreshChildWidgetState();
}

class _RefreshChildWidgetState extends State<RefreshChildWidget> {
  String _text = '';

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant RefreshChildWidget oldWidget) {
    debugPrint('didUpdateWidget');
    switch (widget.showText) {
      case 1:
        _text = '第1个';
        break;
      case 2:
        _text = '第2个';
        break;
      case 3:
        _text = '第3个';
        break;
      default:
        _text = '3以后第${widget.showText}个';
        break;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('传递过来的原始值：${widget.showText}');
    debugPrint('处理后值：$_text');
    return Text('当前值为：$_text', textScaleFactor: 2.0);
  }
}
