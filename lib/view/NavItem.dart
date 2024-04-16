import 'package:flutter/material.dart';
class NavItem extends StatelessWidget {
  const NavItem({Key? key, required this.title, required this.icon}) :
        super(key: key);
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(this.icon),
      title: Text(this.title),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(title),
        ));
      },
    );
  }
}