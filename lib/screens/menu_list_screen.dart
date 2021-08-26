import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart.dart';
import '../widgets/menu_item_list.dart';
import 'screens.dart';

class MenuItemListScreen extends StatefulWidget {
  final String firestoreCollectionName;
  final String title;
  final Widget nextScreen;
  final bool isMenuListLastScreen;
  final bool isVerticalTransitionActivated;
  const MenuItemListScreen({
    Key? key,
    required this.firestoreCollectionName,
    required this.title,
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
        firestoreCollectionName: widget.firestoreCollectionName,
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
