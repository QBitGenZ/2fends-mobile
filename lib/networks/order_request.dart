import 'dart:convert';
import 'package:fends_mobile/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../models/order.dart';

class OrderRequest {
  static const String URLS = '${AppConfig.SERVER_API_URL}/orders/';

  static List<Order> parseOrder(String responseBody) {
    final parsed = json
        .decode(utf8.decode(responseBody.runes.toList()))['data']
        .cast<Map<String, dynamic>>();
    return parsed.map<Order>((json) => Order.fromJson(json)).toList();
  }

  static Future<List<Order>> getOrders() async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(Uri.parse('${URLS}myorders/'),
          headers: {"Authorization": "Bearer $tokenString"},);
      if (res.statusCode == 200) {
        return compute(parseOrder, res.body);
      }
      else {
        throw Exception("Fail to load Orders");
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<Order> addOrder(Order order) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;

      if (order.address == null || order.paymentMethod == null) {
        throw Exception('Address or payment method is null');
      }


      final res = await http.post(Uri.parse(URLS),
          headers: {"Authorization": "Bearer $tokenString"},
          body: {
            'address' : order.address!,
            'payment_method' : order.paymentMethod!
          });
      if (res.statusCode == 201) {
        var responseBody = jsonDecode(utf8.decode(res.bodyBytes));
        return Order.fromJson(responseBody['data']);
      } else {
        throw Exception('Failed to add order');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

}