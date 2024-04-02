import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem({required this.title, required this.icon, required this.route});
}

List<MenuItem> navbar = [
  MenuItem(title: 'Trang chủ', icon: FontAwesomeIcons.house, route: '/home'),
  MenuItem(title: 'Tìm kiếm', icon: FontAwesomeIcons.searchengin, route: '/search'),
  MenuItem(title: 'Bán hàng', icon: FontAwesomeIcons.shop, route: '/departmentStore'),
  MenuItem(title: 'Quyên góp', icon: FontAwesomeIcons.gift, route: '/donation'),
  MenuItem(title: 'Tài khoản', icon: FontAwesomeIcons.user, route: '/account'),
];