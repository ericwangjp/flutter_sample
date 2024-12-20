import 'package:flutter/material.dart';

class Person1 with ChangeNotifier {
  String name = "MultiProvider - 1";

  Person1({required this.name});

  /// 提供一个改变name的方法,需要混入 ChangeNotifier
  void changName({required String newName}) {
    name = newName;
    notifyListeners();
  }
}


class Person2 with ChangeNotifier {
  String name =  "MultiProvider - 2";

  Person2({required this.name});

  /// 提供一个改变name的方法,需要混入 ChangeNotifier
  void changName({required String newName}) {
    name = newName;
    notifyListeners();
  }
}

