import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/cart/cart.dart';
import 'screens/screens.dart';
import 'simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(
              create: (BuildContext buildContext) => CartBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Buutti Ravintola',
          theme: ThemeData(primaryColor: Colors.black),
          home: const HomeScreen(),
        ));
  }
}
