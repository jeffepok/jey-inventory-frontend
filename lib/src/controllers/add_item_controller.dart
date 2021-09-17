
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final itemName = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  // final image = TextEditingController();
  final category = TextEditingController();
  final _loading = false.obs;
  get loading => _loading.value;
  set loading(value) => _loading.value = value;

  @override
  void onClose() {
    itemName.dispose();
    price.dispose();
    description.dispose();
    // image.dispose();
    category.dispose();
    super.onClose();
  }
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }
}
