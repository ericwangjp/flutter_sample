import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "导航",
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

/// 返回拦截
class _HomePageState extends State<HomePage> {
  DateTime? _lastPressedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("flutter 导航控制"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            WillPopScope(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text("1s内按下2次返回键退出"),
                ),
                onWillPop: () async {
                  if (_lastPressedTime == null ||
                      DateTime.now().difference(_lastPressedTime!) >
                          const Duration(seconds: 1)) {
                    _lastPressedTime = DateTime.now();
                    return false;
                  }
                  return true;
                }),
            const InheritedTestWidget()
          ],
        ));
  }
}

/// 数据共享
class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  final int data;

  static ShareDataWidget? of(BuildContext context) {
    // 使用父类数据，会调用 didChangeDependencies
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
    // 不使用父类数据，不会调用 didChangeDependencies
    // return context
    //     .getElementForInheritedWidgetOfExactType<ShareDataWidget>()
    //     ?.widget as ShareDataWidget?;
  }

  @override
  bool updateShouldNotify(covariant ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _ShareWidget extends StatefulWidget {
  const _ShareWidget({Key? key}) : super(key: key);

  @override
  State<_ShareWidget> createState() => _ShareWidgetState();
}

class _ShareWidgetState extends State<_ShareWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context)!.data.toString());
    // 此时 didChangeDependencies 不会调用
    // return const Text("未依赖父组件");
  }

  //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
  //如果build中没有依赖InheritedWidget，则此回调不会被调用。
  @override
  void didChangeDependencies() {
    debugPrint("didChangeDependencies");
    // 如果你需要在依赖改变后执行一些昂贵的操作，比如网络请求，这时最好的方式就是在此方法中执行，
    // 这样可以避免每次build()都执行这些昂贵操作
    super.didChangeDependencies();
  }
}

class InheritedTestWidget extends StatefulWidget {
  const InheritedTestWidget({Key? key}) : super(key: key);

  @override
  State<InheritedTestWidget> createState() => _InheritedTestWidgetState();
}

class _InheritedTestWidgetState extends State<InheritedTestWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _ShareWidget(),
            ),
            ElevatedButton(
                onPressed: () => setState(() => ++count),
                child: const Text("增加"))
          ],
        ),
      ),
    );
  }
}
