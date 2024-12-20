import 'package:flutter/cupertino.dart';

/// 自定义过渡动画组件
class AnimatedTransitionDecorateBox extends ImplicitlyAnimatedWidget {
  const AnimatedTransitionDecorateBox(
      {Key? key,
      required this.decoration,
      required this.child,
      Curve curve = Curves.linear,
      required Duration duration})
      : super(key: key, curve: curve, duration: duration);

  final BoxDecoration decoration;
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedDecorateBoxState();
  }
}

class _AnimatedDecorateBoxState
    extends AnimatedWidgetBaseState<AnimatedTransitionDecorateBox> {
  late DecorationTween _decorationTween;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decorationTween.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decorationTween = visitor(_decorationTween, widget.decoration,
        (value) => DecorationTween(begin: value)) as DecorationTween;
  }
}
