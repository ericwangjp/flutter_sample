import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

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
      body: CustomScrollView(
          slivers: List.generate(
              4,
              (index) => _StickyHeaderList(
                    index: index,
                  ))
          // [
          //   // _StickyHeaderList(index: 0),
          //   // _StickyHeaderList(index: 1),
          //   // _StickyHeaderList(index: 2),
          //   // _StickyHeaderList(index: 3),
          //
          //   // SliverList(
          //   //     delegate: SliverChildBuilderDelegate((context, index) {
          //   //   return _StickyHeaderList(index: index);
          //   // }, childCount: 10))
          //
          // ],
          ),
    );
  }
}

class _StickyHeaderList extends StatelessWidget {
  const _StickyHeaderList({
    Key? key,
    this.index,
  }) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Header(index: index),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i){
            return _itemDayPerformance(context, i);
          },
          childCount: 10,
        ),
      ),
    );
  }

  Widget _itemDayPerformance(BuildContext context, int i) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '11月10日',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Image.asset(
                        'images/cat.jpg',
                        width: 10,
                        height: 10,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '服务&一销收益：1000.00',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    '二销收益：500.00',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '+ 1500.00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    this.index,
    this.title,
    this.color = Colors.lightBlue,
  }) : super(key: key);

  final String? title;
  final int? index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hit $index');
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint('弹出日期选择控件');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '2020年11月',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    'images/ic_close_black.png',
                    width: 30,
                    height: 20,
                  )
                ],
              ),
            ),
            Container(
              height: 15,
            ),
            Text(
              '总收益：12323.22',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  '服务&一销收益：1000.00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                Container(
                  width: 50,
                ),
                Text('二销收益：1000.00',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400))
              ],
            ),
          ],
        ),
      ),
    );
  }
}





// Widget _body(BuildContext context) {
//   return CustomScrollView(
//     slivers: List.generate(4, (index) {
//       return SliverStickyHeader(
//         header: Container(
//           color: Colors.white,
//           padding: EdgeInsets.all(20.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: () {
//                   debugPrint('弹出日期选择控件');
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       '2020年11月',
//                       style: TextStyle(
//                           color: MTColors.mtTextPrimary,
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     Image.asset(
//                       'assets/images/4.0x/home/ic_arrow_down_black.png',
//                       width: 30.w,
//                       height: 20.w,
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 15.w,
//               ),
//               Text(
//                 '总收益：12323.22',
//                 style: TextStyle(
//                     color: MTColors.mtTextPrimary,
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600),
//               ),
//               Container(
//                 height: 8.w,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     '服务&一销收益：1000.00',
//                     style: TextStyle(
//                         color: MTColors.mtTextPrimary,
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w400),
//                   ),
//                   Container(
//                     width: 50.w,
//                   ),
//                   Text('二销收益：1000.00',
//                       style: TextStyle(
//                           color: MTColors.mtTextPrimary,
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w400))
//                 ],
//               ),
//             ],
//           ),
//         ),
//         sliver: SliverList(
//           delegate: SliverChildBuilderDelegate(
//                 (context, i) {
//               return _itemDayPerformance(context, i);
//             },
//             childCount: 10,
//           ),
//         ),
//       );
//     }),
//   );
// }


