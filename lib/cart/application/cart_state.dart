import 'package:buutti_ravintola/core/model/menu_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CartState extends Equatable {
  final List<MenuItem> menuItems;

  const CartState({required this.menuItems}) : super();
  @override
  List<Object?> get props => [menuItems];

  CartState copyWith({required List<MenuItem> menuItems}) =>
      CartState(menuItems: menuItems);
}
