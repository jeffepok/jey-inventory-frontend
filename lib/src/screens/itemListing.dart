import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/home_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';
import 'package:jey_inventory_mobile/src/models/item.dart';

import 'add_item.dart';

class ItemListing extends StatelessWidget {
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: FutureBuilder(
            future: userController.getItems(),
            builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
              if (snapshot.hasData) {

                return ListView(
                    children: snapshot.data!.map((item) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          leading: item.imageLink != null
                              ? Image.network(item.imageLink!,
                              loadingBuilder: (
                                  BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress
                                  ) {
                                 if (loadingProgress == null) {
                                   return child;
                                 }
                                 return CircularProgressIndicator(
                                   value: loadingProgress.expectedTotalBytes != null
                                       ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                       : null,
                                 );
                               }) : Text('No image'),
                            title: Text(item.name),
                            subtitle: Text(item.description!),
                          onTap: (){
                          },
                          trailing: Text("Price: ${item.price}"),
                        ),

                      ],
                    ),
                  );
                }).toList());
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Item'),
        icon: const Icon(Icons.add,),
        onPressed: (){
          Get.to(() => AddItem());
        },
      ),
    );
  }
}
