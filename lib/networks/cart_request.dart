import 'package:fends_mobile/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../app_config.dart';
import '../models/cart_item.dart';
import '../models/token.dart';


class CartRequest{
  static const String URLS = AppConfig.SERVER_API_URL + '/carts/';

  static Future<List<CartItem>> getCarts() async{
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.get(Uri.parse(URLS), headers: {
      "Authorization": "Bearer $tokenString"
    });
    final responseBody =  jsonDecode(utf8.decode(res.bodyBytes));
    // responseBody['data'].forEach((data) => {});

    if(res.statusCode == 200){
      List<CartItem> carts = [      ];
      responseBody['data'].map((dynamic cart) => carts.add(CartItem.fromJson(cart))).toList();
      return carts;
    } else{
      throw Exception(responseBody);
    }
  }

  static Future<bool> addToCart(String productId, String quantity) async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.post(Uri.parse(URLS), headers: {
      "Authorization": "Bearer $tokenString"
    },
    body: {
      'product' : productId,
      'quantity': quantity
    });
    final responseBody =  jsonDecode(utf8.decode(res.bodyBytes));
    return res.statusCode == 201 || res.statusCode == 200;
  }

  static Future<bool> deleteFromCart(String cartID) async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.delete(Uri.parse(URLS + cartID), headers: {
      "Authorization": "Bearer $tokenString"
    });
    return res.statusCode == 204;
  }

}