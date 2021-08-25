
import 'package:flutter/material.dart';
import 'package:fruits/actions/cart_notifier.dart';
import 'package:fruits/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
      create: (BuildContext context) =>CartNotifier(),
      child:MyApp(),
      )
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}