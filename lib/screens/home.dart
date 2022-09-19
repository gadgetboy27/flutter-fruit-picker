import 'package:flutter/material.dart';
import 'package:fruits/models/cart_item.dart';
import 'package:fruits/providers/cart.dart';
import 'package:fruits/screens/cart_list.dart';
import 'package:fruits/screens/cart_Item.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController slideController;
  List<Fruit> cartFruit = [];

  @override
  void initState() {
    slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
              animation: slideController,
              builder: (context, snapshot) {
                return Positioned(
                    width: size.width - (105 * (slideController.value)),
                    height: size.height,
                    child: buildSafeArea());
              }),
          AnimatedBuilder(
              animation: slideController,
              builder: (context, snapshot) {
                return Positioned(
                  right: 102 * (slideController.value),
                  child: SafeArea(
                    child: Container(
                      height: size.height,
                      width: 2,
                      color: Colors.grey[100],
                    ),
                  ),
                );
              }),
          AnimatedBuilder(
              animation: slideController,
              builder: (context, snapshot) {
                return Positioned(
                  right: 0,
                  height: size.height,
                  width: 100 * slideController.value,
                  child: buildSecondList(),
                );
              })
        ],
      ),
    );
  }

  Widget buildSafeArea() {
    print('Cartlist Safe Area');
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          buildTopBar(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: getFruitsList().map((f) => buildFruit(f)).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTopBar() {
    print('TopBar Build');
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Pick Your Fruit',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
        Expanded(
          child: Image.asset('images/material_icon_leaf.png'),
          flex: 1,
        ),

        SizedBox(
          width: 20,
        ),
        // Icon(Icons.local_bar),
        Spacer(),
      ],
    );
  }

//Main Fruit list
  Widget buildFruit(Fruit fruit) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    print('MainFruitList Build');
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
                    // Part of the card containing fruit image
                    key: key,
                    color: fruit.color,
                    child: Image.asset(
                      fruit.image,
                      height: 100,
                    ),
                  ),
                  Container(
                    // Part of the card that containing fruit name
                    height: 50,
                    margin: EdgeInsets.only(left: 20, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        fruit.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              // Part of the card containing price
              padding: EdgeInsets.all(20),
              child: Text(
                '\$${fruit.price}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                print('adding fruit line');
                if (cartNotifier.cartFruit.length == 0)
                  slideController.forward();
                setState(() {
                  fruit.currentPosition = getPositionbyKey(key);
                  int index = cartNotifier.cartFruit.indexOf(fruit);
                  if (index != -1) {
                    cartNotifier.cartFruit[index].Qty =
                        cartNotifier.cartFruit[index].qty + 1;
                    cartNotifier.cartFruit[index].qty == 2
                        ? cartNotifier.cartFruit[index].reAnimate = true
                        // ignore: unnecessary_statements
                        : null;
                  } else {
                    fruit.Qty = 1;
                    cartNotifier.cartFruit.add(fruit);
                  }
                  print(fruit.qty);
                });
              },
              child: Card(
                // Part of card containing the add button
                elevation: 4,
                child: Container(
                  height: 60,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Icon(Icons.add_circle_outline),
                ),
              ),
            )
          ],
        )
      ],
    );
  } // This is entire fruit card section

  // List of Cart Items when picked
  Widget buildSecondList() {
    var list = Provider.of<CartNotifier>(context);
    print('secondList Build');
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text(
            'Cart',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.shopping_cart_outlined),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.cartFruit.length,
              itemBuilder: (context, index) {
                print(list);
                return CartItem(list.cartFruit[index], index);
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => CartList(),
                ),
              );
            },
            child: Icon(Icons.shopping_cart),
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}

Position getPositionbyKey(GlobalKey key) {
  RenderBox box = key.currentContext.findRenderObject();
  Size size = box.size;
  Offset position = box.localToGlobal(Offset.zero); //this is global position
  double x = position.dx;
  double y = position.dy;
  return Position(x, y, size);
}

class Position {
  double x;

  double y;
  Size size;

  Position(this.x, this.y, this.size);
}
