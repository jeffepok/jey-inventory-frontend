import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/bindings/login_binding.dart';
import 'package:jey_inventory_mobile/src/controllers/login_controller.dart';
import 'package:jey_inventory_mobile/src/screens/home_screen.dart';
import 'package:jey_inventory_mobile/src/screens/login_screen.dart';
import 'package:jey_inventory_mobile/src/middlewares/global_middleware.dart';
import 'package:jey_inventory_mobile/src/screens/splash_screen.dart';

void main() {
  Get.put(LoginController());

  runApp(GetMaterialApp(
    initialRoute: '/splash',
    getPages: [
      GetPage(
        name: '/splash',
        page: () => SplashScreen(),
        middlewares: [GlobalMiddleware()],
        binding: LoginControllerBinding()
      ),
      GetPage(
        name: '/home',
        page: () => Home(),
        binding: LoginControllerBinding(),
        middlewares: [GlobalMiddleware()]
      ),
      GetPage(
        name: '/login',
        page: () => LoginScreen(),
        binding: LoginControllerBinding(),
        middlewares: [GlobalMiddleware()],
      ),
    ],
  ));
}