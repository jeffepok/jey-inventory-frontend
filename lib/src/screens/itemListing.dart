import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/edit_add_item_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/home_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';
import 'package:jey_inventory_mobile/src/models/item.dart';
import 'package:http/http.dart' as http;

import 'edit_add_item.dart';

class ItemListing extends StatelessWidget {
  final userController = Get.find<UserController>();
  final editAddItemController = Get.find<EditAddItemController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: FutureBuilder(
            future: userController.getItems(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
              if (snapshot.hasData) {
                return Obx(() {
                  var homeController = Get.find<HomeController>();
                  if (!homeController.loading) {
                    return ListView(
                        children: snapshot.data!.map((item) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ListTile(
                              leading: item.image != null
                                  ? Image.network(item.image, loadingBuilder:
                                      (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      );
                                    })
                                  : Text('No image'),
                              title: Text(item.name),
                              subtitle: Text(item.description!),
                              trailing: Text("Price: ${item.price}"),
                              onTap: () async {
                                editAddItemController.itemName.text = item.name;
                                editAddItemController.price.text =
                                    "${item.price}";
                                editAddItemController.description.text =
                                    item.description!;
                                homeController.loading = true;
                                //Get image as bytes
                                var response =
                                    await http.get(Uri.parse(item.image));
                                editAddItemController.image =
                                    response.bodyBytes;
                                Get.to(() => EditAddItem(), arguments: {
                                  "change": true,
                                  "itemId": item.id
                                })!
                                    .then((value) =>
                                        homeController.loading = false);
                              },
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            ListTile(
                              subtitle: Center(child: Icon(Icons.delete)),
                              onTap: () {
                                _showDeleteDialog(context, item.id);
                              },
                            )
                          ],
                        ),
                      );
                    }).toList());
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Item'),
        icon: const Icon(
          Icons.add,
        ),
        onPressed: () {
          clearAddEditForm();
          Get.to(() => EditAddItem(), arguments: {"change": false});
        },
      ),
    );
  }

  void clearAddEditForm() {
    editAddItemController.itemName.text = "";
    editAddItemController.image = [0];
    editAddItemController.price.text = "";
    editAddItemController.description.text = "";
  }

  void _showDeleteDialog(BuildContext context, int? itemId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Alert!!"),
          content: Text("Are you sure you want to delete item?"),
          actions: <Widget>[
            TextButton(
              child: Text("Yes"),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                final homeController = Get.find<HomeController>();
                homeController.loading = true;
                var deleted = await userController.deleteItem(itemId);
                homeController.loading = false;
                homeController.body = ItemListing();
                if (deleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item is deleted')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Something went wrong!')));
                }
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
