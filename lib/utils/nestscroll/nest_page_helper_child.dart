import 'package:flutter/material.dart';

import 'nest_scroll_notification.dart';

/// @Description: 嵌套滚动子布局边界通知
/// @Author: SWY
/// @Date: 2021/2/15 20:29

class NestPageHelperChild extends StatelessWidget {
  final Widget child;

  const NestPageHelperChild({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movediff;
    bool isStart = false;
    return NotificationListener(
      child: ScrollConfiguration(
        child: child,
        behavior: _AlphaScrollBehavior(),
      ),
      onNotification: (notification) {
        if(notification == null){
          return true;
        }
        switch (notification.runtimeType) {
          case ScrollStartNotification:
            break;
          case ScrollUpdateNotification:
            if (!isStart) return false;
            ScrollUpdateNotification xdiff = notification as ScrollUpdateNotification;
            if (xdiff.dragDetails == null) return false;
            double offsetX = xdiff.dragDetails!.delta.dx;
            movediff.update(offsetX);
            movediff.dispatch(context);
            break;
          case ScrollEndNotification:
            movediff = null;
            if (isStart) {
              NestedEndNotification().dispatch(context);
              isStart = false;
            }
            break;
          case OverscrollNotification:
            OverscrollNotification xdiff = notification as OverscrollNotification;
            if (xdiff.dragDetails == null) return false;
            double offsetX = xdiff.dragDetails!.delta.dx;
            if (movediff == null) {
              isStart = true;
              movediff = NestedMoveNotification(xdiff: offsetX);
              NestedStartNotification().dispatch(context);
            }
            movediff.update(offsetX);
            movediff.dispatch(context);
            break;
        }
        return true;
      },
    );
  }
}

class _AlphaScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return GlowingOverscrollIndicator(
      child: child,
      axisDirection: axisDirection,
      color: Colors.transparent,
      showLeading: false,
      showTrailing: false,
    );
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return ClampingScrollPhysics();
  }
}
