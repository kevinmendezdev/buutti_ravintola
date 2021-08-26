import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart.dart';
import '../models/menu_item.dart';
import 'primary_progress_indicator.dart';

class MenuItemTile extends StatelessWidget {
  final MenuItem menuItem;
  const MenuItemTile({Key? key, required this.menuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 40, 10),
      child: Row(
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
                child: Center(child: PrimaryProgressIndicator())),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuItem.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                    children: List<Widget>.generate(
                  menuItem.rating,
                  (index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                )),
              ],
            ),
          ])
        ],
      ),
    );
  }
}

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
        bool doesCartContainsMenuItem =
            state.menuItems.any((element) => element.name == menuItem.name);
        return InkWell(
            onTap: () {
              if (doesCartContainsMenuItem) {
                _cartBloc.add(DeleteMenuItem(menuItem));
              } else {
                _cartBloc.add(AddMenuItem(menuItem));
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
                    child: Icon(
                      doesCartContainsMenuItem ? Icons.check : null,
                    ))
              ],
            ));
      },
    );
  }
}
