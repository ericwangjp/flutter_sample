import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sample/model/Ball.dart';

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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Ball firstBall;
  late Rect _rect;
  late AnimationController _animationController;
  List<Ball> balls = [];

  @override
  void initState() {
    super.initState();
    firstBall = Ball(
        aX: 0.1,
        aY: 0.1,
        vX: 2,
        vY: -2,
        x: 0,
        y: 0,
        color: Colors.orange,
        r: 10);
    balls.add(firstBall);
    _rect = const Rect.fromLTRB(-140, -100, 140, 100);
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 200))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          })
          ..addListener(() {
            //更新小球
            updateBall();
          });
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
        title: const Text("自定义粒子运动"),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return CustomPaint(
            painter: BallPainter(balls, _rect),
            size: MediaQuery.of(context).size,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_animationController.isAnimating) {
            _animationController.forward();
          }
        },
        child: const Icon(Icons.change_circle),
      ),
    );
  }

//更新小球位置
  void updateBall() {
    for (var i = 0; i < balls.length; i++) {
      var ball = balls[i];
      if (ball.r < 0.3) {
        balls.removeAt(i);
      }
      //运动学公式
      ball.x += ball.vX;
      ball.y += ball.vY;
      ball.vX += ball.aX;
      ball.vY += ball.aY;
      //限定下边界
      if (ball.y > _rect.bottom - ball.r) {
        var newBall = Ball.fromBall(ball);
        newBall.r = newBall.r / 2;
        newBall.vX = -newBall.vX;
        newBall.vY = -newBall.vY;
        balls.add(newBall);

        ball.r = ball.r / 2;
        ball.y = _rect.bottom - ball.r;
        ball.vY = -ball.vY;
        ball.color = _randomColor(); //碰撞后随机色
      }
      //限定上边界
      if (ball.y < _rect.top + ball.r) {
        ball.y = _rect.top + ball.r;
        ball.vY = -ball.vY;
        ball.color = _randomColor(); //碰撞后随机色
      }

      //限定左边界
      if (ball.x < _rect.left + ball.r) {
        ball.x = _rect.left + ball.r;
        ball.vX = -ball.vX;
        ball.color = _randomColor(); //碰撞后随机色
      }

      //限定右边界
      if (ball.x > _rect.right - ball.r) {
        var newBall = Ball.fromBall(ball);
        newBall.r = newBall.r / 2;
        newBall.vX = -newBall.vX;
        newBall.vY = -newBall.vY;
        balls.add(newBall);

        ball.r = ball.r / 2;
        ball.x = _rect.right - ball.r;
        ball.vX = -ball.vX;
        ball.color = _randomColor(); //碰撞后随机色
      }
    }
  }

  Color _randomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }
}

class BallPainter extends CustomPainter {
  late Paint mPaint;
  final List<Ball> balls;
  final Rect rect;

  BallPainter(this.balls, this.rect) {
    mPaint = Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(160, 300);
    // mPaint.color = Colors.black;
    // canvas.drawLine(Offset(0, size.height / 2),
    //     Offset(size.width, size.height / 2), mPaint);
    mPaint.color = const Color.fromARGB(148, 198, 246, 248);
    canvas.drawRect(rect, mPaint);
    canvas.save();
    for (var ball in balls) {
      drawBall(canvas, ball);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawBall(Canvas canvas, Ball ball) {
    mPaint.color = ball.color;
    canvas.drawCircle(Offset(ball.x, ball.y), ball.r, mPaint);
  }
}
