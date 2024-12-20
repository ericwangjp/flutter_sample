import 'dart:math';

import 'package:flutter/material.dart';

/// 圆环渐变进度条
class CircleGradientProgressIndicator extends StatefulWidget {
  const CircleGradientProgressIndicator(
      {Key? key,
      this.strokeWidth = 2.0,
      this.gapWidth = 0.0,
      required this.radius,
      this.strokeCapRound = false,
      this.progressAngle,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.animationDuration = 200,
      this.totalAngle = 2 * pi,
      this.fullColor,
      this.colors,
      this.stops,
      this.animate = true})
      : super(key: key);

  /// 粗细
  final double strokeWidth;

  /// 背景和进度间的间隙
  final double gapWidth;

  /// 圆的半径
  final double radius;

  ///两端是否为圆角
  final bool strokeCapRound;

  /// 当前进度，取值范围 [0.0-1.0]
  final double? progressAngle;

  /// 进度为 1 时的填充颜色
  final Color? fullColor;

  /// 进度条背景色，默认值为 `Color(0xFFEEEEEE)`
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 渐变色数组
  final List<Color>? colors;

  /// 渐变色的终止点，对应colors属性
  final List<double>? stops;

  /// 是否执行动画
  final bool animate;

  /// 动画执行时间 单位 毫秒
  final int animationDuration;

  @override
  State<CircleGradientProgressIndicator> createState() =>
      _CircleGradientProgressIndicatorState();
}

class _CircleGradientProgressIndicatorState
    extends State<CircleGradientProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));
    if (widget.animate) {
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CircleGradientProgressIndicator oldWidget) {
    if (widget.animate) {
      _animationController.reset();
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double offset = 0.0;
    if (widget.strokeCapRound && widget.totalAngle != 2 * pi) {
      offset =
          asin(widget.strokeWidth / (widget.radius * 2 - widget.strokeWidth));
    }
    var gradientColors = widget.colors;
    if (gradientColors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      gradientColors = [color, color];
    }
    // return Transform.rotate(
    //   angle: -pi - offset,
    //   child: CustomPaint(
    //       size: Size.fromRadius(radius),
    //       painter: _GradientCircularProgressPainter(
    //           strokeWidth: strokeWidth,
    //           strokeCapRound: strokeCapRound,
    //           backgroundColor: backgroundColor,
    //           fullColor: fullColor,
    //           value: progressAngle,
    //           total: totalAngle,
    //           radius: radius,
    //           colors: gradientColors,
    //           stops: stops)),
    // );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double mRadius = widget.radius;
        if (mRadius <= 0) {
          //当宽的一半大于等于高的时候，采取高来作为半径。
          if (constraints.maxWidth / 2 >= constraints.maxHeight) {
            mRadius = constraints.maxHeight;
          }
          //当宽的一半小于高的时候，采取宽的一半作为半径。
          else {
            mRadius = constraints.maxWidth / 2;
          }
        }
        Size size;
        if (widget.totalAngle > pi) {
          size = Size.fromRadius(mRadius);
        } else {
          size = Size(mRadius * 2, mRadius);
        }
        return AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              return CustomPaint(
                  size: size,
                  painter: _GradientCircularProgressPainter(
                      strokeWidth: widget.strokeWidth,
                      gapWidth: widget.gapWidth,
                      strokeCapRound: widget.strokeCapRound,
                      backgroundColor: widget.backgroundColor,
                      fullColor: widget.fullColor,
                      value: widget.animate
                          ? CurvedAnimation(
                                      parent: _animationController,
                                      curve: Curves.decelerate)
                                  .value *
                              (widget.progressAngle ?? 0.0)
                          : (widget.progressAngle ?? 0.0),
                      total: widget.totalAngle,
                      radius: widget.radius,
                      colors: gradientColors!,
                      stops: widget.stops));
            });
      },
    );
  }
}

//实现画笔
class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.strokeWidth = 2.0,
      this.gapWidth = 0.0,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.radius,
      this.total = 2 * pi,
      required this.colors,
      this.fullColor,
      this.stops,
      this.value = 0});

  final double strokeWidth;
  final bool strokeCapRound;
  final double? value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double? radius;
  final List<double>? stops;
  final Color? fullColor;
  final double gapWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius!);
    }
    double offsetPos = strokeWidth / 2.0;
    double sweepAngle = (value ?? .0).clamp(.0, 1.0) * total;
    double startAngle = pi;
    //
    // if (strokeCapRound) {
    //   startAngle = asin(strokeWidth / (size.width - strokeWidth));
    // }

    Rect rect = Offset(offsetPos, offsetPos) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    // Rect rect = Rect.fromCircle(
    //     center: Offset(radius!, radius!), radius: radius! - strokeWidth / 2);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    // 先画背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, startAngle, total, false, paint);
    }

    // 再画前景，应用渐变
    paint.strokeWidth = strokeWidth - gapWidth * 2;
    if (value == 1 && fullColor != null) {
      paint.color = fullColor!;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    } else if (sweepAngle > 0) {
      paint.shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: colors,
        stops: stops,
      ).createShader(rect);
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }
  }

  /// 是否重绘
  @override
  bool shouldRepaint(_GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.strokeCapRound != strokeCapRound ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.radius != radius ||
        oldDelegate.value != value ||
        oldDelegate.fullColor != fullColor ||
        oldDelegate.colors.toString() != colors.toString() ||
        oldDelegate.stops.toString() != stops.toString();
  }
}
