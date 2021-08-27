import 'package:flutter/material.dart';
import 'screens.dart';

class MainDishScreen extends StatelessWidget {
  const MainDishScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MenuItemListScreen(
      firestoreCollectionName: "main_dishes",
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
      firestoreCollectionName: "side_dishes",
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
      firestoreCollectionName: "drinks",
      title: 'Drinks',
      isMenuListLastScreen: true,
      nextScreen: OrderResultScreen(),
      isVerticalTransitionActivated: true,
    );
  }
}
