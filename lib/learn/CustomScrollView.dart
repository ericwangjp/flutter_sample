import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "滚动组件",
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const HomePage(),
      home: const SliverCoordinateScrollView(),
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
        title: const Text("CustomScrollView Slivers"),
      ),
      // body: CustomScrollViewWidget(),
      // body: const CustomCoordinateView(),
      body: const StickHeaderWidget(),
    );
  }
}

class CustomScrollViewWidget extends StatelessWidget {
  const CustomScrollViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildListView(),
    );
  }

  Widget buildListView() {
    var listView = ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("$index"),
        );
      },
      itemCount: 20,
    );
    return Column(
      children: [
        Expanded(child: listView),
        const Divider(
          color: Colors.grey,
        ),
        Expanded(child: listView)
      ],
    );
  }
}

/// 两个listview 联动
class CustomCoordinateView extends StatelessWidget {
  const CustomCoordinateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSliverList();
  }

  Widget buildSliverList() {
    var listView = SliverFixedExtentList(
      // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
      // 再次提醒，如果列表项高度相同，我们应该优先使用SliverFixedExtentList
      // 和 SliverPrototypeExtentList，如果不同，使用 SliverList.
      delegate: SliverChildBuilderDelegate((context, index) {
        return ListTile(
          title: Text("$index"),
        );
      }, childCount: 20),
      itemExtent: 50,
    );
    return CustomScrollView(
      slivers: [listView, listView],
    );
  }
}

class SliverCoordinateScrollView extends StatefulWidget {
  const SliverCoordinateScrollView({Key? key}) : super(key: key);

  @override
  State<SliverCoordinateScrollView> createState() =>
      _SliverCoordinateScrollViewState();
}

class _SliverCoordinateScrollViewState
    extends State<SliverCoordinateScrollView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true, // 滑动到顶端时会固定住
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("头部联动"),
              background: Image.asset(
                "images/sea.webp",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: PageView(
                children:  [
                  Text("111", textScaleFactor: 5),
                  Text("222", textScaleFactor: 5),
                  ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('内容$index'),
                      );
                    },
                    itemCount: 10,
                  ),
                  Text("333", textScaleFactor: 5)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
            height: 500,
            child: _buildNestedScrollView(),
          )),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 4),
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                        alignment: Alignment.center,
                        color: Colors.cyan[100 * (index % 9)],
                        child: Text("grid item $index"),
                      ),
                  childCount: 21),
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                        alignment: Alignment.center,
                        color: Colors.lightBlue[100 * (index % 9)],
                        child: Text("list item $index"),
                      ),
                  childCount: 20),
              itemExtent: 50)
        ],
      ),
    );
  }

  _buildNestedScrollView() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 230.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('复仇者联盟'),
                background: Image.network(
                  'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          ];
        },
        body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 80,
                color: Colors.primaries[index % Colors.primaries.length],
                alignment: Alignment.center,
                child: Text(
                  '组合ListView $index',
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              );
            },
            itemCount: 10));
  }
}

/// SliverPersistentHeader 使用

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverHeaderDelegate(
      {required this.maxHeight, this.minHeight = 0, required Widget child})
      : builder = ((a, b, c) => child);

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  SliverHeaderDelegate.builder(
      {required this.maxHeight, this.minHeight = 0, required this.builder});

  SliverHeaderDelegate.fixedHeight(
      {required double height, required Widget child})
      : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    // if(child.key!= null){
    debugPrint(
        "key: ${child.key}: shrinkOffset: $shrinkOffset overlapsContent: $overlapsContent");
    // }
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}

class StickHeaderWidget extends StatefulWidget {
  const StickHeaderWidget({Key? key}) : super(key: key);

  @override
  State<StickHeaderWidget> createState() => _StickHeaderWidgetState();
}

class _StickHeaderWidgetState extends State<StickHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      buildSliverList(),
      SliverPersistentHeader(
        delegate: SliverHeaderDelegate(
            maxHeight: 80, minHeight: 50, child: buildHeader(1)),
        pinned: true,
      ),
      buildSliverList(),
      SliverPersistentHeader(
        pinned: true,
        delegate:
            SliverHeaderDelegate.fixedHeight(height: 50, child: buildHeader(2)),
      ),
      buildSliverList(20)
    ]);
  }

  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade200,
      alignment: Alignment.centerLeft,
      child: Text("SliverPersistentHeader $i"),
    );
  }

  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            title: Text("$index"),
          );
        }, childCount: count),
        itemExtent: 50);
  }
}
