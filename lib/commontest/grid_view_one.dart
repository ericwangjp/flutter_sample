import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'option_grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // 方式一
        body: OptionGridView(
          alignHeight: true,
          itemCount: 20,
          colCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          //   // childAspectRatio: 3 / 2,
          //   crossAxisCount: 2,
          // ),
          itemBuilder: (BuildContext context, int index) {
            debugPrint('index: ${0%7}');
            debugPrint('index: ${1%7}');
            debugPrint('index: ${2%7}');
            debugPrint('index: ${3%7}');
            debugPrint('index: ${6%7}');
            debugPrint('index: ${7%7}');
            debugPrint('index: ${8%7}');
            debugPrint('================');
            return Container(
              color: Colors.green,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.grey[index % 5 * 100],
                      ),
                      // height: index % 5 * 100 + 50,
                      child: Center(
                        child: Text(
                          index % 2 == 0 ?'Item $index' : 'item $index' *10,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // 方式二
        // body: AlignedGridView.count(
        //   crossAxisCount: 3,
        //   mainAxisSpacing: 4,
        //   crossAxisSpacing: 4,
        //   itemBuilder: (context, index) {
        //     if (index == 0) {
        //       return Container(
        //         color: Colors.red,
        //         // padding: const EdgeInsets.all(20),
        //         child: Column(
        //           children: [
        //             Center(
        //               child: Text('Item $index'),
        //             ),
        //             Container(
        //               height: 50,
        //               color: Colors.yellow,
        //             ),
        //           ],
        //         ),
        //       );
        //     } else if (index == 1) {
        //       return Container(
        //         color: Colors.blue,
        //         // padding: const EdgeInsets.all(50),
        //         child: Column(
        //           children: [
        //             Center(
        //               child: Text('Item $index'),
        //             ),
        //             Container(
        //               height: 100,
        //               color: Colors.purple,
        //             ),
        //           ],
        //         ),
        //       );
        //     } else if (index == 2) {
        //       return Container(
        //         color: Colors.green,
        //         // padding: const EdgeInsets.all(80),
        //         child: Center(
        //           child: Text('Item $index'),
        //         ),
        //       );
        //     }
        //     return Tile(
        //       index: index,
        //       extent: (index % 7 + 1) * 30,
        //     );
        //   },
        // ),
        //   方式三
        // body: DynamicHeightGridView(
        //     rowCrossAxisAlignment: CrossAxisAlignment.start,
        //     itemCount: 120,
        //     crossAxisCount: 3,
        //     crossAxisSpacing: 10,
        //     mainAxisSpacing: 10,
        //     builder: (ctx, index) {
        //       return Container(
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Colors.black, width: 1),
        //           color: Colors.grey[index % 5 * 100],
        //         ),
        //         height: index % 5 * 100 + 50,
        //         child: Center(
        //           child: Text(
        //             'Item $index',
        //             style: TextStyle(fontSize: 20),
        //           ),
        //         ),
        //       );
        //     }),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? Colors.orange[100],
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
