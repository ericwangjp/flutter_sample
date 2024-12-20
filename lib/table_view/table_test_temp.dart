import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticky Headers Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sticky Headers Demo'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item #$index'),
                );
              },
              childCount: 10,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 60.0,
              maxHeight: 200.0,
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Header 1',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ), onPinned: () {
                debugPrint('pinned one ');
            },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item #$index'),
                );
              },
              childCount: 20,
            ),
          ),
          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: _SliverAppBarDelegate(
          //     minHeight: 60.0,
          //     maxHeight: 200.0,
          //     child: Container(
          //       color: Colors.green,
          //       child: const Center(
          //         child: Text(
          //           'Header 2',
          //           style: TextStyle(color: Colors.white, fontSize: 24),
          //         ),
          //       ),
          //     ), onPinned: () {
          //     debugPrint('pinned two');
          //   },
          //   ),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item #${index + 20}'),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    required this.onPinned,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  final VoidCallback onPinned;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset >= (maxHeight - minHeight)) {
      onPinned();
    }
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
