import 'package:flutter/material.dart';

import 'buutti_logo.dart';
import 'order_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 40,
              ),
              PrimaryButton(
                text: 'start order',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderScreen()),
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
