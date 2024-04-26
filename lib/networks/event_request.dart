import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../app_config.dart';
import '../models/donation_product.dart';
import '../models/event.dart';
import 'package:http/http.dart' as http;

class EventRequest {
  static const String URLS = AppConfig.SERVER_API_URL + '/events/';

  static Future<List<MyEvent>> getEvents({int? page = 1}) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(Uri.parse('$URLS?page=${page}'),
          headers: {"Authorization": "Bearer $tokenString"});
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));

      if (res.statusCode == 200) {
        List<MyEvent> events = [];
        responseBody['data']
            .map((dynamic product) => events.add(MyEvent.fromJson(product)))
            .toList();
        return events;
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<MyEvent>> getMyEvents({int? page = 1}) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(Uri.parse('${URLS}my/?page=${page}'),
          headers: {"Authorization": "Bearer $tokenString"});
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));

      if (res.statusCode == 200) {
        List<MyEvent> events = [];
        responseBody['data']
            .map((dynamic product) => events.add(MyEvent.fromJson(product)))
            .toList();
        return events;
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addEvent(MyEvent event, XFile src) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      File file = File(src.path);
      final List<int> imageBytes = await file.readAsBytes();
      final req = await http.MultipartRequest("POST", Uri.parse(URLS));
      req.headers["Authorization"] = "Bearer $tokenString";
      req.files.add(http.MultipartFile(
          'image', http.ByteStream.fromBytes(imageBytes), imageBytes.length,
          filename: src.name));
      req.fields['name'] = event.name.toString();
      req.fields['description'] = event.description.toString();
      req.fields['beginAt'] = event.beginAt.toString();
      req.fields['endAt'] = event.endAt.toString();
      //TODO: chon san phammm can quyen gop
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

  static Future<bool> updateEvent(MyEvent event, XFile src) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      File file = File(src.path);
      final List<int> imageBytes = await file.readAsBytes();
      final req = await http.MultipartRequest("PUT", Uri.parse('${URLS}${event.id}/'));
      req.headers["Authorization"] = "Bearer $tokenString";
      req.files.add(http.MultipartFile(
          'image', http.ByteStream.fromBytes(imageBytes), imageBytes.length,
          filename: src.name));
      req.fields['name'] = event.name.toString();
      req.fields['description'] = event.description.toString();
      req.fields['beginAt'] = event.beginAt.toString();
      req.fields['endAt'] = event.endAt.toString();
      //TODO: chon san phammm can quyen gop
      var res = await req.send();
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addDonationProduct(
      int quantity, String productID, String eventID) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http
          .post(Uri.parse('${URLS}${eventID}/donation_products/'), headers: {
        "Authorization": "Bearer $tokenString"
      }, body: {
        'product': productID.toString(),
        'quantity': quantity.toString(),
        'event': eventID.toString()
      });
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

  static Future<List<DonationProduct>> getDonationProduct(
      String eventID, {int? page=1}) async {
    try {
      final tokenString = AppConfig.ACCESS_TOKEN;
      final res = await http.get(
        Uri.parse('$URLS$eventID/donation_products/?page=$page'),
        headers: {"Authorization": "Bearer $tokenString"},
      );
      final responseBody = jsonDecode(utf8.decode(res.bodyBytes));

      if (res.statusCode == 200) {
        List<DonationProduct> donationProducts = [];
        responseBody['data']
            .map((dynamic product) =>
                donationProducts.add(DonationProduct.fromJson(product)))
            .toList();
        return donationProducts;
      } else {
        throw Exception(responseBody);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
