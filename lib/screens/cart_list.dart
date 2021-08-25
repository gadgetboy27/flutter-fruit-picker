import 'package:flutter/material.dart';
import 'package:fruits/actions/cart_notifier.dart';
import 'package:fruits/models/fruit.dart';
import 'package:provider/provider.dart';

class CartList extends StatelessWidget {
  BuildContext get context => context;

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

  //Main CartFruit list
  Widget cartList(Fruit fruit) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    GlobalKey key = GlobalKey();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    key: key,
                    color: cartNotifier.cartFruit.color,
                    child: Image.asset(
                      cartNotifier.cartFruit.image,
                      height: 100,
                    ),
                  ),
                  // New Code Here--
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 20, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        cartNotifier.cartFruit.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                      itemCount: cartNotifier.cartList.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                                title: cartNotifier.cartList[fruit].fruit,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
