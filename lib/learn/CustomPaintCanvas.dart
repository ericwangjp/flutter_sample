import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../ui/circle_gradient_progress_indicator.dart';
import '../ui/custom_checkbox_widget.dart';
import '../ui/custom_checkerboard_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "自定义canvas paint",
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
        title: const Text("flutter custom paint canvas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomCheckerboardWidget(),
              ElevatedButton(onPressed: () {}, child: const Text("刷新防止重绘验证")),
              const GradientCircularProgressRoute(),
              const CustomCheckBoxWidget()
            ],
          ),
        ),
      ),
    );
  }
}

/// 圆形进度示例
class GradientCircularProgressRoute extends StatefulWidget {
  const GradientCircularProgressRoute({Key? key}) : super(key: key);

  @override
  GradientCircularProgressRouteState createState() {
    return GradientCircularProgressRouteState();
  }
}

class GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: <Widget>[
                          CircleGradientProgressIndicator(
                            // No gradient
                            colors: const [Colors.blue, Colors.blue],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            progressAngle: _animationController.value,
                          ),
                          CircleGradientProgressIndicator(
                            colors: const [Colors.red, Colors.orange],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            progressAngle: _animationController.value,
                          ),
                          CircleGradientProgressIndicator(
                            colors: const [
                              Colors.red,
                              Colors.orange,
                              Colors.red
                            ],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            progressAngle: _animationController.value,
                          ),
                          CircleGradientProgressIndicator(
                            colors: const [Colors.teal, Colors.cyan],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            progressAngle: CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.decelerate,
                            ).value,
                          ),
                          // TurnBox(
                          //   turns: 1 / 8,
                          //   child:
                          CircleGradientProgressIndicator(
                            colors: const [
                              Colors.red,
                              Colors.orange,
                              Colors.red
                            ],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            backgroundColor: Colors.red.shade50,
                            totalAngle: 1.5 * pi,
                            progressAngle: CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.ease,
                            ).value,
                            // ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: CircleGradientProgressIndicator(
                              colors: [
                                Colors.blue.shade700,
                                Colors.blue.shade200
                              ],
                              radius: 50.0,
                              strokeWidth: 3.0,
                              strokeCapRound: true,
                              backgroundColor: Colors.transparent,
                              progressAngle: _animationController.value,
                            ),
                          ),
                          CircleGradientProgressIndicator(
                            colors: [
                              Colors.red,
                              Colors.amber,
                              Colors.cyan,
                              Colors.green.shade200,
                              Colors.blue,
                              Colors.red
                            ],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            progressAngle: _animationController.value,
                          ),
                        ],
                      ),
                      CircleGradientProgressIndicator(
                        colors: [Colors.blue.shade700, Colors.blue.shade200],
                        radius: 100.0,
                        strokeWidth: 20.0,
                        progressAngle: _animationController.value,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: CircleGradientProgressIndicator(
                          colors: [Colors.blue.shade700, Colors.blue.shade300],
                          radius: 100.0,
                          strokeWidth: 20.0,
                          progressAngle: _animationController.value,
                          strokeCapRound: true,
                        ),
                      ),
                      //剪裁半圆
                      ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: .5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              //width: 100.0,
                              // child: TurnBox(
                              //   turns: .75,
                              child: CircleGradientProgressIndicator(
                                colors: [Colors.teal, Colors.cyan.shade500],
                                radius: 100.0,
                                strokeWidth: 8.0,
                                progressAngle: _animationController.value,
                                totalAngle: pi,
                                strokeCapRound: true,
                              ),
                              // ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 104.0,
                        width: 200.0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              height: 200.0,
                              top: .0,
                              // child: TurnBox(
                              //   turns: .75,
                              child: CircleGradientProgressIndicator(
                                colors: [Colors.teal, Colors.cyan.shade500],
                                radius: 100.0,
                                strokeWidth: 8.0,
                                progressAngle: _animationController.value,
                                totalAngle: pi,
                                strokeCapRound: true,
                              ),
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${(_animationController.value * 100).toInt()}%",
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 自定义CheckBox测试
class CustomCheckBoxWidget extends StatefulWidget {
  const CustomCheckBoxWidget({Key? key}) : super(key: key);

  @override
  State<CustomCheckBoxWidget> createState() => _CustomCheckBoxWidgetState();
}

class _CustomCheckBoxWidgetState extends State<CustomCheckBoxWidget> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCheckBox(
            selected: _checked,
            onChanged: _onChange,
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CustomCheckBox(
                strokeWidth: 1,
                radius: 1,
                selected: _checked,
                onChanged: _onChange,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            height: 30,
            child: CustomCheckBox(
              strokeWidth: 3,
              radius: 3,
              selected: _checked,
              onChanged: _onChange,
            ),
          )
        ],
      ),
    );
  }

  void _onChange(value) {
    setState(() {
      _checked = value;
    });
  }
}
