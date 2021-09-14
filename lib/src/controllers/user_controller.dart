import 'dart:async';

import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/models/item.dart';
import 'package:jey_inventory_mobile/src/services/auth_service.dart';
import 'package:jey_inventory_mobile/src/services/user_service.dart';
import 'dart:convert' as convert;

class UserController extends GetxController {
  var _id = (-1).obs;
  var _username = "".obs;
  var _email = "".obs;
  var _authenticated = false;
  bool get authenticated => _authenticated;

  set authenticated(value) {
    _authenticated = value;
    //Get user data once authentication is set to true.
    if (value) {
      getUserData();
    }
  }

  get username => _username.value;
  set username(value) => _username.value = value;
  String get email => _email.value;
  set email(value) => _email.value = value;
  get id => _id.value;
  set id(value) => _id.value = value;

  @override
  onInit() async {
    AuthService.getToken().then((token) {
      if (token.length > 0) {
        authenticated = true;
      }
      super.onInit();
    });
  }

  Future<void> getUserData() async {
    try {
      var response = await UserService.getUserData();
      //Convert response from json to native object
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        username = jsonResponse["username"];
        email = jsonResponse["email"];
        id = jsonResponse["id"];
      } else if (response.statusCode == 400) {
        print(jsonResponse);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Item>> getItems() async {
    try {
      var response = await UserService.getItems();
      //Convert response from json to native object
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      List<Item> items = [];

      //To be implemented efficiently
      jsonResponse.forEach((item) {
        items.add(new Item(
            name: item['name'],
            price: double.parse(item['price']),
            description: item['description'],
            owner: item['owner'],
            category: item['category'],
            imageLink: item['image']));
      });

      return items;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> logout() async {
    AuthService.removeToken();
    authenticated = false;
  }
}
