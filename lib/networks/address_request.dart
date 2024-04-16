import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fends_mobile/models/address.dart';

import '../app_config.dart';

class AddressRequset {
  static const String URLS = AppConfig.SERVER_API_URL + '/addresses/';

  static List<Address> parseAddress(String responseBody) {
    final parsed = json
        .decode(utf8.decode(responseBody.runes.toList()))['data']
        .cast<Map<String, dynamic>>();
    return parsed.map<Address>((json) => Address.fromJson(json)).toList();
  }

  static Future<List<Address>> getAddresses() async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.get(Uri.parse(URLS),
        headers: {"Authorization": "Bearer $tokenString"});

    if (res.statusCode == 200) {
      return compute(parseAddress, res.body);
    } else {
      throw Exception('Failed to load address');
    }
  }

  static Future<bool> addAddress(String address) async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    final res = await http.post(Uri.parse(URLS),
        headers: {"Authorization": "Bearer $tokenString"},
        body: {'address': address});
    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
