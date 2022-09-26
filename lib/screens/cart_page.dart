import 'package:flutter/material.dart';
import 'package:fruits/models/fruit_item.dart';
// import 'package:fruits/screens/cart_Item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  final cartFruit;
  final fruit;

  CartPage( {
    key,
    @required this.fruit, 
    @required this.cartFruit, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: buildSafeArea(),
          ),
          SafeArea(
            child: Container(
              height: size.height,
              width: 2,
              color: Colors.grey[100],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSafeArea() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          buildTopBar(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget buildTopBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Your Picked Fruit',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
        Expanded(
          child: Image.asset('images/material_icon_leaf.png'),
          flex: 1,
        ),
        SizedBox(
          width: 30,
        ),
        Spacer(),
      ],
    );
  }

  Widget buildCartPage(BuildContext context) {
    final cartFruit = ModalRoute.of(context).settings.arguments as String;
    final fruits = Provider.of<Fruit>(
      context,
      listen: false,
    ).getFruit(cartFruit);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                fruits.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 30),
            Text('\$ ${fruits.price}'),
            SizedBox(height: 30),
            Text(
              '${fruits.description}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} //The end bracket