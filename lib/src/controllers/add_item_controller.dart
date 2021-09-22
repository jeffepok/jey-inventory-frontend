
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItemController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final itemName = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
  final _loading = false.obs;
  get loading => _loading.value;
  set loading(value) => _loading.value = value;

  final Rx<List<int>> _image = Rx([0]); //Store image bytes

  get image {
    if(this.hasImage()){
      return _image.value;
    }
    return null;
  }
  set image(value) => _image.value = value;

  @override
  void onClose() {
    itemName.dispose();
    price.dispose();
    description.dispose();
    category.dispose();
    super.onClose();
  }
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }
  void pickImage() async{
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery);
    this.image = await image!.readAsBytes();
  }
  bool hasImage(){
    return !_image.value.every((element) => element == 0);
  }

}
