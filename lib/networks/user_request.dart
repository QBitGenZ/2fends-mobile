import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fends_mobile/app_config.dart';
import 'package:fends_mobile/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class UserRequest {
  static const String URLS = AppConfig.SERVER_API_URL ;
  static Token parseToken(String res) {
    return (Token.fromJson(json.decode(res)));
  }

  static Future<Token> loginToken(String username, String password) async {
    final res = await http.post(Uri.parse(URLS+'/login'),
        body: {"username": username, "password": password});
    final responseBody = json.decode(res.body);
    // print(responseBody);
    if (res.statusCode == 200) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // final Token token = parseToken(responseBody);
      // await prefs.setString('token', token.access.toString());
      return compute(parseToken, res.body);

    } else {
      throw Exception(responseBody);
    }
  }

  static Future<bool> signup(String username, String password, String fullname, DateTime birthday, String gender,String email, String phone) async {
    try {
      String formattedBirthday = DateFormat('yyyy-MM-dd').format(birthday);
      final res = await http.post(
        Uri.parse(URLS + '/register'),
        body: {
          'username': username,
          'password': password,
          'full_name': fullname,
          'birthday':formattedBirthday, // Convert DateTime to string
          'gender': gender,
          'phone': phone,
          'email': email
        },
      );

      // Decode the response body
      final responseBody = json.decode(res.body);
      print(res.statusCode);
      // Check the response status code
      if (res.statusCode == 201) {
        return true;
      } else {
        // Signup failed, throw exception with response body
        throw Exception(responseBody);
      }
    } catch (e) {
      // Error occurred during signup process
      throw Exception('Failed to signup: $e');
    }
  }

}
