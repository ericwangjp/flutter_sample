import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "粘性滚动头",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final List<String> photos = [
    'https://img2.baidu.com/it/u=1395980100,2999837177&fm=253&fmt=auto&app=120&f=JPEG?w=1200&h=675',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Flmg.jj20.com%2Fup%2Fallimg%2F1114%2F033021091503%2F210330091503-6-1200.jpg&refer=http%3A%2F%2Flmg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1674200990&t=c2080b85a1be4f882dbc88388aa64571',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Flmg.jj20.com%2Fup%2Fallimg%2F1114%2F040221103339%2F210402103339-8-1200.jpg&refer=http%3A%2F%2Flmg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1674200990&t=c7c5455612e99a7bb29ed3e5c6844184',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Flmg.jj20.com%2Fup%2Fallimg%2F1114%2F042421133312%2F210424133312-1-1200.jpg&refer=http%3A%2F%2Flmg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1674200990&t=0d8bc23e8cf49533a36214df08a0b0be',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2017-11-09%2F5a0407990ec4d.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1674200990&t=583734f3d930749ebce070102cd039a0',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fupload.pig66.com%2Fuploadfile%2F2017%2F0511%2F20170511075802322.jpg&refer=http%3A%2F%2Fupload.pig66.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1674200990&t=8f5d0392df6a01347f1575a90871c918',
    'https://img1.baidu.com/it/u=407852637,3650486136&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500',
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 粘性滚动头"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return StickyHeader(
              header: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  debugPrint('点击了$index');
                },
                child: Container(
                        height: 50,
                        color: Colors.blueGrey[700],
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Header #$index',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
              ),
              content: ListView.separated(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const Divider();
                  },
                  separatorBuilder: (context, index) {
                    return Image.network(
                      imageForIndex(index),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    );
                  },
                  itemCount: widget.photos.length));
        },
        itemCount: widget.photos.length,
      ),
    );
  }

  String imageForIndex(int index) {
    return widget.photos[index];
  }
}
