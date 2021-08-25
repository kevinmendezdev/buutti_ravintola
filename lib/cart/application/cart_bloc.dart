import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buutti_ravintola/cart/application/bloc.dart';
import 'package:buutti_ravintola/core/model/menu_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<MenuItem> menuItems = [];
  CartBloc() : super(CartState(menuItems: []));

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is AddMenuItem) {
      menuItems.add(event.menuItem);
      print('item added');
      for (var item in menuItems) {
        print(item.name);
      }
      yield state.copyWith(menuItems: menuItems);
    } else if (event is DeleteMenuItem) {
      menuItems.removeWhere((element) => element.name == event.menuItem.name);
      // menuItems = [];
      print('items left');
      for (var item in menuItems) {
        print(item.name);
      }
      yield state.copyWith(menuItems: menuItems);
    } else if (event is DeleteAllMenuItem) {
      menuItems.clear();
      yield state.copyWith(menuItems: menuItems);
    }
  }
}
