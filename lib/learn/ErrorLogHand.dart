import 'dart:async';

import 'package:flutter/material.dart';

// flutter 中的四棵树（Widget、Element、Layer）
// Widget 树 -> Element 树 -> Render 树 -> Layer 树

// 异常捕获

void collectLog(String line) {
//收集日志
  print("$line");
}

void reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志逻辑
  print(details.toString());
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
  return FlutterErrorDetails(exception: Exception(obj));
}

void main() {
  var onError = FlutterError.onError; //先将 onError 保存起来
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details); //调用默认的onError
    reportErrorAndLog(details); //上报
  };
  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: ZoneSpecification(
      // 拦截print
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line);
        parent.print(zone, "Interceptor: $line");
      },
      // 拦截未处理的异步错误
      handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
          Object error, StackTrace stackTrace) {
        reportErrorAndLog(FlutterErrorDetails(exception: Exception(error)));
        parent.print(zone, '${error.toString()} $stackTrace');
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第一个 Flutter APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
