import 'package:fends_mobile/constants/navbar.dart';
import 'package:flutter/material.dart';


class Navbar extends StatefulWidget {
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late double screenWidth;
  late String selectedTitle;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    selectedTitle = navbar[0].title;

    return Scaffold(
      body: Container(
        width: 322/360 *screenWidth,
        height: 42,
        child: Row(
          children: navbar.map((e) =>
              InkWell(
                onTap: () => setState(() {
                  selectedTitle = e.title;
                }),
                  child: NavbarItem(
                    title: e.title,
                    icon: e.icon,
                    selectedTitle: selectedTitle,)
              )
          ).toList()
        ),
      ),
    );
  }
}

class NavbarItem extends StatefulWidget {
  final String selectedTitle;
  final String title;
  final IconData icon;

  const NavbarItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.selectedTitle,
  }):super(key: key);

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(widget.icon),
          Text(widget.title)
        ],
      )
    );
  }
}