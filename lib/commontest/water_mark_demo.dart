import 'package:flutter/material.dart';

import '../ui/watermark_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "水印",
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
        title: const Text("flutter 水印"),
      ),
      // body: WatermarkWidget(
      //   watermarkText: "水印使用示例",
      //   child: Image.asset('images/sea.webp', fit: BoxFit.fill),
      //   // child: Text('实例文本---'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IgnorePointer(
              child: Stack(
                children: [
                  Image.asset(
                    'images/watermark_sample.png',
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 40,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: List.generate(
                          4,
                          (index) => Expanded(
                            child: Center(
                              child: Transform.rotate(
                                angle: 0,
                                child: const Text(
                                  '626188\n小灰灰',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.white24),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Text('水印测试'),
            Container(
                height: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/cat.jpg'), fit: BoxFit.fill)),
                child: const WatermarkWidget(watermarkText: '水印 12323233')),
            WatermarkWidget(
              watermarkText: "水印使用示例",
              height: 400,
              child: Image.asset('images/sea.webp', fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
