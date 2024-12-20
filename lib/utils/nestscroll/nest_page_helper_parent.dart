import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'nest_scroll_notification.dart';

/// @Description: 嵌套滚动父布局响应
/// @Author: SWY
/// @Date: 2021/2/15 20:29
class NestPageHelperParent extends StatefulWidget {
  final Widget child;
  final PageController pageController;

  const NestPageHelperParent(
      {Key? key, required this.child, required this.pageController})
      : super(key: key);

  @override
  State<NestPageHelperParent> createState() => _NestPageHelperParentState();
}

class _NestPageHelperParentState extends State<NestPageHelperParent> {
  double _totalOffset = 0;
  Drag? _drag;
  int _frequency = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: widget.child,
      onNotification: (notification) {
        if (notification == null) return true;

        switch (notification.runtimeType) {
          case NestedStartNotification:
            _totalOffset = 0.0;
            _drag = createDragStart();
            _frequency = 0;
            break;

          case NestedMoveNotification:
            _totalOffset += (notification as NestedMoveNotification).xdiff;
            _frequency++;
            if (_drag == null) return false;
            _drag?.update(DragUpdateDetails(
                delta: Offset(notification.xdiff, 0),
                globalPosition:
                    Offset(widget.pageController.offset + notification.xdiff, 0),
                primaryDelta: notification.xdiff));
            break;

          case NestedEndNotification:
            if (_drag != null) _drag?.end(DragEndDetails(primaryVelocity: 0.0));
            _drag = null;
            double velocity = _totalOffset / _frequency;
            //去前页
            if (velocity > 2) {
              widget.pageController.previousPage(
                  duration: const Duration(milliseconds: 300), curve: Curves.ease);
            }
            //去后页
            if (velocity < -2) {
              widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 300), curve: Curves.ease);
            }
            break;
        }
        return true;
      },
    );
  }

  @override
  void dispose() {
    _drag?.cancel();
    widget.pageController.dispose();
    super.dispose();
  }

  Drag createDragStart() {
    if (_drag != null) _drag?.cancel();
    return widget.pageController.position.drag(
        DragStartDetails(localPosition: Offset(widget.pageController.offset, 0)),
        () {});
  }
}
