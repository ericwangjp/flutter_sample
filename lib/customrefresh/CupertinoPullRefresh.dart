import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/customrefresh/CircleRefreshWidget.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter cupertino 下拉刷新"),
      ),
      // body: Column(
      //   children: const [
      //     Text('这里是header'),
      //     // Expanded(child: CustomRefreshDemo())
      //     Expanded(child: CustomRefreshWidget())
      //     // CustomRefreshWidget()
      //   ],
      // ),
      body: CustomRefreshWidget(),
    );
  }
}

/// 下拉刷新
class CustomRefreshWidget extends StatefulWidget {
  const CustomRefreshWidget({Key? key}) : super(key: key);

  @override
  State<CustomRefreshWidget> createState() => _CustomRefreshWidgetState();
}

class _CustomRefreshWidgetState extends State<CustomRefreshWidget>
    with SingleTickerProviderStateMixin {
  final List<int> _data = [1, 2, 3, 4];
  late AnimationController _animationController;
  late EasyRefreshController _controller;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // _animationController.forward();
    // _animationController.addStatusListener((status) {
    //   if(status == AnimationStatus.completed){
    //     _animationController.reset();
    //     _animationController.forward();
    //   }
    // });
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _controller,
      header: ClassicHeader(),
      child: Container(
        color: Colors.lightGreen,
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: SingleChildScrollView(
            child: Container(
              color: Colors.lightBlue,
                height: 100,
                child: Text(
          '不是列表',
          style: TextStyle(backgroundColor: Colors.blue),
        ))),
      ),
      // child: Column(
      //   children: [
      //     Expanded(child: _getChild(type: 4)),
      //     ElevatedButton(onPressed: (){
      //       _controller.callRefresh();
      //       // _controller.callLoad();
      //     }, child: Text('下拉刷新'))
      //   ],
      // ),
      onLoad: () async {
        debugPrint('加载更多');
      },
      onRefresh: () async {
        debugPrint('下拉刷新');
        _controller.finishRefresh();
        _controller.resetFooter();
      },
    );

    // return EasyRefresh.builder(
    //   childBuilder: (context, physics) {
    //     return Container(
    //       color: Colors.green,
    //       width: MediaQuery.of(context).size.width,
    //       child: SingleChildScrollView(
    //         physics: physics,
    //         child: Container(
    //           color: Colors.lightGreen,
    //           // height: 500,
    //           child: Text('非列表'),
    //         ),
    //       ),
    //       // child: ListView.builder(
    //       //   physics: physics,
    //       //   itemBuilder: (context, index) {
    //       //     return Text('这里是文本 $index');
    //       //   },
    //       //   itemCount: 10,
    //       //   itemExtent: 50,
    //       // ),
    //     );
    //   },
    //   onRefresh: () async {},
    //   // onLoad: () async {},
    // );

    // return CustomScrollView(
    //   // shrinkWrap: true,
    //   physics:
    //       const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    //   slivers: [
    //     CupertinoSliverRefreshControl(
    //       refreshTriggerPullDistance: 100,
    //       refreshIndicatorExtent: 60,
    //       onRefresh: _onRefresh,
    //       // builder: _getRefreshWidget,
    //     ),
    //     // SliverFixedExtentList(
    //     //     delegate: SliverChildBuilderDelegate((context, index) {
    //     //       return Column(
    //     //         children: [
    //     //           Text('外层列表：$index'),
    //     //           Expanded(
    //     //             child: ListView.separated(
    //     //                 physics: const ClampingScrollPhysics(),
    //     //                 itemBuilder: (context, index) {
    //     //                   return Column(
    //     //                     children: [
    //     //                       Text(
    //     //                         '内层列表 $index',
    //     //                         textScaleFactor: 2.0,
    //     //                       )
    //     //                     ],
    //     //                   );
    //     //                 },
    //     //                 separatorBuilder: (context, index) {
    //     //                   return const Divider(
    //     //                     color: Colors.red,
    //     //                   );
    //     //                 },
    //     //                 itemCount: 15),
    //     //           ),
    //     //         ],
    //     //       );
    //     //
    //     //       // return const ListTile(
    //     //       //   title: Text(
    //     //       //     'SliverFixedExtentList',
    //     //       //     textScaleFactor: 2.0,
    //     //       //   ),
    //     //       // );
    //     //     }, childCount: 5),
    //     //     itemExtent: 50),
    //     SliverToBoxAdapter(child: _getChild(type: 3)),
    //   ],
    // );
    // return NestedScrollView(
    //   // physics:
    //   //     const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //     return [
    //       CupertinoSliverRefreshControl(
    //         refreshTriggerPullDistance: 100,
    //         refreshIndicatorExtent: 60,
    //         onRefresh: _onRefresh,
    //         // builder: _getRefreshWidget,
    //       ),
    //       SliverFixedExtentList(
    //           delegate: SliverChildBuilderDelegate((context, index) {
    //             return const ListTile(
    //               title: Text(
    //                 'SliverFixedExtentList',
    //                 textScaleFactor: 2.0,
    //               ),
    //             );
    //           }, childCount: 5),
    //           itemExtent: 50)
    //     ];
    //   },
    //   body: _getChild(type: 3),
    // );
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 5))
        .then((value) => setState(() {
              _data.add(_data.length + 1);
            }));
  }

  Widget _getChild({int type = 1}) {
    switch (type) {
      case 1:
        return SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Center(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('数据：${_data[index]}'),
                          ),
                          const Divider(
                            height: 10,
                            color: Colors.orange,
                          )
                        ],
                      ),
                    ),
                childCount: _data.length));
      case 2:
        return SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.green,
              height: 500,
              child: const Text(
                '可滚动父类',
                style: TextStyle(backgroundColor: Colors.orange),
              ),
            ),
          ),
        );
      case 3:
        // return SliverMultiBoxAdaptorElement(widget);
        //   SliverMultiBoxAdaptorWidget;
        //   RenderSliverMultiBoxAdaptor;
        // return RenderSliverToBoxAdapter(child: );
        return Container(
            color: Colors.orange,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Text('这里是文本 $index');
              },
              itemCount: 10,
              itemExtent: 50,
            ));
      case 4:
        return ListView.separated(
            itemBuilder: (context, index) {
              return Column(
                children: const [
                  Text(
                    '这里是文字',
                    textScaleFactor: 2.0,
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.red,
              );
            },
            itemCount: 15);
      case 5:
        return Container(
          color: Colors.green,
          child: Text('假装布局'),
        );
      default:
        return const SliverToBoxAdapter(
          child: Text(
            '默认布局',
            textScaleFactor: 3,
          ),
        );
    }
  }

  Widget _getRefreshWidget(
      BuildContext context,
      RefreshIndicatorMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent) {
    final double percentageComplete =
        (pulledExtent / refreshTriggerPullDistance).clamp(0.0, 1.0);
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              child: _buildRefreshWidget(refreshState, percentageComplete))
        ],
      ),
    );
  }

  Widget _buildRefreshWidget(
      RefreshIndicatorMode refreshState, double percentageComplete) {
    switch (refreshState) {
      case RefreshIndicatorMode.drag:
        // While we're dragging, we draw individual ticks of the spinner while simultaneously
        // easing the opacity in. Note that the opacity curve values here were derived using
        // Xcode through inspecting a native app running on iOS 13.5.
        const Curve opacityCurve = Interval(0.0, 0.35, curve: Curves.easeInOut);
        return Opacity(
          opacity: opacityCurve.transform(percentageComplete),
          child: CircleRefreshIndicator.partiallyRevealed(
              radius: 14, progress: percentageComplete),
          // CircularProgressIndicator(
          //     value: percentageComplete,
          //     valueColor: ColorTween(begin: Colors.orange, end: Colors.blue)
          //         .animate(CurvedAnimation(
          //       parent: _animationController,
          //       curve: const Interval(0.0, 0.35, curve: Curves.easeInOut),
          //     ))) // CupertinoActivityIndicator.partiallyRevealed(radius: 14, progress: percentageComplete),
        );
      case RefreshIndicatorMode.armed:
      case RefreshIndicatorMode.refresh:
        // Once we're armed or performing the refresh, we just show the normal spinner.
        return CircleRefreshIndicator(
          radius: 14,
          activeColors: [Colors.blue, Colors.orange],
        );
      case RefreshIndicatorMode.done:
        // When the user lets go, the standard transition is to shrink the spinner.
        return CircleRefreshIndicator(radius: 14 * percentageComplete);
      case RefreshIndicatorMode.inactive:
        // Anything else doesn't show anything.
        return Container();
    }
  }
}
