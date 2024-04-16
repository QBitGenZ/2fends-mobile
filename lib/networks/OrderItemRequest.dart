import 'dart:convert';
import 'package:fends_mobile/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';

class OrderItemRequest {
  static const String URLS = '${AppConfig.SERVER_API_URL}/orders/';

  static List<OrderItem> parseOrderItem(String responseBody) {
    final parsed = json
        .decode(utf8.decode(responseBody.runes.toList()))['data']
        .cast<Map<String, dynamic>>();
    return parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  static Future<bool> addOrderItem(String orderId, OrderItem item) async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.post(Uri.parse("$URLS$orderId/items/"),
        headers: {"Authorization": "Bearer $tokenString"},
    body: {
      'product' : item.product?.id,
      'quantity' : item.quantity.toString()
    });


    if (res.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to load address');
    }
  }
}