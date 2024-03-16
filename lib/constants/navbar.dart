import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItem {
  final String title;
  final IconData icon;

  MenuItem({required this.title, required this.icon});
}

List<MenuItem> navbar = [
  MenuItem(title: 'Trang chủ', icon: FontAwesomeIcons.house),
  MenuItem(title: 'Tìm kiếm', icon: FontAwesomeIcons.searchengin),
  MenuItem(title: 'Bán hàng', icon: FontAwesomeIcons.shop),
  MenuItem(title: 'Quyên góp', icon: FontAwesomeIcons.gift),
  MenuItem(title: 'Tài khoản', icon: FontAwesomeIcons.user),
];