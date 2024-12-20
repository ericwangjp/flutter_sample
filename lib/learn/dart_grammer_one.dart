// 只能声明在顶层
import 'package:flutter_sample/learn/dart_mixin.dart';

typedef bool aha();

void main() {
  // Dart 中 var 变量一旦赋值，类型便会确定，则不能再改变其类型
  var t = "hello world";
  // t = 10;
// dynamic与Object声明的变量都可以赋值任意对象，且后期可以改变赋值的类型，这和 var 是不同的
  dynamic a;
  Object? b;
  a = "哈哈";
  b = "你好";
  a = 10;
  b = 20;
  a = "ccc";
//  dynamic与Object不同的是dynamic声明的对象编译器会提供所有可能的组合，而Object声明的对象只能使用 Object 的属性与方法
  print(a.length);
// print(b.length);

// 一个 final 变量只能被设置一次，两者区别在于：const 变量是一个编译时常量（编译时直接替换为常量值），final变量在第一次使用时被初始化。
// 被final或者const修饰的变量，变量类型可以省略
  final c = "hello";
  const d = "world";
  // 默认为不可空，定义为可空类型，对于可空变量，我们在使用前必须判空。
  int? e;
  // 如果我们预期变量不能为空，但在定义时不能确定其初始值，则可以加上late关键字，
  // 表示会稍后初始化，但是在正式使用它之前必须得保证初始化过了，否则会报错
  late int f;
  if (e != null) {
    // 通过在变量后面加一个”!“符号,告诉预处理器它已经不是null了  e!
    print(2 + e);
  }
  f = 10;
  print(2 * f);

  // 可空安全调用 ?.

  bool isNotNull(int atomicNumber) {
    return e != null;
  }

  // Dart函数声明如果没有显式声明返回值类型时会默认当做dynamic处理，注意，函数返回值没有类型推断
  bool testTypeDef(aha cb) {
    return cb();
  }

  //  对于只包含一个表达式的函数，可以使用简写语法：
  bool isBigger(int num) => true;

  // 函数作为变量
  // var say = (str) {
  //   print(str);
  // };

  // 函数作为参数
  void execute(var callback) {
    callback();
  }

  execute(() => print("aaa"));

  // 用[]标记为可选的位置参数，并放在参数列表的最后面
  // String say(String from,String msg,[String? device]){
  //   var result = "$from says $msg";
  //   if(device!= null){
  //     result = "$result with a $device";
  //   }
  //   return result;
  // }

  // 使用{param1, param2, …}用于指定命名参数，放在参数列表的最后面，
  String say(int a, {String? from = "小明", String msg = "呵呵", String? device}) {
    var result = "$from $a years old，says $msg";
    if (device != null) {
      result = "$result with a $device";
    }
    return result;
  }

  print(say(22, msg: "Aa", device: "大喇叭"));

  Dog().think();
  Man().think();
  Man().eat();

  // 返回 Future 或者 Stream 对象的函数称为异步函数
//  async和await关键词支持了异步编程，允许您写出和同步代码很像的异步代码。
//  一个Future只会对应一个结果，要么成功，要么失败。
  void httpRequest() {
    Future.delayed(const Duration(seconds: 2), () {
      return "hi world!";
    }).then((value) => print(value));
  }

  // httpRequest();

  void requestWithError() {
    Future.delayed(const Duration(seconds: 2),
            () => throw AssertionError("request error 1"))
        .then((value) => print("request success 1")) // 执行成功会走到这里
        .catchError((onError) => print(onError)); // 执行失败会走到这里

    Future.delayed(const Duration(seconds: 2),
            () => throw AssertionError("request error 2"))
        .then((value) => print("request success 2"), onError: (e) => print(e))
        .whenComplete(() => print("执行结束了")); // 无论成功或失败都会走到这里
  }

  // requestWithError();

  // Future.wait，它接受一个Future数组参数，只有数组中所有Future都执行成功后，才会触发then的成功回调，只要有一个Future执行失败，就会触发错误回调
  void asyncRequest() {
    Future.wait([
      Future.delayed(const Duration(seconds: 2), () {
        return "hello";
      }),
      Future.delayed(const Duration(seconds: 4), () => " world !")
    ])
        .then((value) => print(value[0] + value[1]))
        .catchError((onError) => print(onError))
        .whenComplete(() => print("全部执行结束了"));
  }

  // asyncRequest();

  Future<String> login(String userName, String pwd) {
    return Future.delayed(
        const Duration(seconds: 2), () => "$userName-$pwd-登录成功");
  }

  Future<String> getUserInfo(String id) {
    return Future.delayed(
        const Duration(seconds: 3), () => "$id-查询用户信息成功");
  }

  Future<String> saveUserInfo(String userInfo) {
    return Future.delayed(
        const Duration(seconds: 4), () => "$userInfo-保存成功");
  }

  // login("jack", "123456")
  //     .then((id) => getUserInfo(id))
  //     .then((userInfo) => saveUserInfo(userInfo))
  //     .then((value) => print("请求成功了：$value"))
  //     .catchError((onError) => print(onError))
  //     .whenComplete(() => print("多个请求全部完成"));

  taskTest() async {
    try {
      String id = await login("jim", "123");
      String userInfo = await getUserInfo(id);
      String result = await saveUserInfo(userInfo);
      print("全部请求结束：$result");
      // 继续其他操作
    } catch (e) {
      print(e);
    }
  }

  // taskTest();


//  Stream 也是用于接收异步事件数据，和 Future 不同的是，它可以接收多个异步操作的结果（成功或失败）
//  在执行异步任务时，可以通过多次触发成功或失败事件来传递结果数据或错误异常。
//  Stream 常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等
  void streamTest() {
    Stream.fromFutures([
      Future.delayed(const Duration(seconds: 1), () {
        return "hello 1";
      }),

      Future.delayed(const Duration(seconds: 2), () =>
      throw AssertionError("抛出异常")
      ),

      Future.delayed(const Duration(seconds: 3), () => "hello 3")

    ]).listen((event) {
      print(event);
    }, onError: (e) {
      print(e.message);
    }, onDone: () {
      print("执行结束");
    });
  }

  streamTest();
}
