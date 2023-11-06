import 'package:crud/Screen/ProductCreate.dart';
import 'package:crud/Screen/ProductGridView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD APP',
      home: ProductGridView(),
    );
  }
}
