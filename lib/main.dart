

import 'package:fends_mobile/pages/product/cart_page.dart';

import 'package:fends_mobile/pages/chat/chat_page.dart';

import 'package:fends_mobile/pages/index.dart';


import 'package:fends_mobile/pages/home/home_page.dart';
import 'package:fends_mobile/pages/home/start_page.dart';

import 'package:fends_mobile/pages/sales/addproduct.dart';


import 'package:fends_mobile/pages/order/comment_page.dart';
import 'package:fends_mobile/pages/order/order_page.dart';
import 'package:fends_mobile/pages/order/status_order_page.dart';
// import 'package:fends_mobile/pages/home/index.dart';

import 'package:fends_mobile/sections/recomment_product_section.dart';

import 'package:fends_mobile/widgets/navbar.dart';
import 'package:flutter/material.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      supportedLocales: const [
        Locale('en', 'US'),
        // Add other supported locales as needed
      ],
      theme: ThemeData(

          scaffoldBackgroundColor: Colors.white
      ),
      color: Colors.white,


      // home: AddProductPage(),
home: StartPage(),
      // home: RecommentProductSection(),
      // home: ChatPage(),
      // home: CommentPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
