import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "事件处理",
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
        title: const Text("flutter event"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class WaterMaskWidget extends StatelessWidget {
  const WaterMaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getWidget(1, Colors.white, 200),
      ],
    );
  }

  Widget getWidget(int index, color, double size) {
    return Listener(
      onPointerDown: (e) => debugPrint("$index"),
      child: Container(
        width: size,
        height: size,
        color: color ?? Colors.grey,
      ),
    );
  }
}


// 处理手势冲突
class CustomTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    // super.rejectGesture(pointer);
    //宣布成功
    super.acceptGesture(pointer);
  }
}

RawGestureDetector customGestureDetector({
  GestureTapCallback? onTap,
  GestureTapDownCallback? onTapDown,
  Widget? child,
}) {
  return RawGestureDetector(
    child: child,
    gestures: {
      CustomTapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<CustomTapGestureRecognizer>(
              () => CustomTapGestureRecognizer(), (detector) {
        detector.onTap = onTap;
      })
    },
  );
}


// 事件总线

