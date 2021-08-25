import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart/application/bloc.dart';
import 'cart/application/cart_bloc.dart';
import 'cart/presentation/cart_screen.dart';
import 'cart/presentation/order_result_screen.dart';
import 'core/model/menu_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int index = 0;
  final List<String> collectionsValues = [
    "main_dishes",
    "side_dishes",
    "drinks"
  ];
  final List<String> collectionsNames = [
    "Main Dishes",
    "Side Dishes",
    "Drinks"
  ];

  @override
  void initState() {
    // index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(collectionsNames[index]),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  print('cart length');
                  print(state.menuItems.length);
                  return Positioned(
                      top: 0.0,
                      right: 4.0,
                      child: Center(
                        child: Text(
                          state.menuItems.length.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ));
                },
              ),
            ],
          )
        ],
      ),
      body: Center(
          child: ItemList(
        collectionName: collectionsValues[index],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (index <= 1) {
            setState(() {
              index++;
            });
          } else if (index > 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OrderResultScreen()),
            );
          }
        },
        tooltip: 'next',
        child: Icon(index <= 1 ? Icons.navigate_next : Icons.payment),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final String collectionName;
  const ItemList({Key? key, required this.collectionName}) : super(key: key);

  getItemsfromList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs
        .map((doc) => ItemTile(
              menuItem: MenuItem(
                  name: doc["name"], type: doc["type"], image: doc["image"]),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection(collectionName).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("loading");
          return ListView(children: getItemsfromList(snapshot));
        });
  }
}

class ItemTile extends StatefulWidget {
  final MenuItem menuItem;
  const ItemTile({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  late CartBloc _cartBloc;

  late bool _selectedItem;
  @override
  void initState() {
    super.initState();
    _selectedItem = false;
    _cartBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            setState(() {
              _selectedItem = !_selectedItem;
              if (_selectedItem) {
                _cartBloc.add(AddMenuItem(MenuItem(
                    name: widget.menuItem.name,
                    type: widget.menuItem.type,
                    image: widget.menuItem.image)));
              } else {
                _cartBloc.add(DeleteMenuItem(MenuItem(
                    name: widget.menuItem.name,
                    type: widget.menuItem.type,
                    image: widget.menuItem.image)));
              }
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 40, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   height: 30,
                //   width: 30,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage(widget.menuItem.image),
                //       fit: BoxFit.contain,
                //     ),
                //   ),
                // ),
                CachedNetworkImage(
                  imageUrl: widget.menuItem.image,
                  imageBuilder: (context, imageProvider) => Stack(
                    // TODO: Check if Clip.none == Overflow.visible
                    // clipBehavior: Clip.none,
                    // overflow: Overflow.visible,
                    children: [
                      Container(
                        width: 140,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          // shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                  placeholder: (context, url) => const SizedBox(
                      width: 140,
                      height: 120,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      ))),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    widget.menuItem.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(_selectedItem
                    //  && state.menuItems.any((element) => element.name == widget.menuItem.name)
                    ? Icons.check
                    : null)
              ],
            ),
          ),
        );
        return ListTile(
          onTap: () {
            setState(() {
              _selectedItem = !_selectedItem;
              if (_selectedItem) {
                _cartBloc.add(AddMenuItem(MenuItem(
                    name: widget.menuItem.name,
                    type: widget.menuItem.type,
                    image: widget.menuItem.image)));
              } else {
                _cartBloc.add(DeleteMenuItem(MenuItem(
                    name: widget.menuItem.name,
                    type: widget.menuItem.type,
                    image: widget.menuItem.image)));
              }
            });
          },
          title: Text(widget.menuItem.name),
          trailing: Icon(_selectedItem
              //  && state.menuItems.any((element) => element.name == widget.menuItem.name)
              ? Icons.check
              : null),
        );
      },
    );
  }
}
