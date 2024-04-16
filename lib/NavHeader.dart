import 'package:flutter/material.dart';
class NavHeader extends StatelessWidget {
  const NavHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height : 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0))
            ),
            child: Image.network("https://www.codewithflutter.com/wp-content/uploads/2021/05/flutter-in-tamil-01.png"),
          ),
          Text("Shop Mart")
        ],
      ),
    );
  }
}