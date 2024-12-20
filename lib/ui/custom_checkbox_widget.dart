import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../mixin/RenderObjectAnimationMixin.dart';

/// 自定义 CheckBox
class CustomCheckBox extends LeafRenderObjectWidget {
  // “勾”的线条宽度
  final double strokeWidth;

  // “勾”的线条颜色
  final Color strokeColor;

  // 填充颜色
  final Color? fillColor;

  //选中状态
  final bool selected;

  // 圆角
  final double radius;

  // 选中状态发生改变后的回调
  final ValueChanged<bool>? onChanged;

  const CustomCheckBox(
      {Key? key,
      this.strokeWidth = 2.0,
      this.strokeColor = Colors.white,
      this.fillColor = Colors.blue,
      this.selected = false,
      this.radius = 2.0,
      this.onChanged})
      : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCheckbox(selected, strokeWidth, strokeColor,
        fillColor ?? Theme.of(context).primaryColor, radius, onChanged);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCustomCheckbox renderObject) {
    super.updateRenderObject(context, renderObject);
    if (renderObject.value != selected) {
      renderObject.animationStatus =
          selected ? AnimationStatus.forward : AnimationStatus.reverse;
    }
    renderObject
      ..strokeWidth = strokeWidth
      ..strokeColor = strokeColor
      ..fillColor = fillColor ?? Theme.of(context).primaryColor
      ..radius = radius
      ..value = selected
      ..onChanged = onChanged;
  }
}

class RenderCustomCheckbox extends RenderBox with RenderObjectAnimationMixin {
  bool value;
  int pointerId = -1;
  double strokeWidth;
  Color strokeColor;
  Color fillColor;
  double radius;
  ValueChanged<bool>? onChanged;

  //背景动画时长占比（背景动画要在前40%的时间内执行完毕，之后执行打勾动画）
  final double bgAnimationInterval = .4;

  RenderCustomCheckbox(this.value, this.strokeWidth, this.strokeColor,
      this.fillColor, this.radius, this.onChanged) {
    progress = value ? 1 : 0;
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void performLayout() {
    // 布局
    size = constraints
        .constrain(constraints.isTight ? Size.infinite : const Size(25, 25));
    // super.performLayout();
  }

  // 必须置为true，确保能通过命中测试
  @override
  bool hitTestSelf(Offset position) {
    // return super.hitTestSelf(position);
    return true;
  }

  // 只有通过命中测试，才会调用本方法，我们在手指抬起时触发事件即可
  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event.down) {
      pointerId = event.pointer;
    } else if (pointerId == event.pointer) {
      // 判断手指抬起时是在组件范围内的话才触发onChange
      if (size.contains(event.localPosition)) {
        onChanged?.call(!value);
      }
    }
  }

  @override
  void doPaint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    _drawBackground(context, rect);
    _drawCheckMark(context, rect);
  }

  // 画背景
  void _drawBackground(PaintingContext context, Rect rect) {
    Color color = value ? fillColor : Colors.grey;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;

    // 我们需要算出每一帧里面矩形的大小，为此我们可以直接根据矩形插值方法来确定里面矩形
    final outer = RRect.fromRectXY(rect, radius, radius);
    var rects = [
      rect.inflate(-strokeWidth),
      Rect.fromCenter(center: rect.center, width: 0, height: 0)
    ];
    // 根据动画执行进度调整来确定里面矩形在每一帧的大小
    var rectProgress = Rect.lerp(
      rects[0],
      rects[1],
      // 背景动画的执行时长是前 40% 的时间
      min(progress, bgAnimationInterval) / bgAnimationInterval,
    )!;
    final inner = RRect.fromRectXY(rectProgress, 0, 0);
    // 绘制
    context.canvas.drawDRRect(outer, inner, paint);
  }

  //画 "勾"
  void _drawCheckMark(PaintingContext context, Rect rect) {
    // 在画好背景后再画前景
    if (progress > bgAnimationInterval) {
      //确定中间拐点位置
      final secondOffset = Offset(
        rect.left + rect.width / 2.5,
        rect.bottom - rect.height / 4,
      );
      // 第三个点的位置
      final lastOffset = Offset(
        rect.right - rect.width / 6,
        rect.top + rect.height / 4,
      );

      // 我们只对第三个点的位置做插值
      final _lastOffset = Offset.lerp(
        secondOffset,
        lastOffset,
        (progress - bgAnimationInterval) / (1 - bgAnimationInterval),
      )!;

      // 将三个点连起来
      final path = Path()
        ..moveTo(rect.left + rect.width / 7, rect.top + rect.height / 2)
        ..lineTo(secondOffset.dx, secondOffset.dy)
        ..lineTo(_lastOffset.dx, _lastOffset.dy);

      final paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = strokeColor
        ..strokeWidth = strokeWidth;

      context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
    }
  }
}
