import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/application/bloc.dart';
import '../../core/model/menu_item.dart';

class MenuItemTilePressable extends StatelessWidget {
  final MenuItem menuItem;
  const MenuItemTilePressable({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartBloc _cartBloc = BlocProvider.of(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return InkWell(
            onTap: () {
              if (state.menuItems
                  .any((element) => element.name == menuItem.name)) {
                _cartBloc.add(DeleteMenuItem(MenuItem(
                    name: menuItem.name,
                    type: menuItem.type,
                    image: menuItem.image)));
              } else {
                _cartBloc.add(AddMenuItem(MenuItem(
                    name: menuItem.name,
                    type: menuItem.type,
                    image: menuItem.image)));
              }
            },
            child: Stack(
              children: [
                MenuItemTile(
                  menuItem: menuItem,
                ),
                Positioned(
                    right: 10,
                    top: 50,
                    child: Icon(state.menuItems
                            .any((element) => element.name == menuItem.name)
                        ? Icons.check
                        : null))
              ],
            ));
      },
    );
  }
}

class MenuItemTile extends StatelessWidget {
  final MenuItem menuItem;
  const MenuItemTile({Key? key, required this.menuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 40, 10),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: menuItem.image,
            imageBuilder: (context, imageProvider) => Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            placeholder: (context, url) => const SizedBox(
                width: 130,
                height: 130,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ))),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
              child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuItem.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List<Widget>.generate(
                      menuItem.rating,
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    )),
                // Icon(_selectedItem
                //     //  && state.menuItems.any((element) => element.name == widget.menuItem.name)
                //     ? Icons.check
                //     : null)
              ],
            ),
          ]))
        ],
      ),
    );
  }
}
