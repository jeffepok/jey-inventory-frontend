import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/screens/dashboard.dart';

class HomeController extends GetxController{
  Rx<Widget> _body = Rx(Dashboard());

  get body {
    return _body.value;
  }

  set body (value) {
    _body.value = value;
  }
}