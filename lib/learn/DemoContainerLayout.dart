import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "布局组件展示",
      theme: ThemeData(primarySwatch: Colors.lightGreen),
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
        title: const Text("flutter 布局组件"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: const [
            // ConstraintWidget(),
            // LinearLayoutWidget()
            // FlexWidget()
            // WrapWidget()
            // FlowWidget()
            // StackPositionedWidget()
            // AlignWidget()
            LayoutBuilderRoute()
          ],
        ),
      ),
    );
  }
}

class ConstraintWidget extends StatefulWidget {
  const ConstraintWidget({Key? key}) : super(key: key);

  @override
  State<ConstraintWidget> createState() => _ConstraintWidgetState();
}

class _ConstraintWidgetState extends State<ConstraintWidget> {
  final Widget _cyanBox =
      const DecoratedBox(decoration: BoxDecoration(color: Colors.cyan));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints:
              const BoxConstraints(minWidth: double.infinity, minHeight: 50),
          child: Container(
            height: 8,
            child: _cyanBox,
          ),
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: _cyanBox,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 100, height: 100),
          child: _cyanBox,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 90, minHeight: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 60, minHeight: 60),
            child: _cyanBox,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 60, minHeight: 100),
          child: UnconstrainedBox(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 90, minHeight: 20),
              child: _cyanBox,
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 2,
          child: _cyanBox,
        ),
        LimitedBox(
          maxHeight: 60,
          maxWidth: 100,
          child: _cyanBox,
        ),
        // FractionallySizedBox(widthFactor: 2,heightFactor: 3,child: _cyanBox,),
      ],
    );
  }
}

class LinearLayoutWidget extends StatefulWidget {
  const LinearLayoutWidget({Key? key}) : super(key: key);

  @override
  State<LinearLayoutWidget> createState() => _LinearLayoutWidgetState();
}

class _LinearLayoutWidgetState extends State<LinearLayoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("从左往后"),
                  Text("水平居中文本二"),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("从左往右"),
                  Text("水平居左二"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                textDirection: TextDirection.rtl,
                children: const [Text("从右往左"), Text("水平居左二")],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: const [
                  Text(
                    "水平居中一",
                    style: TextStyle(fontSize: 30),
                  ),
                  Text("水平居中二"),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [Text("哈哈"), Text("你好吗")],
          ),
          Container(
            color: Colors.grey,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: Colors.red,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [Text("哈哈"), Text("你好吗,测试宽度")],
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [Text("哈哈"), Text("你好吗,测试宽度")],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FlexWidget extends StatelessWidget {
  const FlexWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          // 1:2 占用屏幕宽
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 30,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                color: Colors.green,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 100,
            // 2:1:1 占用 100px
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    color: Colors.orange,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    color: Colors.lightBlue,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class WrapWidget extends StatelessWidget {
  const WrapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: const [
        Chip(
          label: Text("hello world !"),
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text("A"),
          ),
        ),
        Chip(
          label: Text("你好 !"),
          avatar: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text("B"),
          ),
        ),
        Chip(
          label: Text("happy"),
          avatar: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text("C"),
          ),
        ),
        Chip(
          label: Text("congratulation"),
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text("D"),
          ),
        ),
      ],
    );
  }
}

class FlowWidget extends StatelessWidget {
  const FlowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: MyFlowDelegate(margin: EdgeInsets.all(10)),
      children: [
        Container(
          width: 80,
          height: 80,
          color: Colors.blue,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.orange,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.green,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.red,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.yellow,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.amber,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.deepPurple,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.pink,
        ),
      ],
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  MyFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    for (int i = 0; i < context.childCount; i++) {
      var w = (context.getChildSize(i)?.width ?? 0) + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x = w + margin.left;
        debugPrint("水平绘制x：$x");
      } else {
        x = margin.left;
        y +=
            (context.getChildSize(i)?.height ?? 0) + margin.top + margin.bottom;
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x += (context.getChildSize(i)?.width ?? 0) + margin.left + margin.right;
        debugPrint("垂直绘制x：$x");
        debugPrint("垂直绘制y：$y");
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // return super.getSize(constraints);
    return const Size(double.infinity, 300);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class StackPositionedWidget extends StatelessWidget {
  const StackPositionedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 500, height: 500),
      child: Stack(
        alignment: Alignment.center,
        //确定没有定位的子组件如何去适应Stack的大小:
        // StackFit.loose表示使用子组件的大小，
        // StackFit.expand表示扩伸到Stack的大小。
        fit: StackFit.expand,
        children: [
          const Positioned(
            left: 20,
            child: Text("positioned 定位一"),
          ),
          Container(
            color: Colors.green,
            child: const Text("这是一段文本", style: TextStyle(color: Colors.white)),
          ),
          const Positioned(
            top: 20,
            child: Text("positioned 定位二"),
          ),
        ],
      ),
    );
  }
}

class AlignWidget extends StatelessWidget {
  const AlignWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.lime,
      width: 500,
      height: 500,
      child: Stack(
        alignment: Alignment.topLeft,
        fit: StackFit.loose,
        children: [
          Container(
            height: 120,
            width: 120,
            color: Colors.blue.shade50,
            child: const Align(
              // Alignment Widget会以矩形的中心点作为坐标原点，即Alignment(0.0, 0.0)
              alignment: Alignment.topRight,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),
          Positioned(
              left: 130,
              child: Container(
                color: Colors.blue.shade100,
                child: const Align(
                  widthFactor: 2,
                  heightFactor: 2,
                  alignment: Alignment(1, 0),
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              )),
          Positioned(
              top: 130,
              child: Container(
                width: 120,
                height: 120,
                color: Colors.blue.shade200,
                child: const Align(
                  alignment: FractionalOffset(0.2, 0.6),
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              )),
          const DecoratedBox(
            decoration: BoxDecoration(color: Colors.green),
            child: Center(
              child: Text("居中显示"),
              widthFactor: 2,
              heightFactor: 2,
            ),
          )
        ],
      ),
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 200) {
        return Column(
          children: children,
          mainAxisSize: MainAxisSize.min,
        );
      } else {
        var _children = <Widget>[];
        for (var i = 0; i < children.length; i += 2) {
          if (i + 1 < children.length) {
            _children.add(Row(
              children: [children[i], children[i + 1]],
              mainAxisSize: MainAxisSize.min,
            ));
          } else {
            _children.add(children[i]);
          }
        }
        return Column(
          children: _children,
          mainAxisSize: MainAxisSize.min,
        );
      }
    });
  }
}

class LayoutBuilderRoute extends StatelessWidget {
  const LayoutBuilderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children = List.filled(6, Text("A"));
    return Column(
      children: [
        SizedBox(
          width: 190,
          child: ResponsiveColumn(children: _children),
        ),
        ResponsiveColumn(children: _children),
        const LayoutLogPrint(child: Text("xx"),)
      ],
    );
  }
}

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({Key? key, required this.child, this.tag})
      : super(key: key);

  final Widget child;
  final T? tag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      assert(() {
        debugPrint("${tag ?? key ?? child} : $constraints");
        return true;
      }());
      return child;
    });
  }
}
