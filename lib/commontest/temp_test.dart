import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sample/commontest/excel_like_table.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter",
      theme: ThemeData(primarySwatch: Colors.blue),
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate
      // ],
      // supportedLocales: const [
      //   Locale('zh', 'CN'),
      //   Locale('en', 'US'),
      // ],
      home: const HomePage(),
      routes: {
        // '/': (context) => HomePage(),
        '/excel': (context) => const ExcelLikeTable(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _globalKey = GlobalKey();
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("flutter组件"),
        ),
        body: Column(
          children: [
            Center(
              child: CounterWidget(count: _counter),
            ),
            Center(
              child: Text('parent Count: $_counter', style: TextStyle(fontSize: 24)),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              _counter++;
            });
          },
          child: const Icon(Icons.camera),
        ));
  }

  Widget _getScreenshotWidget() {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        color: Colors.lightGreen,
        child: Column(
          children: [
            const Center(
              child: Text(
                'Hello, World!!!',
                style: TextStyle(color: Colors.blue, fontSize: 30),
              ),
            ),
            Image.asset('images/sea.webp'),
            ListBody(
                children: List.generate(
                    10,
                    (index) => Container(
                          color: Colors.red[300],
                          padding: const EdgeInsets.all(8.0),
                          child: Text('item $index'),
                        )))
          ],
        ),
      ),
    );
  }

  Future<void> _capturePng() async {
    try {
      RenderRepaintBoundary? boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      ui.Image? image = await boundary?.toImage();
      ByteData? byteData =
          await image?.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      if (pngBytes != null) {
        final directory = (await getExternalStorageDirectory())?.path;
        File imgFile = File('$directory/screenshot.png');
        imgFile.writeAsBytes(pngBytes);
        debugPrint('Image saved at ${imgFile.path}');
      } else {
        debugPrint('Image is null');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}

class CounterWidget extends StatefulWidget {
  final int count;

  const CounterWidget({Key? key, required this.count}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text('Count: ${widget.count}', style: TextStyle(fontSize: 24)),
    );
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count != oldWidget.count) {
      print("Count has been updated from ${oldWidget.count} to ${widget.count}");
    }
  }
}

