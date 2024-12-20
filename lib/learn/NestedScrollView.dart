import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "自定义滚动组件",
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const HomePage(),
      // home: const NestedScrollWidget(),
      // home: const SnapAppBar(),
      // home: const SnapAppBarFit(),
      home: const NestedTabBarView1(),
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
        title: const Text("custom sliver"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class NestedScrollWidget extends StatefulWidget {
  const NestedScrollWidget({Key? key}) : super(key: key);

  @override
  State<NestedScrollWidget> createState() => _NestedScrollWidgetState();
}

class _NestedScrollWidgetState extends State<NestedScrollWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text("嵌套ListView"),
                // pinned: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
              ),
              buildSliverList(5)
            ];
          },
          body: ListView.builder(
            itemBuilder: (context, index) {
              return SizedBox(
                height: 50,
                child: Center(
                  child: Text("Item $index"),
                ),
              );
            },
            padding: EdgeInsets.all(10),
            physics: ClampingScrollPhysics(),
            itemCount: 30,
          )),
    );
  }

  Widget buildSliverList(int i) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text("中间的 ListView $index"),
                ),
            childCount: i),
        itemExtent: 50);
  }
}

class SnapAppBar extends StatelessWidget {
  const SnapAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            floating: true,
            snap: true,
            // pinned: true,
            expandedHeight: 200,
            // collapsedHeight: 300,
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "images/sea.webp",
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      }, body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: [buildSliverList(100)],
          );
        },
      )),
    );
  }

  Widget buildSliverList(int i) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text("中间的 ListView $index"),
                ),
            childCount: i),
        itemExtent: 50);
  }
}

class SnapAppBarFit extends StatelessWidget {
  const SnapAppBarFit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              floating: true,
              snap: true,
              // pinned: true,
              expandedHeight: 200,
              // collapsedHeight: 300,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "images/sea.webp",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ];
      }, body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: [buildSliverList(100)],
          );
        },
      )),
    );
  }

  Widget buildSliverList(int i) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text("中间的 ListView $index"),
                ),
            childCount: i),
        itemExtent: 50);
  }
}

/// 嵌套 TabBarView
class NestedTabBarView1 extends StatelessWidget {
  const NestedTabBarView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _tabs = ["猜你喜欢", "今日特价", "发现更多"];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      title: const Text("商城"),
                      centerTitle: true,
                      leading: IconButton(
                          onPressed: () {
                            debugPrint("返回上一级页面");
                          },
                          icon: const Icon(Icons.arrow_back)),
                      floating: true,
                      snap: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                          tabs: _tabs
                              .map((e) => Tab(
                                    text: e,
                                  ))
                              .toList()),
                    ),
                  )
                ];
              },
              body: TabBarView(
                  children: _tabs
                      .map((e) => Builder(builder: (context) {
                            return CustomScrollView(
                              key: PageStorageKey(e),
                              slivers: [
                                SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context)),
                                SliverPadding(
                                  padding: const EdgeInsets.all(8),
                                  sliver: buildSliverList(50),
                                )
                              ],
                            );
                          }))
                      .toList()))),
    );
  }

  Widget buildSliverList(int i) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text("中间的 ListView $index"),
                ),
            childCount: i),
        itemExtent: 50);
  }
}
