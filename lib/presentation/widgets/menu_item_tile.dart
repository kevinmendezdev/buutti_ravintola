import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/application/bloc.dart';
import '../../core/model/menu_item.dart';

class MenuItemTile extends StatefulWidget {
  final MenuItem menuItem;
  const MenuItemTile({Key? key, required this.menuItem}) : super(key: key);

  @override
  _MenuItemTileState createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<MenuItemTile> {
  late bool _selectedItem;
  late CartBloc _cartBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedItem = false;
    _cartBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.menuItem.image,
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
                    widget.menuItem.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List<Widget>.generate(
                        widget.menuItem.rating,
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      )),
                  Icon(_selectedItem
                      //  && state.menuItems.any((element) => element.name == widget.menuItem.name)
                      ? Icons.check
                      : null)
                ],
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
