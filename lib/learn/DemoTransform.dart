import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter 容器",
      theme: ThemeData(primarySwatch: Colors.green),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 容器展示"),
      ),
      body: Column(
        children: const [
          // PaddingWidget(),
          // DecoratedBoxWidget(),
          // TransformWidget(),
          ContainerWidget()
        ],
      ),
    );
  }
}

class PaddingWidget extends StatelessWidget {
  const PaddingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text("左边距 8"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text("上下间距 8"),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text("左右间距10，上下间距0"),
          )
        ],
      ),
    );
  }
}

class DecoratedBoxWidget extends StatelessWidget {
  const DecoratedBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange.shade700]),
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2, 2),
                      blurRadius: 4)
                ]),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              child: Text(
                "登录",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TransformWidget extends StatelessWidget {
  const TransformWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.lime,
          child: Transform(
            alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
            transform: Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.deepOrange,
              child: const Text("transform ！"),
            ),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.translate(
            offset: const Offset(-20, -10),
            child: const Text("平移变换"),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.green),
          child: Transform.rotate(
            angle: math.pi / 2,
            child: const Text(
              "旋转变换",
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.lightBlue),
          child: Transform.scale(
            scale: 1.5,
            child: const Text("缩放变换"),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.pink),
          child: Transform.translate(
            offset: Offset(20, 20),
            child: Transform.rotate(
              angle: math.pi / 2,
              child: Text("先平移再旋转"),
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.lightBlue),
          child: Transform.rotate(
            angle: math.pi / 2,
            child: Transform.translate(
              offset: Offset(20, 20),
              child: Text("先旋转再平移"),
            ),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(color: Colors.pink),
          child: RotatedBox(
            quarterTurns: 1, //旋转90度(1/4圈)
            child: Text(
              "rotate 改变位置和大小",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.all(20),
      // color: Colors.pink,
      decoration: BoxDecoration(
          gradient: const RadialGradient(
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: .98),
          boxShadow: const [
            BoxShadow(
                color: Colors.black54, offset: Offset(2, 2), blurRadius: 4)
          ],
          border: Border.all(color: Colors.pink, width: 2),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
      // width: 300,
      // height: 200,
      constraints: BoxConstraints.tightFor(width: 200, height: 150),
      transform: Matrix4.rotationZ(.2),
      margin: EdgeInsets.only(top: 50, left: 120),
      child: const Text(
        "container 配置",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}


