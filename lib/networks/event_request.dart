import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../app_config.dart';
import '../models/event.dart';
import 'package:http/http.dart' as http;

class EventRequest {
  static const String URLS = AppConfig.SERVER_API_URL + '/events/';

  static Future<List<MyEvent>> getEvents({int? page = 1}) async {
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
  }

  static Future<bool> addEvent(MyEvent event, XFile src) async {
    final tokenString = AppConfig.ACCESS_TOKEN;
    File file = File(src.path);
    final List<int> imageBytes = await file.readAsBytes();
    final req = await http.MultipartRequest("POST", Uri.parse(URLS));
    req.headers["Authorization"] = "Bearer $tokenString";
    req.files.add(http.MultipartFile('image',  http.ByteStream.fromBytes(imageBytes),imageBytes.length, filename: src.name));
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
  }

}
