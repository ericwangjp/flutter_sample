import 'package:flutter/material.dart';
import 'package:flutter_sample/learn/refresh_child_widget.dart';

class RefreshParentWidget extends StatefulWidget {
  const RefreshParentWidget({Key? key}) : super(key: key);

  @override
  State<RefreshParentWidget> createState() => _RefreshParentWidgetState();
}

class _RefreshParentWidgetState extends State<RefreshParentWidget> {
  int showNum = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RefreshChildWidget(showText: showNum),
        ElevatedButton(
            onPressed: () {
              showNum++;
              setState(() {});
            },
            child: const Text('刷新内容', textScaleFactor: 2.0))
      ],
    );
  }
}
