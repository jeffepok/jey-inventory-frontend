import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';

class GlobalMiddleware extends GetMiddleware {
  final userController = Get.find<UserController>();

  @override
  RouteSettings? redirect(String? route) {
    if(userController.authenticated && route == '/login'){
      return RouteSettings(name: '/home');
    }else if(!userController.authenticated && route != '/login'){
      return RouteSettings(name: '/login');
    }else{
      return null;
    }
  }

}