import 'package:fends_mobile/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../app_config.dart';
import '../models/token.dart';


class ProductRequest{
  static const String URLS = AppConfig.SERVER_API_URL + '/products/';

  static Future<List<Product>> GetProducts() async{
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.get(Uri.parse(URLS), headers: {
      "Authorization": "Bearer $tokenString"
    });
    final responseBody =  jsonDecode(utf8.decode(res.bodyBytes));
    // responseBody['data'].forEach((data) => {});

    if(res.statusCode == 200){
      List<Product> products = [      ];
      responseBody['data'].map((dynamic product) => products.add(Product.fromJson(product))).toList();
      print(responseBody['data'].runtimeType);
      return products;
    } else{
      throw Exception(responseBody);
    }
  }

}