
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/add_item_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';

import 'home_screen.dart';

class AddItem extends StatelessWidget {
  final userController = UserController();
  final addItemController = Get.find<AddItemController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: Form(
              key: addItemController.formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: addItemController.itemName,
                      validator: addItemController.validator,
                      decoration: InputDecoration(
                      hintText: 'Item name',
                      hintStyle: TextStyle(color: Colors.black26)
                    )
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: addItemController.description,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.black26)
                    )
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    controller: addItemController.price,
                    validator: addItemController.validator,
                    decoration: InputDecoration(
                        hintText: 'Price',
                        hintStyle: TextStyle(color: Colors.black26)
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx((){
                      if(addItemController.loading){
                        return CircularProgressIndicator();
                      }
                      return ElevatedButton(
                          onPressed: () async {
                            if(addItemController.formKey.currentState!.validate()){
                              addItemController.loading = true;
                              var added = await userController.addItem();
                              addItemController.loading = false;
                              if(added) {
                                addItemController.formKey.currentState!.reset();
                                Get.off(() => Home());
                              }
                              else print('An error occurred');
                            }
                          },
                          child: Text('Save')
                      );
                    })
                  )
                ],
              ),
            ) ,
          ),
        ),
      ),
    );
  }
}
