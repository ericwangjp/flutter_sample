import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "数据监听",
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const HomePage(),
      home: const ValueListenableBuilderWidget(),
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
        title: const Text("flutter ValueListenable"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class ValueListenableBuilderWidget extends StatefulWidget {
  const ValueListenableBuilderWidget({Key? key}) : super(key: key);

  @override
  State<ValueListenableBuilderWidget> createState() =>
      _ValueListenableBuilderWidgetState();
}

class _ValueListenableBuilderWidgetState
    extends State<ValueListenableBuilderWidget> {
  final ValueNotifier<int> _counter = ValueNotifier(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text("ValueListenableBuilder"),
      ),
      body: Center(
        // builder 方法只会在 _counter 变化时被调用
        child: ValueListenableBuilder<int>(
          valueListenable: _counter,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child!,
                Text(
                  "$value 次",
                  textScaleFactor: textScaleFactor,
                )
              ],
            );
          },
          // 当子组件不依赖变化的数据，且子组件收件开销比较大时，指定 child 属性来缓存子组件非常有用
          child: const Text(
            "点击了",
            textScaleFactor: textScaleFactor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _counter.value += 1;
        },
      ),
    );
  }
}
