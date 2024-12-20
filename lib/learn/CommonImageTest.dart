import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "图片测试",
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
        title: const Text("flutter Image"),
      ),
      body: Column(
        children: [
          const Text('图片默认错误处理测试:'),
          Image.network("https://p.qqan.com/up/2022-9/16644331614271146.jpg",
              width: double.infinity,
              height: 300,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                    'images/cat.jpg',
                    height: 300,
                    width: double.infinity,
                  ))
        ],
      ),
    );
  }
}
