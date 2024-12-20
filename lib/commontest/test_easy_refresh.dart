import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/commontest/custom_circle_refresh_header.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "下拉刷新",
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
  late EasyRefreshController _controller;

  @override
  void initState() {
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 下拉刷新"),
      ),
      body: Column(
        children: [
          const Text(
            '这里是header',
            textScaleFactor: 2.0,
          ),
          // Expanded(child: DefaultPage()),
          Expanded(
            child: EasyRefresh.builder(
                header: CustomCircleRefreshHeader(
                    // iconDimension: 150,
                    pullIconBuilder: (context, state, animation) {
                      debugPrint('拖拽动画值：${animation.value}');
                      return RotationTransition(
                        turns: animation,
                        child: Image.asset(
                          'images/ic_green_refresh.png',
                          width: 30,
                          height: 30,
                        ),
                      );
                    },
                    refreshIcon: Image.asset(
                      'images/ic_green_refresh.png',
                      width: 30,
                      height: 30,
                    ),
                    succeededIcon: Image.asset(
                      'images/ic_green_refresh.png',
                      width: 30,
                      height: 30,
                    ),
                    iconTheme: IconThemeData().copyWith(color: Colors.green),
                    progressIndicatorSize: 30),
                //   notLoadFooter:NotLoadFooter(frictionFactor:(frictionFactor){
                //     return 3;
                //   }) ,
                childBuilder: (context, physics) {
                  return ListView.separated(
                      // physics: BouncingScrollPhysics(
                      //     parent:
                      //         AlwaysScrollableScrollPhysics(parent: physics)),
                      // physics: BouncingScrollPhysics(parent: physics),
                      //   physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics(parent: physics)),
                      physics: physics,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('这是第 $index 个'),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 10,
                          color: Colors.orange,
                        );
                      },
                      itemCount: 15);
                },
                onRefresh: _onRefresh),

            //     child: EasyRefresh(
            //   // controller: _controller,
            //   onRefresh: _onRefresh,
            //   child: const ListPage(),
            //   // child: const CustomScrollView(
            //   //   slivers: [
            //   //     SliverFillRemaining(child: DefaultPage(),)
            //   //   ],
            //   // )
            // )
          )
        ],
      ),
    );
  }

  FutureOr _onRefresh() {
    debugPrint('下拉刷新了~~~~');
  }
}
