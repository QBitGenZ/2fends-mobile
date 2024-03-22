import 'package:fends_mobile/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../app_config.dart';
import '../models/cart.dart';
import '../models/token.dart';


class CartRequest{
  static const String URLS = AppConfig.SERVER_API_URL + '/carts/';

  static Future<List<Cart>> GetCarts() async{
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.get(Uri.parse(URLS), headers: {
      "Authorization": "Bearer $tokenString"
    });
    final responseBody =  jsonDecode(utf8.decode(res.bodyBytes));
    // responseBody['data'].forEach((data) => {});

    if(res.statusCode == 200){
      List<Cart> carts = [      ];
      responseBody['data'].map((dynamic cart) => carts.add(Cart.fromJson(cart))).toList();
      print(responseBody['data'].runtimeType);
      return carts;
    } else{
      throw Exception(responseBody);
    }
  }

}