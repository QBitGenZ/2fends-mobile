import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fends_mobile/app_config.dart';
import 'package:fends_mobile/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRequest {
  static const String URLS = AppConfig.SERVER_API_URL + 'login';
  static Token parseToken(String res) {
    return (Token.fromJson(json.decode(res)));
  }

  static Future<Token> loginToken(String username, String password) async {
    final res = await http.post(Uri.parse(URLS),
        body: {"username": username, "password": password});
    final responseBody = json.decode(res.body);
    if (res.statusCode == 200) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // final Token token = parseToken(responseBody);
      // await prefs.setString('token', token.access.toString());
      return compute(parseToken, res.body);
    } else {
      throw Exception(responseBody);
    }
  }
}
