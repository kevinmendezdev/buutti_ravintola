import 'package:buutti_ravintola/core/model/menu_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'menu_item_tile.dart';

class MenuItemList extends StatelessWidget {
  final String collectionName;
  const MenuItemList({Key? key, required this.collectionName})
      : super(key: key);

  List<Widget>? getItemsfromList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs
        .map((doc) => MenuItemTile(
              menuItem: MenuItem(
                  name: doc["name"] as String,
                  type: doc["type"] as String,
                  image: doc["image"] as String,
                  rating: doc["rating"] as int),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection(collectionName).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            );
          }
          return ListView(children: getItemsfromList(snapshot)!);
        });
  }
}
