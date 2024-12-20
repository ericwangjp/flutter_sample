import 'package:flutter/material.dart';

import '../ui/guide_widget/prompt_builder.dart';
import '../ui/guide_widget/prompt_item.dart';

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
  GlobalKey centerWidgetKey = GlobalKey();
  GlobalKey bottomWidgetKey = GlobalKey();
  List<PromptItem> _prompts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint('==绘制完成==');
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        _prompts.add(PromptItem(centerWidgetKey, '这里是文字提示区域'));
        _prompts.add(PromptItem(bottomWidgetKey, '底部图片引导区域'));
        PromptBuilder.promptToWidgets(_prompts);
      });
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
          Text('这里是文本区域', textScaleFactor: 1.2, key: centerWidgetKey),
          const Spacer(),
          Image.asset(
            'images/sea.webp',
            key: bottomWidgetKey,
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                _prompts.add(PromptItem(centerWidgetKey, '这里是文字提示区域'));
                _prompts.add(PromptItem(bottomWidgetKey, '底部图片引导区域'));
                PromptBuilder.promptToWidgets(_prompts);
              },
              child: const Text('展示新手引导'))
        ],
      ),
    );
  }
}
