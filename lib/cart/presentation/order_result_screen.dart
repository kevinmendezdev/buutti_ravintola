import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/model/menu_item.dart';
import '../../home_screen.dart';
import '../application/bloc.dart';

class OrderResultScreen extends StatefulWidget {
  const OrderResultScreen({Key? key}) : super(key: key);

  @override
  _OrderResultScreenState createState() => _OrderResultScreenState();
}

class _OrderResultScreenState extends State<OrderResultScreen> {
  @override
  Widget build(BuildContext context) {
    CartBloc _cartBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Order'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final List<MenuItem> menuItems = state.menuItems;
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Text(
                  'Thank you for your order',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: state.menuItems.length,
                    itemBuilder: (context, index) {
                      var menuitem = menuItems[index];
                      var menuItemtype = menuitem.type;
                      Widget _listTiel = ListTile(
                        title: Text(
                          state.menuItems[index].name,
                        ),
                      );
                      Widget _listTileWithHeader = Column(
                        children: [
                          Text(
                            menuItemtype,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          _listTiel
                        ],
                      );
                      if (index == 0) {
                        return _listTileWithHeader;
                      } else {
                        if (menuItemtype != menuItems[index - 1].type) {
                          return _listTileWithHeader;
                        } else {
                          return _listTiel;
                        }
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: PrimaryButton(
                    onPressed: () {
                      _cartBloc.add(DeleteAllMenuItem());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    text: 'new order'),
              )
            ],
          );
        },
      ),
    );
  }
}
