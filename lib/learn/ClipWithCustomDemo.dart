import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "裁剪",
      theme: ThemeData(primarySwatch: Colors.orange),
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
        title: Text("flutter clip"),
      ),
      body: Column(
        children: const [ClipWidget()],
      ),
    );
  }
}

class ClipWidget extends StatelessWidget {
  const ClipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset(
      "images/little_girl.jpeg",
      width: 60,
    );
    return Center(
      child: Column(
        children: [
          avatar, // 不裁剪
          ClipOval(
            child: avatar,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: avatar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,
                child: avatar,
              ),
              const Text(
                "你好世界",
                style: TextStyle(color: Colors.orange),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,
                  child: avatar,
                ),
              ),
              const Text(
                "你好世界",
                style: TextStyle(color: Colors.orange),
              )
            ],
          ),
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.lime),
            child: ClipRect(
              clipper: MyClipper(),
              child: avatar,
            ),
          ),
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.lightBlue),
            child: ClipPath(
              clipper: MyPathClipper(),
              child: avatar,
            ),
          )
        ],
      ),
    );
  }
}

/// 自定义矩形裁剪
class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTWH(10, 15, 40, 30);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

/// 自定义路径裁剪
class MyPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(const Rect.fromLTWH(10, 10, 40, 30));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
