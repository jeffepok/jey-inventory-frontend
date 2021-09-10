import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final baseUrl = "jey-inventory.herokuapp.com";

  Future<http.Response> login(String username, String password) async {
    var url = Uri.https(baseUrl, 'api/auth/token/login/');
    var response = await http.post(url, body: {
      'username': username,
      'password': password,
    });
    return response;
  }

  static Future <bool> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    return Future.value(token);
  }

  static removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}