import 'dart:convert';

import '../app_config.dart';import 'package:http/http.dart' as http;


class StatisticRequest {
  static const String URLS = '${AppConfig.SERVER_API_URL}/statistics/';

  static Future<int> myTotalFund() async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(Uri.parse('${URLS}my-total-fund/'),
          headers: {"Authorization": "Bearer $tokenString"});
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));

      if (res.statusCode == 200) {
        return responseBody['data'].toInt();
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

}
