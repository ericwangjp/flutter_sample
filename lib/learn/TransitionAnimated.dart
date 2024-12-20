import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "滚动组件",
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
  Color _decorationColor = Colors.blue;
  var duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 滚动组件"),
      ),
      body: Column(
        children: [
          AnimatedDecorateBox(
              boxDecoration: BoxDecoration(color: _decorationColor),
              duration: duration,
              child: TextButton(onPressed: () {
                setState(() {
                  _decorationColor = Colors.red;
                });
              },
                  child: const Text("AnimatedDecorateBox",
                    style: TextStyle(color: Colors.white),))),
          const FlutterAnimatedWidgets()
        ],
      ),
    );
  }
}

// 过渡动画
class AnimatedDecorateBox extends StatefulWidget {
  const AnimatedDecorateBox({Key? key,
    required this.boxDecoration,
    required this.child,
    required this.duration,
    this.curve = Curves.linear,
    this.reverseDuration})
      : super(key: key);

  final BoxDecoration boxDecoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration? reverseDuration;

  @override
  State<AnimatedDecorateBox> createState() => _AnimatedDecorateBoxState();
}

class _AnimatedDecorateBoxState extends State<AnimatedDecorateBox>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController get controller => _controller;
  late AnimationController _controller;

  Animation<double> get animation => _animation;
  late Animation<double> _animation;

  late DecorationTween _tween;

  @override
  void initState() {
    _controller = AnimationController(vsync: this,
        duration: widget.duration,
        reverseDuration: widget.reverseDuration);

    _tween = DecorationTween(begin: widget.boxDecoration);
    _updateCurve();

    super.initState();
  }

  void _updateCurve() {
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return DecoratedBox(
          decoration: _tween
              .animate(_animation)
              .value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedDecorateBox oldWidget) {
    if (widget.curve != oldWidget.curve) {
      _updateCurve();
    }
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    if (widget.boxDecoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.boxDecoration;

      _controller
        ..value = 0
        ..forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// flutter 内置的自定义过渡动画
class FlutterAnimatedDecoratedBox extends ImplicitlyAnimatedWidget {
  final BoxDecoration decoration;
  final Widget child;

  const FlutterAnimatedDecoratedBox(
      {Key? key, required this.decoration, required this.child, Curve curve = Curves
          .linear, required super.duration});

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedDecoratedBoxState();
  }
}

class _AnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<FlutterAnimatedDecoratedBox> {
  late DecorationTween _decorationTween;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decorationTween.evaluate(animation), child: widget.child,);
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decorationTween = visitor(
      _decorationTween,
      widget.decoration,
          (value) => DecorationTween(begin: value as Decoration?),
    ) as DecorationTween;
  }

}

// flutter 预置过渡动画效果展示
class FlutterAnimatedWidgets extends StatefulWidget {
  const FlutterAnimatedWidgets({Key? key}) : super(key: key);

  @override
  State<FlutterAnimatedWidgets> createState() => _FlutterAnimatedWidgetsState();
}

class _FlutterAnimatedWidgetsState extends State<FlutterAnimatedWidgets> {
  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _textStyle = TextStyle(color: Colors.black);
  Color _decorationColor = Colors.blue;
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    var duration = const Duration(milliseconds: 400);
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(onPressed: () {
            setState(() {
              _padding = 20;
            });
          }, child: AnimatedPadding(
            duration: duration,
            padding: EdgeInsets.all(_padding),
            child: const Text("AnimatedPadding"),
          )),
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                AnimatedPositioned(duration: duration,
                  left: _left, child: ElevatedButton(onPressed: () {
                    setState(() {
                      _left = 100;
                    });
                  }, child: const Text("AnimatedPositioned")),)
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: AnimatedAlign(alignment: _align,
              duration: duration,
              child: ElevatedButton(onPressed: () {
                setState(() {
                  _align = Alignment.center;
                });
              }, child: const Text("AnimatedAlign")),),
          ),
          AnimatedContainer(
            duration: duration,
            height: _height,
            color: _color,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    _height = 150;
                    _color = Colors.blue;
                  });
                },
                child: const Text("AnimatedContainer",
                  style: TextStyle(color: Colors.white),)),),
          AnimatedDefaultTextStyle(
              style: _textStyle, duration: duration, child: GestureDetector(
            child: const Text("AnimatedDefaultTextStyle"), onTap: () {
            setState(() {
              _textStyle = const TextStyle(color: Colors.blue,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Colors.blue);
            });
          },)),
          AnimatedOpacity(opacity: _opacity,
            duration: duration,
            child: TextButton(onPressed: () {
              setState(() {
                _opacity = 0.2;
              });
            },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: const Text(
                "AnimatedOpacity", style: TextStyle(color: Colors.white),),),)
        ]
            .map((e) =>
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16), child: e,))
            .toList(),
      ),
    );
  }
}

