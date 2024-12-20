import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "手势识别",
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
        title: const Text("flutter gesture detector"),
      ),
      // body: Column(
      //   children: [GestureWidget(),],
      // ),
      // body: DragEventWidget(),
      // body: ScaleGestureWidget(),
      body: GestureRecognizer(),
    );
  }
}

class GestureWidget extends StatefulWidget {
  const GestureWidget({Key? key}) : super(key: key);

  @override
  State<GestureWidget> createState() => _GestureWidgetState();
}

class _GestureWidgetState extends State<GestureWidget> {
  String _operation = "No Gesture detected!"; //保存事件名

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200,
          height: 100,
          child: Text(
            _operation,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        onTap: () => updateText("tap"),
        onDoubleTap: () => updateText("double tap"),
        onLongPress: () => updateText("long press"),
      ),
    );
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }
}

class DragEventWidget extends StatefulWidget {
  const DragEventWidget({Key? key}) : super(key: key);

  @override
  State<DragEventWidget> createState() => _DragEventWidgetState();
}

class _DragEventWidgetState extends State<DragEventWidget>
    with SingleTickerProviderStateMixin {
  double _top = 0;
  double _left = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: const CircleAvatar(
              child: Text("A"),
            ),
            onTapDown: (e) {
              debugPrint("用户手指按下：${e.globalPosition}");
            },
            onPanUpdate: (e) {
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (e) {
              debugPrint("结束了:${e.velocity}");
            },
          ),
        )
      ],
    );
  }
}

class ScaleGestureWidget extends StatefulWidget {
  const ScaleGestureWidget({Key? key}) : super(key: key);

  @override
  State<ScaleGestureWidget> createState() => _ScaleGestureWidgetState();
}

class _ScaleGestureWidgetState extends State<ScaleGestureWidget> {
  double _width = 300.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Image.asset(
          "images/sea.webp",
          width: _width,
        ),
        onScaleUpdate: (details) {
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

class GestureRecognizer extends StatefulWidget {
  const GestureRecognizer({Key? key}) : super(key: key);

  @override
  State<GestureRecognizer> createState() => _GestureRecognizerState();
}

class _GestureRecognizerState extends State<GestureRecognizer> {
  TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        const TextSpan(text: "你好啊"),
        TextSpan(
            text: "点我变色",
            style: TextStyle(
                fontSize: 30, color: _toggle ? Colors.blue : Colors.red),
            recognizer: _gestureRecognizer
              ..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              }),
        const TextSpan(text: "大家好才是真的好")
      ])),
    );
  }

  @override
  void dispose() {
    _gestureRecognizer.dispose();
    super.dispose();
  }
}
