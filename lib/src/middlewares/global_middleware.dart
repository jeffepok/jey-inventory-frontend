import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/login_controller.dart';

class GlobalMiddleware extends GetMiddleware {
  final loginController = Get.find<LoginController>();

  @override
  RouteSettings? redirect(String? route) {
    return loginController.authenticated && route == '/login'
        ? RouteSettings(name: '/home')
        : null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    print('>>> Page ${page!.name} called');
    var routeSettings =  loginController.username != null
        ? page.copyWith(arguments: {'user': loginController.username})
        : page;
    return page.copy(settings: routeSettings);
  }

}