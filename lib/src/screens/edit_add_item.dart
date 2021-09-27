import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/edit_add_item_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';
import 'home_screen.dart';

class EditAddItem extends StatelessWidget {
  final userController = UserController();
  final editAddItemController = Get.find<EditAddItemController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments["change"]
              ? 'Edit Item'
              : 'Add Item'
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: Form(
              key: editAddItemController.formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      // The validator receives the text that the user has entered.
                      controller: editAddItemController.itemName,
                      validator: editAddItemController.validator,
                      decoration: InputDecoration(
                          hintText: 'Item name',
                          hintStyle: TextStyle(color: Colors.black26))),
                  TextFormField(
                      // The validator receives the text that the user has entered.
                      controller: editAddItemController.description,
                      decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: TextStyle(color: Colors.black26))),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: editAddItemController.price,
                    validator: editAddItemController.validator,
                    decoration: InputDecoration(
                        hintText: 'Price',
                        hintStyle: TextStyle(color: Colors.black26)),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            editAddItemController.pickImage();
                          },
                          child: Text('Pick an image')),
                      ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 80),
                          child: Obx((){
                            if(editAddItemController.hasImage()){
                              return Image.memory(editAddItemController.image);
                            }
                            return Text('Pick an image');
                          }),
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        if (editAddItemController.loading) {
                          return CircularProgressIndicator();
                        }
                        return ElevatedButton(
                            onPressed: () async {
                              if (editAddItemController.formKey.currentState!
                                  .validate()) {
                                editAddItemController.loading = true;
                                var success = false;
                                if(!Get.arguments["change"]){
                                  success = await userController.addItem();
                                }else{
                                  success =
                                  await userController.editItem(
                                    Get.arguments["itemId"]
                                  );
                                }
                                editAddItemController.loading = false;
                                if (success) {
                                  editAddItemController.formKey.currentState!
                                      .reset();
                                  editAddItemController.image = [0];
                                  Get.off(() => Home());
                                } else
                                  print('An error occurred');
                              }
                            },
                            child: Text('Save'));
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
