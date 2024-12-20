import 'package:flutter/material.dart';

class RotateBoxWidget extends StatefulWidget {
  const RotateBoxWidget(
      {Key? key, this.duration = 200, this.child, this.rotateTurns = 0.0})
      : super(key: key);

  //旋转的“圈”数,一圈为360度，如0.25圈即90度
  final double rotateTurns;

  //过渡动画执行的总时长
  final int duration;
  final Widget? child;

  @override
  State<RotateBoxWidget> createState() => _RotateBoxWidgetState();
}

class _RotateBoxWidgetState extends State<RotateBoxWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity)
      ..value = widget.rotateTurns;
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationController,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant RotateBoxWidget oldWidget) {
    if (oldWidget.rotateTurns != widget.rotateTurns) {
      _animationController.animateTo(widget.rotateTurns,
          duration: Duration(milliseconds: widget.duration),
          curve: Curves.easeOut);
    }
    super.didUpdateWidget(oldWidget);
  }
}
