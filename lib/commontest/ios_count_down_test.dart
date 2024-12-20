import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/date_util.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter",
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
  Timer? _counterTimer;
  ValueNotifier<int> _curCountTime = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    if (_counterTimer?.isActive == true) {
      _counterTimer?.cancel();
      _counterTimer = null;
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("倒计时"),
      ),
      body: Column(
        children: [
          const Text('计时', textScaleFactor: 1.2),
          ValueListenableBuilder(
              valueListenable: _curCountTime,
              builder: (BuildContext context, int value, Widget? child) {
                return Text(DateUtil.second2HMS(value), textScaleFactor: 1.2);
              }),
          ElevatedButton(
              onPressed: () {
                _curCountTime.value = Random().nextInt(100);
              },
              child: const Text('随机计时', textScaleFactor: 1.2))
        ],
      ),
    );
  }

  void _startTimer() {
    // DateTime startTime = DateTime.now().subtract( Duration(minutes: 10, seconds: Random.secure().nextInt(30)));
    if (_counterTimer?.isActive == true) {
      _counterTimer?.cancel();
      _counterTimer = null;
    }

    DateTime? startDateTime = DateUtil.formatStringToDate(
        DateUtil.dateFormatLineYYYYMMDDDotHHMMSS, '2023-10-31 11:31:44');

    debugPrint('fqy-开启定时器');
    _counterTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _curCountTime.value =
          DateUtil.getDateDifference(startDateTime!, DateTime.now())
              .inSeconds;
    });
  }
}
