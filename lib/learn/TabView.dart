import 'package:flutter/material.dart';
import 'package:flutter_sample/learn/tab_bar_vew_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TabBarView",
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const HomePage(),
      home: const TabViewWidget(),
      // home: const DefaultTabViewWidget(),
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
        title: const Text("flutter TabBarView"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class TabViewWidget extends StatefulWidget {
  const TabViewWidget({Key? key}) : super(key: key);

  @override
  State<TabViewWidget> createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabViewWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // List _tabs = ["新闻", "历史", "图片"];
  List<String> _tabs = ["新闻"];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    Future.delayed(const Duration(seconds: 5)).then((value) {
      setState(() {
        debugPrint('fqy--开始刷新tab');
        _tabController.dispose();
        _tabs = ["新闻", "历史"];
        _tabController = TabController(length: _tabs.length, vsync: this);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("_tabController:${_tabController.length}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("TabBarView"),
        bottom: TabBar(
          tabs: _tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((e) => TabBarViewWidget(title: e)).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _testFun() {
    debugPrint('开始执行');
    getPartnerCurPermissions().then((value) => debugPrint('获取到结果：$value'));
    debugPrint('执行结束');
  }

  Future getPartnerCurPermissions() async {
    return Future.delayed(const Duration(seconds: 3), () => 11).then((value) {
      debugPrint('获取结果成功$value');
      return value;
    });
  }
}

class DefaultTabViewWidget extends StatelessWidget {
  const DefaultTabViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tabs = ["新闻", "历史", "图片"];
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("TabBarView"),
              bottom: TabBar(
                tabs: tabs
                    .map((e) => Tab(
                          text: e,
                        ))
                    .toList(),
              ),
            ),
            body: TabBarView(
              children: tabs
                  .map((e) => Container(
                        alignment: Alignment.center,
                        child: Text(
                          e,
                          textScaleFactor: 5,
                        ),
                      ))
                  .toList(),
            )));
  }
}
