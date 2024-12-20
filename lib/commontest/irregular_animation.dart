import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            CustomPaint(
              painter: MyPainter(_controller.value),
              child: Container(),
            ),
            const PicAnimationWidget(),
            CustomPaint(
              painter: BezierCurvePainter(_controller.value),
              child: Container(),
            ),
          ],
        );
      },
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this.value);

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 2)
      // ..lineTo(size.width / 2 + 100.0 * value, size.height / 2)
      // ..lineTo(size.width / 2, size.height / 2 + 100.0 * value)
      ..arcToPoint(
          Offset(size.width / 2 + 100.0 * value, size.height / 2), // 目标点
          radius: const Radius.circular(30), // 圆角的半径
          largeArc: true,
          clockwise: true)
      ..arcToPoint(
          Offset(size.width / 2, size.height / 2 + 100.0 * value), // 目标点
          radius: const Radius.circular(30), // 圆角的半径
          largeArc: true,
          clockwise: true)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}

class BezierCurvePainter extends CustomPainter {
  BezierCurvePainter(this.value);

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    // ..strokeWidth = 4.0;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..quadraticBezierTo(
        size.width * value / 2, // 控制点的x坐标
        size.height * value / 2, // 控制点的y坐标
        size.width * value, // 结束点的x坐标
        size.height * value, // 结束点的y坐标
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PicAnimationWidget extends StatefulWidget {
  const PicAnimationWidget({super.key});

  @override
  State createState() => _PicAnimationState();
}

class _PicAnimationState extends State<PicAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipPath(
          clipper: MyClipper(_controller.value),
          child: Image.asset('images/sea.webp'),
        );
      },
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  MyClipper(this.value);

  final double value;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width * value, 0);
    path.arcToPoint(Offset(size.width * value, size.height), // 目标点
        radius: const Radius.circular(20), // 圆角的半径
        largeArc: true,
        clockwise: true);
    // path.lineTo(size.width * value, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(MyClipper oldClipper) {
    return oldClipper.value != value;
  }
}
