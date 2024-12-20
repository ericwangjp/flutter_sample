import 'package:flutter/material.dart';

class GuideWidgetPage extends StatefulWidget {
  const GuideWidgetPage({Key? key}) : super(key: key);

  @override
  State<GuideWidgetPage> createState() => _GuideWidgetPageState();
}

class _GuideWidgetPageState extends State<GuideWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // 拦截手机返回键
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.black45,
          child: Column(
            children: const [Spacer(), Text('通过跳转页面实现的新手引导'),Spacer()],
          ),
        ),
      ),
    );
  }
}
