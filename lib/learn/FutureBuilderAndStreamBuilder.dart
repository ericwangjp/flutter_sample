import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "异步UI更新",
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
        title: const Text("FutureBuilder StreamBuilder"),
      ),
      body: Column(
        children: [
          Center(
            child: FutureBuilder<String>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(
                      "error: ${snapshot.error}",
                      textScaleFactor: 2,
                    );
                  } else {
                    return Text(
                      "success: ${snapshot.data}",
                      textScaleFactor: 2,
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
              future: mockNetworkData(),
            ),
          ),
          const StreamBuilderWidget()
        ],
      ),
    );
  }

  Future<String> mockNetworkData() async {
    return Future.delayed(const Duration(seconds: 2), () => "我是从网络获取到的数据");
  }
}

class StreamBuilderWidget extends StatelessWidget {
  const StreamBuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "error: ${snapshot.error}",
            textScaleFactor: 2,
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text(
              "没有 stream ",
              textScaleFactor: 2,
            );
          case ConnectionState.waiting:
            return const Text(
              "没有数据",
              textScaleFactor: 2,
            );
          case ConnectionState.active:
            return Text(
              "success: ${snapshot.data}",
              textScaleFactor: 2,
            );
          case ConnectionState.done:
            return const Text(
              "stream 已经关闭",
              textScaleFactor: 2,
            );
        }
      },
      stream: counter(),
    );
  }

  Stream<int> counter() {
    return Stream.periodic(const Duration(seconds: 1), (value) {
      return value;
    });
  }
}
