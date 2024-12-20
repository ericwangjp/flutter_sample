import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "事件与监听",
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
        title: const Text("flutter listener"),
      ),
      body: Column(
        children: [PointerMoveIndicator()],
      ),
    );
  }
}

class PointerMoveIndicator extends StatefulWidget {
  const PointerMoveIndicator({Key? key}) : super(key: key);

  @override
  State<PointerMoveIndicator> createState() => _PointerMoveIndicatorState();
}

class _PointerMoveIndicatorState extends State<PointerMoveIndicator> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Listener(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 300,
            height: 150,
            child: Text(
              '${_event?.localPosition ?? ''}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onPointerDown: (event) => setState(() => _event = event),
          onPointerMove: (event) => setState(() => _event = event),
          onPointerUp: (event) => setState(() => _event = event),
        ),
        Listener(
          // 忽略指针事件
          child: AbsorbPointer(
            child: Listener(
              child: Container(
                alignment: Alignment.center,
                color: Colors.lightGreen,
                width: 300,
                height: 150,
                child: Text(
                  '${_event?.localPosition ?? ''}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onPointerDown: (event) => debugPrint("内部响应事件 down"),
            ),
          ),
          onPointerDown: (event) => debugPrint("外部响应事件 down"),
          onPointerMove: (event) => debugPrint("外部响应事件 move"),
          onPointerUp: (event) => debugPrint("外部响应事件 up"),
        )
      ],
    );
  }
}
