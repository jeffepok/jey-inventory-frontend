import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/home_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/login_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';
import 'package:jey_inventory_mobile/src/screens/itemListing.dart';
import 'dashboard.dart';

class Home extends StatelessWidget {
  final loginController = Get.find<LoginController>();
  final userController = Get.find<UserController>();
  final homeController = Get.find<HomeController>();

  @override
  Widget build(context) {
    return Scaffold(
      // Use Obx(()=> to update Text()
      appBar: AppBar(
        title: Obx(() => Text(userController.username)),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
                onPressed: () async {
                  await userController.logout();
                  Get.offNamed('/login');
                },
                icon: Icon(Icons.logout)),
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 700,
          ),
          child: Obx((){
            return homeController.body;
          }),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Obx(() => Center(
                child: Text(
                      userController.email,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
              )),
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                homeController.body = Dashboard();
              },
            ),
            ListTile(
              title: const Text('Items'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                homeController.body = ItemListing();
              },
            ),
          ],
        ),
      ),
    );
  }
}


