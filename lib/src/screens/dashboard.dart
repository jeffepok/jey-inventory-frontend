import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/home_controller.dart';
import 'package:jey_inventory_mobile/src/controllers/user_controller.dart';
import 'package:jey_inventory_mobile/src/models/item.dart';


class Dashboard extends StatelessWidget {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 50,),
        ListTile(
          title: Card(
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
      ],
    );
  }
}
