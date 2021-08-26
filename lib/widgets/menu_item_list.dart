import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/menu_item.dart';
import 'menu_item_tile.dart';
import 'primary_progress_indicator.dart';

class MenuItemList extends StatelessWidget {
  final String firestoreCollectionName;
  const MenuItemList({Key? key, required this.firestoreCollectionName})
      : super(key: key);

  List<Widget>? getItemsfromList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs
        .map((doc) => MenuItemTilePressable(
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
        stream: FirebaseFirestore.instance
            .collection(firestoreCollectionName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const PrimaryProgressIndicator();
          }
          return ListView(children: getItemsfromList(snapshot)!);
        });
  }
}
