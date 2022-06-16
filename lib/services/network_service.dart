import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:network_contact_app/models/contact_model.dart';

import 'log_service.dart';

class NetworkService {
  static bool isTester = true;

  static const String SERVER_DEVELOPMENT = "62a72d5c97b6156bff896081.mockapi.io";
  static const String SERVER_PRODUCTION = "62a72d5c97b6156bff896081.mockapi.io";

  static const String API_POST = "/contact";
  static const String API_POST_CREATE = "/contact";
  static const String API_POST_DELETE = "/contact/"; //ID
  static const String API_POST_UPDATE = "/contact/"; //ID

  static String getServer() {
    if (isTester) {
      return SERVER_DEVELOPMENT;
    }
    return SERVER_PRODUCTION;
  }

  static Map<String, String> get headers {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    return headers;
  }

  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    Uri uri = Uri.https(getServer(), api, params);
    http.Response? response = await http.get(uri, headers: headers);
    LogService.i(response.statusCode.toString());

    if (response.statusCode != 200) {
      return null;
    }
    return response.body;
  }

  static Future<String?> POST(String api, String body) async {
    Uri uri = Uri.https(getServer(), api);
    http.Response? response = await http.post(uri, body: body, headers: headers);
    LogService.i(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, String id) async {
    Uri uri = Uri.https(getServer(), '$api$id');
    http.Response? response = await http.delete(uri,headers: headers);
    LogService.i(response.statusCode.toString());

    if (response.statusCode != 200 || response.statusCode != 201) {
      return null;
    }
    return response.body;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> body) async {
    Uri uri = Uri.https(getServer(), api);
    http.Response? response = await http.put(uri, body: jsonEncode(body), headers: headers);
    LogService.i(response.body);

    return response.body;
  }

  // #params
  static Map<String, dynamic> emptyParams() {
    Map<String, dynamic> map = {};
    return map;
  }

  // #body
  static String bodyCreate(Contact contact) {
    Map<String, dynamic> mapJson = {
      "id": contact.id,
      "name": contact.name,
      "phoneNumber": contact.phoneNumber
    };
    String stringJson = jsonEncode(mapJson);
    return stringJson;
  }

  // #parsing
  static List<Contact> parsePostList(String body) {
    List json = jsonDecode(body);
    List<Contact> contacts = json.map((item) => Contact.fromJson(item)).toList();
    return contacts;
  }
}