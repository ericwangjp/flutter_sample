import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flex box",
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
          title: const Text("flutter flex list"),
        ),
        // body: GridView.builder(
        //   // physics: NeverScrollableScrollPhysics(),
        //   //shrinkWrap: true,
        //   padding: const EdgeInsets.all(0.0),
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     //单个widget的水平最大宽度
        //     maxCrossAxisExtent: 80,
        //     //垂直单个子widget间距
        //     mainAxisSpacing: 4,
        //     //水平单个子widget间距
        //     crossAxisSpacing: 4,
        //   ),
        //   itemBuilder: (context, index) {
        //     return ListTile(title: Text('第$index个${Random.secure().nextInt(1000)}'));
        //   },
        //   itemCount: 15,
        // )

        body: Wrap(
            // alignment: WrapAlignment.spaceBetween,
            spacing: 10,
            runSpacing: 5,
            children: List.generate(15, (index) {
              return GestureDetector(
                onTap: (){
                  debugPrint('点击了$index');
                },
                behavior: HitTestBehavior.opaque,
                child: Text(
                  '第$index个${Random.secure().nextInt(1000)}',
                  style: const TextStyle(backgroundColor: Colors.green, fontSize: 16),
                ),
              );
            })
            // ListView.separated(
            //       scrollDirection: Axis.horizontal,
            //       physics: const NeverScrollableScrollPhysics(),
            //       shrinkWrap: true,
            //       itemBuilder: (context, index) {
            //         // return ListTile(
            //         //   title: Text('第$index个'),
            //         // );
            //         return Text(
            //           '第$index个',
            //           style: const TextStyle(backgroundColor: Colors.green, fontSize: 16),
            //         );
            //       },
            //       separatorBuilder: (context, index) {
            //         return const Divider(
            //           color: Colors.orange,
            //           thickness: 20,
            //           indent: 10,
            //         );
            //       },
            //       itemCount: 15)
            ));
  }
}
