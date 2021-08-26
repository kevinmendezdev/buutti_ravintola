import 'package:buutti_ravintola/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart.dart';
import '../widgets/buutti_logo.dart';
import '../widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartBloc _cartBloc = BlocProvider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Buutti Ravintola'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(50, 28, 50, 28),
                child: Text('Welcome to Buutti Ravintola',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
              ),
              const BuuttiLogo(),
              const SizedBox(
                height: 40,
              ),
              PrimaryButton(
                text: 'start order',
                onPressed: () {
                  _cartBloc.add(DeleteAllMenuItem());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainDishScreen()),
                  );
                },
              )
            ],
          ),
        ));
  }
}
