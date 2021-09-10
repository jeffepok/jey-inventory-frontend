import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/services/auth_service.dart';
import 'dart:convert' as convert;


class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _authenticated = false.obs;
  var _username = "admin".obs;
  bool get authenticated => _authenticated.value;
  set authenticated(value) => _authenticated.value = value;
  get username => _username.value;
  set username(value) => _username.value = value;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    Timer(Duration(seconds: 3), () async{
      var token = await AuthService.getToken();
      if(token.length > 0){
        _authenticated(true);
      }
    });

    super.onInit();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 4){
      return 'Username too short';
    }
    return null;
  }

  Future<Map<String, dynamic>> login() async{
    AuthService auth = AuthService();
    var result = new Map<String, dynamic>();
    var response =
      await auth.login(usernameController.text, passwordController.text);
    var jsonResponse;
    try{
      //Convert response from json to native object
      jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    }catch(e){
      result['success'] = false;
      result['error'] = "An error occurred";
      print(e);
    }
    if (response.statusCode == 200) {
      //Set the token to storage
      await AuthService.setToken(jsonResponse['auth_token']);
      result['success'] = true;
    } else if(response.statusCode == 400) {
      result['success'] = false;
      result['error'] = jsonResponse['non_field_errors'][0];
    }
    return result;
  }

  Future<void> logout() async {
    AuthService.removeToken();
    authenticated = false;
  }
}
