import 'package:flutter/material.dart';

import '../../cart/presentation/order_result_screen.dart';
import 'menu_list_screen.dart';

class MainDishScreen extends StatelessWidget {
  const MainDishScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MenuItemListScreen(
      collectionName: "main_dishes",
      title: 'Main Dishes',
      nextScreen: SideDishScreen(),
    );
  }
}

class SideDishScreen extends StatelessWidget {
  const SideDishScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MenuItemListScreen(
      collectionName: "side_dishes",
      title: 'Side Dishes',
      nextScreen: DrinkScreen(),
    );
  }
}

class DrinkScreen extends StatelessWidget {
  const DrinkScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MenuItemListScreen(
      collectionName: "drinks",
      title: 'Drinks',
      isMenuListLastScreen: true,
      nextScreen: OrderResultScreen(),
      isVerticalTransitionActivated: true,
    );
  }
}
