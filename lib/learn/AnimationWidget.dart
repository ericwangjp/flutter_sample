import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "动画",
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
        title: const Text("flutter animation"),
      ),
      body: Column(
        children: const [
          ScaleAnimationWidget(),
          SimplifyAnimationWidget(),
          FinalAnimWidget()
        ],
      ),
    );
  }
}

class ScaleAnimationWidget extends StatefulWidget {
  const ScaleAnimationWidget({Key? key}) : super(key: key);

  @override
  State<ScaleAnimationWidget> createState() => _ScaleAnimationWidgetState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationWidgetState extends State<ScaleAnimationWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    // 添加弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    animation = Tween(begin: 0.0, end: 200.0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/little_girl.jpeg',
        width: animation.value,
        height: animation.value,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// 动画简化版本
class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Image.asset(
        "images/little_girl.jpeg",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class SimplifyAnimationWidget extends StatefulWidget {
  const SimplifyAnimationWidget({Key? key}) : super(key: key);

  @override
  State<SimplifyAnimationWidget> createState() =>
      _SimplifyAnimationWidgetState();
}

class _SimplifyAnimationWidgetState extends State<SimplifyAnimationWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 200.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });

    //启动动画
    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedImage(animation: animation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// 最终版动画
class FinalAnimWidget extends StatefulWidget {
  const FinalAnimWidget({Key? key}) : super(key: key);

  @override
  State<FinalAnimWidget> createState() => _FinalAnimWidgetState();
}

class _FinalAnimWidgetState extends State<FinalAnimWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 200.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });
    //启动动画
    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: Image.asset(
          "images/little_girl.jpeg",
          width: animation.value,
          height: animation.value,
        ),
        builder: (context, child) {
          return Center(
            child: SizedBox(
              height: animation.value,
              width: animation.value,
              child: child,
            ),
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
