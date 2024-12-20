import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sample/learn/refresh_parent_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "刷新父子组件",
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
        title: const Text("flutter 刷新父子组件"),
      ),
      body: Column(
        children: [
          const RefreshParentWidget(),
          // 毛玻璃效果，会对下层所有的子组件起过滤效果
          Offstage(
            offstage: false,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                width: 300,
                height: 300,
                color: Colors.white24,
                child: Image.asset('images/sea.webp'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
