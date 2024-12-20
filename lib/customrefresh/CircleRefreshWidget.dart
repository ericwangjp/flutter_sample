import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const double _twoPI = math.pi * 2.0;
const Color _kActiveTickColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF3C3C44),
  darkColor: Color(0xFFEBEBF5),
);

/// The alpha value that is used to draw the partially revealed ticks.
const int _partiallyRevealedAlpha = 147;

/// Alpha values extracted from the native component (for both dark and light mode) to
/// draw the spinning ticks.
const List<int> _kAlphaValues = <int>[
  47,
  47,
  47,
  47,
  72,
  97,
  122,
  147,
];
const double _defaultIndicatorRadius = 10;
const double _strokeWidth = 4;

class CircleRefreshIndicator extends StatefulWidget {
  const CircleRefreshIndicator({
    Key? key,
    this.activeColors,
    this.animating = true,
    this.radius = _defaultIndicatorRadius,
    this.strokeWidth = 2.0,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = _twoPI,
  })  : progress = 1.0,
        super(key: key);

  const CircleRefreshIndicator.partiallyRevealed({
    Key? key,
    this.activeColors,
    this.radius = _defaultIndicatorRadius,
    this.progress = 1.0,
    this.strokeWidth = 2.0,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = _twoPI,
  })  : animating = false,
        super(key: key);

  /// Color of the activity indicator.
  final List<Color>? activeColors;

  /// Whether the activity indicator is running its animation.
  /// Defaults to true.
  final bool animating;

  /// Radius of the spinner widget.
  ///
  /// Defaults to 10px. Must be positive and cannot be null.
  final double radius;

  final double progress;

  final double strokeWidth;

  final bool strokeCapRound;
  final Color backgroundColor;
  final double totalAngle;

  /// 渐变色的终止点，对应colors属性
  final List<double>? stops;

  @override
  State<CircleRefreshIndicator> createState() => _CircleRefreshIndicatorState();
}

class _CircleRefreshIndicatorState extends State<CircleRefreshIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.animating) {
      _controller.repeat();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(CircleRefreshIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double _offset = .0;
    // // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏离起始位置
    // if (widget.strokeCapRound) {
    //   _offset = math
    //       .asin(widget.strokeWidth / (widget.radius * 2 - widget.strokeWidth));
    // }
    var _colors = widget.activeColors;
    if (_colors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      _colors = [color, color];
    }
    return SizedBox(
      height: widget.radius * 2,
      width: widget.radius * 2,
      child: CustomPaint(
        painter: _CircleProgressIndicatorPainter(
          strokeWidth: widget.strokeWidth,
          strokeCapRound: widget.strokeCapRound,
          backgroundColor: widget.backgroundColor,
          totalAngle: widget.totalAngle,
          position: _controller,
          activeColors: _colors,
          radius: widget.radius,
          progress: widget.progress,
        ),
      ),
    );
  }
}

class _CircleProgressIndicatorPainter extends CustomPainter {
  _CircleProgressIndicatorPainter(
      {required this.strokeWidth,
      required this.strokeCapRound,
      this.backgroundColor = const Color(0xFFEEEEEE),
      required this.totalAngle,
      required this.position,
      required this.activeColors,
      required this.radius,
      required this.progress,
      this.stops})
      : mPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _strokeWidth,
        super(repaint: position);

  final Animation<double> position;
  final List<Color> activeColors;
  final double radius;
  final double progress;
  final double strokeWidth;
  final bool strokeCapRound;
  final Color backgroundColor;
  final double totalAngle;
  final List<double>? stops;

  final Paint mPaint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);
    // 透明度稍后处理
    // final int tickCount = _kAlphaValues.length;
    // final int activeTick = (tickCount * position.value).floor();
    // for (int i = 0; i < tickCount * progress; ++i) {
    //   final int t = (i - activeTick) % tickCount;
    //   mPaint.color = activeColor
    //       .withAlpha(progress < 1 ? _partiallyRevealedAlpha : _kAlphaValues[t]);
    // canvas.drawRRect(tickFundamentalRRect, paint);
    // canvas.rotate(_kTwoPI / tickCount);
    // }

    double _offset = strokeWidth / 2.0;
    double _total = progress * totalAngle;
    double _start = 0.0;
    if (strokeCapRound) {
      _start = math.asin(strokeWidth / (size.width - strokeWidth));
    }
    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    // Rect rect = Rect.fromLTWH(0,0,size.width,size.height);
    mPaint.strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt;
    mPaint.isAntiAlias = true;
    mPaint.strokeWidth = strokeWidth;
    // 先画背景
    if (backgroundColor != Colors.transparent) {
      mPaint.color = backgroundColor;
      canvas.drawArc(
          rect,
          _start,
          totalAngle,
          false,
          mPaint
      );
    }

    // 再画前景，应用渐变
    if (_total > 0) {
      debugPrint('进度：$progress');
      debugPrint('进度2：${position.value}');
      final int tickCount = _kAlphaValues.length;
      final int activeTick = (tickCount * position.value).floor();

      for (int i = 0; i < tickCount * progress; ++i) {
        final int t = (i - activeTick) % tickCount;
        // paint.color = activeColor
        //     .withAlpha(progress < 1 ? _partiallyRevealedAlpha : _kAlphaValues[t]);
        // canvas.drawRRect(tickFundamentalRRect, paint);
        // canvas.rotate(_kTwoPI / tickCount);
        mPaint.shader = SweepGradient(
          startAngle: 0.0,
          endAngle: _total,
          colors: activeColors,
          stops: stops,
        ).createShader(rect);
        canvas.drawArc(
            rect,
            _start,
            _total*position.value,
            false,
            mPaint
        );
        canvas.rotate(_twoPI / tickCount);
      }



    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CircleProgressIndicatorPainter oldPainter) {
    // return oldPainter.position != position ||
    //     oldPainter.activeColors != activeColors ||
    //     oldPainter.progress != progress;
    return true;
  }
}
