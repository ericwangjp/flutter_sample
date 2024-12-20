import 'dart:math';

import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  final Size? size;
  final Color color;

  const StarWidget({Key? key, this.size, this.color = Colors.lightBlue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var finalSize = size;
        if (size == null) {
          //当宽的一半大于等于高的时候，采取高来作为边长。
          if (constraints.maxWidth / 2 >= constraints.maxHeight) {
            finalSize = Size.fromHeight(constraints.maxHeight);
          }
          //当宽的一半小于高的时候，采取宽的一半作为边长。
          else {
            finalSize = Size.fromWidth(constraints.maxWidth / 2);
          }
        }
        return CustomPaint(
          painter: CustomStarPainter(color),
          size: finalSize!,
        );
      },
    );
  }
}

class CustomStarPainter extends CustomPainter {
  late Paint guidePaint, coordinatePaint, starPaint;
  final Color color;

  CustomStarPainter(this.color) {
    starPaint = Paint()
      // ..style = PaintingStyle.stroke
      ..color = Colors.orange
      ..isAntiAlias = true;
    guidePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..isAntiAlias = true;
    coordinatePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(_getGridPath(20, size), guidePaint);
    _drawCoordinate(canvas, size);
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawPath(regularStarPath(5, 100), starPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  /// 绘制网格
  /// step 每个网格大小
  /// viewSize 整个网格的总大小
  Path _getGridPath(int step, Size viewSize) {
    Path gridPath = Path();
    for (var i = 0; i < viewSize.height / step + 1; i++) {
      gridPath.moveTo(0, step * i.toDouble());
      gridPath.lineTo(viewSize.width, step * i.toDouble());
    }
    for (var i = 0; i < viewSize.width / step + 1; i++) {
      gridPath.moveTo(step * i.toDouble(), 0);
      gridPath.lineTo(step * i.toDouble(), viewSize.height);
    }
    return gridPath;
  }

  /// 绘制坐标系
  void _drawCoordinate(Canvas canvas, Size size) {
    // 绘制横轴
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), coordinatePaint);
    //  绘制右箭头
    canvas.drawLine(Offset(size.width - 10, size.height / 2 - 6),
        Offset(size.width, size.height / 2), coordinatePaint);
    canvas.drawLine(Offset(size.width - 10, size.height / 2 + 6),
        Offset(size.width, size.height / 2), coordinatePaint);
    //  绘制纵轴
    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height), coordinatePaint);
    //  绘制下箭头
    canvas.drawLine(Offset(size.width / 2 - 6, size.height - 10),
        Offset(size.width / 2, size.height), coordinatePaint);
    canvas.drawLine(Offset(size.width / 2 + 6, size.height - 10),
        Offset(size.width / 2, size.height), coordinatePaint);
  }

  /// 画正n角星的路径:
  ///
  /// @param num 角数
  /// @param R   外接圆半径
  /// @return 画正n角星的路径
  Path regularStarPath(int num, double R) {
    double degA, degB;
    if (num % 2 == 1) {
      //奇数和偶数角区别对待
      degA = 360 / num / 2 / 2;
      degB = 180 - degA - 360 / num / 2;
    } else {
      degA = 360 / num / 2;
      degB = 180 - degA - 360 / num / 2;
    }
    double r = R * sin(_rad(degA)) / sin(_rad(degB));
    return nStarPath(num, R, r);
  }

  /// 画正n边形的路径
  ///
  /// @param num 边数
  /// @param R   外接圆半径
  /// @return 画正n边形的路径
  Path regularPolygonPath(int num, double R) {
    double r = R * cos(_rad(360 / num / 2)); //!!一点解决
    return nStarPath(num, R, r);
  }

  /// 弧度转换
  double _rad(double deg) {
    return deg * pi / 180;
  }

  /// n角星路径
  ///
  /// @param num 几角星
  /// @param R   外接圆半径
  /// @param r   内接圆半径
  /// @return n角星路径
  Path nStarPath(int num, double R, double r) {
    Path path = Path();
    double perDeg = 360 / num; //尖角的度数
    double degA = perDeg / 2 / 2;
    double degB = 360 / (num - 1) / 2 - degA / 2 + degA;

    path.moveTo(cos(_rad(degA)) * R, (-sin(_rad(degA)) * R));
    for (int i = 0; i < num; i++) {
      path.lineTo(
          cos(_rad(degA + perDeg * i)) * R, -sin(_rad(degA + perDeg * i)) * R);
      path.lineTo(
          cos(_rad(degB + perDeg * i)) * r, -sin(_rad(degB + perDeg * i)) * r);
    }
    path.close();
    return path;
  }
}
