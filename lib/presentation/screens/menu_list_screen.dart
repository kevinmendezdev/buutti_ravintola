import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/application/bloc.dart';
import '../../cart/application/cart_bloc.dart';
import '../../cart/presentation/cart_screen.dart';
import '../widgets/menu_item_list.dart';

class MenuItemListScreen extends StatefulWidget {
  final String collectionName;
  final String title;
  // final void Function() onPressedNext;
  final Widget nextScreen;
  final bool isMenuListLastScreen;
  final bool isVerticalTransitionActivated;
  const MenuItemListScreen({
    Key? key,
    required this.collectionName,
    required this.title,
    // required this.onPressedNext,
    this.isMenuListLastScreen = false,
    required this.nextScreen,
    this.isVerticalTransitionActivated = false,
  }) : super(key: key);

  @override
  _MenuItemListScreenState createState() => _MenuItemListScreenState();
}

class _MenuItemListScreenState extends State<MenuItemListScreen> {
  @override
  void initState() {
    super.initState();
  }

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = widget.isVerticalTransitionActivated
            ? const Offset(0.0, 1.0)
            : const Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title),
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
                  print(state.menuItems);
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
          child: MenuItemList(
        collectionName: widget.collectionName,
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(_createRoute(widget.nextScreen));
        },
        tooltip: widget.isMenuListLastScreen ? 'pay' : 'next',
        child: Icon(
            widget.isMenuListLastScreen ? Icons.payment : Icons.navigate_next),
      ),
    );
  }
}
