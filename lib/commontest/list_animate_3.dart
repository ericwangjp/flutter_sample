import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';

class AnimateListThreePage extends StatelessWidget {
  const AnimateListThreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "列表动画",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  final options = const LiveOptions(
    // Start animation after (default zero)
    delay: Duration(milliseconds: 0),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 100),

    // Animation duration (default 250)
    showItemDuration: Duration(milliseconds: 200),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.025,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    reAnimateOnVisibility: false,
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("flutter 列表动画"),
        ),
        body: LiveList.options(
            itemBuilder: _buildAnimatedItem,
            separatorBuilder: (context, index) {
              return const Divider(
                height: 10,
                color: Colors.orange,
              );
            },
            itemCount: 20,
            options: widget.options));
  }

  Widget _buildAnimatedItem(
      BuildContext context, int index, Animation<double> animation) {
    return FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        // And slide transition
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(animation),
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.all(20),
            child: Text('这是第 $index 个'),
          ),
        ));
  }
}
