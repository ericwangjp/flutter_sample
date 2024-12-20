import 'package:flutter/material.dart';
import 'package:flutter_sample/model/CartModel.dart';
import 'package:flutter_sample/model/GoodsItem.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "状态共享",
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
        title: const Text("flutter shared state"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const [
            CartProvider(),
            NavBar(title: "标题一", color: Colors.blue),
            NavBar(title: "标题二", color: Colors.white),
          ],
        ),
      ),
    );
  }
}

/// 自定义实现 Provider

// 使用保存共享的数据 InheritedWidget 来实现 Provider
class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider({required this.data, required super.child});

  final T data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

// 订阅者类
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierProvider(
      {Key? key, required this.child, required this.data})
      : super(key: key);

  final Widget child;
  final T data;

  static T of<T>(BuildContext context, {bool listen = true}) {
    // final type = _typeOf<InheritedProvider<T>>();
    // final provider =
    //     context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;
    return provider!.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider(data: widget.data, child: widget.child);
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }
}

// 购物车示例: 显示购物车中所有商品总价
class CartProvider extends StatefulWidget {
  const CartProvider({Key? key}) : super(key: key);

  @override
  State<CartProvider> createState() => _CartProviderState();
}

class _CartProviderState extends State<CartProvider> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Builder(builder: (context) {
                  var cart = ChangeNotifierProvider.of<CartModel>(context);
                  return Text("总价：${cart.totalPrice}");
                }),
                Builder(builder: (context) {
                  debugPrint("ElevatedButton build");
                  return ElevatedButton(
                      onPressed: () {
                        ChangeNotifierProvider.of<CartModel>(context,
                                listen: false)
                            .add(GoodsItem(20, 1,'水果名'));
                      },
                      child: const Text("添加商品"));
                })
              ],
            );
          },
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(minHeight: 52, minWidth: double.infinity),
      decoration: BoxDecoration(color: color, boxShadow: const [
        BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3)
      ]),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                color.computeLuminance() < 0.5 ? Colors.white : Colors.black),
      ),
    );
  }
}
