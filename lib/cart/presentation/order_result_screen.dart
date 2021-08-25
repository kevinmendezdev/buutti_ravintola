import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/model/menu_item.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/widgets/menu_item_tile.dart';
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
          menuItems.sort((a, b) => a.type.compareTo(b.type));
          return Column(
            children: [
              menuItems.isEmpty
                  ? const SizedBox()
                  : const Padding(
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Text(
                        'Thank you for your order',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
              // const SizedBox(
              //   height: 30,
              // ),
              Expanded(
                child: menuItems.isEmpty
                    ? Center(child: Text('Your order is empty'))
                    : ListView.builder(
                        itemCount: state.menuItems.length,
                        itemBuilder: (context, index) {
                          var menuitem = menuItems[index];
                          var menuItemtype = menuitem.type;
                          Widget _listTiel =
                              MenuItemTile(menuItem: state.menuItems[index]);
                          Widget _listTileWithHeader = Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.black,
                                  child: Text(
                                    menuItemtype,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: PrimaryButton(
                    onPressed: () {
                      _cartBloc.add(DeleteAllMenuItem());
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (Route<dynamic> route) => false);
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
