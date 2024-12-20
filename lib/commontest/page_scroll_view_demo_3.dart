import 'package:flutter/material.dart';

import '../utils/nestscroll/nest_page_helper_child.dart';
import '../utils/nestscroll/nest_page_helper_parent.dart';

class PageScrollViewDemo3 extends StatefulWidget {
  const PageScrollViewDemo3({Key? key}) : super(key: key);

  @override
  State<PageScrollViewDemo3> createState() => _PageScrollViewDemo3State();
}

class _PageScrollViewDemo3State extends State<PageScrollViewDemo3> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 1, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestPageHelperParent(
          pageController: _pageController,
          child: PageView.builder(
              itemCount: 5,
              controller: _pageController,
              itemBuilder: (context, index) {
                //嵌套PageView
                if (index == 3) {
                  return NestPageHelperChild(
                      child: PageView.builder(
                          itemCount: 5,
                          itemBuilder: (_, childIndex) {
                            return Container(
                              color: childIndex % 2 == 0
                                  ? Colors.orange
                                  : Colors.green,
                              child: Center(
                                child: Text('内部:$childIndex',
                                    style: const TextStyle(
                                        fontSize: 30, color: Colors.white)),
                              ),
                            );
                          }));
                }
                return Container(
                  color: index % 2 == 0 ? Colors.cyan : Colors.amber,
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                );
              })),
    );
  }
}
