import 'dart:ui';

import 'package:flutter/material.dart';

class Ball {
  double aX; //加速度
  double aY; //加速度Y
  double vX; //速度X
  double vY; //速度Y
  double x; //点位X
  double y; //点位Y
  Color color; //颜色
  double r; //小球半径

  Ball(
      {this.aX = 0,
      this.aY = 0,
      this.vX = 0,
      this.vY = 0,
      this.x = 0,
      this.y = 0,
      this.color = Colors.lightBlue,
      this.r = 10});

  Ball.fromBall(Ball ball)
      : aX = ball.aX,
        aY = ball.aY,
        vX = ball.vX,
        vY = ball.vY,
        x = ball.x,
        y = ball.y,
        color = ball.color,
        r = ball.r;
}
