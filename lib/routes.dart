import 'package:fends_mobile/pages/account/account_page.dart';
import 'package:fends_mobile/pages/account/login_page.dart';
import 'package:fends_mobile/pages/donation/donation_page.dart';
import 'package:fends_mobile/pages/sales/department_store_page.dart';
import 'package:fends_mobile/pages/search/search_page.dart';
import 'package:fends_mobile/sections/home/index.dart';
import 'package:flutter/cupertino.dart';

var customRoutes = <String, WidgetBuilder> {
  '/login': (context) => LoginPage(),
  '/home': (context) => HomeSection(),
  '/departmentStore': (context) => DepartmentStorePage(),
  '/search': (context) => SearchPage(),
  '/donation': (context) => DonationPage(),
  '/account': (context) => AccountPage()
};

