import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jey_inventory_mobile/src/config.dart';

class AuthService {
  static Future<http.Response> login(String username, String password) async {
    var url = Config.production
        ? Uri.https(Config.backendBaseUrl, 'api/auth/token/login/')
        : Uri.http(Config.backendBaseUrl, 'api/auth/token/login/');
    var response = await http.post(url, body: {
      'username': username,
      'password': password,
    });
    return response;
  }

  static Future <bool> setToken(String token) async {
    var prefs = Get.find<SharedPreferences>();
    return prefs.setString('token', token);
  }

  static Future<String> getToken() async {
    var prefs = Get.find<SharedPreferences>();
    var token = prefs.getString('token') ?? "";
    return Future.value(token);
  }

  static removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}