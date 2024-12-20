import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "禁止截屏",
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
  final _noScreenshot = NoScreenshot.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 禁止截屏"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: const Text('Press to toggle screenshot'),
                onPressed: () async {
                  final result = await _noScreenshot.toggleScreenshot();
                  debugPrint('-->$result');
                },
              ),
              ElevatedButton(
                child: const Text('Press to turn off screenshot'),
                onPressed: () async {
                  final result = await _noScreenshot.screenshotOff();
                  debugPrint('-->$result');
                },
              ),
              ElevatedButton(
                child: const Text('Press to turn on screenshot'),
                onPressed: () async {
                  final result = await _noScreenshot.screenshotOn();
                  debugPrint('-->$result');
                },
              ),
            ],
          )),
    );
  }
}
