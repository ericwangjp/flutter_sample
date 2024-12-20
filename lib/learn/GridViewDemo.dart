import 'package:flutter/material.dart';

import 'iconmodel.dart';

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
      body: Column(
        children: const [
          GridViewWidget(),
          GridViewMaxCrossWidget(),
          Expanded(
            child: InfiniteGridView(),
          )
        ],
      ),
    );
  }
}

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GridView(
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 3, childAspectRatio: 1),
    //   shrinkWrap: true,
    //   children: const [
    //     Icon(Icons.ac_unit),
    //     Icon(Icons.airport_shuttle),
    //     Icon(Icons.all_inclusive),
    //     Icon(Icons.beach_access),
    //     Icon(Icons.cake),
    //     Icon(Icons.free_breakfast),
    //   ],
    // );
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1,
      shrinkWrap: true,
      children: const [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

class GridViewMaxCrossWidget extends StatelessWidget {
  const GridViewMaxCrossWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GridView(
    //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //       maxCrossAxisExtent: 120, childAspectRatio: 2),
    //   padding: EdgeInsets.zero,
    //   shrinkWrap: true,
    //   children: const [
    //     Icon(Icons.ac_unit),
    //     Icon(Icons.airport_shuttle),
    //     Icon(Icons.all_inclusive),
    //     Icon(Icons.beach_access),
    //     Icon(Icons.cake),
    //     Icon(Icons.free_breakfast),
    //   ],
    // );
    return GridView.extent(
      maxCrossAxisExtent: 120,
      childAspectRatio: 2,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: const [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

class InfiniteGridView extends StatefulWidget {
  const InfiniteGridView({Key? key}) : super(key: key);

  @override
  State<InfiniteGridView> createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  final List<IconData> _icons = [];

  @override
  void initState() {
    _retrieveIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1),
      itemBuilder: (context, index) {
        if (index == _icons.length - 1 && _icons.length < 200) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      },
      itemCount: _icons.length,
    );
  }

  void _retrieveIcons() {
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => setState(() {
              _icons.addAll([
                Icons.ac_unit,
                Icons.airport_shuttle,
                Icons.all_inclusive,
                Icons.beach_access,
                Icons.cake,
                Icons.free_breakfast,
              ]);
            }));
  }
}
