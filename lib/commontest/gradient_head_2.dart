import 'dart:math';

import 'package:auto_animated/auto_animated.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

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
  final _appbarScrollOffset = 100;
  final List _imageUrl = [
    'https://upload-images.jianshu.io/upload_images/5809200-a99419bb94924e6d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
    'https://upload-images.jianshu.io/upload_images/5809200-736bc3917fe92142.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
    'https://upload-images.jianshu.io/upload_images/5809200-7fe8c323e533f656.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
    'https://upload-images.jianshu.io/upload_images/5809200-48dd99da471ffa3f.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
    'https://upload-images.jianshu.io/upload_images/5809200-4de5440a56bff58f.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ];
  late ValueNotifier<double> _appBarAlpha;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _appBarAlpha = ValueNotifier(0);
    _scrollController.addListener(_onPageScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("渐变头"),
      // ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 260,
            centerTitle: true,
            title: ValueListenableBuilder(
              valueListenable: _appBarAlpha,
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: Text('我的'),
                );
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              // title: ValueListenableBuilder(
              //   valueListenable: _appBarAlpha,
              //   builder: (BuildContext context, double value, Widget? child) {
              //     return Opacity(
              //       opacity: value,
              //       child: Text('我的'),
              //     );
              //   },
              // ),
              centerTitle: true,
              // collapseMode: CollapseMode.pin,
              stretchModes: const [StretchMode.fadeTitle],
              background: Image.network(
                _imageUrl[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPersistentHeader(
              floating: true,
              pinned: false,
              delegate: MySliverPersistentHeaderDelegate(150, 50, Text('标题'))),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Container(
                            alignment: Alignment.center,
                            color: Colors.cyan[100 * (index % 9)],
                            child: Text('grid item $index'),
                          ),
                      childCount: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 4)),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建列表项
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('list item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1),
                  children: List.generate(30, (index) => Text('第$index个'))),
            ),
          )
        ],
      ),

      //Stack相对布局
      //     body: Stack(
      //   children: [
      //     //移除上部的距离
      //     MediaQuery.removePadding(
      //       removeTop: true, //移除上部
      //       context: context,
      //       //监听滚动
      //       child: NotificationListener(
      //         onNotification: (scrollNotification) {
      //           if (scrollNotification is ScrollUpdateNotification &&
      //               scrollNotification.depth == 0) {
      //             //发生滚动并且是第0个元素
      //             _onScroll(scrollNotification.metrics.pixels);
      //             return true;
      //           }
      //           return false;
      //         },
      //         child: ListView(
      //           // shrinkWrap: true,
      //           children: [
      //             SizedBox(
      //               height: 260, //高度
      //               //item1
      //               child: Swiper(
      //                 itemCount: _imageUrl.length, //广告图片长度
      //                 autoplay: true, //自动播放
      //                 itemBuilder: (BuildContext context, int index) {
      //                   return Image.network(
      //                     _imageUrl[index],
      //                     fit: BoxFit.fill, //图片适配方式
      //                   );
      //                 },
      //                 //设置指示器
      //                 pagination: const SwiperPagination(),
      //               ),
      //             ),
      //             // const SizedBox(
      //             //   height: 800,
      //             //   child: ListTile(
      //             //     title: Text('ListTile'),
      //             //   ),
      //             // )
      //             const Divider(
      //               color: Colors.grey,
      //             ),
      //             SizedBox(
      //               height: 50,
      //               child: ListView.builder(
      //                 itemBuilder: (BuildContext context, int index) {
      //                   return ListTile(title: Text("第 $index 个"));
      //                 },
      //                 scrollDirection : Axis.horizontal,
      //                 itemCount: 20,
      //                 itemExtent: 50,
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //     //改变元素透明度,自定义了一个appbar
      //     ValueListenableBuilder(
      //       valueListenable: _appBarAlpha,
      //       builder: (BuildContext context, double value, Widget? child) {
      //         return Opacity(
      //           opacity: value,
      //           child: Container(
      //             height: 80,
      //             decoration: const BoxDecoration(color: Colors.white),
      //             child: const Center(
      //                 child: Padding(
      //               padding: EdgeInsets.only(top: 20),
      //               child: Text('首页'),
      //             )),
      //           ),
      //         );
      //       },
      //     )
      //   ],
      // )
    );
  }

  @override
  void dispose() {
    _appBarAlpha.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onPageScroll() {
    // if (_scrollController.offset >=
    //     (_scrollController.position.maxScrollExtent - kToolbarHeight))

    // double alpha = _scrollController.offset / (260- kToolbarHeight);
    double alpha = 0;
    debugPrint('偏移量：${_scrollController.offset}');
    //  渐变色
    if (_scrollController.offset >= 260 - kToolbarHeight) {
      // 203
      alpha = 1;
    } else if (_scrollController.offset >= 160) {
      alpha = _scrollController.offset / 160 * 0.5;
    }
    debugPrint('透明度：$alpha');
    _appBarAlpha.value = alpha.clamp(0, 1);
  }

  void _onScroll(offset) {
    //offset滚动距离
    double alpha = offset / _appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    // setState(() {
    _appBarAlpha.value = alpha;
    // });
    debugPrint('透明度：$_appBarAlpha');
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  MySliverPersistentHeaderDelegate(this.maxHeight, this.minHeight, this.child);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => max(minHeight, maxHeight);

  @override
  double get minExtent => min(minHeight, maxHeight);

  @override
  bool shouldRebuild(covariant MySliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
