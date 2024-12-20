import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/model/chart_gpt.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../utils/image_watermark.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "网络组件",
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
  late Dio dio;
  String getRespResult = '等待请求';
  String postRespResult = '等待提问';
  String inputText = '';
  String requestKey = '';
  WebSocketChannel? channel;
  String? result;
  var hintInfo = {"id": 1, "from": "hint", "content": " "};

  @override
  void initState() {
    dio = Dio();
    // dio.httpClientAdapter =
    //     IOHttpClientAdapter(onHttpClientCreate: (HttpClient httpClient) {
    //   httpClient.findProxy = (uri) {
    //     return 'PROXY localhost:8888';
    //   };
    //   httpClient.badCertificateCallback =
    //       (X509Certificate x509certificate, String host, int port) => true;
    //   return httpClient;
    // });
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.findRenderObject()?.parent;
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter dio 与图片水印"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  _getData();
                },
                child: const Text(
                  '开始请求',
                  textScaleFactor: 1.5,
                )),
            Text('get 响应结果：$getRespResult'),
            TextField(
              decoration: InputDecoration(hintText: '请输入问题'),
              onChanged: (result) {
                inputText = result;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  _postData();
                },
                child: Text('发送')),
            Text('ChartGPT key：$postRespResult'),
            StreamBuilder(
              stream: channel?.stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Text('websocket 加载出错：${snapshot.error}');
                } else {
                  debugPrint('websocket 返回：${snapshot.data}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('websocket 未返回 stream');
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    case ConnectionState.active:
                      String dataContent = snapshot.data;

                      int n = dataContent.indexOf('￥\$￥');
                      if (-1 != n) {
                        if (n > 0) {
                          hintInfo['from'] = "assistant";
                          String content = hintInfo['content'] as String;
                          hintInfo['content'] =
                              content + dataContent.substring(0, n);
                          debugPrint('结果1：${hintInfo['content']}');
                        }
                      } else {
                        hintInfo['from'] = "assistant";
                        String content = hintInfo['content'] as String;
                        hintInfo['content'] = content + dataContent;
                        debugPrint('结果2：${hintInfo['content']}');
                      }
                      return Text('ChartGPT: ${hintInfo['content']}');
                    case ConnectionState.done:
                      return Text('${hintInfo['content']}\n加载完成');
                  }
                }
              },
            ),
            Container(
              height: 260,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/cat.jpg'), fit: BoxFit.fill)),
              child: ClipPath(
                clipper: WatermarkClipper(points: [
                  [
                    Offset(15, 15),
                    Offset(100, 15),
                    Offset(100, 100),
                    Offset(15, 100)
                  ],
                  [
                    Offset(30, 30),
                    Offset(100, 100),
                    Offset(80, 170),
                    Offset(30, 200)
                  ],
                  [
                    Offset(150, 30),
                    Offset(200, 50),
                    Offset(180, 150),
                    Offset(120, 200)
                  ]
                ]),
                child: Container(
                  color: Colors.lightBlue.withOpacity(0.3),
                  // transform: Matrix4.rotationZ(pi/4),// 旋转45度
                  child: const WatermarkWidget(watermarkText: '水印 223355'),
                ),
              ),
            ),
            FutureBuilder(
              future: imageAddWaterMark(
                  '/sdcard/DCIM/Screenshots/Screenshot_2022-12-08-13-39-12-840_com.katans.leader.jpg',
                  '水印 2323'),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('加载出错：${snapshot.error}');
                  } else {
                    return Image.file(snapshot.data);
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Container(
              // color: Colors.lightBlue,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/cat.jpg'), fit: BoxFit.fill)),
              child: ClipPath.shape(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Image.asset('images/sea.webp')),
              // child: ClipPath(
              //   clipper: ShapeBorderClipper(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10))),
              //   child: Image.asset('images/sea.webp'),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    /// 在加载后初始化
    Future.delayed(Duration.zero, () {
      waterMark(context);
    });
    super.didChangeDependencies();
  }

  Future<void> _getData() async {
    Response<String> response;
    try {
      response = await dio.get('https://www.baidu.com');
      debugPrint('==> ${response.statusCode}');
      setState(() {
        getRespResult = response.data ?? '出错了';
      });
    } catch (e, s) {
      setState(() {
        getRespResult = e.toString();
      });
    }

    debugPrint('==> $getRespResult');
  }

  Future<void> _postData() async {
    if (inputText.isEmpty) {
      inputText = '如何静下心来长时间集中注意力';
    }
    if (requestKey.isEmpty) {
      try {
        Response<String> response =
            await dio.post('https://tryai.top/api/chatfree', data: {
          'message': [
            {"id": 0, "from": "user", "content": inputText},
            hintInfo
          ]
        });
        debugPrint('==> ${response.statusCode}');
        debugPrint('==> ${response.data}');
        String respDate = response.data ?? '';
        if (respDate.isNotEmpty) {
          ChartGpt chartGpt = ChartGpt.fromJson(jsonDecode(respDate));
          requestKey = chartGpt.key ?? '';
          postRespResult = '请求key：$requestKey';
        } else {
          postRespResult = '出错了';
        }
        setState(() {});
        _connectWebSocket();
      } catch (e, s) {
        debugPrint('发生异常： $e - $s');
        setState(() {
          postRespResult = '发生异常：${e.toString()}';
        });
      }
    } else {
      _connectWebSocket();
    }
  }

  void waterMark(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Container(
          transform: Matrix4.rotationZ(-pi / 4), // 旋转45度
          child: CustomPaint(
            foregroundPainter: WaterMarkPainter(), // 保障水印在前面且不影响点击等操作
          ),
        );
      },
    );
    Overlay.of(context)?.insert(overlayEntry);
  }

  void _connectWebSocket() {
    if (requestKey.isNotEmpty && requestKey != '0') {
      final url = Uri.parse('wss://tryai.top/wsapi/?$requestKey&$requestKey');
      channel = WebSocketChannel.connect(url);
      // channel.stream.listen((message) {
      // 发送消息
      // channel.sink.add('received!');
      // 关闭 websocket
      // channel.sink.close(WebSocketStatus.goingAway);
      // });
    } else {
      debugPrint('请求次数超限');
    }
  }
}

/// painter类
class WaterMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < 10; i++) {
      for (var j = 0; j < 10; j++) {
        TextPainter(
            textDirection: TextDirection.ltr,
            text: const TextSpan(children: [
              TextSpan(
                  text: '水印 78899',
                  style: TextStyle(color: Colors.black12, height: 20)),
            ]))
          ..layout(maxWidth: 1875, minWidth: 1875)
          ..paint(canvas, Offset(700 - 201.0 * i, 500 - 100.0 * j));
      }
    }
  }

  @override
  bool shouldRepaint(WaterMarkPainter oldDelegate) {
    return false;
  }
}

class WatermarkClipper extends CustomClipper<Path> {
  WatermarkClipper({
    required this.points,
  }) : backgroundPath = Path();

  final Path backgroundPath;
  final List<List<Offset>> points;

  @override
  Path getClip(Size size) {
    backgroundPath.reset();
    debugPrint('获取宽高信息：宽- ${size.width} 高- ${size.height}');
    // path.lineTo(0.0, size.height / 2 - 20);
    // // 控制点一
    // Offset firstControlPoint = Offset(size.width / 4, size.height/2);
    // // 一阶贝塞尔曲线终点
    // Offset firstEndPoint = Offset(size.width / 2.25, size.height / 2 - 30);
    // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
    //     firstEndPoint.dx, firstEndPoint.dy);
    //
    // // 控制点二
    // Offset secondControlPoint =
    //     Offset(size.width - size.width / 3.25, size.height / 2 -65);
    // // 二阶贝塞尔曲线终点
    // Offset secondEndPoint = Offset(size.width, size.height / 2- 40);
    // path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
    //     secondEndPoint.dx, secondEndPoint.dy);
    //
    // path.lineTo(size.width, size.height / 2 -40);
    // // path.lineTo(size.width, 0.0);
    //
    // path.lineTo(size.width, size.height );
    // path.lineTo(0.0, size.height);
    // path.close();

    // path.addPolygon([
    //   Offset(size.width / 2 - 50, size.height / 2 - 50),
    //   Offset(size.width / 2, size.height / 2 - 80),
    //   Offset(size.width / 2 + 50, size.height / 2 - 50),
    //   Offset(size.width / 2 + 40, size.height / 2 + 30),
    //   Offset(size.width / 2 - 40, size.height / 2 + 30),
    // ], false);

    backgroundPath.fillType = PathFillType.evenOdd;
    backgroundPath
        .addRect(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));

    for (var element in points) {
      Path path = Path();
      path.moveTo(element.first.dx, element.first.dy);
      for (int i = 0; i < element.length; i++) {
        path.lineTo(element[i].dx, element[i].dy);
        if (i == element.length - 1) {
          path.close();
          backgroundPath.addPath(path, Offset.zero);
        }
      }
    }

    return backgroundPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    final WatermarkClipper watermarkClipper = oldClipper as WatermarkClipper;
    return watermarkClipper.points != points;
  }
}

/// 水印
class WatermarkWidget extends StatelessWidget {
  const WatermarkWidget(
      {Key? key,
      this.rowCount = 6,
      this.columnCount = 3,
      required this.watermarkText,
      this.watermarkTextStyle = const TextStyle(
        color: Colors.black12,
        fontSize: 14,
        decoration: TextDecoration.none,
      )})
      : super(key: key);

  final int rowCount;
  final int columnCount;
  final String watermarkText;
  final TextStyle watermarkTextStyle;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        children: List.generate(
          rowCount,
          (index) => Expanded(
            child: Row(
              children: List.generate(
                columnCount,
                (index) => Expanded(
                  child: Center(
                    child: Transform.rotate(
                      angle: -0.34,
                      child: Text(
                        watermarkText,
                        style: watermarkTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
