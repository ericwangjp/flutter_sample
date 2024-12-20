import 'dart:math';

import 'package:flutter/material.dart';

/// 水印组件
class WatermarkWidget extends StatelessWidget {
  const WatermarkWidget(
      {Key? key,
      required this.watermarkText,
      this.child,
      this.height,
      this.width,
      this.rowCount = 6,
      this.columnCount = 3,
      this.rotateAngle = -pi / 12.0,
      this.isForegroundWatermark = true,
      this.watermarkTextStyle = const TextStyle(
        color: Colors.black12,
        fontSize: 14,
        decoration: TextDecoration.none,
      )})
      : super(key: key);

  final Widget? child;
  final int rowCount;
  final int columnCount;
  final double rotateAngle;
  final String watermarkText;
  final bool isForegroundWatermark;
  final TextStyle watermarkTextStyle;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LimitedBox(
        maxHeight: height ?? double.infinity,
        maxWidth: width ?? double.infinity,
        child: Stack(
          children: _getChildrenWidget(),
        ),
      ),
    );
  }

  List<Widget> _getChildrenWidget() {
    if (child == null) {
      return [_getWatermarkWidget()];
    }
    return isForegroundWatermark
        ? [child!, _getWatermarkWidget()]
        : [_getWatermarkWidget(), child!];
  }

  Widget _getWatermarkWidget() {
    return Column(
      children: List.generate(
        rowCount,
        (index) => Expanded(
          child: Row(
            children: List.generate(
              columnCount,
              (index) => Expanded(
                child: Center(
                  child: Transform.rotate(
                    angle: rotateAngle,
                    child: Text(
                      watermarkText,
                      style: watermarkTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
