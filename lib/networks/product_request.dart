import 'package:fends_mobile/models/feedback.dart';
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
  static const String URLS = '${AppConfig.SERVER_API_URL}/products/';

  static Future<List<Product>> getProducts({int? page = 1}) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(Uri.parse('$URLS?page=${page}'),
          headers: {"Authorization": "Bearer $tokenString"});
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));
      // responseBody['data'].forEach((data) => {});

      if (res.statusCode == 200) {
        List<Product> products = [];
        responseBody['data']
            .map((dynamic product) => products.add(Product.fromJson(product)))
            .toList();
        return products;
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Product>> getMyProducts({int? page = 1}) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(Uri.parse('${URLS}myproducts/?page=$page'),
          headers: {"Authorization": "Bearer $tokenString"});
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));

      if (res.statusCode == 200) {
        List<Product> products = [];
        responseBody['data']
            .map((dynamic product) => products.add(Product.fromJson(product)))
            .toList();
        return products;
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<Product> getProductByID(String productID) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(Uri.parse('${URLS}$productID/'),
          headers: {"Authorization": "Bearer $tokenString"});
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));

      if (res.statusCode == 200) {
        Product product = Product.fromJson(responseBody['data']);
        return product;
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<ProductType>> getProductType() async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(Uri.parse('${URLS}types/'),
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
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<Product> addProduct(Product product) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.post(Uri.parse(URLS), headers: {
        "Authorization": "Bearer $tokenString"
      }, body: {
        'name': product.name.toString(),
        'price': product.price.toString(),
        'quantity': product.quantity.toString(),
        'product_type': product.productType.toString(),
        'size': product.size.toString(),
        'description': product.description.toString(),
        'degree': product.degree.toString(),
        'gender': product.gender.toString()
      });
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));
      print(responseBody);
      if (res.statusCode == 201) {
        return Product.fromJson(responseBody['data']);
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<Product> updateProduct(Product product) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.put(Uri.parse('$URLS${product.id}/'), headers: {
        "Authorization": "Bearer $tokenString"
      }, body: {
        'name': product.name.toString(),
        'price': product.price.toString(),
        'quantity': product.quantity.toString(),
        'product_type': product.productType.toString(),
        'size': product.size.toString(),
        'description': product.description.toString(),
        'degree': product.degree.toString(),
        'gender': product.gender.toString()
      });
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));
      if (res.statusCode == 201) {
        return Product.fromJson(responseBody['data']);
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addProductImage(
      String alt, String productID, XFile src) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      File file = File(src.path);
      final List<int> imageBytes = await file.readAsBytes();
      final req =
          await http.MultipartRequest("POST", Uri.parse("${URLS}images/"));
      req.headers["Authorization"] = "Bearer $tokenString";
      req.files.add(http.MultipartFile(
          'src', http.ByteStream.fromBytes(imageBytes), imageBytes.length,
          filename: src.name));
      req.fields['alt'] = alt;
      req.fields['product'] = productID;
      var res = await req.send();

      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }



  static Future<double> getRevenue() async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(
          Uri.parse('${AppConfig.SERVER_API_URL}/products/myproducts/revenue/'),
          headers: {"Authorization": "Bearer $tokenString"});
      var revenue = 0.0;
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));
      if (res.statusCode == 200) {
        revenue = responseBody['data'];
        print(responseBody);
        return revenue;
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addFeedback(MyFeedback feedback) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.post(Uri.parse("${URLS}feedbacks/"), headers: {
        "Authorization": "Bearer $tokenString"
      }, body: {
        'title': feedback.title.toString(),
        'text': feedback.text.toString(),
        'product': feedback.product.toString(),
        'star_number': feedback.starNumber.toString()
      });
      print(res.body);
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Product>> search({int? page = 1, String? keyword}) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(
          Uri.parse('${URLS}search/?page=${page}&keyword=${keyword}'),
          headers: {"Authorization": "Bearer $tokenString"});
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));
      if (res.statusCode == 200) {
        List<Product> products = [];
        responseBody['data']
            .map((dynamic product) => products.add(Product.fromJson(product)))
            .toList();
        return products;
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
