import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/rotate_box_with_transition.dart';

import '../ui/circle_gradient_progress_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "旋转组件",
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
  int _turns = 1;
  double _rotateTurns = 0.0;
  late AnimationController _animationController;
  late Animation<double> _doubleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _doubleAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_animationController);
    //   ..addStatusListener((status) {
    //     debugPrint('状态改变：$status');
    //     if (status == AnimationStatus.completed) {
    //       _animationController.reset();
    //       _animationController.forward();
    //     } else if (status == AnimationStatus.dismissed) {
    //       _animationController.reverse();
    //       _animationController.forward();
    //     }
    //   });

    // 启动动画
    // _animationController.forward();
    _animationController.repeat();
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
        title: const Text("flutter 旋转组件"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RotatedBox(
              quarterTurns: _turns, // 90 度的整数倍
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green, Colors.orange]),
                    border: Border.all(color: Colors.pink),
                    borderRadius: BorderRadius.circular(5)),
                height: 100,
                width: 100,
                child: const Text(
                  '子组件展示',
                  textScaleFactor: 2.0,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _turns += 1;
                  });
                },
                child: const Text('顺时针旋转90度')),
            RotateBoxWidget(
              rotateTurns: _rotateTurns,
              duration: 500,
              child: const Icon(
                Icons.add,
                size: 50,
              ),
            ),
            RotateBoxWidget(
              rotateTurns: _rotateTurns,
              duration: 1000,
              child: const Icon(
                Icons.refresh,
                size: 100,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _rotateTurns += 0.2;
                  });
                },
                child: const Text('顺时针选择1/5圈')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _rotateTurns -= 0.2;
                  });
                },
                child: const Text('逆时针选择1/5圈')),
            RotateBoxWidget(
              rotateTurns: _rotateTurns,
              duration: 1000,
              child: const CircleGradientProgressIndicator(
                  strokeWidth: 10,
                  radius: 50,
                  progressAngle: 100,
                  colors: [Colors.white, Colors.green]),
            ),
            AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return RotateBoxWidget(
                    rotateTurns: _animationController.value,
                    duration: 600,
                    child: const CircleGradientProgressIndicator(
                        strokeWidth: 10,
                        radius: 50,
                        progressAngle: 100,
                        colors: [Colors.white, Colors.green]),
                  );
                }),
            RotationTransition(
              turns: _animationController,
              child: const CircleGradientProgressIndicator(
                  strokeWidth: 10,
                  radius: 50,
                  progressAngle: 100,
                  colors: [Colors.white, Colors.green]),
            ),
            AnimatedBuilder(
              animation: _doubleAnimation,
              builder: (context, child) {
                debugPrint('值改变：${_doubleAnimation.value}');
                return CircleGradientProgressIndicator(
                    strokeWidth: 10,
                    radius: 50,
                    progressAngle: _doubleAnimation.value,
                    colors: const [Colors.blue, Colors.green, Colors.orange]);
              },
            )
          ],
        ),
      ),
    );
  }
}
