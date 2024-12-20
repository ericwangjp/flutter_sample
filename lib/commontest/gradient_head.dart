import 'dart:developer';

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
  _onScroll(offset) {
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

  @override
  void initState() {
    super.initState();
    _appBarAlpha = ValueNotifier(0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("渐变头"),
      // ),
      // body: Column(
      //   children: [],
      // ),


      //Stack相对布局
        body: Stack(
          children: [
            //移除上部的距离
            MediaQuery.removePadding(
              removeTop: true, //移除上部
              context: context,
              //监听滚动
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    //发生滚动并且是第0个元素
                    _onScroll(scrollNotification.metrics.pixels);
                    return true;
                  }
                  return false;
                },
                child: ListView(
                  children: [
                    SizedBox(
                      height: 260, //高度
                      //item1
                      child: Swiper(
                        itemCount: _imageUrl.length, //广告图片长度
                        autoplay: true, //自动播放
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imageUrl[index],
                            fit: BoxFit.fill, //图片适配方式
                          );
                        },
                        //设置指示器
                        pagination: const SwiperPagination(),
                      ),
                    ),
                    const SizedBox(
                      height: 800,
                      child: ListTile(
                        title: Text('ListTile'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //改变元素透明度,自定义了一个appbar
            ValueListenableBuilder(
              valueListenable: _appBarAlpha,
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('首页'),
                        )),
                  ),
                );
              },
            ),
            CircleAvatar(foregroundImage: NetworkImage(_imageUrl[1]),radius: 30)
          ],
        ));
  }

  @override
  void dispose() {
    _appBarAlpha.dispose();
    super.dispose();
  }

}
