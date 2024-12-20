import 'package:flutter/material.dart';

import '../utils/page_view_nested_utils.dart';

class PageViewPage extends StatefulWidget {
  const PageViewPage({Key? key}) : super(key: key);

  @override
  State<PageViewPage> createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  late PageController _pageController;
  late PageViewNestedUtils _pageViewScrollUtils;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageViewScrollUtils = PageViewNestedUtils(_pageController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Try scroll"),
      ),
      body: NotificationListener(
        onNotification: _pageViewScrollUtils.handleNotification,
        child: PageView(
          controller: _pageController,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Column(
                  children: [
                    Expanded(child: Page2()),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '第一页',
                      style: TextStyle(fontSize: 30),
                    ),
                    Expanded(child: Page2()),
                  ],
                ),
              ),
            ),
            Center(
              child: Text("第二页",style: TextStyle(fontSize: 30)),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Column(
                  children: [
                    Expanded(child: Page2()),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '第三页',
                      style: TextStyle(fontSize: 30),
                    ),
                    Expanded(child: Page2()),
                  ],
                ),
              ),
            ),
            Center(
              child: Text("第四页",style: TextStyle(fontSize: 30)),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Column(
                  children: [
                    Expanded(child: Page2()),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '第五页',
                      style: TextStyle(fontSize: 30),
                    ),
                    Expanded(child: Page2()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 30, color: Colors.white);
    return Container(
      color: Colors.lightGreen,
      child: PageView(
        children: [
          Center(
            child: Text(
              "a",
              style: textStyle,
            ),
          ),
          Center(
            child: Text(
              "b",
              style: textStyle,
            ),
          ),
          Center(
            child: Text(
              "c",
              style: textStyle,
            ),
          ),
          Center(
            child: Text(
              "d",
              style: textStyle,
            ),
          ),
          Center(
            child: Text(
              "e",
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
