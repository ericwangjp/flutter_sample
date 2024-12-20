import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "粘性头",
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
  List<String> _data = [];

  @override
  void initState() {
    for (var i = 0; i < 40; i++) {
      _data.add('这是第$i项数据');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 粘性头"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverStickyHeader(
            header: Header(title: '1'),
            sliver: MultiSliver(
              children: [
                SliverStickyHeader(
                  header: Header(title: '1.1'),
                  sliver: _SliverLeaf(),
                ),
                SliverStickyHeader(
                  header: Header(title: '1.2'),
                  sliver: MultiSliver(
                    children: [
                      SliverStickyHeader(
                        header: Header(title: '1.2.1'),
                        sliver: _SliverLeaf(),
                      ),
                      SliverStickyHeader(
                        header: Header(title: '1.2.2'),
                        sliver: _SliverLeaf(),
                      ),
                      SliverStickyHeader(
                        header: Header(title: '1.2.3'),
                        sliver: _SliverLeaf(),
                      ),
                    ],
                  ),
                ),
                SliverStickyHeader(
                  header: Header(title: '1.3'),
                  sliver: _SliverLeaf(),
                ),
              ],
            ),
          ),
          SliverStickyHeader(
            header: Header(title: '2'),
            sliver: MultiSliver(
              children: [
                SliverStickyHeader(
                  header: Header(title: '2.1'),
                  sliver: _SliverLeaf(),
                ),
                SliverStickyHeader(
                  header: Header(title: '2.2'),
                  sliver: MultiSliver(
                    children: [
                      SliverStickyHeader(
                        header: Header(title: '2.2.1'),
                        sliver: _SliverLeaf(),
                      ),
                      SliverStickyHeader(
                        header: Header(title: '2.2.2'),
                        sliver: _SliverLeaf(),
                      ),
                      SliverStickyHeader(
                        header: Header(title: '2.2.3'),
                        sliver: _SliverLeaf(),
                      ),
                    ],
                  ),
                ),
                SliverStickyHeader(
                  header: Header(title: '2.3'),
                  sliver: _SliverLeaf(),
                ),
              ],
            ),
          ),
          SliverStickyHeader(
            header: Header(title: '3'),
            sliver: _SliverLeaf(),
          ),
          SliverStickyHeader(
            header: Header(title: '4'),
            sliver: MultiSliver(
              children: [
                SliverStickyHeader(
                  header: Header(title: '4.1'),
                  sliver: _SliverLeaf(),
                ),
                SliverStickyHeader(
                  header: Header(title: '4.2'),
                  sliver: _SliverLeaf(),
                ),
                SliverStickyHeader(
                  header: Header(title: '4.3'),
                  sliver: _SliverLeaf(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _SliverLeaf extends StatelessWidget {
  const _SliverLeaf();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        color: Colors.amber,
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    this.index,
    this.title,
    this.color = Colors.lightBlue,
  }) : super(key: key);

  final String? title;
  final int? index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hit $index');
      },
      child: Container(
        height: 60,
        color: color,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          title ?? 'Header #$index',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}