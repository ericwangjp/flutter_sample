import 'dart:collection';

import 'package:flutter/material.dart';

import 'GoodsItem.dart';

class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
   List<GoodsItem> items = [GoodsItem(5, 5, '香蕉')];

  // 禁止改变购物车里的商品信息
  // UnmodifiableListView<GoodsItem> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice => items.fold(
      0,
      (previousValue, element) =>
          previousValue + element.price * element.count);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(GoodsItem item){
    items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  void update(List<GoodsItem> itemList){
    items = itemList;
    notifyListeners();
  }

  void updateAll(){
    notifyListeners();
  }

}

