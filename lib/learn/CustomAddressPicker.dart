import 'package:flutter/material.dart';
import 'package:flutter_sample/wheelpicker/pickers.dart';
import 'package:flutter_sample/wheelpicker/style/default_style.dart';
import 'package:flutter_sample/wheelpicker/style/picker_style.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "自定义地址选择器",
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
  String initProvince = '四川省', initCity = '成都市', initTown = '双流区';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter 自定义地址选择器"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _showCustomAddressPicker(context: context);
              },
              child: const Text('显示自定义地址选择器')),
          ElevatedButton(
              onPressed: () {
                Pickers.showAddressPicker(
                  context,
                  initProvince: initProvince,
                  initCity: initCity,
                  initTown: initTown,
                  addAllItem: false,
                  // 市、区是否添加 '全部' 选项
                  // pickerStyle: ClosePickerStyle(haveRadius: true),
                  pickerStyle: customizeStyle(),
                  onConfirm: (p, c, t) {
                    setState(() {
                      initProvince = p;
                      initCity = c;
                      initTown = t ?? '';
                    });
                  },
                );
              },
              child: Text('改造地址选择器'))
        ],
      ),
    );
  }

  Future<String?> _showCustomAddressPicker({required BuildContext context}) {
    return showModalBottomSheet<String?>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return _dialogBuilder(context);
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))));
  }

  Widget _dialogBuilder(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 16),
            child: Row(
              children: [
                const Text(
                  '修改登记地',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop("1");
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Image.asset(
                    'images/ic_close_black.png',
                    width: 28,
                    height: 28,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: (MediaQuery.of(context).size.height * 2) / 3,
                minWidth: MediaQuery.of(context).size.width),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // todo 取消
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text(
                    "取消",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: const Text('确定',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  PickerStyle customizeStyle() {
    double headerHeight = 46.0;
    double footerHeight = 72.0;
    Widget _headerView = Container(
        color: Colors.white54,
        height: headerHeight,
        child: const Center(
            child: Text(
          '净身高',
          style: TextStyle(color: Colors.white),
        )));

    Widget _footerView = Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
            onPressed: () {
              // todo 取消
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            child: const Text(
              "取消",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                backgroundColor: MaterialStateProperty.all(Colors.green)),
            child: const Text('确定',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );

    Widget _cancelButton = const Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        '修改登记地',
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );

    Widget _commitButton = GestureDetector(
      onTap: () {
        Navigator.of(context).pop("1");
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(
          'images/ic_close_black.png',
          width: 28,
          height: 28,
        ),
      ),
    );

    // 头部样式
    Decoration headDecoration = const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)));

    Widget title = const Center(
        child: Text(
      '身高选择器',
      style: TextStyle(color: Colors.cyanAccent, fontSize: 14),
    ));

    /// item 覆盖样式
    Widget itemOverlay = Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Color(0xFFE9E9E9), width: 0.5)),
      ),
    );

    return PickerStyle(
      // menu: _headMenuView,
      // menuHeight: menuHeight,
      footer: _footerView,
      footerHeight: footerHeight,
      // pickerHeight: 280,
      pickerTitleHeight: 70,
      pickerItemHeight: 40,
      headerLineHeight: 0.5,
      cancelButton: _cancelButton,
      commitButton: _commitButton,
      headDecoration: headDecoration,
      // title: title,
      textColor: Colors.black,
      dividerColor: const Color(0xFFE9E9E9),
      backgroundColor: Colors.white,
      itemOverlay: itemOverlay,
    );
  }
}
