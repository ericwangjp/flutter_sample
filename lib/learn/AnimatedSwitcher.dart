import 'dart:async';
import 'dart:math';

import 'package:animated_digit/animated_digit.dart';
import 'package:animated_number/animated_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/slide_transition_x.dart';

import '../ui/animate_number_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "动画切换组件",
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
        title: const Text("flutter animated switcher"),
      ),
      body: const SingleChildScrollView(
        child: AnimatedSwitcherCounterWidget(),
      ),
    );
  }
}

class AnimatedSwitcherCounterWidget extends StatefulWidget {
  const AnimatedSwitcherCounterWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitcherCounterWidget> createState() =>
      _AnimatedSwitcherCounterWidgetState();
}

class _AnimatedSwitcherCounterWidgetState
    extends State<AnimatedSwitcherCounterWidget>
    with SingleTickerProviderStateMixin {
  int _count = 0;
  late Timer _timer;

  //随机颜色
  Color get _randomColor => Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        1,
      );
  double _value = 123;
  final AnimatedDigitController _numController =
      AnimatedDigitController(12340.22);
  double _endValue = 1230.05;
  final AnimatedDigitController _controller = AnimatedDigitController(0.00);
  bool _first = true;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // setState(() {
      //   _count += 1;
      // });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _numController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedCrossFade(
              firstChild: Container(
                  color: Colors.amber,
                  width: 200,
                  height: 200,
                  child: const Text('firstChild')),
              secondChild: Container(
                  color: Colors.blue,
                  width: 200,
                  height: 200,
                  child: const Text('secondChild')),
              crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(seconds: 2)),
          ElevatedButton(onPressed: () {
            setState(() {
              _first = !_first;
            });
          }, child: const Text('切换')),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              debugPrint('animation: ${animation.value}');
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
            child: Text(
              "$_count",
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _startUpdate();
              },
              child: const Text("增加")),
          // AnimatedSwitcher(
          //   duration: const Duration(milliseconds: 300),
          //   transitionBuilder: (Widget child, Animation<double> animation) {
          //     var tween = Tween<Offset>(
          //         begin: const Offset(1, 0), end: const Offset(0, 0));
          //     return SlideTransition(
          //       position: tween.animate(animation),
          //       child: child,
          //     );
          //   },
          //   child: DefaultPage(
          //     key: ValueKey(Random.secure().nextInt(1000)),
          //   ),
          // ),
          // AnimatedSwitcher(
          //   duration: const Duration(milliseconds: 300),
          //   transitionBuilder: (Widget child, Animation<double> animation) {
          //     var tween = Tween<Offset>(
          //         begin: const Offset(0, -1), end: const Offset(0, 0));
          //     return SlideTransition(
          //       position: tween.animate(animation),
          //       child: child,
          //     );
          //   },
          //   child: Text(
          //     "$_count",
          //     key: ValueKey<int>(_count),
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransitionX(
                position: animation,
                direction: AxisDirection.down,
                child: child,
              );
            },
            child: Text(
              "$_count",
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              // 构建切换使用组合动画
              return _buildMultiAnimation(animation, child);
            },
            child: Text(
              '$_count',
              key: ValueKey<int>(_count),
              //⚠️重要: 必须设置。显示指定key，不同的key会被认为是不同的Text
              style: TextStyle(
                color: _randomColor,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          // only show
          AnimatedDigitWidget(
            value: _value,
            controller: _controller,
            fractionDigits: 2,
            textStyle: const TextStyle(color: Colors.orange, fontSize: 30),
          ),
          ElevatedButton(
              onPressed: () {
                // setState(() {
                // _value = Random.secure().nextInt(99999999) + 1.34;
                // Random.secure().nextDouble();
                // _value = 456789.44;
                _controller.resetValue(0.00);
                Future.delayed(const Duration(milliseconds: 100))
                    .then((value) => _controller.resetValue(456.88));
                // _value += 12.25;
                // });
              },
              child: const Text('更新')),
          const SizedBox(
            height: 30,
          ),
          AnimatedDigitWidget(
            controller: _numController,
            textStyle: const TextStyle(color: Colors.blue, fontSize: 30),
            fractionDigits: 2, // number of decimal places reserved, not rounded
            enableSeparator: true, // like this 10,240.98
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _numController.addValue(1234.66);
                  },
                  child: const Text('增加')),
              ElevatedButton(
                  onPressed: () {
                    _numController.minusValue(1234.66);
                  },
                  child: const Text('减少')),
              ElevatedButton(
                  onPressed: () {
                    _numController.timesValue(1234.66);
                  },
                  child: const Text('乘')),
              ElevatedButton(
                  onPressed: () {
                    _numController.divideValue(1234.66);
                  },
                  child: const Text('除')),
              ElevatedButton(
                  onPressed: () {
                    _numController.resetValue(2345.88);
                  },
                  child: const Text('重置'))
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          AnimateNumberWidget(
            // key: ValueKey(_endValue + 1),
            startValue: 0,
            endValue: _endValue,
            duration: const Duration(seconds: 2),
            isFloatingPoint: true,
            decimalPoint: 2,
            style: const TextStyle(
              color: Colors.lightBlue,
              fontSize: 42,
            ),
          ),
          AnimatedNumber(
            key: ValueKey(_endValue),
            startValue: 0,
            endValue: _endValue,
            duration: const Duration(seconds: 2),
            isFloatingPoint: true,
            decimalPoint: 2,
            style: const TextStyle(
              color: Colors.lightBlue,
              fontSize: 42,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _endValue = 5500.38273626732;
                });
              },
              child: const Text('刷新'))
        ],
      ),
    );
  }

  void _startUpdate() {
    setState(() {
      _count += 1;
    });
  }

  Widget _buildMultiAnimation(Animation<double> animation, Widget child) {
    Offset beginOffset = const Offset(0, -1.2);
    Offset endOffset = Offset.zero;

    if (animation.status == AnimationStatus.completed) {
      // Text移出的平移动画
      beginOffset = const Offset(0.0, 1.2);
      endOffset = Offset.zero;
    }

    return SlideTransition(
      // 平移动画
      position: Tween<Offset>(begin: beginOffset, end: endOffset).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        ),
      ),
      child: FadeTransition(
        // 渐变动画
        opacity: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
        ),
        child: ScaleTransition(
          // 缩放动画
          scale: Tween(begin: 0.6, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
