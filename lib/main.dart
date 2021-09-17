import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/add_item_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/home_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/login_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';
import 'package:jey_inventory_mobile/src/screens/home_screen.dart';
import 'package:jey_inventory_mobile/src/screens/login_screen.dart';
import 'package:jey_inventory_mobile/src/middlewares/global_middleware.dart';
import 'package:jey_inventory_mobile/src/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {

  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  Get.put(UserController());
  Get.put(HomeController());
  Get.put(LoginController());
  Get.put(AddItemController());



  runApp(GetMaterialApp(
    initialRoute: '/splash',
    getPages: [
      GetPage(
          name: '/splash',
          page: () => SplashScreen(),
          middlewares: [GlobalMiddleware()],
      ),
      GetPage(
          name: '/home',
          page: () => Home(),
          middlewares: [GlobalMiddleware()],
      ),
      GetPage(
          name: '/login',
          page: () => LoginScreen(),
          middlewares: [GlobalMiddleware()],
      ),
    ],
  ));
}
