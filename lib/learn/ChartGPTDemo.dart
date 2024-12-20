import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chart GPT",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('当前环境：${Localizations.localeOf(context)}');
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 五角星"),
      ),
      body: const Center(
          child: Star(
        size: 100,
        color: Colors.red,
      )),
    );
  }
}

class Star extends StatelessWidget {
  final double size;
  final Color color;

  const Star({Key? key, required this.size, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: StarPainter(color),
    );
  }
}

class StarPainter extends CustomPainter {
  final Color color;

  StarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final double halfWidth = size.width / 2;
    final double halfHeight = size.height / 2;
    final double radius = math.min(halfWidth, halfHeight);
    final double radian = 2 * math.pi / 5;
    final Path path = Path();
    path.moveTo(halfWidth, 0);
    for (int i = 1; i <= 5; i++) {
      final double dx = radius * math.sin(i * radian);
      final double dy = -radius * math.cos(i * radian);
      path.lineTo(halfWidth + dx, halfHeight + dy);
    }
    path.close();
    canvas.drawPath(
      path,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
