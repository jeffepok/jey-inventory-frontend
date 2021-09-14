import 'package:http_interceptor/http_interceptor.dart';
import 'package:jey_inventory_mobile/src/services/auth_service.dart';

class TokenRequiredEndPointInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    var token = await AuthService.getToken();
    try {
      data.headers["Authorization"] = "Token $token";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}