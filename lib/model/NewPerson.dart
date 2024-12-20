import 'package:flutter/material.dart';

class NewPerson with ChangeNotifier {
  String name = "ChangeNotifierProvider";

  NewPerson({required this.name});

  /// 提供一个改变name的方法,需要混入 ChangeNotifier
  void changName({required String newName}) {
    name = newName;
    notifyListeners();
  }
}
