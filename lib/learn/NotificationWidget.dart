import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "通知",
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
        title: const Text("flutter notification"),
      ),
      body: Column(
        children: [
          // ScrollNotificationWidget(),
          CustomNotificationWidget()
        ],
      ),
    );
  }
}

class ScrollNotificationWidget extends StatelessWidget {
  const ScrollNotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
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
          default:
            debugPrint("idle fling");
            break;
        }
        return true;
      },
      child: Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("$index"),
            );
          },
          itemExtent: 50,
          itemCount: 20,
        ),
      ),
    );
  }
}

// 自定义通知
class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}

class CustomNotificationWidget extends StatefulWidget {
  const CustomNotificationWidget({Key? key}) : super(key: key);

  @override
  State<CustomNotificationWidget> createState() =>
      _CustomNotificationWidgetState();
}

class _CustomNotificationWidgetState extends State<CustomNotificationWidget> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += "${notification.msg} ";
          });
          return true;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () {
                      MyNotification("hello").dispatch(context);
                    },
                    child: Text("发送通知"));
              }),
              Text(_msg)
            ],
          ),
        ));
  }
}
