import 'package:fends_mobile/constants/navbar.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final selectedTitle;
  final Function(String) updateSelectedTitle;

  Navbar({
    Key? key,
    required this.selectedTitle,
    required this.updateSelectedTitle
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD6C8AD),
            blurRadius: 24,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      width: screenWidth,
      height: 68,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: navbar
            .map(
              (e) => InkWell(
            onTap: () => widget.updateSelectedTitle(e.title),
            child: NavbarItem(
              title: e.title,
              icon: e.icon,
              selectedTitle: widget.selectedTitle,
              updateSelectedTitle: widget.updateSelectedTitle,
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}

class NavbarItem extends StatefulWidget {
  final String selectedTitle;
  final String title;
  final IconData icon;
  final Function(String) updateSelectedTitle;

  const NavbarItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.selectedTitle,
    required this.updateSelectedTitle,
  }) : super(key: key);

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            widget.icon,
            color: widget.title == widget.selectedTitle
                ? Color(0xff000000)
                : Color(0xffC3C3C3),
          ),
          Text(
            widget.title,
            style: TextStyle(
              color: widget.title == widget.selectedTitle
                  ? Color(0xff000000)
                  : Color(0xffC3C3C3),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}
