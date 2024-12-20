import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/utils/aspect_ratio_image.dart';
import 'package:flutter_sample/utils/image_utils.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "图片显示比例",
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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey _globalKey = GlobalKey();
  String _widthHeight = '';
  final String _imageUrl =
      'https://img2.baidu.com/it/u=617579813,2960860841&fm=253&fmt=auto&app=120&f=JPEG?w=1280&h=800';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    SystemChannels.lifecycle.setMessageHandler((message) {
      debugPrint('当前生命周期1：$message');
      return Future(() => message);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint("当前单次Frame绘制回调1：$timeStamp"); //只回调一次
      debugPrint(
          '当前宽1：${_globalKey.currentContext?.size?.width} - 高：${_globalKey.currentContext?.size?.height}');
    });
    WidgetsBinding.instance.addPersistentFrameCallback((duration) {
      debugPrint("当前实时Frame绘制回调2：$duration"); //每帧都回调
      debugPrint(
          '当前宽2：${_globalKey.currentContext?.size?.width} - 高：${_globalKey.currentContext?.size?.height}');
    });
    ImageUtils.loadImageFromNetwork(_imageUrl).then((value) {
      debugPrint('当前图片加载完成：宽-${value.width} 高-${value.height}');
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('当前生命周期2：$state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 图片显示比例"),
      ),
      body: Column(
        children: [
          Image.network(
            _imageUrl,
            fit: BoxFit.contain,
            key: _globalKey,
          ),
          Text(
            '图片宽高信息：$_widthHeight',
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _widthHeight =
                      '宽：${_globalKey.currentContext?.size?.width} - 高：${_globalKey.currentContext?.size?.height}';
                });
              },
              child: const Text('点击获取图片宽高')),
          AspectRatioImage.network(_imageUrl,
              builder: (context, snapshot, url) {
                return Text(
                  '宽：${snapshot.data?.width} - 高：${snapshot.data?.height}',
                  style: const TextStyle(fontSize: 25),
                );
              }),
          LayoutBuilder(builder: (context, constraints) {
            debugPrint('布局信息1:${constraints.maxHeight}');
            debugPrint('布局信息2:${constraints.minHeight}');
            return Image.network(
              _imageUrl,
              fit: BoxFit.contain,
            );
          }),
        ],
      ),
    );
  }
}
