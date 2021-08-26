import 'package:buutti_ravintola/blocs/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    CartBloc _cartBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('cart'),
        actions: [
          IconButton(
              onPressed: () {
                _cartBloc.add(DeleteAllMenuItem());
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: Center(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.menuItems.isEmpty) {
              return const Center(
                child: Text('no items in your cart where found'),
              );
            }
            return ListView.builder(
                itemCount: state.menuItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      state.menuItems[index].name,
                    ),
                    subtitle: Text(state.menuItems[index].type),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _cartBloc.add(DeleteMenuItem(state.menuItems[index]));
                        setState(() {});
                      },
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
