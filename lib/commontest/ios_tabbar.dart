import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter",
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
      // appBar: AppBar(
      //   title: const Text("ios 灵动岛适配"),
      // ),
      body: Stack(
        children: [
          Image.asset('images/sea.webp'),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                title: const Text("ios 灵动岛适配"),
              )),
          Positioned(
              top: 5 + MediaQuery.of(context).padding.top,
              child: IconButton(
                  onPressed: () {
                    debugPrint('你点击我了');
                    BrnToast.showInCenter(
                        text: '你点击我了',
                        context: context,
                        duration: const Duration(seconds: 5));
                  },
                  icon: Image.asset('images/cat.jpg', width: 50, height: 50)))
        ],
      ),
    );
  }
}
