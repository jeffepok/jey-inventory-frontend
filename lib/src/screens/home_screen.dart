import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/login_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';

class Home extends StatelessWidget {
  final loginController = Get.find<LoginController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(context) {

    return Scaffold(
      // Use Obx(()=> to update Text()
      appBar: AppBar(
        title: Obx(() => Text(userController.username)),
        actions: [
          IconButton(
              onPressed: () async {
                await userController.logout();
                Get.offNamed('/login');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      // Replace the 8 lines Navigator.push by a simple Get.to().
      // You don't need context
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.addchart_sharp),
                title: Text('Items'),
                subtitle: FutureBuilder(
                  future: userController.getItems(),
                  builder: (
                      BuildContext context,
                      AsyncSnapshot<List<Item>> snapshot){
                    if(snapshot.hasData){
                      return Text('${snapshot.data!.length}');
                    }else{
                      return Text('loading...');
                    }
                  }
                )
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Obx(() => Text(
                    userController.email,
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Items'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
