import 'package:flutter/material.dart';

/// @Description: 自定义通知
/// @Author: SWY
/// @Date: 2021/2/15 20:34
class NestedMoveNotification extends Notification {
  double xdiff;

  NestedMoveNotification({required this.xdiff});

  update(double xdiff) {
    this.xdiff = xdiff;
  }
}

class NestedStartNotification extends Notification {}

class NestedEndNotification extends Notification {}
