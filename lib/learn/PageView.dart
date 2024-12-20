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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 滚动组件"),
      ),
      body: PageViewWidget(),
    );
  }
}

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context); // 混入 AutomaticKeepAliveClientMixin 后，必须调用 super
    var children = <Widget>[];
    for (int i = 0; i < 6; ++i) {
      children.add(Center(
        child: Text(
          "${i + 1}",
          textScaleFactor: 5,
        ),
      ));
    }
    debugPrint("构建====");
    return PageView(
      children: children,
      allowImplicitScrolling: true,
      // scrollDirection: Axis.vertical,
    );
  }

  @override
  bool get wantKeepAlive => true; // 是否需要缓存

// 需要注意，如果我们采用 PageView.custom 构建页面时没有给列表项包装 AutomaticKeepAlive 父组件，则上述方案不能正常工作，
// 因为此时Client 发出消息后，找不到 Server，404 了
}
