import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:jey_inventory_mobile/src/interceptors/interceptors.dart';
import 'package:jey_inventory_mobile/src/config.dart';

class UserService{
  static final baseUrl = "jey-inventory.herokuapp.com";
  static http.Client client = InterceptedClient.build(interceptors: [
    TokenRequiredEndPointInterceptor()
  ]);

  static Future<http.Response> getUserData() async {
    var url = Config.production
        ? Uri.https(Config.backendBaseUrl, 'api/auth/users/me')
        : Uri.http(Config.backendBaseUrl, 'api/auth/users/me');

    var response = await client.get(url);
    return response;
  }

  static Future<http.Response> getItems() async {
    var url = Config.production
        ? Uri.https(Config.backendBaseUrl, 'api/inventory/items')
        : Uri.http(Config.backendBaseUrl, 'api/inventory/items');
    var response = await client.get(url);
    return response;
  }
}