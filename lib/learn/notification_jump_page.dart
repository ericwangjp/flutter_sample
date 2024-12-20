import 'package:flutter/material.dart';
import 'package:flutter_sample/constants/project_consts.dart';

class NotificationJumpPage extends StatefulWidget {
  const NotificationJumpPage({Key? key, this.payload}) : super(key: key);

  final String? payload;

  @override
  State<NotificationJumpPage> createState() => _NotificationJumpPageState();
}

class _NotificationJumpPageState extends State<NotificationJumpPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('可见性2：$isVisible');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("通知跳转页"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(widget.payload ?? '默认展示信息', textScaleFactor: 2.0),
            ElevatedButton(
                onPressed: () {
                  isVisible = false;
                },
                child: const Text('修改全局变量'))
          ],
        ),
      ),
    );
  }
}
