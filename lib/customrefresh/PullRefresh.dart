import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "下拉刷新",
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
  final List<int> _data = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 下拉刷新"),
      ),
      body: RefreshIndicator(onRefresh: _onRefresh, child: _getChild(type: 2)),
    );
  }

  Future<void> _onRefresh() {
    setState(() {
      _data.add(_data.length + 1);
    });
    return Future.delayed(const Duration(seconds: 1));
  }

  Widget _getChild({int type = 1}) {
    switch (type) {
      case 1:
        return ListView.separated(
            itemBuilder: (context, index) {
              return Center(
                heightFactor: 1.5,
                child: Text('数据:${_data[index]}'),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 10,
                color: Colors.red,
              );
            },
            itemCount: _data.length);
      case 2:
        return SingleChildScrollView(
          child: Container(
            color: Colors.green,
            height: 500,
            child: const Text(
              '可滚动父类',
              style: TextStyle(backgroundColor: Colors.orange),
            ),
          ),
        );
      default:
        return Container(
          child: const Text(
            '默认布局',
            textScaleFactor: 2,
          ),
        );
    }
  }
}
