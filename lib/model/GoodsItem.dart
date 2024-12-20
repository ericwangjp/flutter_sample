import 'package:flutter/material.dart';

class GoodsItem  {
  GoodsItem(this.price, this.count, this.name);

  double price;

  int count;

  String name;

  void update(GoodsItem goodsItem) {
    name = goodsItem.name;
    count = goodsItem.count;
    price = goodsItem.price;
    // notifyListeners();
  }

  void updateName(String newName) {
    name = newName;
    // notifyListeners();
  }
}
