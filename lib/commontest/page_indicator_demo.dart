import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// void main() => runApp(const MyApp());
void main() {
  // 开启可视化布局调试
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "指示器",
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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  late TabController _switchController;
  final List<String> _titleList = <String>[
    '关注',
    '推荐',
    '抗疫',
    '热榜',
    '精品课',
    '旅游',
    '资讯',
    '美食'
  ];
  final _colors = const [
    Colors.red,
    Colors.green,
    Colors.greenAccent,
    Colors.amberAccent,
    Colors.blue,
    Colors.amber,
    Colors.orange,
    Colors.teal,
  ];
  int _activeIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: _titleList.length, vsync: this);
    _switchController = TabController(length: 2, vsync: this);
    _pageController = PageController(viewportFraction: 0.8, keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    _switchController.dispose();
    super.dispose();
  }

  void _changeTab(int index) {
    debugPrint('切换 tab');
    _activeIndex = index;
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChanged(int index) {
    debugPrint('pageview 页面变化了：$index');
    _tabController.animateTo(index,
        duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final pages = List.generate(
        _titleList.length,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              clipBehavior: Clip.hardEdge,
              child: ChildPageView(parentPageController: _pageController),
            ));
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 页面指示器"),
        // 修改顶部状态栏颜色
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // TabBar 区域
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              height: 45,
              child: TabBar(
                labelColor: Colors.white,
                //选中的颜色
                labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
                unselectedLabelColor: Colors.black54,
                //未选中的颜色
                unselectedLabelStyle:
                    const TextStyle(color: Colors.black54, fontSize: 14),
                isScrollable: true,
                //自定义indicator样式
                indicator: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                controller: _tabController,
                onTap: _changeTab,
                tabs: _titleList.map((e) => Tab(text: e)).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // PageView 区域
            SizedBox(
              height: 400,
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: _onPageChanged,
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            // indicator 区域
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 12),
              child: Text(
                'Worm',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: pages.length,
              effect: const WormEffect(
                dotHeight: 16,
                dotWidth: 16,
                type: WormType.thin,
                // strokeWidth: 5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                'Jumping Dot',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: pages.length,
              effect: const JumpingDotEffect(
                dotHeight: 16,
                dotWidth: 16,
                jumpScale: .7,
                verticalOffset: 15,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 12),
              child: Text(
                'Scrolling Dots',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SmoothPageIndicator(
                controller: _pageController,
                count: pages.length,
                effect: const ScrollingDotsEffect(
                  activeStrokeWidth: 2.6,
                  activeDotScale: 1.3,
                  maxVisibleDots: 5,
                  radius: 8,
                  spacing: 10,
                  dotHeight: 12,
                  dotWidth: 12,
                )),
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                'Customizable Effect',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Container(
              // color: Colors.red.withOpacity(.4),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: pages.length,
                effect: CustomizableEffect(
                  activeDotDecoration: DotDecoration(
                    width: 32,
                    height: 12,
                    color: Colors.indigo,
                    rotationAngle: 180,
                    verticalOffset: -10,
                    borderRadius: BorderRadius.circular(24),
                    // dotBorder: DotBorder(
                    //   padding: 2,
                    //   width: 2,
                    //   color: Colors.indigo,
                    // ),
                  ),
                  dotDecoration: DotDecoration(
                    width: 24,
                    height: 12,
                    color: Colors.grey,
                    // dotBorder: DotBorder(
                    //   padding: 2,
                    //   width: 2,
                    //   color: Colors.grey,
                    // ),
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(2),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(16),
                    //     bottomRight: Radius.circular(2)),
                    borderRadius: BorderRadius.circular(16),
                    verticalOffset: 0,
                  ),
                  spacing: 6.0,
                  // activeColorOverride: (i) => colors[i],
                  inActiveColorOverride: (i) => _colors[i],
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Container(
              height: 24,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              child: TabBar(
                // indicatorSize: TabBarIndicatorSize.tab,
                // indicatorWeight: 0,
                automaticIndicatorColorAdjustment: false,
                //选中的颜色
                labelColor: Colors.white,
                // labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                //未选中的颜色
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle:
                    const TextStyle(color: Colors.grey, fontSize: 12),
                isScrollable: true,
                //自定义indicator样式
                indicator: const BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                controller: _switchController,
                onTap: _changeTab,
                tabs: const [
                  Tab(
                    text: '客片',
                  ),
                  Tab(
                    text: '原片',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      )),
    );
  }
}

class ChildPageView extends StatefulWidget {
  const ChildPageView({Key? key, required this.parentPageController})
      : super(key: key);
  final PageController parentPageController;

  @override
  State<ChildPageView> createState() => _ChildPageViewState();
}

class _ChildPageViewState extends State<ChildPageView> {
  late PageController _pageController;
  Drag? _drag;
  int _index = 0;
  bool hasReachedEnd = false, hasReachedStart = true;
  final List<String> _photos = [
    'https://p.qqan.com/up/2022-9/16644331618490721.jpg',
    'https://p.qqan.com/up/2022-9/16644331614978803.jpg',
    'https://p.qqan.com/up/2022-9/16644331615953703.jpg',
    'https://p.qqan.com/up/2022-9/16644331614271146.jpg',
    'https://p.qqan.com/up/2022-9/16644331612803098.jpg',
    'https://p.qqan.com/up/2022-9/16644331611094175.jpg'
  ];

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 1.0, keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    _drag?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: (notification) {
          debugPrint('当前事件类型：$notification');
          debugPrint('当前页面index：$_index');

          if (notification is UserScrollNotification) {
            if ((notification.direction == ScrollDirection.reverse &&
                    hasReachedEnd) ||
                (notification.direction == ScrollDirection.forward &&
                    hasReachedStart)) {
              _drag = widget.parentPageController.position
                  .drag(DragStartDetails(), () {
                _drag = null;
              });
            }
          }
          if (notification is OverscrollNotification) {
            if (notification.dragDetails != null && _drag != null) {
              _drag?.update(notification.dragDetails!);
            }
          }
          if (notification is ScrollEndNotification) {
            if (notification.dragDetails != null && _drag != null) {
              _drag?.end(notification.dragDetails!);
            }
          }
          return true;
        },
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            // return PhotoViewGalleryPageOptions(
            //   imageProvider: NetworkImage(_photos[index]),
            //   initialScale: PhotoViewComputedScale.contained * 0.8,
            //   heroAttributes: PhotoViewHeroAttributes(tag: _photos[index]),
            // );
            return PhotoViewGalleryPageOptions.customChild(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage((index % 2 != 0)
                            ? _photos[index]
                            : 'https://cloud.cdn-qn.hzmantu.com/upload/2023/01/13/lh7jBA83J9IyDCDCBq-W34iTc1Ng.jpg'))),
                child: Image.network(
                  'https://cloud.cdn-qn.hzmantu.com/algo/watermark/2023/01/13/lh7jBA83J9IyDCDCBq-W34iTc1Ng.png?imageView2/2/w/700/format/webp/q/1',
                  fit: BoxFit.contain,
                ),
                // 'https://cloud.cdn-qn.hzmantu.com/algo/watermark/2023/01/13/lh7jBA83J9IyDCDCBq-W34iTc1Ng.png',fit: BoxFit.contain,),
              ),
              initialScale: PhotoViewComputedScale.contained * 1.0,
              minScale: 0.8,
              heroAttributes: PhotoViewHeroAttributes(tag: _photos[index]),
            );
          },
          itemCount: _photos.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
          backgroundDecoration: const BoxDecoration(color: Colors.orange),
          pageController: _pageController,
          onPageChanged: _onPageChanged,
        ));
  }

  void _onPageChanged(int value) {
    debugPrint('子页面变化:$value');
    _index = value;
    if (value == 5 - 1) {
      hasReachedEnd = true;
    } else if (value == 0) {
      hasReachedStart = true;
    } else {
      hasReachedStart = false;
      hasReachedEnd = false;
    }
  }
}
