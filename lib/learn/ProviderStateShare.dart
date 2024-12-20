import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/GoodsItem.dart';
import '../model/NewPerson.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "组件间状态共享",
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
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter provider"),
      ),
      body: Column(
        children: [
          // 暴露一个新的对象实例
          Provider(
            create: (_) => GoodsItem(2.5, 5,'苹果'),
            // 变量被读取时，create 和 update 函数才会被调用,如果你想预先计算一些对象内的逻辑，可以使用 lazy 参数来禁用这一行为
            lazy: false,
            // error 此时不能调用，使用下面的方式调用
            // child: Text("${context.watch<GoodsItem>().price}"),
            builder: (context, child) {
              return Text("${context.watch<GoodsItem>().price}");
            },
          ),
          ProxyProvider0(
              update: (a, b) => GoodsItem(3.5, count,'香蕉'),
              // child: (Text("将可能被外界修改的变量传入给对象")),
              builder: (context, child) {
                return Text(
                    "将可能被外界修改的变量传入给对象:${context.watch<GoodsItem>().count}");
              }),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  count += 1;
                });
              },
              // 注意的是，context.read<T>() 方法不会在值变化时让 widget 重新构建，并且不能在 StatelessWidget.build 和 State.build 内调用.
              // context.read<GoodsItem>().count
              child: Text("更新对象的值")),
          // 如果你要将一个已经存在的对象实例暴露出来， 你应当使用 provider 的 .value 构造函数
          // 使用 ChangeNotifierProvider.value 来提供一个当前已存在的 ChangeNotifier
          // MyChangeNotifier variable;
          // ChangeNotifierProvider.value(value: variable,child: Text("复用一个已存在的对象实例"),)
          TestProviderWidget(),
        ],
      ),
    );
  }
}

// 处理复杂状态方案：
// 1、使用 ChangeNotifier
// 2、使用 Provider.value 配合 StatefulWidget

class ExampleProvider extends StatefulWidget {
  const ExampleProvider({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<ExampleProvider> createState() => _ExampleProviderState();
}

class _ExampleProviderState extends State<ExampleProvider> {
  int _count = 0;

  void increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _count,
      child: Provider.value(
        value: this,
        child: widget.child,
      ),
    );
  }
}

class TestProviderWidget extends StatelessWidget {
  const TestProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleProvider(
      child: Column(
        children: const [
          TestText(),
          ButtonWidget()
        ],
      ),
    );
  }
}

class TestText extends StatelessWidget {
  const TestText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("读取状态：${context.watch<int>()}");
  }

}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<_ExampleProviderState>().increment();
        },
        child: const Text("修改状态"));
  }
}


