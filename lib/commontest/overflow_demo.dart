import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "布局溢出",
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 布局溢出"),
      ),
      // SizedOverflowBox
      // body: Center(
      //   child: Container(
      //     color: Colors.green[400],
      //     width: 100,
      //     height: 100,
      //     alignment: Alignment.topCenter,
      //     child: SizedOverflowBox(
      //       size: Size.zero,
      //       child: Container(
      //         color: Colors.blue,
      //         width: 50,
      //         height: 50,
      //       ),
      //     ),
      //   ),
      // ),

      // OverflowBox
      // body: Center(
      //   child: Container(
      //     color: Colors.green[400],
      //     width: 100,
      //     height: 100,
      //     child: OverflowBox(
      //       maxHeight: 150,
      //       child: Align(
      //         alignment: Alignment.topCenter,
      //         child: Container(
      //           color: Colors.blue,
      //           width: 50,
      //           height: 50,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      // Stack
      // body: Center(
      //   child: Stack(
      //     clipBehavior: Clip.none,
      //     alignment: Alignment.center,
      //     children: [
      //       Container(
      //         color: Colors.green[400],
      //         width: 100,
      //         height: 100,
      //       ),
      //       Positioned(
      //           top: -25,
      //           child: Container(
      //             color: Colors.blue,
      //             width: 50,
      //             height: 50,
      //           ))
      //     ],
      //   ),
      // ),

      // Transform
      // body: Center(
      //   child: Container(
      //     color: Colors.green[400],
      //     width: 100,
      //     height: 100,
      //     alignment: Alignment.topCenter,
      //     child: Transform.translate(
      //       offset: const Offset(0, -25),
      //       child: Container(
      //         color: Colors.blue,
      //         width: 50,
      //         height: 50,
      //       ),
      //     ),
      //   ),
      // ),

      // FittedBox
      // body: Center(
      //   child: Container(
      //     color: Colors.green[400],
      //     width: 100,
      //     height: 100,
      //     child: FittedBox(
      //       fit: BoxFit.none,
      //       child: Container(
      //         height: 150,
      //         alignment: Alignment.topCenter,
      //         child: Container(
      //           color: Colors.blue,
      //           width: 50,
      //           height: 50,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      // Alignment
      body: Center(
        child: Container(
          color: Colors.green[400],
          width: 100,
          height: 100,
          alignment: const Alignment(0, -2),
          child: Container(
            color: Colors.blue,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}
