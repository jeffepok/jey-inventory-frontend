import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';


class UserControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }
}