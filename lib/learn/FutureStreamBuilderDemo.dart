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
      appBar: AppBar(
        title: const Text("future stream builder"),
      ),
      body: SingleChildScrollView(
        child: NotificationListener(
          onNotification: (notification) {
            switch (notification.runtimeType) {
              case ScrollStartNotification:
                debugPrint("开始滚动");
                break;
              case ScrollUpdateNotification:
                debugPrint("正在滚动");
                break;
              case ScrollEndNotification:
                debugPrint("滚动停止");
                break;
              case OverscrollNotification:
                debugPrint("滚动到边界");
                break;
            }
            return true;
          },
          child: Column(
            children: const [FutureBuilderWidget(), StreamBuilderWidget()],
          ),
        ),
      ),
    );
  }
}

class FutureBuilderWidget extends StatelessWidget {
  const FutureBuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('加载出错：${snapshot.error}');
            } else {
              return Text('加载成功：${snapshot.data}');
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
        future: mockNetworkData(),
      ),
    );
  }

  Future<String> mockNetworkData() {
    return Future.delayed(const Duration(seconds: 2), () => '接口返回网络数据');
  }
}

class StreamBuilderWidget extends StatelessWidget {
  const StreamBuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: myStream(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text('加载出错：${snapshot.error}');
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('未返回 stream');
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
                return Text('active 成功: ${snapshot.data}');
              case ConnectionState.done:
                return const Text('stream 加载完成');
            }
          }
        },
      ),
    );
  }

  Stream myStream() {
    return Stream.periodic(const Duration(seconds: 1), (value) => value);
  }
}
