import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart.dart';
import '../widgets/buutti_logo.dart';
import '../widgets/primary_button.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Connectivity _connectivity = Connectivity();
  String _connectionStatusErrorMessage = 'Unknown';
  late ConnectivityResult _connectionStatus;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() {
          _connectionStatus = result;
          _connectionStatusErrorMessage = result.toString();
        });
        break;
      default:
        setState(() {
          _connectionStatusErrorMessage = 'Failed to get connectivity.';
        });
        break;
    }
  }

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
              const BuuttiLogoAnimated(),
              const SizedBox(
                height: 40,
              ),
              PrimaryButton(
                text: 'start order',
                onPressed: () {
                  print('connectivity');
                  print(_connectionStatus == ConnectivityResult.none);
                  if (_connectionStatus == ConnectivityResult.none) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("No internet detected"),
                          content: Text(
                              "Error: $_connectionStatusErrorMessage Before starting an order, make sure your app is connected to the internet."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                        ;
                      },
                    );
                  } else {
                    _cartBloc.add(const DeleteAllMenuItem());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainDishScreen()),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}
