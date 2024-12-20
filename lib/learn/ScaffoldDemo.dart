import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "页面骨架",
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
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {
    debugPrint("点击添加");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter scaffold"),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("你分享了");
              },
              icon: const Icon(Icons.share))
        ],
      ),
      drawer: const HomeDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "首页",
              activeIcon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              icon: Icon(Icons.business_outlined),
              label: "探索",
              activeIcon: Icon(Icons.business)),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined),
              label: "我的",
              activeIcon: Icon(Icons.school)),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   shape: CircularNotchedRectangle(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(onPressed: (){}, icon: Icon(Icons.home),tooltip: "首页",),
      //       SizedBox(),
      //       IconButton(onPressed: (){}, icon: Icon(Icons.school))
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
      body: Text(
        "内容:$_selectedIndex",
        style: const TextStyle(fontSize: 30, color: Colors.lightBlue),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 38),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ClipOval(
                        child: Image.asset(
                          "images/cat.jpg",
                          width: 80,
                        ),
                      ),
                    ),
                    const Text(
                      "风清扬",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                itemExtent: 40,
                children: const [
                  ListTile(
                    leading: Icon(Icons.account_box),
                    title: Text("添加好友"),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text("我的钱包"),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("设置"),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("退出登录"),
                  ),
                ],
              ))
            ],
          )),
    );
  }
}
