import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/learn/iconmodel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter 基础组件",
      theme: ThemeData(primarySwatch: Colors.lightBlue),
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
  String getIcons() {
    String icons = "";
// accessible: 0xe03e
    icons += "\uE03e";
// error:  0xe237
    icons += " \uE237";
// fingerprint: 0xe287
    icons += " \uE287";
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("基础组件展示"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "文本演示-左对齐",
                textAlign: TextAlign.left,
              ),
              Text(
                "单行显示" * 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                "字体缩放",
                textScaleFactor: 2,
              ),
              Text(
                "字体样式",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.orange,
                    height: 1.2,
                    // 行高 = fontSize * height
                    fontFamily: "Courier",
                    background: Paint()..color = Colors.yellow,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
              const Text.rich(TextSpan(children: [
                TextSpan(text: "Home:"),
                TextSpan(
                    text: "https://fluuterchina.club",
                    style: TextStyle(color: Colors.blue),
                    recognizer: null),
              ])),
              DefaultTextStyle(
                  style:
                      const TextStyle(color: Colors.lightGreen, fontSize: 20),
                  textAlign: TextAlign.start,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text("hello world"),
                      Text("测试文本样式继承"),
                      Text(
                        "测试文本样式继承-这里不继承样式",
                        style: TextStyle(inherit: false, color: Colors.orange),
                      )
                    ],
                  )),

              // 按钮 button
              ElevatedButton(
                  onPressed: () {
                    debugPrint("点击了");
                  },
                  child: const Text("ElevatedButton")),
              TextButton(onPressed: () {}, child: const Text("TextButton")),
              OutlinedButton(
                  onPressed: () {}, child: const Text("OutlinedButton")),
              IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  label: const Text("ElevatedButton Icon")),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.info),
                  label: const Text("TextButton Icon")),
              OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("OutlinedButton Icon")),

              //  图片和icon
              //  从asset中加载图片
              const Image(
                image: AssetImage("images/little_girl.jpeg"),
                width: 200,
              ),
              Image.asset(
                "images/cat.jpg",
                width: 200,
              ),
              Image.asset(
                "images/cat.jpg",
                width: 200,
                color: Colors.orange,
                colorBlendMode: BlendMode.difference,
              ),
              //  从网络加载图片
              const Image(
                image: NetworkImage(
                    "https://i0.hdslb.com/bfs/article/8073e0d9bda9029a7280622b823a3708b47ac79c.jpg@942w_1319h_progressive.webp"),
                width: 200,
              ),
              Image.network(
                "https://i0.hdslb.com/bfs/article/8aced8dcbb8a909e00e2eeedf9e5608c5a2fb444.jpg@942w_1334h_progressive.webp",
                width: 200,
              ),
              Text(
                getIcons(),
                style: const TextStyle(
                    fontFamily: "MaterialIcons",
                    fontSize: 24,
                    color: Colors.orange),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.accessible,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.error,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.fingerprint,
                    color: Colors.blue,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    IconFonts.cloudy,
                    color: Colors.orange,
                  ),
                  Icon(
                    IconFonts.thunderShower,
                    color: Colors.lightGreen,
                  ),
                ],
              ),
              const SwitchAndCheckBoxRoute(),
              const InputAndForm(),
              const TextField(
                decoration: InputDecoration(
                    labelText: "自定义输入框样式",
                    prefixIcon: Icon(Icons.abc_sharp),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightGreen))),
              ),
              const FormWidget(),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                    LinearProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      value: .5,
                    ),
                    SizedBox(
                      height: 100,
                      width: 150,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      value: .5,
                      strokeWidth: 10,
                    ),
                    AnimateProgress()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// 单选开关和复选框
class SwitchAndCheckBoxRoute extends StatefulWidget {
  const SwitchAndCheckBoxRoute({Key? key}) : super(key: key);

  @override
  State<SwitchAndCheckBoxRoute> createState() => _SwitchAndCheckBoxRouteState();
}

class _SwitchAndCheckBoxRouteState extends State<SwitchAndCheckBoxRoute> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            }),
        Checkbox(
            value: _checkboxSelected,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value!;
              });
            })
      ],
    );
  }
}

// 输入框
class InputAndForm extends StatefulWidget {
  const InputAndForm({Key? key}) : super(key: key);

  @override
  State<InputAndForm> createState() => _InputAndFormState();
}

class _InputAndFormState extends State<InputAndForm> {
  String _userName = "";
  String _pwd = "";
  final TextEditingController _editingController = TextEditingController();
  FocusNode focusNodeOne = FocusNode();
  FocusNode focusNodeTwo = FocusNode();
  FocusScopeNode? focusScopeNode;

  @override
  void initState() {
    super.initState();
    _editingController.text = "这里是初始默认值";
    _editingController.selection = TextSelection(
        baseOffset: 2, extentOffset: _editingController.text.length);
    _editingController.addListener(() {
      debugPrint("监听变化：${_editingController.text}");
    });

    focusNodeOne.addListener(() {
      debugPrint("输入框一是否有焦点：${focusNodeOne.hasFocus}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          focusNode: focusNodeOne,
          controller: _editingController,
          onChanged: (value) {
            _userName = value;
            debugPrint("用户名：$value");
          },
          decoration: const InputDecoration(
            labelText: "用户名",
            hintText: "用户名或邮箱",
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextField(
          decoration: const InputDecoration(
              labelText: "密码",
              hintText: "请输入登录密码",
              prefixIcon: Icon(Icons.lock)),
          obscureText: true,
          focusNode: focusNodeTwo,
          controller: _editingController,
          onChanged: (value) {
            _pwd = value;
            debugPrint("密码：$value");
          },
        ),
        Builder(builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    // FocusScope.of(context).requestFocus(focusNodeTwo);
                    focusScopeNode ??= FocusScope.of(context);
                    focusScopeNode!.requestFocus(focusNodeTwo);
                  },
                  child: const Text("移动焦点")),
              OutlinedButton(
                  onPressed: () {
                    focusNodeOne.unfocus();
                    focusNodeTwo.unfocus();
                  },
                  child: const Text("隐藏键盘")),
            ],
          );
        }),
        Theme(
            data: Theme.of(context).copyWith(
                hintColor: Colors.deepOrange[200],
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.blue),
                    hintStyle: TextStyle(color: Colors.cyan, fontSize: 14))),
            child: Column(
              children: const [
                TextField(
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "输入手机号码或者邮箱",
                      prefixIcon: Icon(Icons.person)),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "请输入密码",
                      prefixIcon: Icon(Icons.lock),
                      hintStyle: TextStyle(color: Colors.lime, fontSize: 20)),
                )
              ],
            )),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey[200]!, width: 1))),
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: "Email",
                hintText: "电子邮箱",
                prefixIcon: Icon(Icons.email),
                border: InputBorder.none),
          ),
        )
      ],
    );
  }
}

// 表单
class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _pwdEditingController = TextEditingController();
  final GlobalKey _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _globalKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: _nameEditingController,
              decoration: const InputDecoration(
                  labelText: "用户名",
                  hintText: "请输入用户名",
                  icon: Icon(Icons.person)),
              validator: (value) {
                return value?.trim().isNotEmpty == true ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              controller: _pwdEditingController,
              decoration: const InputDecoration(
                  labelText: "密码", hintText: "请输入密码", icon: Icon(Icons.lock)),
              obscureText: true,
              validator: (value) {
                return value!.trim().isNotEmpty && value.length > 5
                    ? null
                    : "密码不能少于6位";
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 28),
              child: Row(
                children: [
                  Expanded(child: Builder(builder: (context) {
                    return ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("登录"),
                      ),
                      onPressed: () {
                        // if ((_globalKey.currentState as FormState).validate()) {
                        //   debugPrint("表单验证通过，提交数据");
                        // }
                        if (Form.of(context)!.validate()) {
                          debugPrint("表单验证通过，提交数据");
                        }
                      },
                    );
                  }))
                ],
              ),
            )
          ],
        ));
  }
}

class AnimateProgress extends StatefulWidget {
  const AnimateProgress({Key? key}) : super(key: key);

  @override
  State<AnimateProgress> createState() => _AnimateProgressState();
}

class _AnimateProgressState extends State<AnimateProgress>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController?.forward();
    _animationController?.addListener(() {
      setState(() => {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                  .animate(_animationController!),
              value: _animationController!.value,
            ),
          )
        ],
      ),
    );
  }
}
