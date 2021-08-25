import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fruits/screens/home.dart';

class Fruit {
  String name;
  String image;
  double price;
  int qty = 0;
  Color color;
  Position position;
  bool animate = false;

  Fruit(this.name, this.image, this.price, this.qty, this.color);

  // ignore: non_constant_identifier_names
  set Qty(int qty) => this.qty = qty;
  set reAnimate(bool animate) => this.animate = animate;

  set currentPosition(Position position) => this.position = position;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) {
    return this.name == other.name;
  }
}

  List<Fruit> getFruitsList() {
    List<Fruit> fruits = [];
    fruits.add(Fruit('Apple', 'images/apple.png', 25.0, 0, Colors.red));
    fruits.add(Fruit('Banana', 'images/banana.png', 30.0, 0, Colors.amber));
    fruits.add(
        Fruit('Strawberry', 'images/strawberry.png', 40.0, 0, Colors.red[300]));
    fruits
        .add(Fruit('Orange', 'images/orange.png', 45.0, 0, Colors.orange[600]));
    fruits.add(Fruit('Lemon', 'images/lemon.png', 50.0, 0, Colors.yellow[500]));
    fruits.add(Fruit('Papaya', 'images/papaya.png', 55.0, 0, Colors.red));
    fruits
        .add(Fruit('Pineapple', 'images/pineapple.png', 60.0, 0, Colors.amber));
    fruits.add(Fruit(
        'Watermelon', 'images/watermelon.png', 65.0, 0, Colors.purple[300]));
    fruits.add(Fruit('Kiwi', 'images/kiwi.png', 75.0, 0, Colors.green[600]));
    fruits.add(Fruit(
        'Mixed Fruit', 'images/mixed_fruit.png', 80.0, 0, Colors.blue[600]));
    return fruits;
  }
