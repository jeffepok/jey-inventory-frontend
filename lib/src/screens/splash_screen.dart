import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/login_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';
import 'package:jey_inventory_mobile/src/interceptors/interceptors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final loginController = Get.find<LoginController>();
  final userController = Get.find<UserController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue
        ),
        child: Center(
          child: Text(
            'Jey Inventory',
            style: TextStyle(color: Colors.white, fontSize: 45),
          )
        ),
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () async{
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async{
    if (userController.authenticated) {
      Get.offNamed('/home');
    } else {
      Get.offNamed('/login');
    }
  }
}