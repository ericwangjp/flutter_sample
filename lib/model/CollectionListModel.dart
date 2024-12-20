import 'package:flutter/material.dart';

import 'ListModel.dart';
import 'Shop.dart';

class CollectionListModel extends ChangeNotifier {
  // 依赖ListModel
  final ListModel _listModel;

  CollectionListModel(this._listModel);

  // 所有收藏的商品
  List<Shop> shops = [];

  // 添加收藏
  void add(Shop shop){
    shops.add(shop);
    notifyListeners();
  }
  // 移除收藏
  void remove(Shop shop){
    shops.remove(shop);
    notifyListeners();
  }
}