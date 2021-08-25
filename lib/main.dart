import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart/application/bloc.dart';
import 'core/helpers/simple_bloc_observer.dart';
import 'presentation/screens/home_screen.dart';

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
          theme: ThemeData(
              // primarySwatch: Colors.grey,
              primaryColor: Colors.black),
          home: const HomeScreen(),
        ));
  }
}
