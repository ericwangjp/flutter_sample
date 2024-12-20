import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "对话框",
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
        title: const Text("flutter dialog"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                bool? result = await showCustomDialog();
                if (result == null) {
                  debugPrint("点击取消了");
                } else {
                  debugPrint("点击确定");
                }
              },
              child: const Text("弹出dialog")),
          OutlinedButton(
              onPressed: () {
                customSimpleDialog();
              },
              child: const Text("SimpleDialog")),
          ElevatedButton(
              onPressed: () {
                showListDialog();
              },
              child: const Text("dialog")),
          OutlinedButton(
              onPressed: () {
                showCustomAnimDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("自定义dialog"),
                        content: const Text("dialog实现有些复杂"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("确定")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("取消")),
                        ],
                      );
                    });
              },
              child: const Text("自定义dialog")),
          ElevatedButton(
              onPressed: () {
                showBottomDialog();
              },
              child: const Text("底部dialog")),
          OutlinedButton(
              onPressed: () {
                showLoadingDialog();
              },
              child: const Text("加载 dialog")),
          ElevatedButton(
              onPressed: () {
                showCustomDatePicker();
              },
              child: const Text("日期选择对话框")),
          OutlinedButton(
              onPressed: () {
                showIosDatePicker();
              },
              child: const Text("iOS风格日期选择器"))
        ],
      ),
    );
  }

  Future<bool?> showCustomDialog() {
    return showDialog<bool?>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("dialog展示"),
            // titlePadding: EdgeInsets.all( 10),
            titleTextStyle: const TextStyle(color: Colors.pink, fontSize: 20),
            content: const Text("对话框内容展示，效果怎么样，很多很多..."),
            contentPadding: const EdgeInsets.all(15),
            contentTextStyle: const TextStyle(color: Colors.blue, fontSize: 20),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("取消")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("确定"))
            ],
            backgroundColor: Colors.lightGreen,
            elevation: 20,
            shape: const RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.black87, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          );
        });
  }

  Future<void> customSimpleDialog() async {
    int? i = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("请选择语言"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("简体中文"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("英语"),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      debugPrint("选择了：${i == 1 ? "简体中文" : "英语"}");
    }
  }

  Future<void> showListDialog() async {
    int? index = await showDialog(
        context: context,
        builder: (context) {
          var child = Column(
            children: [
              const ListTile(
                title: Text("请选择"),
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("$index"),
                    onTap: () {
                      Navigator.of(context).pop(index);
                    },
                  );
                },
                itemExtent: 50,
                itemCount: 20,
              ))
            ],
          );
          return Dialog(
            child: child,
          );
        });

    if (index != null) {
      debugPrint("点击了 $index");
    }
  }

  Future<T?> showCustomAnimDialog<T>(
      {required BuildContext context,
      bool barrierDismissible = true,
      required WidgetBuilder builder,
      ThemeData? themeData}) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          final Widget pageChild = Builder(builder: builder);
          return SafeArea(child: Builder(builder: (context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }));
        },
        barrierDismissible: barrierDismissible,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black87,
        transitionDuration: const Duration(milliseconds: 200),
        transitionBuilder: _buildMaterialDialogTransitions);
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: child,
    );
  }

  Future<int?> showBottomDialog() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("$index"),
                  onTap: () {
                    Navigator.of(context).pop(index);
                  },
                );
              });
        });
  }

  showLoadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text("正在加载，请稍后..."),
                )
              ],
            ),
          );
        });
  }

  // android 风格
  showCustomDatePicker() {
    var date = DateTime.now();
    return showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date,
        lastDate: date.add(Duration(days: 30)));
  }

  // ios 风格
  Future<DateTime?> showIosDatePicker() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              onDateTimeChanged: (value) {
                debugPrint("选中时间：$value");
              },
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: date,
              maximumDate: date.add(Duration(days: 30)),
              maximumYear: date.year + 1,
            ),
          );
        });
  }
}
