import 'package:flutter/material.dart';

import '../ui/guide_widget/novice_guidance_builder.dart';

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
  late OverlayEntry _lastOverlay;
  final Widget _firstGuidance = Column(
    children: [
      const SizedBox(height: 40,),
      const Text('第一个新手引导'),
      const Spacer(),
      Image.asset('images/cat.jpg',height: 200,),
      const Spacer()
    ],
  );
  final Widget _secondGuidance = Column(
    children: [
      const Spacer(),
      const Text('第二个新手引导'),
      const Spacer(),
      Image.asset('images/little_girl.jpeg')
    ],
  );
  final Widget _thirdGuidance = Column(
    children: [
      Image.asset('images/sea.webp'),
      const Spacer(),
      const Text('第三个新手引导'),
      const Spacer()
    ],
  );
  int _curWidgetIndex = 0;

  @override
  void initState() {
    super.initState();
    _lastOverlay = OverlayEntry(builder: (ctx) {
      return GestureDetector(
        onTap: () {
          debugPrint('当前 index： $_curWidgetIndex');
          // 准备展示下一个overlay
          if (_curWidgetIndex < 2) {
            _curWidgetIndex++;
            _lastOverlay.markNeedsBuild();
          } else {
            // 引导全部显示完，移除 overlay
            _lastOverlay.remove();
          }
        },
        child: Container(
            color: Colors.black.withOpacity(0.7), child: _getCurWidget()),
      );
    });
    List<Widget> guidanceWidgets = [];
    guidanceWidgets.add(_firstGuidance);
    guidanceWidgets.add(_secondGuidance);
    guidanceWidgets.add(_thirdGuidance);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint('==绘制完成==');
      // Overlay.of(context)?.insert(_lastOverlay);
      NoviceGuidanceBuilder(context: context, guidanceWidgets: guidanceWidgets)
          .showGuidanceWidgets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("新手引导 overlay"),
      ),
      body: Column(
        children: [
          const Spacer(),
          const Text('这里是页面区域', textScaleFactor: 1.2),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                _curWidgetIndex = 0;
                Overlay.of(context)?.insert(_lastOverlay);
              },
              child: const Text('展示新手引导')),
          Image.asset('images/sea.webp'),
          const Spacer()
        ],
      ),
    );
  }

  Widget _getCurWidget() {
    switch (_curWidgetIndex) {
      case 0:
        return _firstGuidance;
      case 1:
        return _secondGuidance;
      case 2:
        return _thirdGuidance;
      default:
        return const Text('没有了');
    }
  }
}
