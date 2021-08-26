import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buutti_ravintola/blocs/cart/cart.dart';
import 'package:buutti_ravintola/models/menu_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<MenuItem> menuItems = [];
  CartBloc() : super(const CartState(menuItems: []));

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is AddMenuItem) {
      menuItems.add(event.menuItem);
      yield state.copyWith(menuItems: List.of(menuItems));
    } else if (event is DeleteMenuItem) {
      menuItems.removeWhere((element) => element.name == event.menuItem.name);
      yield state.copyWith(menuItems: List.of(menuItems));
    } else if (event is DeleteAllMenuItem) {
      menuItems.clear();
      yield state.copyWith(menuItems: List.of(menuItems));
    }
  }
}
