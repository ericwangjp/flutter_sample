import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "文本测试",
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
        title: const Text("flutter text"),
      ),
      body: Column(
        children: [
          const Text('文本长度测试:'),
          Wrap(
            runSpacing: 4,
            alignment: WrapAlignment.start,
            // crossAxisAlignment: WrapCrossAlignment.end,
            children: const [
              Text(
                '这是一个标签：',
                style: TextStyle(backgroundColor: Colors.green),
              ),
              // Flexible(child: Text('这里文本很长很长很长文本很长很长很长文本很长很长很长文本很长很长很长',style: TextStyle(backgroundColor: Colors.orange),))
              Text(
                '这里文本很长很长很长文本很长很长很长文本很长很长很长文本很长很长很长',
                style: TextStyle(backgroundColor: Colors.orange),
              )
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '这是一个标签：',
                style: TextStyle(backgroundColor: Colors.green),
              ),
              Expanded(
                child: Text(
                  '这里文本很长很长很长文本很长很长很长文本很长很长很长文本很长很长很长',
                  style: TextStyle(backgroundColor: Colors.orange),textAlign: TextAlign.end,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
