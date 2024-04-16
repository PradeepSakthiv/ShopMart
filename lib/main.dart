import 'package:flutter/material.dart';
import 'package:shop_mart/MyCustomScrollBehavior.dart';
import 'package:shop_mart/bookcard.dart';

void main() {
    runApp(MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: BookCard(),
      routes: {
        'bookcard': (context) => BookCard()
      },
    ));
  }