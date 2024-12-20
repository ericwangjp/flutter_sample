import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "自定义组件",
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
        title: const Text("flutter custom component"),
      ),
      body: Column(
        children: const [
          GradientButtonWidget()
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton(
      {Key? key,
      this.colors,
      this.width,
      this.height,
      this.borderRadius,
      this.onPressed,
      required this.child})
      : super(key: key);

  final List<Color>? colors;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final GestureTapCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    List<Color> _colors =
        colors ?? [themeData.primaryColor, themeData.primaryColorDark];
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientButtonWidget extends StatefulWidget {
  const GradientButtonWidget({Key? key}) : super(key: key);

  @override
  State<GradientButtonWidget> createState() => _GradientButtonWidgetState();
}

class _GradientButtonWidgetState extends State<GradientButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientButton(
          height: 50,
          onPressed: onClick,
          colors: const [Colors.orange, Colors.red],
          child: const Text("提交"),
        ),
        GradientButton(
          height: 50,
          onPressed: onClick,
          colors: [Colors.lightGreen, Colors.green.shade700],
          child: const Text("提交"),
        ),
        GradientButton(
          height: 50,
          onPressed: onClick,
          colors: [Colors.lightBlue.shade300, Colors.blueAccent],
          child: const Text("提交"),
        ),
      ],
    );
  }

  void onClick() {
    debugPrint("点击了");
  }
}
