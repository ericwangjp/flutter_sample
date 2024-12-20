import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';

import 'notification_jump_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InAppNotification(
      child: MaterialApp(
        title: "应用内通知",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
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
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text("flutter 应用内通知"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    InAppNotification.show(
                        child: _notificationDialog(),
                        context: context,
                        duration: const Duration(seconds: 5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationJumpPage(payload: '订单来了'),
                            ),
                          );
                        });
                  },
                  child: const Text('显示一个通知')),
              ElevatedButton(
                  onPressed: () {
                    InAppNotification.dismiss(context: context);
                  },
                  child: const Text('消失一个通知')),
              // ElevatedButton(onPressed: (){
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //       const NotificationHomePage(),
              //     ),
              //   );
              // }, child: const Text('另外一种效果'))
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationDialog() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        children: [
          Image.asset('images/little_girl.jpeg', width: 50),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('消息标题',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Text('消息内容，订单来了',
                  style: TextStyle(fontSize: 12, color: Colors.black45)),
            ],
          ),
        ],
      ),
    );
  }
}
