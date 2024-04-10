import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fends_mobile/app_config.dart';
import 'package:fends_mobile/models/token.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../models/user.dart';

class UserRequest {
  static const String URLS = AppConfig.SERVER_API_URL;
  static Token parseToken(String res) {
    return (Token.fromJson(json.decode(res)));
  }

  static Future<Token> loginToken(String username, String password) async {
    final res = await http.post(Uri.parse(URLS + '/login'),
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

  static Future<bool> signup(String username, String password, String fullname,
      DateTime birthday, String gender, String email, String phone) async {
    try {
      String formattedBirthday = DateFormat('yyyy-MM-dd').format(birthday);
      final res = await http.post(
        Uri.parse(URLS + '/register'),
        body: {
          'username': username,
          'password': password,
          'full_name': fullname,
          'birthday': formattedBirthday, // Convert DateTime to string
          'is_female': gender == 'Nữ',
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

  static Future<User> info() async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(Uri.parse(URLS + '/info'),
          headers: {"Authorization": "Bearer $tokenString"});

      // Decode the response body
      final responseBody = json.decode(res.body);
      print(res.statusCode);
      // Check the response status code
      if (res.statusCode == 200) {
        return User.fromJson(responseBody['data']);
      } else {
        throw Exception(responseBody);
      }
    } catch (e) {
      // Error occurred during signup process
      throw Exception('Failed to signup: $e');
    }
  }

  static Future<bool> updateUser(String fullname,
  DateTime birthday, String gender, String email, String phone, {XFile? src}) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      String formattedBirthday =
          DateFormat('yyyy-MM-dd').format(birthday!);
      final req =
          await http.MultipartRequest("PUT", Uri.parse(URLS + '/user'));
      req.headers["Authorization"] = "Bearer $tokenString";
      if (src != null) {
        File file = File(src.path);
        final List<int> imageBytes = await file.readAsBytes();
        req.files.add(http.MultipartFile(
            'avatar', http.ByteStream.fromBytes(imageBytes), imageBytes.length,
            filename: src.name));
      }
      req.fields['full_name'] = fullname;
      req.fields['email'] = email;
      req.fields['phone'] = phone;
      req.fields['birthday'] = formattedBirthday;
      req.fields['is_female'] = (gender == 'Nữ') ? 'true' : 'false';
      var res = await req.send();
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Error occurred during signup process
      throw Exception('Failed to signup: $e');
    }
  }
}
