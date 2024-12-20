import 'package:english_words/english_words.dart';
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
      // home: const ScrollControllerWidget(),
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
      // body: const SingleChildScrollViewWidget(),
      // body: const ListViewDefaultWidget(),
      // body: const ListViewTwoWidget(),
      // body: const ListViewWithDivider(),
      // body: const FixedExtentList(),
      // body: const InfiniteListView(),
      // body: const ScrollNotificationWidget(),
      body: const AnimatedListWidget(),
    );
  }
}

class SingleChildScrollViewWidget extends StatelessWidget {
  const SingleChildScrollViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: str
              .split("")
              .map((e) => Text(
                    e,
                    textScaleFactor: 2,
                  ))
              .toList(),
        ),
      ),
    ));
  }
}

class ListViewDefaultWidget extends StatelessWidget {
  const ListViewDefaultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      children: const [
        Text('I\'m dedicating every day to you'),
        Text('Domestic life was never quite my style'),
        Text('When you smile, you knock me out, I fall apart'),
        Text('And I thought I was so smart'),
      ],
    );
  }
}

class ListViewTwoWidget extends StatelessWidget {
  const ListViewTwoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("$index"),
        );
      },
      itemCount: 100,
      itemExtent: 50,
    );
  }
}

class ListViewWithDivider extends StatelessWidget {
  const ListViewWithDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget divider1 = const Divider(
      color: Colors.blue,
    );
    Widget divider2 = const Divider(
      color: Colors.pink,
    );
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("$index"),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
        itemCount: 100);
  }
}

class FixedExtentList extends StatelessWidget {
  const FixedExtentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          title: Text("商品列表"),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("$index"),
            );
          },
              // itemExtent 二选一
          prototypeItem: const ListTile(
            title: Text("1"),
          ),
          itemCount: 100,
        ))
      ],
    );
  }
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({Key? key}) : super(key: key);

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {
          _words.insertAll(_words.length - 1,
              generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
        }));
  }

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (_words[index] == loadingTag) {
            if (_words.length - 1 < 100) {
              _retrieveData();
              return Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: const Text(
                  "我是有底线的~",
                  style: TextStyle(color: Colors.grey),
                ),
              );

              // return Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Image.asset("images/little_girl.jpeg",width: 1000,),
              // );
            }
          }
          return ListTile(
            title: Text(_words[index]),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            color: Colors.amber,
          );
        },
        itemCount: _words.length);
  }
}

class ScrollControllerWidget extends StatefulWidget {
  const ScrollControllerWidget({Key? key}) : super(key: key);

  @override
  State<ScrollControllerWidget> createState() => _ScrollControllerWidgetState();
}

class _ScrollControllerWidgetState extends State<ScrollControllerWidget> {
  final ScrollController _scrollController = ScrollController();
  bool showBackToTop = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      debugPrint("滚动距离：${_scrollController.offset}");
      if (_scrollController.offset < 1000 && showBackToTop) {
        setState(() {
          showBackToTop = false;
        });
      } else if (_scrollController.offset >= 1000 && !showBackToTop) {
        setState(() {
          showBackToTop = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滚动控制"),
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            },
            itemCount: 100,
            itemExtent: 50,
            controller: _scrollController),
      ),
      floatingActionButton: !showBackToTop
          ? null
          : FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              },
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }
}

class ScrollNotificationWidget extends StatefulWidget {
  const ScrollNotificationWidget({Key? key}) : super(key: key);

  @override
  State<ScrollNotificationWidget> createState() =>
      _ScrollNotificationWidgetState();
}

class _ScrollNotificationWidgetState extends State<ScrollNotificationWidget> {
  String _progress = "0%";

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) {
        double progress = scrollNotification.metrics.pixels /
            scrollNotification.metrics.maxScrollExtent;
        setState(() {
          _progress = "${(progress * 100).toInt()}%";
        });
        return false;
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
              );
            },
            itemExtent: 50,
            itemCount: 100,
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black54,
            child: Text(_progress),
          )
        ],
      ),
    ));
  }
}

class AnimatedListWidget extends StatefulWidget {
  const AnimatedListWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedListWidget> createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  var data = <String>[];
  int count = 5;
  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (var i = 0; i < count; i++) {
      data.add("${i + 1}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedList(
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: buildItem(context, index),
            );
          },
          key: globalKey,
          initialItemCount: data.length,
        ),
        buildAddBtn()
      ],
    );
  }

  Widget buildAddBtn() {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: FloatingActionButton(
        onPressed: (() {
          data.add("${++count}");
          globalKey.currentState?.insertItem(data.length - 1);
          debugPrint("添加$count");
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    String item = data[index];
    return ListTile(
      key: ValueKey(item),
      title: Text(item),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: (() {
          debugPrint("删除$index");
          globalKey.currentState?.removeItem(index, (context, animation) {
            var item = buildItem(context, index);
            data.removeAt(index);
            // 渐隐 + 缩小列表项动画
            return FadeTransition(
              opacity: CurvedAnimation(
                  parent: animation, curve: const Interval(0.5, 1)),
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: item,
              ),
            );
          }, duration: const Duration(milliseconds: 200));
        }),
      ),
    );
  }
}
