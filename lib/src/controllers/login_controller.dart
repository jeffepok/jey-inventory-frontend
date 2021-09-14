import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/services/auth_service.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';
import 'dart:convert' as convert;


class LoginController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
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
    var result = new Map<String, dynamic>();
    var userController = Get.find<UserController>();
    try{
      var response = await AuthService.login(
          usernameController.text,
          passwordController.text
      );
      //Convert response from json to native object
      var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        //Set the token to storage
        await AuthService.setToken(jsonResponse['auth_token']);
        result['success'] = true;
        userController.authenticated = true;
      } else if(response.statusCode == 400) {
        result['success'] = false;
        result['error'] = jsonResponse['non_field_errors'][0];
      }
    }catch(e){
      result['success'] = false;
      result['error'] = "An error occurred";
      print(e);
    }

    return result;
  }

}
