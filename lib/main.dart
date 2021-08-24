import 'package:buutti_ravintola/cart/presentation/cart_screen.dart';
import 'package:buutti_ravintola/core/model/menu_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart/application/bloc.dart';

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
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Buutti Ravintola'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final List<String> collectionsValues = [
    "main_dishes",
    "side_dishes",
    "drinks"
  ];
  final List<String> collectionsNames = [
    "Main Dishes",
    "Side Dishes",
    "Drinks"
  ];

  @override
  void initState() {
    // index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(collectionsNames[index]),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  print('cart length');
                  print(state.menuItems.length);
                  return Positioned(
                      top: 0.0,
                      right: 4.0,
                      child: Center(
                        child: Text(
                          state.menuItems.length.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ));
                },
              ),
            ],
          )
        ],
      ),
      body: Center(
          child: ItemList(
        collectionName: collectionsValues[index],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (index <= 2) {
            setState(() {
              index++;
            });
          } else if (index > 2) {
            print('result page');
          }
        },
        tooltip: 'next',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class ItemTile extends StatefulWidget {
  final String name;
  const ItemTile({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  late CartBloc _cartBloc;

  late bool _selectedItem;
  @override
  void initState() {
    super.initState();
    _selectedItem = false;
    _cartBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          _selectedItem = !_selectedItem;
          if (_selectedItem) {
            _cartBloc
                .add(AddMenuItem(MenuItem(name: widget.name, type: 'drink')));
          } else {
            _cartBloc.add(
                DeleteMenuItem(MenuItem(name: widget.name, type: 'drink')));
          }
        });
      },
      title: Text(widget.name),
      trailing: Icon(_selectedItem ? Icons.check : null),
    );
  }
}

class ItemList extends StatelessWidget {
  final String collectionName;
  const ItemList({Key? key, required this.collectionName}) : super(key: key);

  getItemsfromList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs
        .map((doc) => ItemTile(
              name: doc["name"],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection(collectionName).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("loading");
          return ListView(children: getItemsfromList(snapshot));
        });
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- bloc: ${bloc.runtimeType}');
  }
}
