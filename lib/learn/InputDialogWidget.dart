import 'package:flutter/material.dart';
import 'package:flutter_sample/dialog/dialog_common_bottom.dart';
import 'package:flutter_sample/dialog/dialog_with_input.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "对话框",
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
        title: const Text("flutter dialog"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                FinishMakeUpDialog().show(context: context);
              },
              child: const Text('打开dialog')),
          ElevatedButton(
              onPressed: () {
                CommonBottomDialog().show(context: context);
              },
              child: const Text('打开通用dialog'))
        ],
      ),
    );
  }
}
