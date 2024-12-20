import 'package:flutter/material.dart';
import 'package:flutter_sample/commontest/list_animate_2.dart';
import 'package:flutter_sample/commontest/list_animate_3.dart';

import 'list_animate_1.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "列表动画",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 列表动画"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AnimateListOnePage();
                }));
              },
              child: const Text('动画列表效果1')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AnimateListTwoPage();
                }));
              },
              child: const Text('动画列表效果2')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AnimateListThreePage();
                }));
              },
              child: const Text('动画列表效果3'))
        ],
      ),
    );
  }

  void _aa(){
    setState(() {
    //                                                 SchedulerBinding      SchedulerBinding   SchedulerBinding
    //  onBuildScheduled -》 _handleBuildScheduled -》 ensureVisualUpdate -> scheduleFrame -> ensureFrameCallbacksRegistered     |->   _handleBeginFrame、_handleDrawFrame
    //                                                                                                        |
    //                                                                                        platformDispatcher.scheduleFrame()
    //                                                                                                        |
    //                                                                                        SchedulerBinding.handleDrawFrame()
    //                                                                                                         | (处理注册的监听进行回调)
    //                                                                                        WidgetsBinding.drawFrame
    });
  }
}
