import 'package:buutti_ravintola/core/model/menu_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

// class LoadCart extends CartEvent {}

class AddMenuItem extends CartEvent {
  final MenuItem menuItem;

  AddMenuItem(this.menuItem);

  @override
  List<Object> get props => [menuItem];
}

class DeleteMenuItem extends CartEvent {
  final MenuItem menuItem;

  DeleteMenuItem(this.menuItem);

  @override
  List<Object> get props => [menuItem];
}

class DeleteAllMenuItem extends CartEvent {}
