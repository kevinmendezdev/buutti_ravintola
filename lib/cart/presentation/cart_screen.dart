import 'package:buutti_ravintola/cart/application/bloc.dart';
import 'package:buutti_ravintola/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
      ),
      body: Center(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return ListView.builder(
                itemCount: state.menuItems.length,
                itemBuilder: (context, index) {
                  return ItemTile(name: state.menuItems[index].name);
                });
          },
        ),
      ),
    );
  }
}
