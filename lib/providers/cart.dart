import 'package:flutter/material.dart';
import 'package:fruits/models/fruit_item.dart';

class CartNotifier with ChangeNotifier {
  List<Fruit> _cartFruit = [];
  get cartFruit => (_cartFruit);

  get cartList => null;

  void addFruit(Fruit fruit) {
    _cartFruit.add(cartFruit);
    notifyListeners();
  }
}
