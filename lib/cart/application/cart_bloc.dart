import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buutti_ravintola/cart/application/bloc.dart';
import 'package:buutti_ravintola/core/model/menu_item.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<MenuItem> menuItems = [];
  CartBloc() : super(CartLoading());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is LoadCart) {
      yield CartLoading();
      yield CartLoaded(menuItems);
    } else if (event is AddMenuItem) {
      menuItems.add(event.menuItem);
      yield CartLoaded(menuItems);
    } else if (event is DeleteMenuItem) {
      menuItems.remove(event.menuItem);
      yield CartLoaded(menuItems);
    }
  }
}
