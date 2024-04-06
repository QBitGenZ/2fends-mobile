import 'package:fends_mobile/models/product.dart';
import 'package:fends_mobile/models/product_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import '../app_config.dart';
import '../models/product_image.dart';
import '../models/token.dart';

class ProductRequest {
  static const String URLS = AppConfig.SERVER_API_URL + '/products/';

  static Future<List<Product>> GetProducts({int? page = 1}) async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.get(Uri.parse(URLS+'?page=${page}'),
        headers: {"Authorization": "Bearer $tokenString"});
    final responseBody = jsonDecode(utf8.decode(res.bodyBytes));
    // responseBody['data'].forEach((data) => {});

    if (res.statusCode == 200) {
      List<Product> products = [];
      responseBody['data']
          .map((dynamic product) => products.add(Product.fromJson(product)))
          .toList();
      // print(responseBody['data'].runtimeType);
      return products;
    } else {
      throw Exception(responseBody);
    }
  }

  static Future<List<ProductType>> GetProductType() async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.get(Uri.parse(URLS + 'types/'),
        headers: {"Authorization": "Bearer $tokenString"});
    final responseBody = jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode == 200) {
      List<ProductType> productType = [];
      responseBody['data']
          .map((dynamic product) =>
              productType.add(ProductType.fromJson(product)))
          .toList();
      return productType;
    } else {
      throw Exception(responseBody);
    }
  }

  static Future<Product> AddProduct(Product product) async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.post(Uri.parse(URLS), headers: {
      "Authorization": "Bearer $tokenString"
    }, body: {
      'name': product.name.toString(),
      'price': product.price.toString(),
      'quantity': product.quantity.toString(),
      'product_type': product.productType.toString(),
      'size': product.size.toString(),
      'description': product.description.toString()
    });
    final responseBody = jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode == 201) {
      return Product.fromJson(responseBody['data']);
    } else {
      throw Exception(responseBody);
    }
  }

  static Future<bool> AddProductImage(
      String alt, String productID, XFile src) async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    File file = File(src.path);
    final List<int> imageBytes = await file.readAsBytes();
    final req = await http.MultipartRequest("POST", Uri.parse(URLS + "images/"));
    req.headers["Authorization"] = "Bearer $tokenString";
    req.files.add(http.MultipartFile('src',  http.ByteStream.fromBytes(imageBytes),imageBytes.length, filename: src.name));
    req.fields['alt'] = alt;
    req.fields['product'] = productID;
    var res = await req.send();
    print(res.toString());
    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
