import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sample/model/CartModel.dart';
import 'package:flutter_sample/model/GoodsItem.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "测试 provider",
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
          title: const Text("flutter provider 动态更新"),
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartModel()),
            // ChangeNotifierProvider(create: (context) => GoodsItem(1, 1, '梨')),
          ],
          child: const ChildWidget(),
        ));
  }
}

class ChildWidget extends StatefulWidget {
  const ChildWidget({Key? key}) : super(key: key);

  @override
  State<ChildWidget> createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  @override
  Widget build(BuildContext context) {
    // debugPrint('监听对象变化:${context.watch<GoodsItem>().name}');
    debugPrint('监听列表变化:${context.watch<CartModel>().items[0].name}');
    return Column(
      children: [
        Text('获取到列表的内容：${_getContent()}'),
        ElevatedButton(
          onPressed: () {
            _updateList();
          },
          child: const Text('更新列表'),
        ),
        Text('获取到对象的内容：${_getObjectContent()}'),
        const GrandsonWidget()
      ],
    );
  }

  String _getContent() {
    List<GoodsItem> itemList = context.watch<CartModel>().items;
    return itemList.map((e) => '${e.name} - ${e.count}').join("\n");
  }

  void _updateList() {
    List<GoodsItem> itemList = [];
    itemList.add(GoodsItem(6, 6, '苹果'));
    context.read<CartModel>().update(itemList);
  }

  String _getObjectContent() {
    // var goodsItem = context.watch<GoodsItem>();
    // return '${goodsItem.name} - ${goodsItem.count}';
    return context.watch<CartModel>().items[0].name;
  }
}

class GrandsonWidget extends StatefulWidget {
  const GrandsonWidget({Key? key}) : super(key: key);

  @override
  State<GrandsonWidget> createState() => _GrandsonWidgetState();
}

class _GrandsonWidgetState extends State<GrandsonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _updateGoodsItem();
          },
          child: const Text('更新对象'),
        )
      ],
    );
  }

  void _updateGoodsItem() {
    // context.read<GoodsItem>().update(GoodsItem(2, 2, '橘子'));
    context.read<CartModel>().items[0].updateName('榴莲3');
    context.read<CartModel>().updateAll();
    debugPrint('读取到的值：${context.read<CartModel>().items[0].name}');
  }
}
