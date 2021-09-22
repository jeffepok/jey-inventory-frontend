import 'dart:convert';

import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jey_inventory_mobile/src/interceptors/interceptors.dart';
import 'package:jey_inventory_mobile/src/config.dart';
import 'package:jey_inventory_mobile/src/models/item.dart';
import 'package:jey_inventory_mobile/src/services/auth_service.dart';


class UserService{
  static http.Client client = InterceptedClient.build(interceptors: [
    TokenRequiredEndPointInterceptor()
  ]);

  static Future<http.Response> getUserData() async {
    var url = "$backendBaseUrl/api/auth/users/me";

    var response = await client.get(Uri.parse(url));
    return response;
  }

  static Future<http.Response> getItems() async {
    var url = "$backendBaseUrl/api/inventory/items";

    var response = await client.get(Uri.parse(url));
    return response;
  }

  static Future<bool> addItem(Item item) async {
    var url = "$backendBaseUrl/api/inventory/items/";

    try{
      var response = await client.post(Uri.parse(url), body: item.toMap());
      return response.statusCode == HttpStatus.created;
    }catch(e){
      print(e);
      return false;
    }

  }
}
