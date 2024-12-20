import 'package:flutter/material.dart';
import 'package:flutter_sample/constants/project_consts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material Banner",
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
        title: const Text("顶部弹出条"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  /// 显示顶部弹出条
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    /// 顶部弹出条
                    MaterialBanner(
                      ///   左侧图标
                      leading: const Icon(Icons.home, color: Colors.white),

                      ///   内容
                      content: const Text('content'),

                      ///   内容的文本样式
                      contentTextStyle:
                          const TextStyle(color: Colors.black, fontSize: 16),

                      ///   背景
                      backgroundColor: Colors.orange[300],

                      ///   是否新起一行显示按钮（仅一个按钮时有效，多个按钮时会自动强制新起一行）
                      forceActionsBelow: false,

                      ///   按钮集合
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            /// 隐藏当前的顶部弹出条
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                          },
                          child: const Text('dismiss'),
                        ),
                        // OutlinedButton(
                        //     onPressed: () {
                        //       /// 隐藏当前的顶部弹出条
                        //       ScaffoldMessenger.of(context)
                        //           .hideCurrentMaterialBanner();
                        //     },
                        //     child: const Text('更多'))
                      ],
                      onVisible: () {
                        ///   弹出条显示后触发的事件
                        debugPrint("MaterialBanner onVisible");
                      },
                    ),
                  );
                },
                child: const Text('弹出 MaterialBanner')),
            Flexible(
                flex: 4,
                child: Container(
                  height: 200,
                  color: Colors.lime[100],
                )),
            Flexible(
                flex: 1,
                child: Container(
                  height: 200,
                  color: Colors.blue[100],
                )),
            ElevatedButton(
                onPressed: () {
                  /// 显示底部弹出条
                  ScaffoldMessenger.of(context).showSnackBar(
                    /// 底部弹出条
                    SnackBar(
                      ///   内容
                      content: const Text('content'),
                      // margin: EdgeInsets.all(20),
                      // behavior: SnackBarBehavior.floating,
                      // shape: BeveledRectangleBorder(
                      //     side: BorderSide(),
                      //     borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(15),
                      //         bottomRight: Radius.circular(20))),
                      // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      action: SnackBarAction(
                          label: '消失',
                          onPressed: () {
                            // ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            // ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          },
                          disabledTextColor: Colors.grey[400],
                          textColor: Colors.blue[400]),

                      ///   背景
                      backgroundColor: Colors.orange[300],

                      ///   按钮集合
                      onVisible: () {
                        ///   弹出条显示后触发的事件
                        debugPrint("MaterialBanner onVisible");
                      },
                    ),
                  );
                },
                child: const Text('弹出 MaterialBanner'))
          ],
        ),
      ),
    );
  }
}
