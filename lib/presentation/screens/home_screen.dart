import 'package:buutti_ravintola/cart/application/bloc.dart';
import 'package:buutti_ravintola/presentation/screens/main_dish_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buutti_logo.dart';

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

class PrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .7,
      child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          )),
    );
  }
}
