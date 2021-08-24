import 'package:buutti_ravintola/core/model/menu_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<MenuItem> menuItems;

  CartLoaded(this.menuItems);
  @override
  List<Object> get props => [menuItems];
}
