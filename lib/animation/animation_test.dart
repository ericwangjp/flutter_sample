import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/commontest/default_page.dart';
import 'package:flutter_sample/learn/TransitionAnimated.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "动画组件",
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _doubleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    CurvedAnimation curvedAnimation =
        // CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
        CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.1, 0.83, curve: Curves.bounceInOut));
    _doubleAnimation =
        Tween(begin: 10.0, end: 100.0).animate(_animationController)
          ..addListener(() {
            debugPrint('值改变了===');
            // setState((){});
          });
    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.pink)
        .animate(curvedAnimation)
      ..addStatusListener((status) {
        debugPrint('状态改变：$status');
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    // 启动动画
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 动画组件"),
      ),
      body: Column(
        children: [
          Container(
            color: _colorAnimation.value,
            child: Text(
              '动画 view 视图: ${_doubleAnimation.value}',
              textScaleFactor: 2.0,
            ),
          ),
          CustomAnimatedWidget(animation: _colorAnimation),
          AnimatedBuilder(
              animation: _colorAnimation,
              child: const Text(
                '动画展示2',
                textScaleFactor: 2.0,
              ),
              builder: (context, child) {
                return Container(color: _colorAnimation.value, child: child);
              }),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const Scaffold(
                              body: DefaultPage(),
                            )));
              },
              child: const Text('页面切换动画'))
        ],
      ),
    );
  }
}

// 无需在对应的 tween animation 中添加 addListener 中 setState
class CustomAnimatedWidget extends AnimatedWidget {
  const CustomAnimatedWidget({Key? key, required Animation<Color?> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    var valueAnimation = listenable as Animation<Color?>;
    return Container(
      color: valueAnimation.value,
      child: const Text(
        '动画展示',
        textScaleFactor: 2.0,
      ),
    );
  }
}
