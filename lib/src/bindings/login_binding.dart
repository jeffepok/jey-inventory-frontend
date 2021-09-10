import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/login_controller.dart';


class LoginControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}