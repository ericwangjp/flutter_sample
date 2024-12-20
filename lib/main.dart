import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第一个 Flutter APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate
      // ],
      // supportedLocales: const [Locale('zh', 'CN')],
      // home: const HomePage(),
      home: const StateLifecycleTest(),
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
        title: const Text("Home Title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Echo(text: "Hello World !"), ContextRoute()],
        ),
      ),
    );
  }
}

class Echo extends StatelessWidget {
  const Echo(
      {Key? key, required this.text, this.backgroundColor = Colors.blueGrey})
      : super(key: key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text, style: Theme.of(context).textTheme.headline4),
      ),
    );
  }
}

class ContextRoute extends StatelessWidget {
  const ContextRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      Scaffold? scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
      if (scaffold?.appBar is AppBar) {
        return Text((scaffold?.appBar as AppBar).title.toString(),
            style: Theme.of(context).textTheme.headline4);
      } else {
        return Text("出错了！", style: Theme.of(context).textTheme.headline4);
      }
    });
  }
}

/// StatefulWidget 生命周期
class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key, this.initValue = 0}) : super(key: key);

  final int initValue;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  static final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  /// 当 widget 第一次插入到 widget 树时会被调用，对于每一个State对象，Flutter 框架只会调用一次该回调
  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    debugPrint("initState $_counter");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build");
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: const Text("StatefulWidget生命周期"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: Text("$_counter"),
            onPressed: () => setState(() => ++_counter),
          ),
          Builder(builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  // ScaffoldState? state =
                  //     context.findAncestorStateOfType<ScaffoldState>();
                  // ScaffoldState state = Scaffold.of(context);
                  // state?.openDrawer();
                  _globalKey.currentState?.openDrawer();
                },
                child: const Text("打开抽屉菜单"));
          }),
          Builder(builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(content: const Text("Banner"), actions: [
                    const Icon(Icons.abc_sharp),
                    const Icon(Icons.access_time),
                    const Icon(Icons.access_alarm),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                      },
                      child: const Text("DISMISS"),
                    )
                  ]));
                },
                child: const Text("显示MaterialBanner"));
          }),
          GestureDetector(
              onTap: () {
                // 多次点击会依次弹出多个SnackBar
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("我是SnackBar")));
              },
              child: const CustomRenderObjectWidget(
                  color: Colors.orange, radius: 50)),
        ],
      )),
      drawer: const Drawer(child: Text('侧边抽屉', style: TextStyle(fontSize: 24))),
    );
  }

  /// 在 widget 重新构建时，Flutter 框架会调用widget.canUpdate来检测 widget 树中同一位置的新旧节点，然后决定是否需要更新
  /// widget.canUpdate会在新旧 widget 的 key 和 runtimeType 同时相等时会返回true,此时didUpdateWidget()就会被调用。
  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("didUpdateWidget");
  }

  /// 当 State 对象从树中被移除时，会调用此回调
  /// 如果移除后没有重新插入到树中则紧接着会调用dispose()方法。
  @override
  void deactivate() {
    super.deactivate();
    debugPrint("deactivate");
  }

  /// 当 State 对象从树中被永久移除时调用；通常在此回调中释放资源。
  @override
  void dispose() {
    super.dispose();
    debugPrint("dispose");
  }

  /// 此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用
  @override
  void reassemble() {
    super.reassemble();
    debugPrint("reassemble");
  }

  /// 当State对象的依赖发生变化时会被调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("didChangeDependencies");
  }
}

class StateLifecycleTest extends StatelessWidget {
  const StateLifecycleTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CounterWidget();
  }
}

/// 有两种方法在子 widget 树中获取父级 StatefulWidget 的State 对象:
/// 1、通过Context获取
/// context对象有一个findAncestorStateOfType()方法，该方法可以从当前节点沿着 widget 树向上查找指定类型的 StatefulWidget 对应的 State 对象。
/// 如果 StatefulWidget 的状态是希望暴露出的，应当在 StatefulWidget 中提供一个of 静态方法来获取其 State 对象，开发者便可直接通过该方法来获取；如果 State不希望暴露，则不提供of方法。
/// ScaffoldState? state = context.findAncestorStateOfType<ScaffoldState>();
/// Scaffold state = Scaffold.of(context) as Scaffold;
/// 2、通过 GlobalKey
/// 分两步：2.1 给目标StatefulWidget添加GlobalKey
///        2.2 通过GlobalKey来获取State对象
/// 定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
/// static GlobalKey<ScaffoldState> _globalKey= GlobalKey();
/// Scaffold(
///     key: _globalKey , //设置key
///     ...
/// )
/// GlobalKey 是 Flutter 提供的一种在整个 App 中引用 element 的机制。如果一个 widget 设置了GlobalKey，那么我们便可以通过globalKey.currentWidget获得该 widget 对象、
/// globalKey.currentElement来获得 widget 对应的element对象，如果当前 widget 是StatefulWidget，则可以通过globalKey.currentState来获得该 widget 对应的state对象。
/// 使用 GlobalKey 开销较大，如果有其他可选方案，应尽量避免使用它。另外，同一个 GlobalKey 在整个 widget 树中必须是唯一的，不能重复。

/// 自定义 RenderObject
/// Flutter 最原始的定义组件的方式就是通过定义RenderObject 来实现
/// 如果组件不会包含子组件，则我们可以直接继承自 LeafRenderObjectWidget
/// 如果自定义的 widget 可以包含子组件，则可以根据子组件的数量来选择继承SingleChildRenderObjectWidget 或
/// MultiChildRenderObjectWidget
class CustomRenderObjectWidget extends LeafRenderObjectWidget {
  final Color color;
  final double radius;

  const CustomRenderObjectWidget(
      {Key? key, required this.color, required this.radius})
      : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCircle(color: color, radius: radius);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCustomCircle renderObject) {
    super.updateRenderObject(context, renderObject);
    debugPrint("updateRenderObject");
    renderObject
      ..color = color
      ..radius = radius;
  }
}

class RenderCustomCircle extends RenderBox {
  Color _color;
  double _radius;
  final Paint _paint = Paint()..style = PaintingStyle.fill;

  RenderCustomCircle({required Color color, required double radius})
      : _color = color,
        _radius = radius {
    _paint.color = _color;
  }

  Color get color => _color;

  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  double get radius => _radius;

  set radius(double value) {
    if (_radius == value) return;
    _radius = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    // super.performLayout();
    debugPrint("performLayout");
    size = constraints.constrain(Size(_radius * 2, _radius * 2));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    debugPrint("paint");
    context.canvas
        .drawCircle(offset + Offset(_radius, _radius), _radius, _paint);
  }

  @override
  bool hitTestSelf(Offset position) {
    // return super.hitTestSelf(position);
    return true;
  }

  @override
  void performResize() {
    super.performResize();
    debugPrint("performResize");
  }

  @override
  void debugPaint(PaintingContext context, Offset offset) {
    super.debugPaint(context, offset);
    debugPrint("debugPaint");
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke;
    context.canvas.drawRect(offset & size, paint);
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    debugPrint("attach");
  }

  @override
  void detach() {
    super.detach();
    debugPrint("detach");
  }
}

/// 状态管理
/// 如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父 Widget 管理。
/// 如果状态是有关界面外观效果的，例如颜色、动画，那么状态最好由 Widget 本身来管理。
/// 如果某一个状态是不同 Widget 共享的则最好由它们共同的父 Widget 管理。

/// 路由管理
/// 路由钩子函数：MaterialApp有一个onGenerateRoute属性
/// 当调用Navigator.pushNamed(...)打开命名路由时，如果指定的路由名在路由表中已注册，
/// 则会调用路由表中的builder函数来生成路由组件；如果路由表中没有注册，才会调用onGenerateRoute来生成路由
/// onGenerateRoute 只会对命名路由生效
/// 开发中最好统一使用命名路由的管理方式

/// 包管理
/// Google 官方的 Dart Packages 仓库 Pub：
/// https://pub.flutter-io.cn/
/// https://pub.dev/

/// 要使用 Package 中定义的字体，必须提供package参数
/// 如果在 package 包内部使用它自己定义的字体，也应该在创建文本样式时指定package参数
/// 一个包也可以只提供字体文件而不需要在 pubspec.yaml 中声明。 这些文件应该存放在包的lib/文件夹中

/// 图片和 button
/// Flutter框架对加载过的图片是有缓存的（内存）

/// 布局类组件继承关系：
/// Widget > RenderObjectWidget > (Leaf/SingleChild/MultiChild)RenderObjectWidget
/// RenderObjectWidget类中定义了创建、更新RenderObject的方法，子类必须实现他们
/// 尺寸限制类容器用于限制容器大小，Flutter中提供了多种这样的容器，如ConstrainedBox、SizedBox、UnconstrainedBox、AspectRatio 等
/// BoxConstraints 是盒模型布局过程中父渲染对象传递给子渲染对象的约束信息，包含最大宽高信息，子组件大小需要在约束的范围内
/// BoxConstraints还定义了一些便捷的构造函数，用于快速生成特定限制规则的BoxConstraints:
/// 如BoxConstraints.tight(Size size)，它可以生成固定宽高的限制；
/// BoxConstraints.expand()可以生成一个尽可能大的用以填充另一个容器的BoxConstraints
/// 任何时候子组件都必须遵守其父组件的约束

/// Row和Column都只会在主轴方向占用尽可能大的空间，而纵轴的长度则取决于他们最大子元素的长度
/// 如果Row里面嵌套Row，或者Column里面再嵌套Column，那么只有最外面的Row或Column会占用尽可能大的空间，
/// 里面Row或Column所占用的空间为实际大小

/// Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，
/// 所以无论对子组件应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。

/// PageStorage是一个用于保存页面(路由)相关数据的组件
/// 子树中的Widget可以通过指定不同的PageStorageKey来存储各自的数据或状态。
///
